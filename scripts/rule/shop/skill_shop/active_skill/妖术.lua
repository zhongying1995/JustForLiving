local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '妖术'
local mt = ac.skill[skill_name]{
    war3_id = 'A20A',
}


Skill_shop:register{
    name = skill_name,
    war3_id = 'h25A',
    skill_name = skill_name,
    max_level = 5,
}
