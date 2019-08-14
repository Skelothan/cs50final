EnemyShot = Class{}

function EnemyShot:init(params)
	self.x = params.x
	self.y = params.y
	
	self.dx = params.dx
	self.dy = params.dy
	
	self.ddx = params.ddx
	self.ddy = params.ddy
	
	self.height = params.height
	self.width = params.width
	self.radius = self.width/2
	
	self.texture = params.texture
	self.frame = params.frame
	self.frame_number = params.frame_number
end

function EnemyShot:update(dt)
	self.dx = self.dx + self.ddx * dt
	self.dy = self.dy + self.ddy * dt
	
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt
end

function EnemyShot:render()
	love.graphics.draw(gTextures[self.texture], gFrames[self.frame][self.frame_number], self.x, self.y)
end