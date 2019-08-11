-- gotta say, Lua's dependencies system is far superior to Python's
require "src/dependencies"

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	math.randomseed(os.time())
	love.window.setTitle("Destroy CS50")
	
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	})
	
	gTextures = {
		["player_ship"] = love.graphics.newImage("graphics/player/ship2.png"),
		["player_shot"] = love.graphics.newImage("graphics/player/playershot.png"),
		["explosion"] = love.graphics.newImage("graphics/shared/explosion.png"),
		["breakout"] = love.graphics.newImage("graphics/enemy/breakout.png")
	}
	
	gFrames = {
		["explosion"] = GenerateQuads(gTextures["explosion"], 16, 16),
		["breakout_bricks"] = GenerateQuads(gTextures["breakout"], 32, 16), -- valid values: 1-21
		["breakout_balls"] = GenerateQuads(gTextures["breakout"], 8, 8) -- valid values: 157-160, 181-183 inclusive
	}
	
	gStateMachine = StateMachine {
		["play"] = function() return PlayState() end
	}
	gStateMachine:change("play", {})
	
	love.keyboard.keysPressed = {}
end

function love.resize(w, h)
	push:resize(w, h)
end

function love.update(dt)
	gStateMachine:update(dt)
	
	love.keyboard.keysPressed = {}
end

function love.keypressed(key)
	love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
	if love.keyboard.keysPressed[key] then
		return true
	else
		return false
	end
end

function love.draw()
	push:apply("start")
	
	gStateMachine:render()
	
	push:apply("end")
end