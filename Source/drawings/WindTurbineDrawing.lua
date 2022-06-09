--[[
  WindTurbineDrawing
  Experimenting with sprites on Playdate
]]

import 'CoreLibs/sprites.lua'
import 'CoreLibs/graphics.lua'

local gfx <const> = playdate.graphics
turbineTable = playdate.graphics.imagetable.new("images/turbines")

local turbineImages = {}
for i = 1, 12 do
  if(i < 10)then
    turbineImages[i] = gfx.image.new('images/turbines_sprite_playdate_00'..i)
  else
    turbineImages[i] = gfx.image.new('images/turbines_sprite_playdate_0'..i)
  end
end

class('TurbineSprite').extends(playdate.graphics.sprite)

function setup()
  sourhall = gfx.image.new("images/sourhall_400x240.png")
  assert(sourhall)
  
  
  
  turbineA = TurbineSprite()
  local turbine = gfx.image.new("images/turbine_sprite_64x64.png")
  assert(turbine)
  turbineA:setImage(turbine)
  turbineA:moveTo(100, 75)
  turbineA:add()
  
  gfx.sprite.setBackgroundDrawingCallback(
      function( x, y, width, height )
          sourhall:draw( 0, 0 )
      end
  )

end

frame = 0
turbineAIndex = 1

function draw()
  frame = frame + 1
  
  if(frame % 4 == 0)then
    turbineAIndex = turbineAIndex + 1
    local turbineFrame = turbineImages[turbineAIndex]
    turbineA:setImage(turbineFrame)
    
    if(turbineAIndex == 12)then
      turbineAIndex = 0
    end
  end

  gfx.sprite.update()
end