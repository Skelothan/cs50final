PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
	self.player = PlayerShip()
	self.player_shots = {}
	self.explosions = {}
end

function PlayState:update(dt)
	-- create a player shot if space is held
	if love.keyboard.isDown("space") and self.player.shot_delay == 0 then
		new_shot_l = PlayerShot({
			x = self.player.x - self.player.GUN_OFFSET - 3, 
			y = self.player.y
		})
		new_shot_r = PlayerShot({
			x = self.player.x + self.player.width + self.player.GUN_OFFSET - 3, 
			y = self.player.y
		})
		table.insert(self.player_shots, new_shot_l)
		table.insert(self.player_shots, new_shot_r)
		
		self.player.shot_delay = 2/60
	end
	
	if love.keyboard.wasPressed("e") then
		new_explosion = Explosion({
			x = self.player.x,
			y = self.player.y - 160
		})
		table.insert(self.explosions, new_explosion)
	end
	
	self.player:update(dt)
	for k = #self.player_shots, 1, -1 do
		shot = self.player_shots[k]
		shot:update(dt)
		if shot.destroyed then
			table.remove(self.player_shots, k)
		end
	end
	for k = #self.explosions, 1, -1 do
		explosion = self.explosions[k]
		explosion:update(dt)
		if explosion.destroyed then
			table.remove(self.explosions, k)
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
end