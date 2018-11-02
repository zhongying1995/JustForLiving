local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '耐久光环'
ac.skill[skill_name]{
    war3_id = 'AHtb'
}

local callback = 
Skill_shop:register{
    name = skill_name,
    war3_id = 'h252',
    skill_name = skill_name,
    max_level = 5,
}
