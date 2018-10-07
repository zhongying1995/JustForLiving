local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

ac.skill['硬化皮肤']{
    war3_id = 'AHbz'
}

ac.unit_button['硬化皮肤']{
    war3_id = 'h251',
}

local callback = {
    name = '硬化皮肤',
    skill_name = '硬化皮肤',
    max_level = 5,
}
Skill_shop:register(callback)
