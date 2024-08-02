local BaseScene = require('scenes.base')

local StateMachine = {}

function StateMachine.new(states)
    local self = {}

    self.states = states
    self.curr = BaseScene.new()

    setmetatable(self, { __index = StateMachine })
    return self
end

function StateMachine:change(to, params)
    self.curr:exit()
    self.curr = self.states[to](self)
    self.curr:enter(params)
end

function StateMachine:handleInput(key)
    self.curr:handleInput(key)
end

function StateMachine:update(dt)
    self.curr:update(dt)
end

function StateMachine:render()
    self.curr:render()
end

return StateMachine
