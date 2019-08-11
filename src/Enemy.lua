Enemy = Class{}

function Enemy:init(x, y, params)
	self.x = x
	self.y = y
	
	self.dx = params.dx
	self.dy = params.dy
	
	self.width = params.width
	self.height = params.height
	
	self.health = params.health
	self.destroyed = false
	
	self.score = params.score
	
	self.shotTimer = params.shotTimer
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
	end
end

function Enemy:render()
end