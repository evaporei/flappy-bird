local BaseScene = require('scenes.base')
local Bird = require('bird')
local PipePair = require('pipe_pair')
local fonts = require('fonts')

local function clamp(min, val, max)
    return math.max(max, math.min(min, val))
end

local PlayScene = {}
setmetatable(PlayScene, { __index = BaseScene })

function PlayScene.new(stateMachine)
    local self = {}

    self.stateMachine = stateMachine

    self.bird = Bird.new()
    self.pipePairs = {}

    -- -267..-188
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
    self.spawnTimer = 0

    self.score = 0

    setmetatable(self, { __index = PlayScene })
    return self
end

function PlayScene:handleInput(key)
    if key == 'space' then
        self.bird:flap()
    end
end

function PlayScene:update(dt)
    self.spawnTimer = self.spawnTimer + dt

    if self.spawnTimer > 2 then
    -- if spawnTimer > 1 then
        local y = clamp(
            -- -232
            GAME_HEIGHT - 90 - PIPE_HEIGHT,
            -- "-287..-168"
            self.lastY + math.random(-20, 20),
            -- -283
            -PIPE_HEIGHT + 15
        )
        self.lastY = y

        table.insert(self.pipePairs, PipePair.new(y))
        self.spawnTimer = 0
    end

    for _, pair in pairs(self.pipePairs) do
        pair:update(dt)

        if not pair.scored then
            local pipe = pair.pipes['top']
            if pipe.x + pipe.width < self.bird.x then
                self.score = self.score + 1
                pair.scored = true
            end
        end

        for _, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                self.stateMachine:change('score', { score = self.score })
            end
        end
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    self.bird:update(dt)

    if self.bird.y > GAME_HEIGHT - 15 then
        self.stateMachine:change('score', { score = self.score })
    end
end

function PlayScene:render()
    for _, pairs in pairs(self.pipePairs) do
        pairs:render()
    end

    love.graphics.setFont(fonts.flappy)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.bird:render()
end

return PlayScene
