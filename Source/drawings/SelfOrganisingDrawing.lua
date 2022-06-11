--[[
  SelfOrganisingDrawing
  A port of Self Organising Lattice: https://orllewin.github.io/coracle/drawings/circle_packing/self_organising/
]]
import 'coracle/Vector'
import 'coracle/SECL.lua'

local maxSpeed <const> = 0.8
local cellWidth = 40.0
local cellRadius = cellWidth/2.0
local cellInnerRadius = cellWidth/4
local bodies = {}

local blackhole = Vector:create(width/2, height/2)

local clickA = sampleLoad("audio/click_a")
local clickB = sampleLoad("audio/click_b")
local clickC = sampleLoad("audio/click_c")
local clickSamples = {clickA, clickB, clickC}

local synthFilterResonance = 0.45
local synthFilterFrequency = 500

function setup()
  local boid = class:new()
  boid.location = Vector:create(width/2  + math.random(-5, 5), height/2 + math.random(-5, 5))
  boid.velocity = Vector:create(0, 0)
  table.insert(bodies, boid)
  
  accelerometerStart()
  
  synth = playdate.sound.synth.new(playdate.sound.kWaveNoise)
  filter = playdate.sound.twopolefilter.new("lowpass") -- XXX - snd.kFilterLowPass should work
  filter:setResonance(synthFilterResonance)
  filter:setFrequency(synthFilterFrequency)
  playdate.sound.addEffect(filter)
  synth:playNote(220)
  synth:setVolume(0.02)
end

function draw()
  background()
  
  --draw blackhole
  fill(1.0)
  cross(blackhole.x, blackhole.y, 15)
  
  for i = 1, #bodies do
    local body = bodies[i]
    noFill()
    stroke()
    circle(body.location.x, body.location.y, cellRadius)
    
    fill(0.3)
    circle(body.location.x, body.location.y, cellInnerRadius)
  end
  

  if(upPressed())then
    synth:stop()
  end
  
  if(downPressed())then
    synth:playNote(220)
  end
  
  if(aPressed())then
      randomClick()
      local boid = class:new()
      boid.location = Vector:create(width/2  + math.random(-5, 5), height/2 + math.random(-5, 5))
      boid.velocity = Vector:create(0, 0)
      table.insert(bodies, boid)
  end
  
  if(bPressed())then
    if(#bodies > 1)then
      randomClickBackwards()
      local deleteIndex = math.random(#bodies)
      table.remove(bodies, deleteIndex)
    end
  end
  
  if(crankUp())then
    cellWidth = cellWidth + 0.2
    cellRadius = cellWidth/2.0
    cellInnerRadius = cellWidth/4
      
    synthFilterFrequency = synthFilterFrequency + 5
    synthFilterFrequency = math.min(synthFilterFrequency, 1000)
    filter:setFrequency(synthFilterFrequency)
  end
  
  if(crankDown())then
    cellWidth = cellWidth - 0.2
    cellRadius = cellWidth/2.0
    cellInnerRadius = cellWidth/4
    
    synthFilterFrequency = synthFilterFrequency - 5
    synthFilterFrequency = math.max(synthFilterFrequency, 150)
    filter:setFrequency(synthFilterFrequency)
  end
  
  updateBlackhole()
  update()
end

function randomClick()
  local sample = clickSamples[math.random(#clickSamples)]
  sample:setRate(0.5)
  sample.play(sample, 1)
end

function randomClickBackwards()
  local sample = clickSamples[math.random(#clickSamples)]
  sample:setRate(1.0)
  sample.play(sample, 1)
end

function updateBlackhole()
  local x, y, z = accelerometerRead()
  -- values are -1.0 to 1.0 we need it in form 0.0 to 1.0
  blackhole.x = 400.0 * ((x + 1.0)/2.0)
  blackhole.y = 240.0 * ((y + 1.0)/2.0)
end

function update()
  for i = 1, #bodies do
  

    local body = bodies[i]
    
    local blackholeDirection = vectorMinus(blackhole, body.location)
    blackholeDirection:normalise()
    blackholeDirection:times(0.09)
    
    body.velocity:plus(blackholeDirection)
    body.location:plus(body.velocity)
    
    local closestDistance = 1000.0
    local closestIndex = -1
    
    for ii = 1, #bodies do
      if (i ~= ii) then
        local other = bodies[ii]
        local dist = body.location:distance(other.location)
        if(dist < closestDistance)then
            closestIndex = ii
            closestDistance = dist
        end  
      end
    end
    
    local closest = bodies[closestIndex]
    
    if(closestDistance < cellWidth)then
      local direction = vectorMinus(closest.location, body.location)
      direction:normalise()
      direction:times(-0.5)
      
      body.velocity:plus(direction)
      body.velocity:limit(maxSpeed)
    end
    
    body.location:plus(body.velocity)
    
    if(body.location.y > height - cellRadius)then
      body.location.y = height - cellRadius
    end
    if(body.location.y < cellRadius)then
      body.location.y = cellRadius
    end
    if(body.location.x > width - cellRadius)then
      body.location.x = width - cellRadius
    end
    if(body.location.x < cellRadius)then
      body.location.x = cellRadius
    end
  
  end
  
end