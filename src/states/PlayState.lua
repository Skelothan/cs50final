PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
	self.player = PlayerShip()
	self.player_shots = {}
	self.effects = {}
	self.enemies = {}
	self.enemy_shots = {}
	self.score = 0
end

function PlayState:update(dt)
	-- create a player shot if space is held
	if love.keyboard.isDown("space") and self.player.shot_delay == 0 then
		local new_shot_l1 = PlayerShot({
			x = self.player.x - self.player.GUN_OFFSET + 1, 
			y = self.player.y
		})
		local new_shot_l2 = PlayerShot({
			x = self.player.x - self.player.GUN_OFFSET - 7, 
			y = self.player.y
		})
		local new_shot_r1 = PlayerShot({
			x = self.player.x + self.player.width + self.player.GUN_OFFSET - 7, 
			y = self.player.y
		})
		local new_shot_r2 = PlayerShot({
			x = self.player.x + self.player.width + self.player.GUN_OFFSET + 1, 
			y = self.player.y
		})
		table.insert(self.player_shots, new_shot_l1)
		table.insert(self.player_shots, new_shot_l2)
		table.insert(self.player_shots, new_shot_r1)
		table.insert(self.player_shots, new_shot_r2)
		
		self.player.shot_delay = 2/60
	end
	
	-- debug controls
	if love.keyboard.wasPressed("e") then
		local new_effect = Effect({
			x = self.player.x,
			y = self.player.y - 160,
			texture = "eff_explosion",
			anim_timer = 0.05,
			last_frame = 5
		})
		table.insert(self.effects, new_effect)
	end
	
	if love.keyboard.wasPressed("n") then
		local new_enemy = BrickEnemy(math.random(16, VIRTUAL_WIDTH-16), -16)
		table.insert(self.enemies, new_enemy)
	end
	
	if love.keyboard.wasPressed("p") then
		local new_enemy = PotEnemy(math.random(16, VIRTUAL_WIDTH-16), -16)
		table.insert(self.enemies, new_enemy)
	end
	
	-- move/update everything
	self.player:update(dt)
	for k, object in pairs(self.player_shots) do
		object:update(dt)
	end
	for k, object in pairs(self.effects) do
		object:update(dt)
	end
	for k, object in pairs(self.enemy_shots) do
		object:update(dt)
	end
	for k, object in pairs(self.enemies) do
		object:update(dt, self)
	end
	
	-- Collision handling
	-- Enemy shots and...
	for k, shot in pairs(self.enemy_shots) do
		-- player
		if check_collision_cc(shot, self.player) then
			shot.destroyed = true
			-- TODO: damage
		end
	end
	
	-- Player shots and...
	for k, shot in pairs(self.player_shots) do
		-- enemies
		for k, enemy in pairs(self.enemies) do
			local collided = false
			if enemy.shape == "rectangle" then
				if check_collision_cr(shot, enemy) then
					collided = true
				end
			elseif enemy.shape == "circle" then
				if check_collision_cc(shot, enemy) then
					collided = true
				end
			end
			if collided then
				-- destroy player shot, create effect
				shot.destroyed = true
				local new_effect = Effect({
					x = shot.x - shot.width/2,
					y = enemy.y + enemy.height - 8,
					texture = "eff_player_shot",
					anim_timer = 0.025,
					last_frame = 3
				})
				table.insert(self.effects, new_effect)
				
				-- subtract enemy health, kill enemy if its health id below zero
				enemy.health = enemy.health - shot.damage
				if enemy.health <= 0 then
					enemy.on_death(enemy, self)
					local new_effect = Effect({
						x = enemy.x + enemy.width/2 - 8,
						y = enemy.y + enemy.height/2 - 8,
						texture = "eff_explosion",
						anim_timer = 0.05,
						last_frame = 5
					})
					table.insert(self.effects, new_effect)
				end
			end
		end
	end
	
	-- remove all destroyed objects from play
	remove_destroyed_objects(self.player_shots)
	remove_destroyed_objects(self.effects)
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

function check_collision_cr(circle, rectangle)
	local circle_x = circle.x + circle.radius
	local circle_y = circle.y + circle.radius
	local rect_point_x = circle_x
	local rect_point_y = circle_y
	
	if rect_point_x > rectangle.x + rectangle.width then
		rect_point_x = rectangle.x + rectangle.width
	elseif rect_point_x < rectangle.x then
		rect_point_x = rectangle.x
	end
	
	if rect_point_y > rectangle.y + rectangle.height then
		rect_point_y = rectangle.y + rectangle.height
	elseif rect_point_y < rectangle.y then
		rect_point_y = rectangle.y
	end
	
	return distance(circle_x, rect_point_x, circle_y, rect_point_y) < circle.radius
end

function check_collision_cc(first, second)
	return distance(first.x + first.radius, second.x + second.radius, first.y + first.radius, second.y + second.radius) < first.radius + second.radius
end

function PlayState:render()
	-- render all game objects
	self.player:render()
	for k, enemy in pairs(self.enemies) do
		enemy:render()
	end
	for k, shot in pairs(self.player_shots) do
		shot:render()
	end
	for k, shot in pairs(self.enemy_shots) do
		shot:render()
	end
	for k, effect in pairs(self.effects) do
		effect:render()
	end
	
	-- render score text
	love.graphics.printf(self.score, -8, VIRTUAL_HEIGHT-24, VIRTUAL_WIDTH, "right")
end