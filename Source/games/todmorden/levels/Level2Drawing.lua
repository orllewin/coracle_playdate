class('Level2Drawing').extends(Drawing)

local onNext = nil

function Level2Drawing:init(_onNext)
  onNext = _onNext
end