local Creep_revive = require 'rule.creep.revive.creep_revive'
local Game_time = require 'base.time.game_time'

local mt = Creep_revive['龙皇']{
    war3_id = 'h40J',

    revive_time = 40,

    drop_item = '龙皇之力',
}

function mt:death_callback( unit, killer )
    local point = unit:get_point()
    point:add_item(self.drop_item)
end