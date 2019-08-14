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
		self.next_enemy = next_spawn[2]
		self.spawn_timer = next_spawn[1]
		
	end
	
	if next(self.wave) == nil then
		self.wave = table.deepcopy(rand_choice(gWaves))
	end
end

gWaves = {
	--six bricks, left-to-right
	{
		{4.5, EmptyEnemy()},
		{1, BrickEnemy(VIRTUAL_WIDTH - 64, -16)},
		{1, BrickEnemy(VIRTUAL_WIDTH - 128, -16)},
		{1, BrickEnemy(128, -16)},
		{1, BrickEnemy(64, -16)}
	},
	--six bricks, right-to-left
	{
		{4.5, EmptyEnemy()},
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
	},
	--two fiftybros from the left and right, top first
	{
		{1.25, EmptyEnemy()},
		{0, FiftyBroEnemy(VIRTUAL_WIDTH + 8, 200)},
		{.75, FiftyBroEnemy(-8, 200)},
		{0, FiftyBroEnemy(VIRTUAL_WIDTH + 8, 128)},
		{.5, FiftyBroEnemy(-8, 128)}
	},
	--a fiftybro from the right
	--[[
	{
		{1, EmptyEnemy()},
		{0, PotEnemy(VIRTUAL_WIDTH - 128, -32)},
		{.5, PotEnemy(128, -32)},
		{0, PotEnemy(VIRTUAL_WIDTH - 256, -16)},
		{.5, PotEnemy(256, -16)}
	}
	]]
	
}