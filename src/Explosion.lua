--[[

	Explosion class. Author: Jonathan Fischer https://github.com/Skelothan

	A small cosmetic explosion effect. Explosion object is destroyed after finishing its animation.

]]

Explosion = Class{}

function Explosion:init(params)
	self.x = params.x
	self.y = params.y
	
	self.width = 16
	self.height = 16
	
	self.animTimer = 0.05
	self.animFrame = 1
	self.lastFrame = 5
	
	self.destroyed = false
end

function Explosion:update(dt)
	self.animTimer = self.animTimer - dt
	
	if self.animTimer <= 0 then
		self.animFrame = self.animFrame + 1
		self.animTimer = 0.05
		if self.animFrame > self.lastFrame then
			self.destroyed = true
		end
	end
end

function Explosion:render()
	love.graphics.draw(gTextures["explosion"], gFrames["explosion"][self.animFrame], self.x, self.y)
end