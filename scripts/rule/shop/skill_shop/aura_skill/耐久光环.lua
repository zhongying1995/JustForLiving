local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

ac.skill['耐久光环']{
    war3_id = 'AHtb'
}

ac.unit_button['耐久光环']{
    war3_id = 'h252',
}

local callback = {
    name = '耐久光环',
    skill_name = '耐久光环',
    max_level = 5,
}
Skill_shop:register(callback)
