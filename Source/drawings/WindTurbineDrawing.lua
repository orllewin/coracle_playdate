--[[
  WindTurbineDrawing
  Experimenting with sprites on Playdate
]]

import 'CoreLibs/sprites'
import 'CoreLibs/graphics'
import 'CoreLibs/animation'
import 'coracle/Vector'

local sound <const> = playdate.sound
local graphics <const> = playdate.graphics

local turbineTable = graphics.imagetable.new("images/turbine_sheet")
local turbineALoop = graphics.animation.loop.new(100, turbineTable)
local turbineBLoop = graphics.animation.loop.new(100, turbineTable)
local turbineCLoop = graphics.animation.loop.new(100, turbineTable)
local turbineDLoop = graphics.animation.loop.new(100, turbineTable)
 
class('TurbineSprite').extends(playdate.graphics.sprite)
class('Raindrop').extends()

-- Rain
local raindrops = {}
local windspeed = 0.2

-- Audio
local synthFilterResonance = 0.25
local synthFilterFrequency = 300

function setup()
  -- Background
  sourhall = graphics.image.new("images/sourhall_400x240.png")
  assert(sourhall)
  
  graphics.sprite.setBackgroundDrawingCallback(
      function( x, y, width, height )
          sourhall:draw(0, 0)
      end
  )
  
  -- Turbines   
  turbineA = TurbineSprite()
  turbineA:moveTo(42, 77)
  turbineA:setScale(0.50)
  turbineA:add()
  turbineALoop.frame = 1
  
  turbineB = TurbineSprite()
  turbineB:moveTo(60, 84)
  turbineB:setScale(0.35)
  turbineB:add()
  turbineBLoop.frame = 4
  
  turbineC = TurbineSprite()
  turbineC:moveTo(178, 79)
  turbineC:setScale(0.40)
  turbineC:add()
  turbineCLoop.frame = 8
  
  turbineD = TurbineSprite()
  turbineD:moveTo(196, 74)
  turbineD:setScale(0.50)
  turbineD:add()
  turbineDLoop.frame = 10
  
  -- Audio
  synth = sound.synth.new(playdate.sound.kWaveNoise)
  filter = sound.twopolefilter.new("lowpass") -- XXX - snd.kFilterLowPass should work
  filter:setResonance(synthFilterResonance)
  filter:setFrequency(synthFilterFrequency)
  sound.addEffect(filter)
  synth:playNote(220)
  synth:setVolume(0.04)
  
  -- Snow
  for i = 1, 1000 do
    local raindrop = Raindrop()
    raindrop.location = Vector:create(math.random(0, width * 1.25), math.random(-400, 0))
    raindrop.speed = math.random(2, 6)
    table.insert(raindrops, raindrop)
  end

end

function draw()
  turbineA:setImage(turbineALoop:image())
  turbineB:setImage(turbineBLoop:image())
  turbineC:setImage(turbineCLoop:image())
  turbineD:setImage(turbineDLoop:image())
  
  graphics.sprite.update()
  
  playdate.graphics.setColor(playdate.graphics.kColorXOR)
  for i = 1, #raindrops do
    local raindrop = raindrops[i]
    line(raindrop.location.x + 3 * windspeed, raindrop.location.y - 1, raindrop.location.x, raindrop.location.y)
    raindrop.location.y = raindrop.location.y + raindrop.speed
    raindrop.location.x = raindrop.location.x - (raindrop.speed * windspeed)
    if(raindrop.location.y > height + 1) then
      raindrop.location = Vector:create(math.random(0, (width * 1.25)), math.random(-100, 0))
    end
  end
  
  if(upPressed())then
    synth:stop()
  end
  
  if(downPressed())then 
    synth:playNote(220)
  end
end