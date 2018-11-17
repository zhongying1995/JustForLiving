local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '召唤水元素'
local mt = ac.skill[skill_name]{
    war3_id = 'A200',
    minion_id = 'h2A0',
    --额外攻击比例
    attack_rate = {0.2, 0.3, 0.4, 0.5, 0.6},
    --额外生命比例
    life_rate = {0.2, 0.3, 0.4, 0.5, 0.6},
    --持续时间
    duration = {30, 35, 40, 45, 50},
}

function mt:on_effect(  )
    local unit = self.owner
    local player = unit:get_owner()
    local fac = unit:get_facing()
    local point = unit:get_point() - {fac, 200}
    local minion = player:create_minion(self.minion_id, point, fac)
    local atk = unit:get_int(true) * self.attack_rate
    local life = unit:get_str(true) * self.life_rate
    minion:add_add_attack(atk)
    minion:add_max_life(life)
    minion:set_time_life(self.duration)
end


Skill_shop:register{
    name = skill_name,
    war3_id = 'h250',
    skill_name = skill_name,
    max_level = 5,
}
