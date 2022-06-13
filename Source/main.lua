import 'CoreLibs/timer'
import 'coracle/Coracle'
--import 'drawings/ShadowParallaxDrawing'
--local shadowParallaxDrawing = ShadowParallaxDrawing()
import 'games/todmorden/TodmordenGame'

local game = TodmordenGame()

function init()
	--shadowParallaxDrawing:setup()
	game:setup()
end

init()

function playdate.update()	
	--shadowParallaxDrawing:draw()
	game:draw()
end