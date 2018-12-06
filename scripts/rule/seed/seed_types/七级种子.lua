ac.unit['七级种子']{
    war3_id = 'h608',
    fruit = 'I133',
    skill_names = '生长',
    grow_duration = 420,
}

local mt = ac.item['七级种子']{
    war3_id = 'I12W',
}



local skill = ac.skill['七级种子']{
    war3_id = 'A407',
    seed = '七级种子',
}

function skill:on_effect(  )
    local point = self.target
    local unit = self.owner
    ac.player[16]:create_unit(self.seed, point)
end