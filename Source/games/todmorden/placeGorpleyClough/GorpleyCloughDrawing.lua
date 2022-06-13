import 'CoreLibs/graphics'
import 'CoreLibs/animation'
import 'CoreLibs/timer'

import 'coracle/Coracle'
import 'coracle/Vector'
import 'coracle/FlowingWater'
import 'coracle/Precipitation'

class('GorpleyCloughDrawing').extends(Drawing)

local graphics <const> = playdate.graphics

local waterfallSmall = FlowingWater:create(15, 1, 165, 183, 97, 110)
local waterfallMain = FlowingWater:create(800, 5, 155, 320, 140, 240)
local pollen = Precipitation:create(false, 15, 2, 1)

local sound <const> = playdate.sound
local synthFilterResonance = 0.1
local synthFilterFrequency = 400

local onGorpleyDismiss = nil

local splashImage = playdate.graphics.image.new("games/todmorden/placeGorpleyClough/images/gorpleyclough")
assert(splashImage)

synth = sound.synth.new(playdate.sound.kWaveNoise)
filter = sound.twopolefilter.new("lowpass") -- XXX - snd.kFilterLowPass should work
filter:setResonance(synthFilterResonance)
filter:setFrequency(synthFilterFrequency)
sound.addEffect(filter)
synth:setVolume(0.04)

function GorpleyCloughDrawing:init(_onGorpleyDismiss)
  print("GorpleyCloughDrawing:init")
  onGorpleyDismiss = _onGorpleyDismiss
    
  -- Audio
  self.start()
end

function GorpleyCloughDrawing:start()
  synth:playNote(330)
end

function GorpleyCloughDrawing:draw()
  splashImage:draw(0, 0)
  
  waterfallSmall:draw(graphics.kColorXOR)
  waterfallMain:draw(graphics.kColorXOR)
  
  graphics.setColor(playdate.graphics.kColorWhite)
  pollen:draw()
  
  if(aPressed())then
    synth:stop()
    onGorpleyDismiss()
  end
end