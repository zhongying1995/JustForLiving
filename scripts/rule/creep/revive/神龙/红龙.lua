local Creep_revive = require 'rule.creep.revive.creep_revive'
local Game_time = require 'base.time.game_time'

local mt = Creep_revive['红龙']{
    war3_id = 'h40I',

    revive_time = 40,

    drop_item = '神灵',
}

function mt:death_callback( unit, killer )
    local point = unit:get_point()
    point:add_item(self.drop_item)
end