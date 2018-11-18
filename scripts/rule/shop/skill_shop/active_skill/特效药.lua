local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '特效药'
local mt = ac.skill[skill_name]{
    war3_id = 'A209',
    base_recovery = {30, 50, 80, 100, 150},
    str_rate = {0.05, 0.05, 0.05, 0.05, 0.05},
    duration = 10,
}

function mt:on_effect()
    local unit = self.owner
    local target = self.target
    local heal = unit:get_str(true) * self.str_rate + self.base_recovery
    unit:heal{
        target = target,
        heal = heal*self.duration,
        skill = self,
        duration = self.duration,
    }
end



Skill_shop:register{
    name = skill_name,
    war3_id = 'h259',
    skill_name = skill_name,
    max_level = 5,
}
