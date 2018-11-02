local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '浪潮'
local mt = ac.skill[skill_name]{
    war3_id = 'A208'
}

function mt:on_effect()
    
end


local callback = 

Skill_shop:register{
    name = skill_name,
    war3_id = 'h258',
    skill_name = skill_name,
    max_level = 5,
}
