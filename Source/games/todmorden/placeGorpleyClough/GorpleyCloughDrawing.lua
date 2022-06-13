import 'CoreLibs/sprites'
import 'CoreLibs/graphics'
import 'CoreLibs/animation'
import 'CoreLibs/timer'

import 'coracle/Coracle'
import 'coracle/Vector'
import 'games/todmorden/Waterfall'

class('TurbineSprite').extends(playdate.graphics.sprite)
class('GorpleyCloughDrawing').extends(Drawing)

local graphics <const> = playdate.graphics

local waterfallSmall = Waterfall(15, 2, 165, 183, 97, 110)
local waterfallMain = Waterfall(800, 4, 155, 320, 140, 240)
local snow = Snow(false, 15, 2, 2)
snow.color =  graphics.kColorWhite

local onSplashDismiss = nil
local splashTimer = nil

local splashImage = playdate.graphics.image.new("games/todmorden/placeGorpleyClough/images/gorpleyclough")
assert(splashImage)

function GorpleyCloughDrawing:init(_onSplashDismiss)
  onSplashDismiss = _onSplashDismiss
  
  graphics.sprite.setBackgroundDrawingCallback(
      function( x, y, width, height )
          splashImage:draw(0, 0)
      end
  )
end

function GorpleyCloughDrawing:draw()
  
  graphics.sprite.update()
  
  waterfallSmall:draw()
  waterfallMain:draw()
  
  graphics.setColor(playdate.graphics.kColorWhite)
  snow:draw()
  
  if(splashTimer == nil)then
    print('timer started')
    splashTimer = playdate.timer.new(5000, onSplashDismiss)
  end
end