local push = require('push')

love.graphics.setDefaultFilter('nearest', 'nearest')

local StateMachine = require('state_machine')
local TitleScene = require('scenes.title')
local PlayScene = require('scenes.play')
local ScoreScene = require('scenes.score')
local CountdownScene = require('scenes.countdown')

local sounds = require('sounds')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

GAME_WIDTH = 512
GAME_HEIGHT = 288

local background = love.graphics.newImage('sprites/background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('sprites/ground.png')
local groundScroll = 0

BACKGROUND_SCROLL_SPEED = 30
GROUND_SCROLL_SPEED = 60

BACKGROUND_LOOPING_POINT = 413
GROUND_LOOPING_POINT = 576

local stateMachine = StateMachine.new(
    {
        ['title'] = TitleScene.new,
        ['play'] = PlayScene.new,
        ['score'] = ScoreScene.new,
        ['countdown'] = CountdownScene.new
    }
)

function love.load()
    love.window.setTitle('Flappy Bird')

    math.randomseed(os.time())

    stateMachine:change('title')

    sounds['music']:setLooping(true)
    sounds['music']:play()

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
    stateMachine:handleInput(key)

    if key == 'escape' or key == 'q' then
        love.event.quit()
    end
end

function love.mousepressed(_, _, _)
    stateMachine:handleInput('mouse')
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % GROUND_LOOPING_POINT

    stateMachine:update(dt)
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)

    stateMachine:render()

    love.graphics.draw(ground, -groundScroll, GAME_HEIGHT - 16)

    push:finish()
end
