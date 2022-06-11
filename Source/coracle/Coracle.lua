import 'CoreLibs/graphics'
import 'CoreLibs/object'

class('Drawing').extends()

local graphics <const> = playdate.graphics

DrawingMode = {Stroke = "0", Fill = "1", FillAndStroke = "2"}

TAU = 6.28318

mode = DrawingMode.FillAndStroke
alpha = 1.0

width = 400
height = 240


function background()
  graphics.clear(graphics.kColorWhite)
end

function noStroke()
  mode = DrawingMode.Fill
end

function noFill()
  mode = DrawingMode.Stroke
  graphics.setDitherPattern(0.0, playdate.graphics.image.kDitherTypeScreen)
end

function stroke()
  if(mode == DrawingMode.Fill) 
  then
    mode = DrawingMode.FillAndStroke
  end
end

function fill()
  if(mode == DrawingMode.Stroke)
  then
    mode = DrawingMode.FillAndStroke
  end
end

-- alpha: 0.0 to 1.0
function fill(alpha)
  alpha = alpha
  graphics.setDitherPattern(1.0 - alpha, playdate.graphics.image.kDitherTypeBayer8x8)
  if(mode == DrawingMode.Stroke) 
  then
    mode = DrawingMode.FillAndStroke
  end
end

function text(text, x, y)
  graphics.drawText(text, x, y)
end
 

function circle(x, y, r)
  if(mode == DrawingMode.FillAndStroke)
  then
    graphics.fillCircleAtPoint(x, y, r)
    graphics.drawCircleAtPoint(x, y, r)
  elseif(mode == DrawingMode.Fill)
  then
    graphics.fillCircleAtPoint(x, y, r)
  else
    graphics.drawCircleAtPoint(x, y, r)
  end
end

function square(x, y, d)
	if(mode == DrawingMode.FillAndStroke)
	then
		graphics.fillRect(x, y, d, d)
		graphics.drawRect(x, y, d, d)
	elseif(mode == DrawingMode.Fill)
	then
		graphics.fillRect(x, y, d, d)
	else
		graphics.drawRect(x, y, d, d)
	end
end

function line(x1, y1, x2, y2)
	graphics.drawLine(x1, y1, x2, y2)
end

function point(x, y)
	graphics.drawPixel(x, y)
end

function cross(x, y, size)
	line(x, y - size, x, y + size)
	line(x - size, y, x + size, y)
end

function clearLog()
  playdate.clearConsole()
end

function crankUp()
	local change, acceleratedChange = playdate.getCrankChange()
	if(change > 0.0)
	then
		return true
	else
		return false
	end
end

function crankDown()
	local change, acceleratedChange = playdate.getCrankChange()
	if(change < 0.0)
	then
		return true
	else
		return false
	end
end

function aPressed()
  return playdate.buttonJustPressed(playdate.kButtonA)
end

function bPressed()
  return playdate.buttonJustPressed(playdate.kButtonB)
end

function upPressed()
  return playdate.buttonIsPressed(playdate.kButtonUp)
end

function downPressed()
  return playdate.buttonIsPressed(playdate.kButtonDown)
end

function leftPressed()
  return playdate.buttonIsPressed(playdate.kButtonLeft)
end

function rightPressed()
  return playdate.buttonIsPressed(playdate.kButtonRight)
end

function perlinNoise(x, y)
	return playdate.graphics.perlin(x, y, 1)
end

-- Accelerometer

function accelerometerStart()
  playdate.startAccelerometer()
end

function accelerometerRead()
  return playdate.readAccelerometer()
end

-- audio
function sampleLoad(path)
  return playdate.sound.sampleplayer.new(path)
end