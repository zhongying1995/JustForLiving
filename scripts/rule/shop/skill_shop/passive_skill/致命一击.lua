local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '致命一击-购买的'

local mt = ac.skill[skill_name]{
    war3_id = 'A20K',
}

Skill_shop:register{
    name = skill_name,
    war3_id = 'h25L',
    skill_name = skill_name,
    max_level = 5,
}
