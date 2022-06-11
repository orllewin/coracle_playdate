--[[
  AvoidClosestDrawing
  A port of Coracle Avoid Closest: https://orllewin.github.io/coracle/drawings/experiments/avoid_closest/
]]
import 'coracle/Vector'
import 'coracle/SECL.lua'

local maxSpeed = 1.5
local cellWidth = 15.0
local bodyCount = 45
local bodies = {}

function setup()
  for i = 1 , bodyCount do
    local boid = class:new()
    boid.location = Vector:create(math.random(width), math.random(height))
    boid.velocity = Vector:create(0, 0)
    table.insert(bodies, boid)
  end
  
  
end

function draw()
  background()
  for i = 1, bodyCount do
    
    fill(0.4)
    circle(bodies[i].location.x, bodies[i].location.y, cellWidth/2)
    
    noFill()
    stroke()
    circle(bodies[i].location.x, bodies[i].location.y, cellWidth)
  end
  
  update()
end

function update()
  for i = 1, bodyCount do
    
    local closestDistance = 1000.0
    local closestIndex = -1
    local body = bodies[i]
    
    for ii = 1, bodyCount do
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
    
    line(body.location.x, body.location.y, closest.location.x, closest.location.y)
    
    local direction = vectorMinus(body.location, closest.location)
    direction:normalise()
    direction:times(0.2)
    
  
    body.velocity:plus(direction)
    body.velocity:limit(maxSpeed)
    body.location:plus(body.velocity)
    
    if (body.location.x > width + cellWidth)then
       body.location.x = -cellWidth
    end
    if (body.location.x < -cellWidth)then 
      body.location.x = width + cellWidth
    end
    if (body.location.y > height + cellWidth)then
       body.location.y = -cellWidth
     end
    if (body.location.y < -cellWidth)then
      body.location.y = height + cellWidth
    end

  end
end
