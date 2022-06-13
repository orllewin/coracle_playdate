

class('TestCardDrawing').extends(Drawing)

local testCard = playdate.graphics.image.new("images/playdate_test_card")
assert(testCard)

local onTestCardDismiss = nil

function TestCardDrawing:init(_onTestCardDismiss)
  onTestCardDismiss = _onTestCardDismiss
end


function TestCardDrawing:draw()
  testCard:draw(0, 0)
  
  if(aPressed())then
    onTestCardDismiss()
  end
end