ac.unit['一级种子']{
    war3_id = 'h606',
    fruit = 'I12X',
    skill_names = '生长',
    grow_duration = 10,
}

local mt = ac.item['一级种子']{
    war3_id = 'I12Q',
}

local skill = ac.skill['一级种子']{
    war3_id = 'A401',
    seed = '一级种子',
}

function skill:on_effect(  )
    local point = self.target
    local unit = self.owner
    ac.player[16]:create_unit('一级种子', point)
end