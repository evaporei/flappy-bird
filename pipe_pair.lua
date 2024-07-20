local Pipe = require('pipe')

local GAP_HEIGHT = 90

local PipePair = {}

function PipePair.new(y)
    local self = {}

    self.pipes = {
        ['top'] = Pipe.new('top', y),
        ['bottom'] = Pipe.new('bottom', y + PIPE_HEIGHT + GAP_HEIGHT),
    }

    setmetatable(self, { __index = PipePair })
    return self
end

function PipePair:update(dt)
    for _, pipe in pairs(self.pipes) do
        if pipe.x > -PIPE_WIDTH then
            pipe:update(dt)
        else
            self.remove = true
        end
    end
end

function PipePair:render()
    for _, pipe in pairs(self.pipes) do
        pipe:render()
    end
end

return PipePair
