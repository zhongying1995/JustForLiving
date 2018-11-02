local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '硬化皮肤'
ac.skill[skill_name]{
    war3_id = 'AHbz'
}


Skill_shop:register{
    name = skill_name,
    war3_id = 'h251',
    skill_name = skill_name,
    max_level = 5,
}
