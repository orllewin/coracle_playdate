import 'coracle/Coracle'
import 'games/todmorden/placeSourhall/SourhallDrawing'
import 'games/todmorden/placeGorpleyClough/GorpleyCloughDrawing'

class('TodmordenGame').extends(Game)

Screens = {gorpley = "0", sourhall = "1"}
screen = Screens.sourhall

onSourhallDismiss = function()
  screen = Screens.gorpley
end

onGorpleyDismiss = function()
  screen = Screens.sourhall
end

gorpleyCloughDrawing = GorpleyCloughDrawing(onGorpleyDismiss)
sourhallDrawing = SourhallDrawing(onSourhallDismiss)

function TodmordenGame:draw()
  if(screen == Screens.gorpley)then
    gorpleyCloughDrawing:draw()
  elseif(screen == Screens.sourhall)then
    sourhallDrawing:draw()
  end
end