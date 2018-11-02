local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '召唤水元素'
ac.skill[skill_name]{
    war3_id = 'A200'
}


Skill_shop:register{
    name = skill_name,
    war3_id = 'h250',
    skill_name = skill_name,
    max_level = 5,
}
