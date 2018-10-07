local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '召唤水元素'
ac.skill[skill_name]{
    war3_id = 'A200'
}

ac.unit_button[skill_name]{
    war3_id = 'h250',
}

local callback = {
    name = skill_name,
    skill_name = skill_name,
    max_level = 5,
}

Skill_shop:register(callback)
