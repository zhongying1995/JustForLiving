

local mt = ac.skill['山神之力']{
    buff_name = '山神之力',
    debuff_name = '弑神之力',
    model = [[Abilities\Spells\Items\SpellShieldAmulet\SpellShieldCaster.mdl]],
    debuff_time = 5,
}

function mt:on_add(  )
    local unit = self.owner
    self.buff = unit:add_buff(self.buff_name){}
    self.damage_trg = unit:event '单位-即将受到伤害'(function ( trg, damage )
        local source = damage.source
        if source:find_buff(self.debuff_name) then
            self.buff:disable()
            ac.wait(self.debuff_time*1000, function ( trg )
                self.buff:enable()
            end)
        else
            damage.damage = 0
            unit:add_effect(self.model):remove()
        end
    end)
end

function mt:on_remove()
    local unit = self.owner
    unit:remove_buff(self.buff_name)
    if self.damage_trg then
        self.damage_trg:remove()
    end
end


local buff = ac.buff['山神之力']{
    model = [[Abilities\Spells\Items\StaffOfSanctuary\Staff_Sanctuary_Target.mdl]],
}

function buff:on_add(  )
    local unit = self.target
    self.effect = unit:add_effect(self.model, 'chest')
end

function buff:on_remove(  )
    if self.effect then
        self.effect:remove()
    end
end