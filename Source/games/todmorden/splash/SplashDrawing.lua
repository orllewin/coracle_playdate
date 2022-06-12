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

for i = 1, 1000 do
  local snowflake = Snowflake()
  snowflake.location = Vector:create(math.random(0, width * 1.25), math.random(-400, 0))
  snowflake.speed = math.random(1, 3)
  table.insert(snowflakes, snowflake)
end

function SplashDrawing:init(_onSplashDismiss)
  onSplashDismiss = _onSplashDismiss
end

function SplashDrawing:draw()
  splashImage:draw(0, 0)
  
  if(splashTimer == nil)then
    print('timer started')
    splashTimer = playdate.timer.new(5000, onSplashDismiss)
  end
  
  playdate.graphics.setColor(playdate.graphics.kColorXOR)
  for i = 1, #snowflakes do
    local snowflake = snowflakes[i]
    line(snowflake.location.x + 3 * windspeed, snowflake.location.y - 1, snowflake.location.x, snowflake.location.y)
    snowflake.location.y = snowflake.location.y + snowflake.speed
    snowflake.location.x = snowflake.location.x - (snowflake.speed * windspeed)
    if(snowflake.location.y > height + 1) then
      snowflake.location = Vector:create(math.random(0, (width * 1.25)), math.random(-100, 0))
    end
  end
  
  playdate.timer.updateTimers()
end