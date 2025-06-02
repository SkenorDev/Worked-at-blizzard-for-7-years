-- Nathan Skinner
-- CMPM 121 
-- 5-14-2025

io.stdout:setvbuf("no")
require "card"
require "powers"
require "vector"
require "area"
require "templates"

function love.load()
  love.window.setTitle("RatSoftware")
  screenWidth = 960
  screenHeight = 960
  love.window.setMode(screenWidth, screenHeight)
  mana=1
  loss=false
  win=false
  amana=mana
  emana=mana
  aScore=0
  eScore=0
  state = 2
  grabbed ={}
  aDeck = {}
  eDeck = {}
  aHand = {}
  eHand = {}
  aDiscard = 0
  eDiscard = 0 
  local r = {0.5, 0, 0}
  local g = {0, 0.5, 0}
  local b = {0, 0, 0.5}
  areas = {
  AreaClass:new(r),
  AreaClass:new(g),
  AreaClass:new(b)
  }
  midY = screenHeight / 2
  arrowSize = 40
  arrowMargin = 20
  lilFont = love.graphics.newFont(10)
  bigFont = love.graphics.newFont(18)
  start()
end


function love.update()
  moveCards()
end

function love.draw()
  -- Draws current area
  areas[state]:draw()
  for i, card in ipairs(aHand) do
    card:draw()
    end
  -- Draws mouse pos
  local x, y = love.mouse.getPosition()
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("Mouse: " .. x .. ", " .. y, 10, 10)
  endTurnBtn = {
  x = screenWidth - 150,
  y = screenHeight - 100,
  w = 120,
  h = 50
}
-- Draw End Turn button
love.graphics.setColor(0.2, 0.2, 0.2)
love.graphics.rectangle("fill", endTurnBtn.x, endTurnBtn.y, endTurnBtn.w, endTurnBtn.h)
love.graphics.setColor(1, 1, 1)
love.graphics.print("Mana: " .. amana, 20, 70)
love.graphics.printf("End Turn", endTurnBtn.x, endTurnBtn.y + 15, endTurnBtn.w, "center")
love.graphics.setFont(love.graphics.newFont(20))
love.graphics.print("Player Score: " .. aScore, 20, 40)
love.graphics.print("Enemy Score: " .. eScore, screenWidth - 200, 40)
if win == true then
  love.graphics.setColor(0, 1, 0)
  love.graphics.printf("You Win!", 0, screenHeight / 2 - 100, screenWidth, "center")
  end
if loss == true then
love.graphics.setColor(0, 1, 0)
  love.graphics.printf("You Lose!", 0, screenHeight / 2 - 100, screenWidth, "center")
end
end


function love.mousepressed(x, y, button)
for i, card in ipairs(aHand) do
     if aHand[i]:isMouseOver(x, y) == true then
          table.insert(grabbed, aHand[i])
          end
    end
  -- Left arrow click
  if x >= arrowMargin and x <= arrowMargin + arrowSize and
     y >= midY - arrowSize / 2 and y <= midY + arrowSize / 2 and state>1 then
    state = state - 1
     findPosition()
  end

  -- Right arrow click
  if x >= screenWidth - arrowMargin - arrowSize and x <= screenWidth - arrowMargin and
     y >= midY - arrowSize / 2 and y <= midY + arrowSize / 2 and state<3 then
    state =state + 1
     findPosition()
  end
if x >= endTurnBtn.x and x <= endTurnBtn.x + endTurnBtn.w and
   y >= endTurnBtn.y and y <= endTurnBtn.y + endTurnBtn.h and loss ==false and win==false then
   newTurn()
end
  end

function love.mousereleased(x, y, button)
  if x<700 and #grabbed>0 then
  aPlay(grabbed[1])
  end 
   grabbed = {}
  drawFindPos()
  end
function aPlay(card)
  if card.cost> amana then
   -- print("too expensive")
    return
  end
  if #areas[state].aPlay>=4 then
    print("too many")
    return
    end
  card.face=false
  card.table=state
  amana=amana-card.cost
  -- Remove from aHand
  for i, c in ipairs(aHand) do
    if c == card then
      table.remove(aHand, i)
      break
    end
  end
  -- Add to the current area's player field
  table.insert(areas[state].aPlay, card)
  -- Reposition the card (example position)
  findPosition()
end
function ePlay(card)
  if card.cost ==nil then
    return
    end
  if card.cost > emana then
    --print("too expensive")
    return
  end
  local randState = math.random(1, 3)
  if #areas[randState].ePlay>=4 then
    print("too many")
    return
  end
  card.table=state
  card.face=false
  emana = emana - card.cost
  -- Remove from eHand
  for i, c in ipairs(eHand) do
    if c == card then
      table.remove(eHand, i)
      break
    end
  end
  -- Play to a random area
  
  table.insert(areas[randState].ePlay, card)
  -- Reposition
  findPosition()
end

function chatGPT()
  for i=1,10 do
    if #eHand>0 then
    ePlay(eHand[math.random(1,#eHand)])
    end
  end
  end

function moveCards()
  -- If card is grabbed than move with mouse cursor
  for i = 1, #grabbed do
    local card = grabbed[i]
    card.position = Vector(love.mouse.getX() - 25, love.mouse.getY() - 25)
  end
end
function eDraw()
  table.insert(eHand,eDeck[1])
  table.remove(eDeck,1)
end
function aDraw()
  table.insert(aHand,aDeck[1])
  table.remove(aDeck,1)
  drawFindPos()
end

function start()
  local allNames = {
    "WoodenCow", "Pegasus", "Minotaur", "Titan", "Zeus",
    "Midas", "Aphrodite", "Hera", "Artemis", "Persephone",
    "Hephaestus", "Dionysus", "Hercules", "Hades"
  }

  -- Shuffle allNames manually
  for i = #allNames, 2, -1 do
    local j = math.random(i)
    allNames[i], allNames[j] = allNames[j], allNames[i]
  end

  -- Use first 10 shuffled names for each deck
  for i = 1, 10 do
    for j = 1, 2 do
      table.insert(aDeck, createCard(allNames[i]))
    end
  end

  -- Shuffle again for enemy deck
  for i = #allNames, 2, -1 do
    local j = math.random(i)
    allNames[i], allNames[j] = allNames[j], allNames[i]
  end

  for i = 1, 10 do
    for j = 1, 2 do
      table.insert(eDeck, createCard(allNames[i]))
    end
  end

shuffle(eDeck)
shuffle(aDeck)
aDraw()
aDraw()
aDraw()
eDraw()
eDraw()
eDraw()
chatGPT()
end

function drawFindPos()
  for i, card in ipairs(aHand) do
   
    card.position=Vector(200 +(100*i),700)
  end
  end
function shuffle(tbl)
  -- randomize cards
  for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
end

function newTurn()
  reveal()
  powerCalcAll()
  checkWin()
  aDraw()
  eDraw()
  mana=mana+1
  amana=mana
  emana=mana
  chatGPT()
  print(loss)
end
function aDiscard(dcard,cstate)
  for i,card in ipairs(areas[cstate].aPlay) do
  if dcard==card then
    table.remove(areas[cstate].aPlay,i)
    aDiscard=aDiscard+1
    return
    end
  end
end
function eDiscard(dcard,cstate)
  for i,card in ipairs(areas[cstate].ePlay) do
  if dcard==card then
    table.remove(areas[cstate].ePlay,i)
    eDiscard=eDiscard+1
    return
    end
  end
  end
function aDiscardHand(dcard)
  for i,card in ipairs(aHand) do
  if dcard==card then
    table.remove(aHand,i)
    aDiscard=aDiscard+1
    return
    end
  end
end
function eDiscardHand(dcard)
  for i,card in ipairs(eHand) do
  if dcard==card then
    table.remove(eHand,i)
    eDiscard=eDiscard+1
    return
    end
  end
  end
function reveal() 
  if aScore > eScore then
   for i, area in ipairs(areas) do
   for i, card in ipairs(area.aPlay) do
   if card.face == false then
     if card.rev then
  card.rev(1,card.table,card)  
end

     card.face = true
   end
 end
 for i, card in ipairs(area.ePlay) do
    if card.face == false then
      if card.rev then
  card.rev(2,card.table,card)  
end
     card.face = true
     
   end
 end
end
end
if eScore > aScore then
   for i, area in ipairs(areas) do
   for i, card in ipairs(area.ePlay) do
   if card.face == false then
     if card.rev then
  card.rev(2,card.table,card)  
end
     card.face = true
   end
 end
 for i, card in ipairs(area.aPlay) do
    if card.face == false then
      if card.rev then
  card.rev(1,card.table,card)  
end
     card.face = true
   end
 end
end
end
if eScore == aScore then
  coin =flipCoin()
  if coin ==1 then
   for i, area in ipairs(areas) do
   for i, card in ipairs(area.aPlay) do
   if card.face == false then
     if card.rev then
  card.rev(1,card.table,card)  
end
     card.face = true
   end
 end
 for i, card in ipairs(area.ePlay) do
    if card.face == false then
      if card.rev then
  card.rev(2,card.table,card)  
end
     card.face = true
   end
 end
end
end
if coin==2 then
   for i, area in ipairs(areas) do
   for i, card in ipairs(area.ePlay) do
   if card.face == false then
     if card.rev then
  card.rev(2,card.table,card)  
end
     card.face = true
   end
 end
 for i, card in ipairs(area.aPlay) do
    if card.face == false then
      if card.rev then
 card.rev(1,card.table,card)  
end
     card.face = true
   end
 end
end
end
  
  end


  end

function powerCalcAll()
  local total=0
  for i, area in ipairs(areas) do
 for i, card in ipairs(area.aPlay) do
   total= total +card.power
 end
 for i, card in ipairs(area.ePlay) do
   total= total -card.power
   end
end
if total == 0 then
  return
end
if total >= 1 then
  aScore= aScore+total
end
if total <= -1 then
  eScore= eScore+(-1*total)
  end
end


function flipCoin()
  if math.random() < 0.5 then
    return 1
  else
    return 2
  end
end
function checkWin()
  if eScore>=20 and aScore>=20 then
    if eScore<aScore then
      win=true
      return
    end
    loss=true
  end
  if eScore>19 then
    loss=true
  end
  if aScore>=20 then
    win=true
    end
  end
  
  
function debug()
  print("--- DEBUG INFO ---")
  print("aDeck:")
  for i, card in ipairs(aDeck) do
    print(i, card.name)
  end

  print("eDeck:")
  for i, card in ipairs(eDeck) do
    print(i, card.name)
  end

  print("aHand:")
  for i, card in ipairs(aHand) do
    print(i, card.name)
  end

  print("eHand:")
  for i, card in ipairs(eHand) do
    print(i, card.name)
  end

  print("aPlay (Area " .. state .. "):")
  for i, card in ipairs(areas[state].aPlay or {}) do
    print(i, card.name)
  end
end

