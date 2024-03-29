BrickEnemy = Class{__includes = Enemy}

function BrickEnemy:init(x, y)
	self.max_dy = 10
	Enemy.init(self, x, y, {
		shape = "rectangle",
		height = 16,
		width = 32,
		dx = 0,
		dy = 200,
		health = 150,
		score = 4000,
		shot_timer = 3,
		texture = "breakout",
		frame = "breakout_bricks",
		frame_number = math.random(1,20),
		death_sound = "brick_death"
	})
end

function BrickEnemy:update(dt, play_state)
	self.shot_timer = self.shot_timer - dt
	if self.shot_timer <= 0 and self.y < VIRTUAL_HEIGHT/2 then
		self.shoot(self, play_state)
		self.shot_timer = 3
	end
	if self.y > VIRTUAL_HEIGHT + self.height + 1 then
		self.destroyed = true
	end
	
	Enemy.update(self, dt)
	if self.dy > self.max_dy then
		self.dy = self.dy - 600 * dt
	else
		self.dy = self.max_dy
	end
	
end

function BrickEnemy.shoot(self, play_state)
	local player_x = play_state.player.x + play_state.player.width/2
	local player_y = play_state.player.y + play_state.player.height/2
	local shot_spread = 0.25 -- about 15 degrees
	
	local shot_x = self.x + self.width/2 - 4
	local shot_y = self.y + self.height - 4
	
	local theta = math.atan2((player_x - shot_x), (player_y - shot_y))
	
	local speed
	
	for speed = 96, 128, 16 do
		local dy = {speed * math.cos(theta), speed * math.cos(theta - shot_spread), speed * math.cos(theta + shot_spread)}
		local dx = {speed * math.sin(theta), speed * math.sin(theta - shot_spread), speed * math.sin(theta + shot_spread)}
	
		for k = 1, 3, 1 do
			local new_shot = EnemyShot({
				x = shot_x,
				y = shot_y,
				dx = dx[k],
				dy = dy[k],
				ddx = 0,
				ddy = 0,
				width = 8,
				height = 8,
				texture = "breakout",
				frame = "breakout_balls",
				frame_number = 181
			})
	
			table.insert(play_state.enemy_shots, new_shot)
		end
	end
	
	gSounds["brick_shoot"]:stop()
	gSounds["brick_shoot"]:play()
end