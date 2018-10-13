local mt = ac.skill['致命一击']{
    war3_id = 'A30B',
    --暴击概率
    crit_pro = {200, 30, 40, 50, 60},
    --暴击倍率
    crit_rate = {150, 170, 190, 210, 230},
}

function mt:on_add()
    local unit = self.owner
    local pro = self.crit_pro
    unit:add_crit_probability(pro)
    self.last_crit_probability = pro

    local rate = self.crit_rate
    unit:add_crit_rate(rate)
    self.last_crit_rate = rate
end

function mt:on_upgrade()
    local unit = self.owner
    local pro = self.crit_pro
    unit:add_crit_probability(pro)
    unit:add_crit_probability(-self.last_crit_probability)
    self.last_crit_probability = pro

    local rate = self.crit_rate
    unit:add_crit_rate(rate)
    unit:add_crit_rate(-self.last_crit_rate)
    self.last_crit_rate = rate
end

function mt:on_remove()
    local unit = self.owner
    unit:add_crit_probability(-self.last_crit_probability)
    self.last_crit_probability = 0
    unit:add_crit_rate(-self.last_crit_rate)
    self.last_crit_rate = 0
end
