import 'coracle/Coracle'
import 'coracle/Vector'
import 'games/todmorden/snow'

class('SplashDrawing').extends(Drawing)
class('Snowflake').extends()

local snow = Snow(false, 1000)

local onSplashDismiss = nil
local splashTimer = nil

local splashImage = playdate.graphics.image.new("games/todmorden/splash/images/splash")
assert(splashImage)

function SplashDrawing:init(_onSplashDismiss)
  onSplashDismiss = _onSplashDismiss
end

function SplashDrawing:draw()
  splashImage:draw(0, 0)
  snow:draw()
  
  if(splashTimer == nil)then
    print('timer started')
    splashTimer = playdate.timer.new(5000, onSplashDismiss)
  end
end