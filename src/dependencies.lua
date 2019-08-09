push = require "lib/push"
Class = require "lib/class"
require "lib/cs50util"

require "src/constants"

-- I have chosen to include Mr. Ogden's state machine as a library as opposed to
-- writing my own, which would be nearly identical anyway
require "lib/StateMachine"
require "lib/BaseState"
require "src/states/PlayState"

require "src/PlayerShip"
require "src/PlayerShot"