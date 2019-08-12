PotEnemy = Class{__includes = Enemy}

function PotEnemy:init(x, y)
	Enemy.init(self, x, y, {
		shape = "circle",
		height = 16,
		width = 16,
		dx = 0,
		dy = 160,
		health = 40,
		score = 2500,
		shotTimer = -1,
		texture = "legend_of_fifty",
		frame = "legend_of_fifty",
		frame_number = math.random(14,16)
	})
end

function PotEnemy:update(dt, play_state)
	Enemy.update(self, dt)
	if self.dy == 0 then
		self.shoot(self, play_state)
		self.destroyed = true
	end
	self.dy = self.dy - 1
end

function PotEnemy.shoot(self, play_state)
	local speed = 64
	
	local theta = math.pi / 4
	
	local dy
	local dx
	
	for k = 1, 8, 1 do
		dy = speed * math.cos(theta * k)
		dx = speed * math.sin(theta * k)
		
		local newShot = EnemyShot({
			x = self.x + 4,
			y = self.y + 4,
			dx = dx,
			dy = dy,
			width = 8,
			height = 8,
			texture = "enemy_shots",
			frame = "enemy_shots",
			frame_number = 1
		})
	
		table.insert(play_state.enemy_shots, newShot)
	end
end