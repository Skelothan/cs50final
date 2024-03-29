PotEnemy = Class{__includes = Enemy}

function PotEnemy:init(x, y)
	Enemy.init(self, x, y, {
		shape = "circle",
		height = 16,
		width = 16,
		dx = 0,
		dy = 320,
		health = 32,
		score = 6500,
		shotTimer = -1,
		texture = "legend_of_fifty",
		frame = "legend_of_fifty",
		frame_number = math.random(14,16),
		death_sound = "pot_death",
	})
end

function PotEnemy:update(dt, play_state)
	Enemy.update(self, dt)
	if self.dy <= 0 then
		self.shoot(self, play_state)
		self.destroyed = true
	end
	self.dy = self.dy - 240 * dt
end

function PotEnemy.shoot(self, play_state)
	local speed = 64
	local speed_2 = 120
	
	local theta = math.pi / 8
	local dy
	local dx
	
	for k = 1, 16, 1 do
		if k % 2 == 1 then
			dy = speed * math.cos(theta * k)
			dx = speed * math.sin(theta * k)
		else
			dy = speed_2 * math.cos(theta * k)
			dx = speed_2 * math.sin(theta * k)
		end
		
		local newShot = EnemyShot({
			x = self.x + 4,
			y = self.y + 4,
			dx = dx,
			dy = dy,
			ddx = 0,
			ddy = 0,
			width = 8,
			height = 8,
			texture = "enemy_shots",
			frame = "enemy_shots",
			frame_number = 1
		})
	
		table.insert(play_state.enemy_shots, newShot)
	end
	
	gSounds["pot_shoot"]:stop()
	gSounds["pot_shoot"]:play()
end