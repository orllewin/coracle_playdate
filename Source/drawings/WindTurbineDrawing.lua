--[[
  WindTurbineDrawing
  Experimenting with sprites on Playdate
]]

import 'CoreLibs/sprites.lua'
import 'CoreLibs/graphics.lua'
import 'Vector'

local sound <const> = playdate.sound
local graphics <const> = playdate.graphics
local turbineTable = playdate.graphics.imagetable.new("images/turbines")

local frame = 0
local turbineAIndex = 1
local turbineBIndex = 3
local turbineCIndex = 8
local turbineDIndex = 11

local turbineImages = {}
for i = 1, 12 do
  if(i < 10)then
    turbineImages[i] = graphics.image.new('images/small_turbines/turbines_sprite_playdate_00'..i)
  else
    turbineImages[i] = graphics.image.new('images/small_turbines/turbines_sprite_playdate_0'..i)
  end
end

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
  local turbine = graphics.image.new("images/turbine_sprite_64x64.png")
  assert(turbine)
  
  turbineA = TurbineSprite()
  turbineA:setImage(turbine)
  turbineA:moveTo(42, 77)
  turbineA:add()
  
  turbineB = TurbineSprite()
  turbineB:setImage(turbine)
  turbineB:moveTo(60, 84)
  turbineB:add()
  
  turbineC = TurbineSprite()
  turbineC:setImage(turbine)
  turbineC:moveTo(178, 79)
  turbineC:add()
  
  turbineD = TurbineSprite()
  turbineD:setImage(turbine)
  turbineD:moveTo(196, 74)
  turbineD:add()
  
  -- Audio
  synth = sound.synth.new(playdate.sound.kWaveNoise)
  filter = sound.twopolefilter.new("lowpass") -- XXX - snd.kFilterLowPass should work
  filter:setResonance(synthFilterResonance)
  filter:setFrequency(synthFilterFrequency)
  sound.addEffect(filter)
  synth:playNote(220)
  synth:setVolume(0.04)
  
  -- Rain
  for i = 1, 1000 do
    local raindrop = Raindrop()
    raindrop.location = Vector:create(math.random(0, width * 1.25), math.random(-400, 0))
    raindrop.speed = math.random(2, 6)
    table.insert(raindrops, raindrop)
  end

end

function draw()
  frame = frame + 1
  
  -- Turbine A
  if(frame % 3 == 0)then
    turbineAIndex = turbineAIndex + 1
    turbineA:setImage(turbineImages[turbineAIndex])
    
    if(turbineAIndex == 12)then
      turbineAIndex = 0
    end
    
    -- Turbine B
    turbineBIndex = turbineBIndex + 1
    turbineB:setImage(turbineImages[turbineBIndex])
    turbineB:setScale(0.8)
    
    if(turbineBIndex == 12)then
      turbineBIndex = 0
    end
    
    -- Turbine C
    turbineCIndex = turbineCIndex + 1
    turbineC:setImage(turbineImages[turbineCIndex])
    turbineC:setScale(0.9)
    
    if(turbineCIndex == 12)then
      turbineCIndex = 0
    end
    
    -- Turbine D
    turbineDIndex = turbineDIndex + 1
    turbineD:setImage(turbineImages[turbineDIndex])
    
    if(turbineDIndex == 12)then
      turbineDIndex = 0
    end
  end

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