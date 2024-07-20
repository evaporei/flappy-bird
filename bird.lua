local Bird = {}

GRAVITY = 20

function Bird.new()
    local self = {}

    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    -- mid screen
    self.x = GAME_WIDTH / 2 - (self.width / 2)
    self.y = GAME_HEIGHT / 2 - (self.height / 2)

    -- velocity / gravity
    self.vy = 0

    setmetatable(self, { __index = Bird })
    return self
end

function Bird:update(dt)
    self.vy = self.vy + GRAVITY * dt

    self.y = self.y + self.vy
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end

return Bird
