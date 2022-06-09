--[[
  SourhallDrawing
  Experimenting with images on Playdate
]]
import 'Vector'
import 'SECL.lua'

local synthFilterResonance = 0.45
local synthFilterFrequency = 500

local raindrops = {}
local dropLength = 10

local windspeed = 1.0

function setup()
  sourhall = playdate.graphics.image.new("images/sourhall_400x240.png")
  
  synth = playdate.sound.synth.new(playdate.sound.kWaveNoise)
  filter = playdate.sound.twopolefilter.new("lowpass") -- XXX - snd.kFilterLowPass should work
  filter:setResonance(synthFilterResonance)
  filter:setFrequency(synthFilterFrequency)
  playdate.sound.addEffect(filter)
  synth:playNote(220)
  synth:setVolume(0.02)
  
  for i = 1,400 do
    local raindrop = class:new()
    raindrop.location = Vector:create(math.random(0, width * 2.5), math.random(-400, 0))
    raindrop.speed = math.random(2, 6)
    table.insert(raindrops, raindrop)
  end
end

function draw()
  sourhall:draw(0, 0)
  
  playdate.graphics.setColor(playdate.graphics.kColorXOR)
  for i = 1, #raindrops do
    local raindrop = raindrops[i]
    line(raindrop.location.x + 3 * windspeed, raindrop.location.y - dropLength, raindrop.location.x, raindrop.location.y)
    raindrop.location.y = raindrop.location.y + raindrop.speed
    raindrop.location.x = raindrop.location.x - (raindrop.speed * windspeed)
    if(raindrop.location.y > height + dropLength) then
      raindrop.location = Vector:create(math.random(0, (width * 3)), math.random(-100, 0))
    end
  end
  
  if(upPressed())then
    synth:stop()
  end
  
  if(downPressed())then
    synth:playNote(220)
  end
  
  if(crankUp())then      
    windspeed = windspeed + 0.02
    windspeed = math.min(windspeed, 10)
    synthFilterFrequency = synthFilterFrequency + 5
    synthFilterFrequency = math.min(synthFilterFrequency, 1000)
    filter:setFrequency(synthFilterFrequency)
  end
  
  if(crankDown())then  
    windspeed = windspeed - 0.02  
    windspeed = math.max(windspeed, 1)
    synthFilterFrequency = synthFilterFrequency - 5
    synthFilterFrequency = math.max(synthFilterFrequency, 150)
    filter:setFrequency(synthFilterFrequency)
  end
end