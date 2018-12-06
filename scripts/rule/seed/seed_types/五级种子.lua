ac.unit['五级种子']{
    war3_id = 'h60A',
    fruit = 'I131',
    skill_names = '生长',
    grow_duration = 300,
}

local mt = ac.item['五级种子']{
    war3_id = 'I12U',
}



local skill = ac.skill['五级种子']{
    war3_id = 'A405',
    seed = '五级种子',
}

function skill:on_effect(  )
    local point = self.target
    local unit = self.owner
    ac.player[16]:create_unit(self.seed, point)
end