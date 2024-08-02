local BaseScene = require('scenes.base')
local fonts = require('fonts')

local ScoreScene = {}
setmetatable(ScoreScene, { __index = BaseScene })

function ScoreScene.new(stateMachine)
    local self = {}

    self.stateMachine = stateMachine

    setmetatable(self, { __index = ScoreScene })
    return self
end

function ScoreScene:enter(params)
    self.score = params.score
end

function ScoreScene:handleInput(key)
    if key == 'enter' or key == 'return' then
        self.stateMachine:change('play')
    end
end

function ScoreScene:render()
    love.graphics.setFont(fonts.flappy)
    love.graphics.printf('Oh no, you lost!', 0, 64, GAME_WIDTH, 'center')

    love.graphics.setFont(fonts.medium)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, GAME_WIDTH, 'center')

    love.graphics.printf('Press Enter to play again!', 0, 160, GAME_WIDTH, 'center')
end

return ScoreScene
