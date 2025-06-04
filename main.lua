-- Nathan Skinner
-- CMPM 121 
-- 5-14-2025

io.stdout:setvbuf("no")
require "card"
require "powers"
require "vector"
require "area"
require "templates"
require "click"
require "game"
require "ai"

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

