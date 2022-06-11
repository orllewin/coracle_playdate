import 'coracle/Coracle'
import 'drawings/ShadowParallaxDrawing'

local shadowParallaxDrawing = ShadowParallaxDrawing()

function init()
	shadowParallaxDrawing:setup()
end

init()

function playdate.update()	
	shadowParallaxDrawing:draw()
end