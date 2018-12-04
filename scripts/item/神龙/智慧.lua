local mt = ac.item['智慧']{
    war3_id = 'I12L',
    str = 1000,
    agi = 1000,
    int = 1000,
    damage_rate = 0.3,
}

function mt:on_add(  )
    local unit = self.owner
    self.dmg_trg = unit:event '单位-即将造成伤害-乘除'(function ( trg, damage )
        if not damage:is_attack() then
            damage.damage = damage.damage * (self.damage_rate + 1)
        end
    end)
end

function mt:on_drop(  )
    if self.dmg_trg then
        self.dmg_trg:remove()
    end
end