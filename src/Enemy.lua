Enemy = Class{}

function Enemy.init(self, x, y, params)
	self.x = x
	self.y = y
	
	self.dx = params.dx
	self.dy = params.dy
	
	self.shape = params.shape
	self.width = params.width
	self.height = params.height
	if self.shape == "circle" then
		self.radius = self.width/2
	end
	
	self.health = params.health
	self.destroyed = false
	
	self.score = params.score
	
	self.shot_timer = params.shot_timer
	
	self.texture = params.texture
	self.frame = params.frame
	self.frame_number = params.frame_number
	
	self.death_sound = params.death_sound
	self.shoot_sound = params.shoot_sound
end

function Enemy.update(self, dt)
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt

	if self.health <= 0 then
		self.destroyed = true
	end
end

function Enemy.on_death(self, play_state)
	if not self.destroyed then
		self.destroyed = true
		play_state.score = play_state.score + self.score
		gSounds[self.death_sound]:stop()
		gSounds[self.death_sound]:play()
	end
end

function Enemy:render()
	love.graphics.draw(gTextures[self.texture], gFrames[self.frame][self.frame_number], self.x, self.y)
end