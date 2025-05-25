require "vector"

CardClass = {}
CardClass.__index = CardClass

function CardClass:new(name,cost,power,desc,rev)
  local card = setmetatable({}, CardClass)
  card.cost= cost
  card.power = power
  card.name = name
  card.desc = desc
  card.position = Vector(-100, 100)
  card.rev =rev
  card.face=true
  card.size = Vector(100, 140)
  card.scale = 0.1
  card.table = nil
  backImage = love.graphics.newImage("Assets/back.jpeg")
  return card
end


function CardClass:draw()
  
  if self.face then
  local x, y = self.position.x, self.position.y
  local w, h = 100, 140

  -- Card background
  love.graphics.setColor(0.9, 0.9, 0.9)
  love.graphics.rectangle("fill", x, y, w, h, 10, 10)

  -- Card border
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("line", x, y, w, h, 10, 10)

  -- Card text
   love.graphics.setFont(bigFont) 
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(self.cost, x + 10, y + 10)
 
  love.graphics.print("Power: " ..self.power, x + 10, y + 50)
   love.graphics.setFont(lilFont) 
  love.graphics.print(self.name, x + 10, y + 30)
   love.graphics.print(self.desc, x + 10, y + 70)
   love.graphics.setFont(bigFont) 
 else
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(backImage, self.position.x, self.position.y, 0, self.size.x / backImage:getWidth(), self.size.y / backImage:getHeight())
   end 
end

function CardClass:isMouseOver(mx, my)
  return mx >= self.position.x and mx <= self.position.x + self.size.x and
         my >= self.position.y and my <= self.position.y + self.size.y
end

function findPosition()
  -- For enemy card
   local Eoffset=screenWidth/(#areas[state].ePlay+1)
for i, card in ipairs(areas[state].ePlay) do
  local x= i*Eoffset
  card.position =Vector(x,200)
end
-- For ally card
local Aoffset=screenWidth/(#areas[state].aPlay+1)
for i, card in ipairs(areas[state].aPlay) do
  local  x= i*Aoffset
  card.position =Vector(x,500)
  end
end



