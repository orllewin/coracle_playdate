import 'CoreLibs/graphics'
import 'CoreLibs/animation'
import 'CoreLibs/timer'

import 'coracle/Coracle'
import 'coracle/Vector'
import 'games/todmorden/Snow'
import 'games/todmorden/Waterfall'

class('GorpleyCloughDrawing').extends(Drawing)

local graphics <const> = playdate.graphics

local waterfallSmall
local waterfallMain
local snow

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
  waterfallSmall = Waterfall(15, 2, 165, 183, 97, 110)
  waterfallMain = Waterfall(800, 4, 155, 320, 140, 240)
  snow = Snow(false, 15, 2, 2)
  synth:playNote(330)
end

function GorpleyCloughDrawing:draw()
  splashImage:draw(0, 0)
  
  waterfallSmall:draw()
  waterfallMain:draw()
  
  graphics.setColor(playdate.graphics.kColorWhite)
  snow:draw()
  
  if(aPressed())then
    synth:stop()
    onGorpleyDismiss()
  end
end