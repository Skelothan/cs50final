PlayerShip = Class{}

function PlayerShip:init()
	self.x = VIRTUAL_WIDTH/2
	self.y = VIRTUAL_HEIGHT * 3/4
	
	-- This offset allows the pink hitbox dot in the middle of the ship to line up with the ship's actual hitbox.
	self.RENDER_OFFSET_X = 19
	self.RENDER_OFFSET_T = 16
	self.RENDER_OFFSET_B = 6
	
	self.dx = 0
	self.dy = 0
	
	-- The player's hitbox is much smaller than the graphic for the spaceship to facilitate dodging.
	-- This is typical of shoot-em-ups.
	self.width = 8
	self.height = 8
	-- However, circular detection is used, so the radius is necessary too.
	self.radius = 4
end

function PlayerShip:update()
	if love.keyboard.isDown("left") then
		self.dx = -4
	elseif love.keyboard.isDown("right") then
		self.dx = 4
	else
		self.dx = 0
	end
	
	if love.keyboard.isDown("up") then
		self.dy = -4
	elseif love.keyboard.isDown("down") then
		self.dy = 4
	else
		self.dy = 0
	end
	
	self.x = math.min(math.max(self.RENDER_OFFSET_X - 1, self.x + self.dx), VIRTUAL_WIDTH - self.width - self.RENDER_OFFSET_X - 1)
	self.y = math.min(math.max(self.RENDER_OFFSET_T - 1, self.y + self.dy), VIRTUAL_HEIGHT - self.height - self.RENDER_OFFSET_B - 1)
end

function PlayerShip:render()
	love.graphics.draw(gTextures["player_ship"], self.x - self.RENDER_OFFSET_X, self.y - self.RENDER_OFFSET_T)
end