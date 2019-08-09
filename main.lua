-- gotta say, Lua's dependencies system is far superior to Python's
require 'src/dependencies'

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	math.randomseed(os.time())
	love.window.setTitle('Destroy CS50')
	
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	})
		
end

function love.resize(w, h)
	push:resize(w, h)
end

function love.update(dt)

end