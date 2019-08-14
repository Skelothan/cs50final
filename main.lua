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
	
	gMusic = {
		["title"] = love.audio.newSource("music/match3_music1.mp3"),
		["game"] = love.audio.newSource("music/fiftymon_battle_music.mp3")
	}
	for k, track in pairs(gMusic) do
		track:setLooping(true)
	end
	gMusic["game"]:setVolume(0.7)
	
	gSounds = {
		["player_shoot"] = love.audio.newSource("sounds/player_shot.wav"),
		["player_hit"] = love.audio.newSource("sounds/50bros_kill.wav"),
		["player_death"] = love.audio.newSource("sounds/flappy_explosion_echo.wav"),
		["brick_shoot"] = love.audio.newSource("sounds/breakout_paddle_hit.wav"),
		["brick_death"] = love.audio.newSource("sounds/brick-hit-1.wav"),
		["pot_shoot"] = love.audio.newSource("sounds/sword_pot.wav"),
		["pot_death"] = love.audio.newSource("sounds/lo50_hit_enemy.wav")
	}
	
	gFonts = {
		["medium"] = love.graphics.newFont("fonts/font.ttf", 16),
		["large"] = love.graphics.newFont("fonts/font.ttf", 32)
	}
	love.graphics.setFont(gFonts["medium"])
	
	gStateMachine = StateMachine {
		["start"] = function() return StartState() end,
		["play"] = function() return PlayState() end,
		["game_over"] = function() return GameOverState() end
	}
	gStateMachine:change("start", {})
	
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