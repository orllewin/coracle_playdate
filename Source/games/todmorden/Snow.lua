class("Snow").extends()
class('Snowflake').extends()

local graphics <const> = playdate.graphics
local snowflakes = {}
local ground = {}

local snowSettles = false
local windspeed = 0.0
local frame = 0

function Snow:init(settles, snowflakeCount, size, maxSpeed)
  for i, v in ipairs(snowflakes) do snowflakes[i] = nil end

  for i = 1, snowflakeCount do
    local snowflake = Snowflake()
    snowflake.location = Vector:create(math.random(0, width * 1.25), math.random(-400, 0))
    snowflake.speed = math.random(1, maxSpeed)
    snowflake.size = size
    snowflake.direction = math.random(-2, 2)
    table.insert(snowflakes, snowflake)
  end
  
  snowSettles = settles
  
  if(snowSettles)then
    for g = 1, width do
      ground[g] = 0
    end 
  end
end

function Snow:draw()
  
  frame += 1

  for i = 1, #snowflakes do
    local snowflake = snowflakes[i]
    
    if(snowflake.size == 1)then
      line(snowflake.location.x + 3 * windspeed, snowflake.location.y - 1, snowflake.location.x, snowflake.location.y)
    else
      circle(snowflake.location.x, snowflake.location.y, snowflake.size)
    end

    snowflake.location.y = snowflake.location.y + snowflake.speed
    
    local wind = graphics.perlin(snowflake.speed, snowflake.location.y * 0.0055, frame * 0.0055) - 0.5
    snowflake.location.x = snowflake.location.x + (wind * snowflake.speed) + snowflake.direction
    if(snowflake.location.y > height + 1) then
      snowflake.location = Vector:create(math.random(0, (width * 1.25)), math.random(-100, 0))
      
      if(snowSettles and snowflake.location.x > 0 and snowflake.location.x < width)then
        local index = snowflake.location.x
        
        local average = 0
        average += ground[ring(index + 1, 1, 400)]
        average += ground[ring(index + 2, 1, 400)]
        average += ground[ring(index + 3, 1, 400)]
        
        average += ground[ring(index - 1, 1, 400)]
        average += ground[ring(index - 2, 1, 400)]
        average += ground[ring(index - 3, 1, 400)]
        
        average = average / 6
        if(average > 0)then
          ground[index] = average + 1
        else
          ground[index] = ground[index] + 1
        end
      end
    end
  end
  
  if(snowSettles)then
    graphics.setColor(playdate.graphics.kColorWhite)
    for g = 1, #ground do
      local gSize = ground[g]
      if(gSize > 0)then
        line(g, height - gSize, g, height)
      end
    end
  end
end

function ring(a, min, max)
  if min > max then
    min, max = max, min
  end
  return min + (a-min) % (max-min)
end
