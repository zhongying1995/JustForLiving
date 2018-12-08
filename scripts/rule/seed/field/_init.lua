local Player = Router.player

require 'rule.seed.field.神种之树'
local Field = require 'rule.seed.field.field'
local Market = require 'rule.seed.field.market'


ac.game:event '游戏-开始'(function(  )
    local pulse = 25 - Player.count_alive()
    Field:init(pulse)
    Market:init()
end)