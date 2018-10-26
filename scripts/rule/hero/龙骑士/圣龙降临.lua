local mt = ac.skill['圣龙降临']{
    war3_id = 'A303',
    life = 1000,
    life_per = {10, 15, 20, 25, 30},
    defence = 10,
    time = {15, 20, 25, 30, 35},
    tranform_id = 'O202',
    tranform_effect_model = [[Abilities\Spells\Orc\FeralSpirit\feralspirittarget.mdl]],
}

function mt:on_effect()
    local unit = self.owner
    
    local level = self:get_level()
    local time = self.time
    local id = unit:get_id()
    if id ~= self.tranform_id then
        self:set('id', id)
    end
    
    local tranform_timer = self:get('tranform_timer')
    if tranform_timer then
        tranform_timer:remove()
    else
        unit:transform(self.tranform_id)
        local life_per = self.life_per
        local life = self.life + unit:get_max_life() * life_per / 100
        self:set('life', life)
        unit:add_max_life(life)
        unit:add_defence(self.defence)
    end
    unit:add_effect(self.tranform_effect_model, 'chest'):remove()

    self.tranform_timer = ac.wait(time * 1000, function()
        local id = self:get('id')
        local life = self:get('life')
        unit:transform(id)
        unit:add_max_life(-life)
        unit:add_defence(-self.defence)
        self:set('tranform_timer', nil)
    end)
    self:set('tranform_timer', self.tranform_timer)
end