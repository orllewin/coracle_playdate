--[[
  PerlinFlowFieldDrawing
  A port of Perlin Noise: https://orllewin.github.io/coracle/drawings/experiments/perlin_noise/
]]
import 'coracle/Vector'
import 'coracle/SECL.lua'

local bodyCount = 200
local tailLength = 40
local frame = 0

local speed = 3.3
local scale = 0.02
local bodies = {}

local xOffset = 0.0
local yOffset = 0.0

local epochAge = 0
local epochLength = 100

function setup()
  for i = 1 , bodyCount do
    local boid = class:new()
    boid.location = Vector:create(math.random(width), math.random(height))
    boid.age = 0
    boid.deathAge = math.random(100, 400)
    boid.tailXs = {}
    boid.tailYs = {}
    
    for t = 1, tailLength do
      boid.tailXs[t] = -1
      boid.tailYs[t] = -1
    end
    table.insert(bodies, boid)
  end
  
  xOffset = math.random(10000)
  yOffset = math.random(10000)
end

function draw()
  background()
  
  fill(1.0)
  
  for i = 1, bodyCount do
    local body = bodies[i]
    circle(body.location.x, body.location.y, 1)
    
    for t = 1, tailLength do
      point(body.tailXs[t], body.tailYs[t])
    end
  end
  
  update()
  
  if(crankUp())then
    scale = scale + 0.0001
  end
  
  if(crankDown())then
    scale = scale - 0.0001
  end
  
  text('Scale: ' .. scale, 5, height - 30)
  
  frame = frame + 1
  epochAge = epochAge + 1
  
  if(epochAge > epochLength)then
    print("Epoch reset")
    epochAge = 0
    xOffset = math.random(10000)
    yOffset = math.random(10000)
  end
end

function update()
  for i = 1, bodyCount do
    
    local body = bodies[i]
    
    local a = 2 * TAU * perlinNoise((body.location.x + xOffset) * scale, (body.location.y + yOffset) * scale)
    body.location.x = body.location.x + (math.cos(a) * speed)
    body.location.y = body.location.y + (math.sin(a )* speed)
    
    local tailIndex = frame % tailLength
    body.tailXs[tailIndex] = body.location.x
    body.tailYs[tailIndex] = body.location.y
    
    if (body.location.x > width)then
      body.location.x = math.random(width)
      body.location.y = math.random(height)
    end
    if (body.location.x < 0)then 
      body.location.x = math.random(width)
      body.location.y = math.random(height)
    end
    if (body.location.y > height)then
      body.location.x = math.random(width)
      body.location.y = math.random(height)
     end
    if (body.location.y < 0)then
      body.location.x = math.random(width)
      body.location.y = math.random(height)
    end
    
    body.age = body.age + 1
    
    if(body.age > body.deathAge)then
      body.location.x = math.random(width)
      body.location.y = math.random(height)
      body.age = 0
      body.deathAge = math.random(100, 2000)
    end
  end
end
