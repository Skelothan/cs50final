-- gotta say, Lua's dependencies system is far superior to Python's
require "src/dependencies"

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	math.randomseed(os.time())
	love.window.setTitle("Destroy CS50G")
	
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	})
	
	gTextures = {
		["player_ship"] = love.graphics.newImage("graphics/player/ship2.png"),
		["player_shot"] = love.graphics.newImage("graphics/player/playershot.png"),
		["eff_player_shot"] = love.graphics.newImage("graphics/player/effect_playershot.png"),
		["eff_explosion"] = love.graphics.newImage("graphics/shared/explosion.png"),
		["breakout"] = love.graphics.newImage("graphics/enemy/breakout.png"),
		["legend_of_fifty"] = love.graphics.newImage("graphics/enemy/legend_of_fifty.png"),
		["enemy_shots"] = love.graphics.newImage("graphics/enemy/enemy_shots.png")
	}
	
	gFrames = {
		["eff_explosion"] = GenerateQuads(gTextures["eff_explosion"], 16, 16),
		["eff_player_shot"] = GenerateQuads(gTextures["eff_player_shot"], 16, 16),
		["breakout_bricks"] = GenerateQuads(gTextures["breakout"], 32, 16), -- valid values: 1-21
		["breakout_balls"] = GenerateQuads(gTextures["breakout"], 8, 8), -- valid values: 157-160, 181-183 inclusive
		["legend_of_fifty"] = GenerateQuads(gTextures["legend_of_fifty"], 16, 16),
		["enemy_shots"] = GenerateQuads(gTextures["enemy_shots"], 8, 8)
	}
	
	gStateMachine = StateMachine {
		["start"] = function() return StartState() end,
		["play"] = function() return PlayState() end,
		["game_over"] = function() return GameOverState() end
	}
	gStateMachine:change("start", {})
	
	gFonts = {
		["medium"] = love.graphics.newFont("fonts/font.ttf", 16),
		["large"] = love.graphics.newFont("fonts/font.ttf", 32)
	}
	love.graphics.setFont(gFonts["medium"])
	
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