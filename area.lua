require "vector"
require "card"
AreaClass = {}
AreaClass.__index = AreaClass

function AreaClass:new(color)
  local area = setmetatable({}, AreaClass)
  area.color=color
  area.aPlay = {}
  area.ePlay = {}
  return area
end


function AreaClass:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setColor(1, 1, 1) 
  
  love.graphics.setColor(1, 1, 1)
local midY = screenHeight / 2
if state>1 then
love.graphics.polygon("fill", {
  20, midY,       
  40, midY - 20,  
  40, midY + 20   
})
end
if state < 3 then
love.graphics.polygon("fill", {
  screenWidth - 20, midY,        
  screenWidth - 40, midY - 20,   
  screenWidth - 40, midY + 20    
})
end
for i, card in ipairs(self.aPlay) do
    card:draw()
  end

  -- Draw cards in ePlay
  for i, card in ipairs(self.ePlay) do
    card:draw()
  end
end


