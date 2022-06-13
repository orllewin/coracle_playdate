class('Level1Drawing').extends(Drawing)

local onNext = nil

function Level1Drawing:init(_onNext)
  onNext = _onNext
end