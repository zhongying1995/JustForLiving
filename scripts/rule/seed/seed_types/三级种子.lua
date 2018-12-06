ac.unit['三级种子']{
    war3_id = 'h604',
    fruit = 'I12Z',
    skill_names = '生长',
    grow_duration = 180,
}

local mt = ac.item['三级种子']{
    war3_id = 'I12S',
}



local skill = ac.skill['三级种子']{
    war3_id = 'A403',
    seed = '三级种子',
}

function skill:on_effect(  )
    local point = self.target
    local unit = self.owner
    ac.player[16]:create_unit(self.seed, point)
end