local Pipe = {}

PIPE_IMAGE = love.graphics.newImage('pipe.png')

PIPE_SCROLL = -60

function Pipe.new()
    local self = {}

    self.x = GAME_WIDTH
    self.y = math.random(GAME_HEIGHT / 4, GAME_HEIGHT - 10)

    self.width = PIPE_IMAGE:getWidth()

    setmetatable(self, { __index = Pipe })
    return self
end

function Pipe:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end

function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, self.x, self.y)
end

return Pipe
