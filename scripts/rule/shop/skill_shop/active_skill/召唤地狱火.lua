local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '召唤地狱火'
ac.skill[skill_name]{
    war3_id = 'A203'
}


Skill_shop:register{
    name = skill_name,
    war3_id = 'h253',
    skill_name = skill_name,
    max_level = 5,
}
