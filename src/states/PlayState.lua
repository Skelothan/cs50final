PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
	self.player = PlayerShip()
end

function PlayState:update()
	self.player:update()
end

function PlayState:render()
	self.player:render()
end