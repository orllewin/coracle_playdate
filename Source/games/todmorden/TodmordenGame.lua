import 'coracle/Coracle'
import 'drawings/TestCardDrawing'
import 'games/todmorden/placeSourhall/SourhallDrawing'
import 'games/todmorden/placeGorpleyClough/GorpleyCloughDrawing'

class('TodmordenGame').extends(Game)

Screens = {testCard = "1", gorpley = "2", sourhall = "3"}
screen = Screens.testCard

onTestCardDismiss = function()
  screen = Screens.gorpley
end

onGorpleyDismiss = function()
  screen = Screens.sourhall
end

onSourhallDismiss = function()
  screen = Screens.testCard
end

testCardDrawing = TestCardDrawing(onTestCardDismiss)
gorpleyCloughDrawing = GorpleyCloughDrawing(onGorpleyDismiss)
sourhallDrawing = SourhallDrawing(onSourhallDismiss)

function TodmordenGame:draw()
  if(screen == Screens.testCard)then
    testCardDrawing:draw()
  elseif(screen == Screens.gorpley)then
    gorpleyCloughDrawing:draw()
  elseif(screen == Screens.sourhall)then
    sourhallDrawing:draw()
  end
end