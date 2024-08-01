local Pipe = {}

PIPE_IMAGE = love.graphics.newImage('pipe.png')

PIPE_HEIGHT = 288
PIPE_WIDTH = 77

PIPE_SPEED = 60
-- PIPE_SPEED = 160

function Pipe.new(orientation, y)
    local self = {}

    self.x = GAME_WIDTH
    self.y = y

    self.width = PIPE_HEIGHT
    self.orientation = orientation

    setmetatable(self, { __index = Pipe })
    return self
end

function Pipe:update(dt)
    self.x = self.x - PIPE_SPEED * dt
end

function Pipe:render()
    love.graphics.draw(
        -- drawable
        PIPE_IMAGE,
        -- x
        self.x,
        -- y
        (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y),
        -- r (orientation in radians) - not used
        0,
        -- x scale (keep the same)
        1,
        -- y scale (invert if necessary)
        self.orientation == 'top' and -1 or 1
    )
end

return Pipe
