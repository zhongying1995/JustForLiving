local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '召唤地狱火'
local mt = ac.skill[skill_name]{
    war3_id = 'A203',
    minion_id = 'h2A5',
    --额外攻击比例
    attack_rate = {0.3, 0.4, 0.5, 0.6, 0.7},
    --额外生命比例
    life_rate = {0.3, 0.4, 0.5, 0.6, 0.7},
    --持续时间
    duration = {25, 30, 35, 40, 45},

    --陨石特效
    effect_model = [[Units\Demon\Infernal\InfernalBirth.mdl]],

    --晕眩范围
    range = 400,

    --晕眩时间
    stun_time = 1,
    
    --陨石落下的时间
    candy_time = 1.2
}

function mt:on_effect(  )
    local unit = self.owner
    local player = unit:get_owner()
    local fac = unit:get_facing()
    local point = self.target
    local ef = point:add_effect(self.effect_model)
    ef:set_size(1.5)
    ac.wait(self.candy_time*1000, function()
        ef:remove()
        for _, u in ac.selector()
            :in_range(point, self.range)
            :is_enemy(unit)
            :ipairs()
        do
            u:add_buff('晕眩'){
                time = self.stun_time,
                skill = self,
            }
        end
        local minion = player:create_minion(self.minion_id, point, fac)
        local atk = unit:get_int(true) * self.attack_rate
        local life = unit:get_str(true) * self.life_rate
        minion:add_add_attack(atk)
        minion:add_max_life(life)
        minion:set_time_life(self.duration)
    end)
end


Skill_shop:register{
    name = skill_name,
    war3_id = 'h253',
    skill_name = skill_name,
    max_level = 5,
}
