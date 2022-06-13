class("Waterfall").extends()
class('Drop').extends()

local graphics <const> = playdate.graphics
local droplets = {}
local prevColor = nil

local frame = 0

function Waterfall:init(dropCount, speedMax, xStart, xEnd, yStart, yEnd)
  for i = 1, dropCount do
    local drop = Drop()
    drop.location = Vector:create(math.random(xStart, xEnd), math.random(yStart, yEnd))
    drop.speed = math.random(1, speedMax)
    drop.direction = math.random(-1, 1)
    drop.xStart = xStart
    drop.xEnd = xEnd
    drop.yStart = yStart
    drop.yEnd = yEnd
    table.insert(droplets, drop)
  end
end

function Waterfall:draw()
  
  frame += 1
  prevColor = graphics.getColor()
  graphics.setColor(playdate.graphics.kColorXOR)
  for i = 1, #droplets do
    local drop = droplets[i]
    line(drop.location.x, drop.location.y, drop.location.x, drop.location.y + 1)
    --point(drop.location.x, drop.location.y)
    drop.location.y = drop.location.y + drop.speed
    drop.location.x = drop.location.x + (drop.direction/4)
    
    if(drop.location.y > drop.yEnd + 1) then
      drop.location = Vector:create(math.random(drop.xStart, drop.xEnd), math.random(drop.yStart, drop.yEnd))
    end
  end
  
  graphics.setColor(prevColor)
end

function ring(a, min, max)
  if min > max then
    min, max = max, min
  end
  return min + (a-min) % (max-min)
end
