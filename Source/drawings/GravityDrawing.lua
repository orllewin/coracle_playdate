--[[
  GravityDrawing
  A port of Coracle Gravity: https://orllewin.github.io/coracle/drawings/vector/gravity/
]]
import 'Vector'
import 'SECL.lua'

local maxSpeed = 2.2
local bodyCount = 5
local tailLength = 20
local frame = 0

local blackhole = Vector:create(width/2, height/2)
local blackholeSize = 35
local blackholeMass = 0.4
local bodies = {}

function setup()
  for i = 1 , bodyCount do
    local boid = class:new()
    boid.location = Vector:create(math.random(width), math.random(height))
    boid.velocity = Vector:create(0, 0)
    boid.tailXs = {}
    boid.tailYs = {}
    
    for t = 1, tailLength do
      boid.tailXs[t] = -1
      boid.tailYs[t] = -1
    end
    table.insert(bodies, boid)
  end
end

function draw()
  background()
  
  fill(0.25)
  circle(blackhole.x, blackhole.y, blackholeSize)
  
  fill(1.0)
  
  for i = 1, bodyCount do
    local body = bodies[i]
    circle(body.location.x, body.location.y, 5)
    
    for t = 1, tailLength do
      cross(body.tailXs[t], body.tailYs[t], 1)
    end
  end
  
  update()
  
  frame = frame + 1
end

function update()
  for i = 1, bodyCount do
    
    local body = bodies[i]
    
    local blackholeDirection = vectorMinus(blackhole, body.location)
    blackholeDirection:normalise()
    blackholeDirection:times(blackholeMass)
    
    body.velocity:plus(blackholeDirection)
    body.location:plus(body.velocity)
    
    for ii = 1, bodyCount do
      if (i ~= ii) then
        local other = bodies[ii]
        
        bodyDirection = vectorMinus(body.location, other.location)
        bodyDirection:normalise()
        bodyDirection:times(0.03)
        body.velocity:plus(bodyDirection)
        body.velocity:limit(3.0)
        body.location:plus(body.velocity)

      end
    end
    
    local tailIndex = frame % tailLength
    body.tailXs[tailIndex] = body.location.x
    body.tailYs[tailIndex] = body.location.y
  end
  
  if(crankUp())then
    blackholeSize = blackholeSize + 0.5
    blackholeMass = blackholeMass + 0.005
  end
  
  if(crankDown())then
    blackholeSize = blackholeSize - 0.5
    blackholeMass = blackholeMass - 0.005
  end
end
