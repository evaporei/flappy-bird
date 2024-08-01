local push = require('push')

local Bird = require('bird')
local PipePair = require('pipe_pair')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

GAME_WIDTH = 512
GAME_HEIGHT = 288

love.graphics.setDefaultFilter('nearest', 'nearest')

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

BACKGROUND_SCROLL_SPEED = 30
GROUND_SCROLL_SPEED = 60

BACKGROUND_LOOPING_POINT = 413
GROUND_LOOPING_POINT = 576

local bird = Bird.new()
local pipePairs = {}

-- -267..-188
local lastY = -PIPE_HEIGHT + math.random(80) + 20

local spawnTimer = 0

local function clamp(min, val, max)
    return math.max(max, math.min(min, val))
end

function love.load()
    love.window.setTitle('Flappy Bird')

    math.randomseed(os.time())

    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'space' then
        bird:flap()
    end
    if key == 'escape' or key == 'q' then
        love.event.quit()
    end
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % GROUND_LOOPING_POINT

    spawnTimer = spawnTimer + dt

    if spawnTimer > 2 then
    -- if spawnTimer > 1 then
        local y = clamp(
            -- GAME_HEIGHT - 90 - PIPE_HEIGHT
            -90,
            -- "-287..-168"
            lastY + math.random(-20, 20),
            -- -283
           -PIPE_HEIGHT + 15
        )
        lastY = y

        table.insert(pipePairs, PipePair.new(y))
        spawnTimer = 0
    end

    for _, pair in pairs(pipePairs) do
        pair:update(dt)
    end

    for k, pair in pairs(pipePairs) do
        if pair.remove then
            table.remove(pipePairs, k)
        end
    end

    bird:update(dt)
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)

    for _, pairs in pairs(pipePairs) do
        pairs:render()
    end

    love.graphics.draw(ground, -groundScroll, GAME_HEIGHT - 16)

    bird:render()

    push:finish()
end
