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
function revealA(i,table,card)
   state=i
  card.rev(1,table,card)  
end
function revealE(i,table,card)
   state=i
  card.rev(2,table,card)
  end
function reveal() 
  local laststate=state
  if aScore > eScore then
   for i, area in ipairs(areas) do
   for f, card in ipairs(area.aPlay) do
   if card.face == false then
     if card.rev then
       revealA(i,card.table,card)
end

     card.face = true
   end
 end
 for f, card in ipairs(area.ePlay) do
    if card.face == false then
      if card.rev then
         revealE(i,card.table,card)

end
     card.face = true
     
   end
 end
end
end
if eScore > aScore then
   for i, area in ipairs(areas) do
   for f, card in ipairs(area.ePlay) do
   if card.face == false then
     if card.rev then
      revealE(i,card.table,card)
end
     card.face = true
   end
 end
 for f, card in ipairs(area.aPlay) do
    if card.face == false then
      if card.rev then
        revealA(i,card.table,card)

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
   for f, card in ipairs(area.aPlay) do
   if card.face == false then
     if card.rev then
      revealA(i,card.table,card) 

end
     card.face = true
   end
 end
 for f, card in ipairs(area.ePlay) do
    if card.face == false then
      if card.rev then
        revealE(i,card.table,card)

end
     card.face = true
   end
 end
end
end
if coin==2 then
   for i, area in ipairs(areas) do
   for f, card in ipairs(area.ePlay) do
   if card.face == false then
     if card.rev then
     revealE(i,card.table,card)
end
     card.face = true
   end
 end
 for f, card in ipairs(area.aPlay) do
    if card.face == false then
      if card.rev then
       revealA(i,card.table,card)

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
  
