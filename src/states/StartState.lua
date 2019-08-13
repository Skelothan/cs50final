StartState = Class{__includes = BaseState}

function StartState:enter(params)
	self.counter = 0
end

function StartState:update(dt)
	self.counter = self.counter + dt
	
	if love.keyboard.wasPressed("space") then
		gStateMachine:change("play", {})
	end
end

function StartState:render()
	love.graphics.setFont(gFonts["large"])
	love.graphics.printf("Destroy CS50G", 0, VIRTUAL_HEIGHT/4, VIRTUAL_WIDTH, "center")
	love.graphics.setFont(gFonts["medium"])
	if self.counter % 1 < 0.5 then
		love.graphics.printf("Press [Space]", 0, VIRTUAL_HEIGHT*3/4, VIRTUAL_WIDTH, "center")
	end
end