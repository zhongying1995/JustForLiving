local mt = ac.item['狂暴']{
    war3_id = 'I12N',
    str = 3000,
    life_recovery_percent = 3,
}

function mt:on_add(  )
    local unit = self.owner
    unit:add_life_recovery(0, self.life_recovery_percent)
end

function mt:on_drop(  )
    local unit = self.owner
    unit:add_life_recovery(0, -self.life_recovery_percent)
end