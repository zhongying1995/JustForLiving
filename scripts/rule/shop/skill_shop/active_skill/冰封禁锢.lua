local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '冰封禁锢'
local mt = ac.skill[skill_name]{
    war3_id = 'A205'
}

function mt:on_effect()
    
end


local callback =

Skill_shop:register {
    war3_id = 'h255',
    name = skill_name,
    skill_name = skill_name,
    max_level = 5,
}
