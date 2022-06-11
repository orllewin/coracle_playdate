-- see https://github.com/spleennooname/shadow-of-the-beast-html5

import 'CoreLibs/object'
import 'CoreLibs/sprites'
import 'CoreLibs/graphics'
import 'CoreLibs/animation'
import 'CoreLibs/animator'

import 'coracle/Coracle'

class('ShadowParallaxDrawing').extends(Drawing)
class('Sprite').extends(playdate.graphics.sprite)

local graphics <const> = playdate.graphics

local mountainY = 130 + 26
local grass0Y = mountainY + 47
local grass1Y = mountainY + 50
local grass2Y = mountainY + 57
local grass3Y = mountainY + 66
local grass4Y = mountainY + 77

mountains = graphics.image.new("images/sotb/moutains")
assert(mountains)
local mountainsSpriteA = Sprite(mountains)
mountainsSpriteA:add()

local mountainsSpriteB = Sprite(mountains)
mountainsSpriteB:add()
local mountainsSpriteAnimator = graphics.animator.new(10000, 200, -200)
mountainsSpriteAnimator.repeatCount = -1

grass0 = graphics.image.new("images/sotb/grass0")
assert(grass0)
local grass0SpriteA = Sprite(grass0)
grass0SpriteA:add()

local grass0SpriteB = Sprite(grass0)
grass0SpriteB:add()

grass1 = graphics.image.new("images/sotb/grass1")
assert(grass1)
local grass1SpriteA = Sprite(grass1)
grass1SpriteA:add()

local grass1SpriteB = Sprite(grass1)
grass1SpriteB:add()
local grass1SpriteAnimator = graphics.animator.new(9000, 200, -200)
grass1SpriteAnimator.repeatCount = -1

grass2 = graphics.image.new("images/sotb/grass2")
assert(grass2)
local grass2SpriteA = Sprite(grass2)
grass2SpriteA:add()

local grass2SpriteB = Sprite(grass2)
grass2SpriteB:add()
local grass2SpriteAnimator = graphics.animator.new(7500, 200, -200)
grass2SpriteAnimator.repeatCount = -1

grass3 = graphics.image.new("images/sotb/grass3")
assert(grass3)
local grass3SpriteA = Sprite(grass3)
grass3SpriteA:add()

local grass3SpriteB = Sprite(grass3)
grass3SpriteB:add()
local grass3SpriteAnimator = graphics.animator.new(6000, 200, -200)
grass3SpriteAnimator.repeatCount = -1

grass4 = graphics.image.new("images/sotb/grass4")
assert(grass4)
local grass4SpriteA = Sprite(grass4)
grass4SpriteA:add()

local grass4SpriteB = Sprite(grass4)
grass4SpriteB:add()
local grass4SpriteAnimator = graphics.animator.new(5500, 200, -200)
grass4SpriteAnimator.repeatCount = -1

local runTable = graphics.imagetable.new("images/sotb/run_sheet")
local runLoop = graphics.animation.loop.new(100, runTable)
runSprite = Sprite()
runSprite:moveTo(200, 190)
runSprite:add()
runLoop.frame = 1

local audioPlayer = playdate.sound.fileplayer.new()

function ShadowParallaxDrawing:setup()
  print("Drawing setup()")
  audioPlayer:load("audio/sotb/sotb")
  audioPlayer:play()
end

function ShadowParallaxDrawing:draw()
  
  local loopValue = math.floor(mountainsSpriteAnimator:currentValue())
  mountainsSpriteA:moveTo(loopValue, mountainY)
  mountainsSpriteB:moveTo(loopValue + 400, mountainY)
  
  --Grass0 same x offset as mountains
  grass0SpriteA:moveTo(loopValue, grass0Y)
  grass0SpriteB:moveTo(loopValue + 400, grass0Y)
  
  local grass1Value = math.floor(grass1SpriteAnimator:currentValue())
  grass1SpriteA:moveTo(grass1Value, grass1Y)
  grass1SpriteB:moveTo(grass1Value + 400, grass1Y)
  
  local grass2Value = math.floor(grass2SpriteAnimator:currentValue())
  grass2SpriteA:moveTo(grass2Value, grass2Y)
  grass2SpriteB:moveTo(grass2Value + 400, grass2Y)
  
  local grass3Value = math.floor(grass3SpriteAnimator:currentValue())
  grass3SpriteA:moveTo(grass3Value, grass3Y)
  grass3SpriteB:moveTo(grass3Value + 400, grass3Y)
  
  local grass4Value = math.floor(grass4SpriteAnimator:currentValue())
  grass4SpriteA:moveTo(grass4Value, grass4Y)
  grass4SpriteB:moveTo(grass4Value + 400, grass4Y)
    
  runSprite:setImage(runLoop:image())
  
  graphics.sprite.update()
  
  if(upPressed())then
    audioPlayer:stop()
  end
  
  if(downPressed())then
    audioPlayer:play()
  end
    
end