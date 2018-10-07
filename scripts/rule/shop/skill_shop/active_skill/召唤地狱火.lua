local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '召唤地狱火'
ac.skill[skill_name]{
    war3_id = 'A203'
}

ac.unit_button[skill_name]{
    war3_id = 'h253',
}

local callback = {
    name = skill_name,
    skill_name = skill_name,
    max_level = 5,
}

Skill_shop:register(callback)
