local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '闪避'
ac.skill[skill_name]{
    war3_id = 'A20G'
}


Skill_shop:register{
    name = skill_name,
    war3_id = 'h25J',
    skill_name = skill_name,
    max_level = 5,
}
