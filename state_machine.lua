local StateMachine = {}

function StateMachine.new(states, initial)
    local self = {}

    self.states = states
    self.curr = self.states[initial](self)
    self.curr:enter()

    setmetatable(self, { __index = StateMachine })
    return self
end

function StateMachine:change(to)
    self.curr:exit()
    self.curr = self.states[to](self)
    self.curr:enter()
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
