local mt = ac.item['真龙皇之翼']{
    war3_id = 'I12O',
    str = 1500,
    agi = 1500,
    int = 1500,
    attack = 20000,
    damage_rate = 0.5,
    life_recovery_percent = 5,
}

function mt:on_add(  )
    local unit = self.owner
    unit:add_life_recovery(0, self.life_recovery_percent)
    self.dmg_trg = unit:event '单位-即将造成伤害-乘除'(function ( trg, damage )
        if not damage:is_attack() then
            damage.damage = damage.damage * (self.damage_rate + 1)
        end
    end)
end

function mt:on_drop(  )
    unit:add_life_recovery(0, -self.life_recovery_percent)
    if self.dmg_trg then
        self.dmg_trg:remove()
    end
end