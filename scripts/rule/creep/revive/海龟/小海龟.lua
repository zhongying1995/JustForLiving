local Creep_revive = require 'rule.creep.revive.creep_revive'
local Game_time = require 'base.time.game_time'

local mt = Creep_revive['小海龟']{
    war3_id = 'h402',

    revive_time = 10,

    --超出这个时间不会掉落装备
    drop_superior_limit = 25,

    --时间影响因子
    time_factor = 3.5,

    --基础概率
    base_rate = 20,
}

mt.drop_item_list = {
    ['剑'] = '桃木剑',
    ['弓'] = '桃木弓',
    ['杖'] = '桃木杖',
    ['铃'] = '桃木铃',
    ['镰'] = '桃木镰',
}

function mt:death_callback( unit, killer )
    local time = Game_time:get_time()
    if time > self.drop_superior_limit then
        return
    end
    local rate = time * self.time_factor + self.base_rate
    local weapon_type
    local is_lucky = killer:roll_fortune(rate)
    if is_lucky then
        local is_dog = killer:roll_fortune(50)
        if is_dog then
            weapon_type = killer:get_weapon_type()
        else
            weapon_type = next(self.drop_item_list)
        end
    end
    if weapon_type then
        local point = unit:get_point()
        point:add_item(self.drop_item_list[weapon_type])
    end
end