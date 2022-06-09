--[[
  HelloDrawing
  A port of Hello, Coracle: https://orllewin.github.io/coracle/drawings/basic/hello_coracle/
]]

local x = 0
local dInc = 1.0

function setup()
end

function draw()
  background()
  
  y = 0
  d = 3
  
  while(y < height)
  do
    x = 0
  
    while(x < width)
    do
      line(x, y, x, y + d)
      x += d
    end
  
    y = y + d
    d = d + dInc
  end
  
  if(crankUp())then
    dInc = dInc + 0.1
  end
  
  if(crankDown())then
    dInc = dInc - 0.1
  end
  
  dInc = math.max(dInc, 0.01)
end