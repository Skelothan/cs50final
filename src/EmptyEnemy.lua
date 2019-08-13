
-- Placeholder enemy class. Dies upon spawn.

EmptyEnemy = Class{__includes = Enemy}

function EmptyEnemy:init()
	Enemy.init(self, -8, -8, {
		shape = "circle",
		height = 0,
		width = 0,
		dx = 0,
		dy = 0,
		health = 1,
		score = 0,
		shot_timer = -1,
		texture = "none",
		frame = "none",
		frame_number = math.random(1,20),
		death_sound = "none"
	})
end

function EmptyEnemy:update()
	self.destroyed = true
end

function EmptyEnemy:render()
end

function EmptyEnemy.on_death(self, play_state)
end