local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '腐臭蜂群'
local mt = ac.skill[skill_name]{
    war3_id = 'A206'
}

function mt:on_effect()
    
end


Skill_shop:register{
    name = skill_name,
    war3_id = 'h256',
    skill_name = skill_name,
    max_level = 5,
}
