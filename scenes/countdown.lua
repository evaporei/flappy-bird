local BaseScene = require('scenes.base')
local fonts = require('fonts')

local CountdownScene = {}
setmetatable(CountdownScene, { __index = BaseScene })

function CountdownScene.new(stateMachine)
    local self = {}

    self.stateMachine = stateMachine

    self.counter = 3
    self.timer = 0

    setmetatable(self, { __index = CountdownScene })
    return self
end

function CountdownScene:update(dt)
    self.timer = self.timer + dt

    -- almost a second
    if self.timer > 0.8 then
        self.counter = self.counter - 1
        self.timer = 0

        if self.counter == 0 then
            self.stateMachine:change('play')
        end
    end
end

function CountdownScene:render()
    love.graphics.setFont(fonts.huge)
    love.graphics.printf(tostring(self.counter), 0, 120, GAME_WIDTH, 'center')
end

return CountdownScene
