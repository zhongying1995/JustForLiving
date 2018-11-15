local Creep_revive = require 'rule.creep.revive.creep_revive'
local Game_time = require 'base.time.game_time'

local mt = Creep_revive['小蝎子']{
    war3_id = 'h404',

    revive_time = 10,

    revive_callback = function(self, unit)
        
    end,

    --超出这个时间不会掉落装备
    drop_superior_limit = 25,
}

local drop_item_list = {
    '精铁',
    '黄铜',
    '纯银',
}

function mt:death_callback( unit, killer )
    local time = Game_time:get_time()
    if time > self.drop_superior_limit then
        return
    end
    local rate = time * 5
    local i
    local is_lucky, roll = killer:get_owner():roll_fortune(rate)
    if is_lucky then
        i = 1
        if roll > rate / 2 then
            if time > 18 or roll > rate/1.5 then
                i = 3
            else
                i = 2
            end
        end
    end
    if i then
        local point = unit:get_point()
        point:add_item(drop_item_list[i])
    end
end