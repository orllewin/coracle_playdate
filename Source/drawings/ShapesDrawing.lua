--[[
  ShapesDrawing
  A port of Shapes: https://orllewin.github.io/coracle/drawings/basic/shapes_and_colours/
]]

function setup()
end

function draw()
  background()
  
  local d = height/4
  local r = d/2
  
  fill(1.0)
  square(0, 0, d)
  circle(r, d + r, r)
  square(0, d * 2, d)
  circle(r, d * 3 + r, r)
  
  fill(0.9)
  circle(r + d, r, r)
  square(d, d, d)
  circle(r + d, d * 2 + r, r)
  square(d, d * 3, d)
  
  fill(0.8)
  square(d * 2, 0, d)
  circle(d * 2 + r, d + r, r)
  square(d * 2, d * 2, d)
  circle(d * 2 + r, d * 3 + r, r)
  
  fill(0.7)
  circle(r + d * 3, r, r)
  square(d * 3, d, d)
  circle(r + d * 3, d * 2 + r, r)
  square(d * 3, d * 3, d)
  
  fill(0.5)
  square(d * 4, 0, d)
  circle(d * 4 + r, d + r, r)
  square(d * 4, d * 2, d)
  circle(d * 4 + r, d * 3 + r, r)
  
  fill(0.3)
  circle(r + d * 5, r, r)
  square(d * 5, d, d)
  circle(r + d * 5, d * 2 + r, r)
  square(d * 5, d * 3, d)
  
  fill(0.1)
  square(d * 6, 0, d)
  circle(d * 6 + r, d + r, r)
  square(d * 6, d * 2, d)
  circle(d * 6 + r, d * 3 + r, r)
end