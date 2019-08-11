PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
	self.player = PlayerShip()
	self.player_shots = {}
	self.explosions = {}
	self.enemies = {}
	self.enemy_shots = {}
	self.score = 0
end

function PlayState:update(dt)
	-- create a player shot if space is held
	if love.keyboard.isDown("space") and self.player.shot_delay == 0 then
		local new_shot_l = PlayerShot({
			x = self.player.x - self.player.GUN_OFFSET - 3, 
			y = self.player.y
		})
		local new_shot_r = PlayerShot({
			x = self.player.x + self.player.width + self.player.GUN_OFFSET - 3, 
			y = self.player.y
		})
		table.insert(self.player_shots, new_shot_l)
		table.insert(self.player_shots, new_shot_r)
		
		self.player.shot_delay = 2/60
	end
	
	-- debug controls
	if love.keyboard.wasPressed("e") then
		local new_explosion = Explosion({
			x = self.player.x,
			y = self.player.y - 160
		})
		table.insert(self.explosions, new_explosion)
	end
	
	if love.keyboard.wasPressed("n") then
		local new_enemy = BrickEnemy(math.random(16, VIRTUAL_WIDTH-16), -16, {
			height = 16,
			width = 32,
			dx = 0,
			dy = 10,
			health = 200,
			score = 400,
			shotTimer = 3,
			texture = "breakout",
			frame = "breakout_bricks",
			frame_number = math.random(1,20)
		})
		table.insert(self.enemies, new_enemy)
	end
	
	-- move/update everything
	self.player:update(dt)
	for k, object in pairs(self.player_shots) do
		object:update(dt)
	end
	for k, object in pairs(self.explosions) do
		object:update(dt)
	end
	for k, object in pairs(self.enemy_shots) do
		object:update(dt)
	end
	for k, object in pairs(self.enemies) do
		object:update(dt, self)
	end
	
	-- TODO: collision handling
	
	-- remove all destroyed objects from play
	remove_destroyed_objects(self.player_shots)
	remove_destroyed_objects(self.explosions)
	remove_destroyed_objects(self.enemies)
	remove_destroyed_objects(self.enemy_shots)
end

function remove_destroyed_objects(check_table)
	for k = #check_table, 1, -1 do
		object = check_table[k]
		if object.destroyed then
			table.remove(check_table, k)
		end
	end
end

function PlayState:render()
	self.player:render()
	
	for k, shot in pairs(self.player_shots) do
		shot:render()
	end
	for k, explosion in pairs(self.explosions) do
		explosion:render()
	end
	for k, enemy in pairs(self.enemies) do
		enemy:render()
	end
	for k, shot in pairs(self.enemy_shots) do
		shot:render()
	end
end