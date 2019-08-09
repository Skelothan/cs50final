PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
	self.player = PlayerShip()
	self.player_shots = {}
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
	
	self.player:update(dt)
	
	for k, shot in pairs(self.player_shots) do
		shot:update(dt)
	end
end

function PlayState:render()
	self.player:render()
	
	for k, shot in pairs(self.player_shots) do
		shot:render()
	end
end