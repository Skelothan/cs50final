Spawner = Class{}

function Spawner:init(params)
	self.wave = {}
	self.next_enemy = nil
	self.spawn_timer = 0
	
	self.wave = table.deepcopy(rand_choice(gWaves))
end

function Spawner:update(dt, play_state)
	self.spawn_timer = self.spawn_timer - dt
	
	if self.spawn_timer <= 0 then
		table.insert(play_state.enemies, self.next_enemy)
		local next_spawn = table.remove(self.wave)
		print(next_spawn)
		self.next_enemy = next_spawn[2]
		self.spawn_timer = next_spawn[1]
		
	end
	
	if next(self.wave) == nil then
		print("Loading a new wave...")
		self.wave = table.deepcopy(rand_choice(gWaves))
	end
end

gWaves = {
	--four bricks, left-to-right
	{
		{6, EmptyEnemy()},
		{1, BrickEnemy(VIRTUAL_WIDTH - 64, -16)},
		{1, BrickEnemy(VIRTUAL_WIDTH - 128, -16)},
		{1, BrickEnemy(128, -16)},
		{1, BrickEnemy(64, -16)}
	},
	--four bricks, right-to-left
	{
		{6, EmptyEnemy()},
		{1, BrickEnemy(64, -16)},
		{1, BrickEnemy(128, -16)},
		{1, BrickEnemy(VIRTUAL_WIDTH - 128, -16)},
		{1, BrickEnemy(VIRTUAL_WIDTH - 64, -16)}
	},
	--four pots, top-heavy trapezoid, bottom first
	{
		{1, EmptyEnemy()},
		{0, PotEnemy(VIRTUAL_WIDTH - 128, -32)},
		{.5, PotEnemy(128, -32)},
		{0, PotEnemy(VIRTUAL_WIDTH - 256, -16)},
		{.5, PotEnemy(256, -16)}
	}
}