local BaseScene = {}

function BaseScene.new()
    return setmetatable({}, { __index = BaseScene })
end

function BaseScene:enter()
end

function BaseScene:exit()
end

function BaseScene:handleInput(_)
end

function BaseScene:update(_)
end

function BaseScene:render()
end

return BaseScene
