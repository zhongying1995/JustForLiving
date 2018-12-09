ac.unit['四级种子']{
    war3_id = 'h607',
    fruit = 'I130',
    skill_names = '生长',
    grow_duration = 240,
}

local mt = ac.item['四级种子']{
    war3_id = 'I12T',
    is_seed = true,
}



local skill = ac.skill['四级种子']{
    war3_id = 'A404',
    seed = '四级种子',
}

function skill:on_effect(  )
    local point = self.target
    local unit = self.owner
    ac.player[16]:create_unit(self.seed, point)
end