ac.unit['二级种子']{
    war3_id = 'h605',
    fruit = 'I12Y',
    skill_names = '生长',
    grow_duration = 120,
}

local mt = ac.item['二级种子']{
    war3_id = 'I12R',
    is_seed = true,
}



local skill = ac.skill['二级种子']{
    war3_id = 'A402',
    seed = '二级种子',
}

function skill:on_effect(  )
    local point = self.target
    local unit = self.owner
    ac.player[16]:create_unit(self.seed, point)
end