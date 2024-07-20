local Bird = {}

function Bird.new()
    local self = {}

    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    -- mid screen
    self.x = GAME_WIDTH / 2 - (self.width / 2)
    self.y = GAME_HEIGHT / 2 - (self.height / 2)

    setmetatable(self, { __index = Bird })
    return self
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end

return Bird
