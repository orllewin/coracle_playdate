Drop = {}
Drop.__index = Drop
function Drop:create(location, speed, direction)
   local drop = {}
   setmetatable(drop, Drop)
   drop.location = location
   drop.speed = speed
   drop.direction = direction
   return drop
end

Waterfall = {}
Waterfall.__index = Waterfall
function Waterfall:create(dropCount, speedMax, xStart, xEnd, yStart, yEnd)
   local waterfall = {}
   setmetatable(waterfall, Waterfall)
   waterfall.xStart = xStart
   waterfall.xEnd = xEnd
   waterfall.yStart = yStart
   waterfall.yEnd = yEnd
   waterfall.prevColor = playdate.graphics.kColorXOR
   waterfall.iterations = 0
   waterfall.droplets = {}
   for i = 1, dropCount do
    local drop = Drop:create(Vector:create(math.random(xStart, xEnd), math.random(yStart, yEnd)), math.random(1, speedMax), math.random(-1, 1))
    table.insert(waterfall.droplets, drop)
   end
   return waterfall
end

function Waterfall:draw(color)
  
  self.iterations += 1
  self.prevColor = playdate.graphics.getColor()
  playdate.graphics.setColor(color)
  for i = 1, #self.droplets do
    local drop = self.droplets[i]
    line(drop.location.x, drop.location.y, drop.location.x, drop.location.y + 1)
    --point(drop.location.x, drop.location.y)
    drop.location.y = drop.location.y + drop.speed
    drop.location.x = drop.location.x + (drop.direction/4)
    
    if(drop.location.y > self.yEnd + 1) then
      drop.location = Vector:create(math.random(self.xStart, self.xEnd), math.random(self.yStart, self.yEnd))
    end
  end
  
  playdate.graphics.setColor(self.prevColor)
end

function ring(a, min, max)
  if min > max then
    min, max = max, min
  end
  return min + (a-min) % (max-min)
end

