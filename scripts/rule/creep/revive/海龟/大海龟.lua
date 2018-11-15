local Creep_revive = require 'rule.creep.revive.creep_revive'
local Game_time = require 'base.time.game_time'

local mt = Creep_revive['大海龟']{
    war3_id = 'h403',

    revive_time = 20,

    --超出这个时间不会掉落装备
    drop_superior_limit = 0,

    time_factor = 5,

    base_rate = 50,
}

mt.drop_item_list_weapon = {
    ['剑'] = '桃木剑',
    ['弓'] = '桃木弓',
    ['杖'] = '桃木杖',
    ['铃'] = '桃木铃',
    ['镰'] = '桃木镰',
}

mt.drop_item_list = {
    '桃木项链',
    '桃木魂珠',
    '精铁',
}

function mt:death_callback( unit, killer )
    local time = Game_time:get_time()
    if time > self.drop_superior_limit then
        return
    end
    local rate = time * self.time_factor + self.base_rate
    local index
    local item_list
    local is_lucky = killer:roll_fortune(rate)
    if is_lucky then
        local weapon_type = killer:get_weapon_type()
        local weapon_name = self.drop_item_list_weapon[weapon_type]
        if killer:has_item(weapon_name) then
            item_list = self.drop_item_list
            index = math.random(1, #item_list)
        else
            item_list = self.drop_item_list_weapon
            index = weapon_type
        end
    end
    if index then
        local point = unit:get_point()
        point:add_item(self.drop_item_list[i])
    end
end