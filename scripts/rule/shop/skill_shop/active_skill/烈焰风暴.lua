local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '烈焰风暴'
local mt = ac.skill[skill_name]{
    war3_id = 'A204'
}

function mt:on_effect()
    
end

ac.unit_button[skill_name]{
    war3_id = 'h254',
}

local callback = {
    name = skill_name,
    skill_name = skill_name,
    max_level = 5,
}

Skill_shop:register(callback)
