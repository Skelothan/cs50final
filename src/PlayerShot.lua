PlayerShot = Class{}

function PlayerShot:init(params)
	self.x = params.x
	self.y = params.y
	
	self.RENDER_OFFSET_X = 0
	self.RENDER_OFFSET_T = 1
	self.RENDER_OFFSET_B = 0
	
	self.dx = 0
	self.dy = -16
	
	self.width = 8
	self.height = 24
	self.radius = 4
	
	self.damage = 2
	
	self.destroyed = false
end

function PlayerShot:update()
	self.y = self.y + self.dy
	
	if self.y < -self.height - 1 then
		self.destroyed = true
	end
end

function PlayerShot:render()
	love.graphics.draw(gTextures["player_shot"], self.x, self.y - self.RENDER_OFFSET_T)
end