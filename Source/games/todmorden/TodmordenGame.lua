import 'coracle/Coracle'
import 'games/todmorden/placeSourhall/SourhallDrawing'
import 'games/todmorden/placeGorpleyClough/GorpleyCloughDrawing'

class('TodmordenGame').extends(Game)

Screens = {gorpley = "0", sourhall = "1"}
screen = Screens.sourhall

onSourhallDismiss = function()
  print("onSourhallDismiss")
  gorpleyCloughDrawing = GorpleyCloughDrawing(onGorpleyDismiss)
  screen = Screens.gorpley
end

onGorpleyDismiss = function()
  print("onGorpleyDismiss")
  screen = Screens.sourhall
  sourhallDrawing = SourhallDrawing(onSourhallDismiss)
  sourhallDrawing:start()
end

onGorpleyDismiss()

function TodmordenGame:draw()
  --background()
  if(screen == Screens.gorpley)then
    gorpleyCloughDrawing:draw()
  elseif(screen == Screens.sourhall)then
    sourhallDrawing:draw()
  end
end