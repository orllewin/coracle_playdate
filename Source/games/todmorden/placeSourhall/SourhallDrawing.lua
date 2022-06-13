import 'CoreLibs/sprites'
import 'CoreLibs/graphics'
import 'CoreLibs/animation'
import 'CoreLibs/timer'

import 'coracle/Coracle'
import 'coracle/Vector'
import 'games/todmorden/Snow'

class('TurbineSprite').extends(playdate.graphics.sprite)
class('SourhallDrawing').extends(Drawing)
class('Snowflake').extends()

local graphics <const> = playdate.graphics

local turbineTable = graphics.imagetable.new("games/todmorden/splash/images/turbine_sheet")

-- Turbines   
local turbineA = TurbineSprite()
turbineA:moveTo(42, 77)
turbineA:setScale(0.50)
turbineA:add()

local turbineALoop = graphics.animation.loop.new(100, turbineTable)
turbineALoop.frame = 1

local turbineB = TurbineSprite()
turbineB:moveTo(60, 84)
turbineB:setScale(0.35)
turbineB:add()

local turbineBLoop = graphics.animation.loop.new(100, turbineTable)
turbineBLoop.frame = 4

local turbineC = TurbineSprite()
turbineC:moveTo(178, 79)
turbineC:setScale(0.40)
turbineC:add()

local turbineCLoop = graphics.animation.loop.new(100, turbineTable)
turbineCLoop.frame = 8

local turbineD = TurbineSprite()
turbineD:moveTo(196, 74)
turbineD:setScale(0.50)
turbineD:add()

local turbineDLoop = graphics.animation.loop.new(100, turbineTable)
turbineDLoop.frame = 10

local snow = Snow(false, 2000, 1, 4)

local onSplashDismiss = nil
local splashTimer = nil

local splashImage = playdate.graphics.image.new("games/todmorden/placeSourhall/images/sourhall")
assert(splashImage)

function SourhallDrawing:init(_onSplashDismiss)
  onSplashDismiss = _onSplashDismiss
  
  graphics.sprite.setBackgroundDrawingCallback(
      function( x, y, width, height )
          splashImage:draw(0, 0)
      end
  )
end

function SourhallDrawing:draw()
  turbineA:setImage(turbineALoop:image())
  turbineB:setImage(turbineBLoop:image())
  turbineC:setImage(turbineCLoop:image())
  turbineD:setImage(turbineDLoop:image())
  
  graphics.sprite.update()
  
  snow:draw()
  
  if(splashTimer == nil)then
    print('timer started')
    splashTimer = playdate.timer.new(5000, onSplashDismiss)
  end
end