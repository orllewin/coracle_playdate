PrecipitationDrop = {}
PrecipitationDrop.__index = PrecipitationDrop
function PrecipitationDrop:create(location, speed, direction, moleculeSize)
   local precipDrop = {}
   setmetatable(precipDrop, PrecipitationDrop)
   precipDrop.location = location
   precipDrop.speed = speed
   precipDrop.direction = direction
   precipDrop.moleculeSize = moleculeSize
   return precipDrop
end

Precipitation = {}
Precipitation.__index = Precipitation
function Precipitation:create(settles, moleculeCount, moleculeSize, maxSpeed)
   local precipitation = {}
   setmetatable(precipitation, Precipitation)
   precipitation.settles = settles
   precipitation.xEnd = xEnd
   precipitation.yStart = yStart
   precipitation.yEnd = yEnd
   precipitation.prevColor = playdate.graphics.kColorXOR
   precipitation.iterations = 0
   precipitation.frame = 0
   precipitation.windspeed = 0.0
   precipitation.precipDroplets = {}
   for i = 1, moleculeCount do
    local precipDrop = PrecipitationDrop:create(Vector:create(math.random(0, width * 1.25), math.random(-400, 0)), math.random(1, maxSpeed), math.random(-2, 2), moleculeSize)
    table.insert(precipitation.precipDroplets, precipDrop)
   end
   
   precipitation.settles = settles
   if(settles)then
    precipitation.ground = {}
    for g = 1, width do
      precipitation.ground[g] = 0
    end 
   end
   return precipitation
end

function Precipitation:draw()
  self.frame += 1
  
  for i = 1, #self.precipDroplets do
    local precipDrop = self.precipDroplets[i]
    
    if(precipDrop.moleculeSize == 1)then
      line(precipDrop.location.x + 3 * self.windspeed, precipDrop.location.y - 1, precipDrop.location.x, precipDrop.location.y)
    else
      circle(precipDrop.location.x, precipDrop.location.y, precipDrop.moleculeSize)
    end
  
    precipDrop.location.y = precipDrop.location.y + precipDrop.speed
    
    local wind = playdate.graphics.perlin(precipDrop.speed, precipDrop.location.y * 0.0055, self.frame * 0.0055) - 0.5
    precipDrop.location.x = precipDrop.location.x + (wind * precipDrop.speed) + precipDrop.direction
    if(precipDrop.location.y > height + 1) then
      precipDrop.location = Vector:create(math.random(0, (width * 1.25)), math.random(-100, 0))
      
      if(self.settles and precipDrop.location.x > 0 and precipDrop.location.x < width)then
        local index = precipDrop.location.x
        
        local average = 0
        average += self.ground[ring(index + 1, 1, 400)]
        average += self.ground[ring(index + 2, 1, 400)]
        average += self.ground[ring(index + 3, 1, 400)]
        
        average += self.ground[ring(index - 1, 1, 400)]
        average += self.ground[ring(index - 2, 1, 400)]
        average += self.ground[ring(index - 3, 1, 400)]
        
        average = average / 6
        if(average > 0)then
          self.ground[index] = average + 1
        else
          self.ground[index] = self.ground[index] + 1
        end
      end
    end
  end
  
  if(self.settles)then
    playdate.graphics.setColor(playdate.graphics.kColorWhite)
    for g = 1, #self.ground do
      local gSize = self.ground[g]
      if(gSize > 0)then
        line(g, height - gSize, g, height)
      end
    end
  end
end

function ring(a, min, max)
  if min > max then
    min, max = max, min
  end
  return min + (a-min) % (max-min)
end