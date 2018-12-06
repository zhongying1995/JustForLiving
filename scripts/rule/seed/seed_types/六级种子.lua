ac.unit['六级种子']{
    war3_id = 'h609',
    fruit = 'I132',
    skill_names = '生长',
    grow_duration = 360,
}

local mt = ac.item['六级种子']{
    war3_id = 'I12V',
}



local skill = ac.skill['六级种子']{
    war3_id = 'A406',
    seed = '六级种子',
}

function skill:on_effect(  )
    local point = self.target
    local unit = self.owner
    ac.player[16]:create_unit(self.seed, point)
end