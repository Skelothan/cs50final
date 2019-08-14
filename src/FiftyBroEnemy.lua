FiftyBroEnemy = Class{__includes = Enemy}

function FiftyBroEnemy:init(x, y)
	Enemy.init(self, x, y, {
		shape = "rectangle",
		width = 16,
		height = 20,
		dx = 64,
		dy = 0,
		health = 76,
		score = 2250,
		shot_timer = 3.33,
		texture = "fiftybros_alien",
		frame = "fiftybros_alien",
		frame_number = 1,
		death_sound = "fiftybro_death"
	})
	
	-- reverse initial velocity if starting on right of screen
	if self.x > VIRTUAL_WIDTH/2 then
		self.dx = self.dx * -1
	end
end

function FiftyBroEnemy:update(dt, play_state)
	-- move to the center, then back
	if self.x > VIRTUAL_WIDTH*3/7 and self.x < VIRTUAL_WIDTH/2 then
		self.dx = self.dx - 128 * dt
	elseif self.x < VIRTUAL_WIDTH*4/7 and self.x > VIRTUAL_WIDTH/2 then
		self.dx = self.dx + 128 * dt
	end
	
	self.shot_timer = self.shot_timer - dt
	if self.shot_timer <= 0 and self.y < VIRTUAL_HEIGHT/2 then
		self.shoot(self, play_state)
		self.shot_timer = 200
	end
	if self.x > VIRTUAL_HEIGHT + self.width + 1 or self.x < -self.width - 1 then
		self.destroyed = true
	end
	
	Enemy.update(self, dt)
end

function FiftyBroEnemy.shoot(self, play_state)
	local dx
	
	for dx = 64, 128, 32 do
		for k = -1, 1, 2 do
			local new_shot = EnemyShot({
				x = self.x,
				y = self.y,
				dx = dx * k,
				dy = -250,
				ddx = 0,
				ddy = 500,
				width = 16,
				height = 16,
				texture = "fiftybros_gems",
				frame = "fiftybros_gems",
				frame_number = 8
			})
	
			table.insert(play_state.enemy_shots, new_shot)
		end
	end
	
	gSounds["fiftybro_shoot"]:stop()
	gSounds["fiftybro_shoot"]:play()
end

function FiftyBroEnemy.on_death(self, play_state)
	if not self.destroyed then
		self.destroyed = true
		play_state.score = play_state.score + self.score
		gSounds["fiftybro_death1"]:stop()
		gSounds["fiftybro_death1"]:play()
		gSounds["fiftybro_death2"]:stop()
		gSounds["fiftybro_death2"]:play()
	end
end