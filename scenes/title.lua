local BaseScene = require('scenes.base')
local fonts = require('fonts')

local TitleScene = {}
setmetatable(TitleScene, { __index = BaseScene })

function TitleScene.new(stateMachine)
    local self = {}

    self.stateMachine = stateMachine

    setmetatable(self, { __index = TitleScene })
    return self
end

function TitleScene:handleInput(key)
    if key == 'enter' or key == 'return' then
        self.stateMachine:change('play')
    end
end

function TitleScene:render()
    love.graphics.setFont(fonts.flappy)
    love.graphics.printf('Flappy Bird', 0, 64, GAME_WIDTH, 'center')

    love.graphics.setFont(fonts.medium)
    love.graphics.printf('Press Enter', 0, 100, GAME_WIDTH, 'center')
end

return TitleScene
