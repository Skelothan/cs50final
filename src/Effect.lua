--[[

	Effect class. Author: Jonathan Fischer https://github.com/Skelothan

	A small cosmetic Effect effect. Effect object is destroyed after finishing its animation.

]]

Effect = Class{}

function Effect:init(params)
	self.x = params.x
	self.y = params.y
	
	self.width = 16
	self.height = 16
	
	self.anim_timer = params.anim_timer
	self.anim_timer_max = params.anim_timer
	self.anim_frame = 1
	self.last_frame = params.last_frame
	
	self.texture = params.texture
	
	self.destroyed = false
end

function Effect:update(dt)
	self.anim_timer = self.anim_timer - dt
	
	if self.anim_timer <= 0 then
		self.anim_frame = self.anim_frame + 1
		self.anim_timer = self.anim_timer_max
		if self.anim_frame > self.last_frame then
			self.destroyed = true
		end
	end
end

function Effect:render()
	love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.anim_frame], self.x, self.y)
end