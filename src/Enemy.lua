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
	
	self.shotTimer = params.shotTimer
end

function Enemy.update(self, dt)
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt

	if self.health <= 0 then
		self.destroyed = true
	end
end

function Enemy:render()
end