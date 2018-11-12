local mt = ac.item['黄铜魂珠']{
    war3_id = 'I10C',
    attr = 876,
    inactive_life_recovery = 70,
}

function mt:on_add()
    local unit = self.owner
    unit:add_inactive_life_recovery(self.inactive_life_recovery)

    if unit:is_str_primary() then
        unit:add_add_str(self.attr)
        self.attr_func = unit.add_add_str
    elseif unit:is_agi_primary() then
        unit:add_add_agi(self.attr)
        self.attr_func = unit.add_add_agi
    elseif unit:is_int_primary() then
        unit:add_add_int(self.attr)
        self.attr_func = unit.add_add_int
    end

end

function mt:on_drop()
    local unit = self.owner
    unit:add_inactive_life_recovery(-self.inactive_life_recovery)
    self.attr_func(unit, self.attr)
end