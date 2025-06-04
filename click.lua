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