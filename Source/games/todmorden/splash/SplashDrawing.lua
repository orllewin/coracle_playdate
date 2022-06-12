import 'coracle/Coracle'
import 'coracle/Vector'

class('SplashDrawing').extends(Drawing)
class('Snowflake').extends()

local onSplashDismiss = nil
local splashTimer = nil

local splashImage = playdate.graphics.image.new("games/todmorden/splash/images/splash")
assert(splashImage)

local windspeed = 0.0
local snowflakes = {}

local ground = {}
for g = 1, width do
  ground[g] = 0
end 

local frame = 0

for i = 1, 1000 do
  local snowflake = Snowflake()
  snowflake.location = Vector:create(math.random(0, width * 1.25), math.random(-400, 0))
  snowflake.speed = math.random(1, 4)
  snowflake.direction = math.random(-2, 2)
  table.insert(snowflakes, snowflake)
end

function SplashDrawing:init(_onSplashDismiss)
  onSplashDismiss = _onSplashDismiss
end

function SplashDrawing:draw()
  splashImage:draw(0, 0)
  
  frame += 1
  
  if(splashTimer == nil)then
    print('timer started')
    splashTimer = playdate.timer.new(5000, onSplashDismiss)
  end
  
  playdate.graphics.setColor(playdate.graphics.kColorXOR)
  for i = 1, #snowflakes do
    local snowflake = snowflakes[i]
    line(snowflake.location.x + 3 * windspeed, snowflake.location.y - 1, snowflake.location.x, snowflake.location.y)
    --point(snowflake.location.x, snowflake.location.y)
    snowflake.location.y = snowflake.location.y + snowflake.speed
    
    local wind = playdate.graphics.perlin(snowflake.speed, snowflake.location.y * 0.0055, frame * 0.0055) - 0.5
    --local wind = 0
    snowflake.location.x = snowflake.location.x + (wind * snowflake.speed) + snowflake.direction
    if(snowflake.location.y > height + 1) then
      snowflake.location = Vector:create(math.random(0, (width * 1.25)), math.random(-100, 0))
      if(snowflake.location.x > 0 and snowflake.location.x < width)then
        local index = snowflake.location.x
        
        local average = 0
        average += ground[ring(index + 1, 1, 400)]
        average += ground[ring(index + 2, 1, 400)]
        average += ground[ring(index + 3, 1, 400)]
        
        average += ground[ring(index - 1, 1, 400)]
        average += ground[ring(index - 2, 1, 400)]
        average += ground[ring(index - 3, 1, 400)]
        
        average = average / 6
        if(average > 0)then
          ground[index] = average + 1
        else
          ground[index] = ground[index] + 1
        end
      end
    end
  end
  
  for g = 1, #ground do
    local gSize = ground[g]
    if(gSize > 0)then
      line(g, height - gSize, g, height)
    end
  end
  
  playdate.timer.updateTimers()
end

function ring(a, min, max)
  if min > max then
    min, max = max, min
  end
  return min + (a-min) % (max-min)
end