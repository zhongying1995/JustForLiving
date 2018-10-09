local mt = ac.skill['钢铁之躯']{
    war3_id = 'A302',
    recoveries = {3, 5, 10, 15, 20},
    layers = {5, 10, 15, 20, 25},
    times = {10, 12, 14, 16, 20}
}

function mt:on_add()
    local unit = self.owner
    self.trg = unit:event '单位-即将受到伤害'(function()
        local level = self:get_level()
        local max_layer = self.layers[level]
        if unit._gangTieZhiQu_buff_lv == nil then
            unit._gangTieZhiQu_buff_lv = 0
        end
        local layer = unit._gangTieZhiQu_buff_lv
        if layer < max_layer then
            unit._gangTieZhiQu_buff_lv = unit._gangTieZhiQu_buff_lv + 1
            local time = self.times[level]
            local recovery = self.recoveries[level]
            unit:add_life_recovery(recovery)
            ac.wait(time*1000, function()
                unit:add_life_recovery(-recovery)
            end)
        end
    end)
end

function mt:on_remove()
    if self.trg then
        self.trg:remove()
    end
end