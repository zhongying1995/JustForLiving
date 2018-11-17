local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '吸血光环-商店学习的'
local skill_mt = ac.skill[skill_name]{
    war3_id = 'A20C'
}

local button_mt = Skill_shop:register{
    name = skill_name,
    war3_id = 'h25D',
    skill_name = skill_name,
    max_level = 5,
}
