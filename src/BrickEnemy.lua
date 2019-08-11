BrickEnemy = Class{__includes = Enemy}

function BrickEnemy:update(dt, play_state)
	self.shotTimer = self.shotTimer - dt
	if self.shotTimer <= 0 and self.y < VIRTUAL_HEIGHT/2 then
		self.shoot(self, play_state)
		self.shotTimer = 3
	end
	if self.y > VIRTUAL_HEIGHT + self.height + 1 then
		self.destroyed = true
	end
	
	Enemy.update(self, dt)
end

function BrickEnemy.shoot(self, play_state)
	local player_x = play_state.player.x + play_state.player.width/2
	local player_y = play_state.player.y + play_state.player.height/2
	local speed = 128
	local shot_spread = 0.25 -- about 15 degrees
	
	local shot_x = self.x + self.width/2 - 4
	local shot_y = self.y + self.height - 4
	
	local theta = math.atan2((player_x - shot_x), (player_y - shot_y))
	
	local dy = {speed * math.cos(theta), speed * math.cos(theta - shot_spread), speed * math.cos(theta + shot_spread)}
	local dx = {speed * math.sin(theta), speed * math.sin(theta - shot_spread), speed * math.sin(theta + shot_spread)}
	
	for k = 1, 3, 1 do
		local newShot = EnemyShot({
			x = shot_x,
			y = shot_y,
			dx = dx[k],
			dy = dy[k],
			width = 8,
			height = 8,
			texture = "breakout",
			frame = "breakout_balls",
			frame_number = 181
		})
	
		table.insert(play_state.enemy_shots, newShot)
	end
end

function BrickEnemy:render()
	love.graphics.draw(gTextures["breakout"], gFrames["breakout_bricks"][10], self.x, self.y)
end