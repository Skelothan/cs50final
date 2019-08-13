push = require "lib/push"
Class = require "lib/class"
require "lib/cs50util"
require "lib/deepcopy"

require "src/constants"
require "src/helpers"

-- I have chosen to include Mr. Ogden's state machine as a library as opposed to
-- writing my own, which would be nearly identical anyway
require "lib/StateMachine"
require "lib/BaseState"
require "src/states/StartState"
require "src/states/PlayState"
require "src/states/GameOverState"

require "src/PlayerShip"
require "src/PlayerShot"
require "src/Effect"

require "src/Enemy"
require "src/EmptyEnemy"
require "src/BrickEnemy"
require "src/PotEnemy"
require "src/EnemyShot"

require "src/Spawner"