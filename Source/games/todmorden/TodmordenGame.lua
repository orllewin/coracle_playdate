import 'coracle/Coracle'
import 'games/todmorden/splash/SplashDrawing'

class('TodmordenGame').extends(Game)

onSplashDismiss = function()
  print('Splash dismissed')
end

local splashDrawing = SplashDrawing(onSplashDismiss)

function TodmordenGame:setup()
  -- todo deprecate this
end

function TodmordenGame:draw()
  splashDrawing:draw()
end