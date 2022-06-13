import 'coracle/Coracle'
import 'games/todmorden/placeSourhall/SourhallDrawing'
import 'games/todmorden/placeGorpleyClough/GorpleyCloughDrawing'

class('TodmordenGame').extends(Game)

onSplashDismiss = function()
  print('Splash dismissed')
end

local sourhallDrawing = SourhallDrawing(onSplashDismiss)
local gorpleyCloughDrawing = GorpleyCloughDrawing(onSplashDismiss)


function TodmordenGame:draw()
  gorpleyCloughDrawing:draw()
end