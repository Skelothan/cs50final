GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
	self.score = params.score
	self.counter = 0
end

function GameOverState:update(dt)
	self.counter = self.counter + dt
	
	if love.keyboard.wasPressed("space") then
		gStateMachine:change("start", {})
	end
end

function GameOverState:render()
	love.graphics.setFont(gFonts["large"])
	love.graphics.printf("Game Over!", 0, VIRTUAL_HEIGHT/4, VIRTUAL_WIDTH, "center")
	love.graphics.setFont(gFonts["medium"])
	love.graphics.printf("Final score: " .. self.score, 0, VIRTUAL_HEIGHT*3/5, VIRTUAL_WIDTH, "center")
	if self.counter % 1 < 0.5 then
		love.graphics.printf("Press [Space]", 0, VIRTUAL_HEIGHT*3/4, VIRTUAL_WIDTH, "center")
	end
end