local mt = ac.skill['致命一击']{
    war3_id = 'A30B',
    --暴击概率
    crit_pro = {20, 30, 40, 50, 60},
    --暴击倍率
    crit_rate = {150, 170, 190, 210, 230},
    passive = true,
}

function mt:on_upgrade()
    if self:is_enable() then
        local unit = self.owner
        unit:remove_buff('潜影者-致命一击')
        unit:add_buff('潜影者-致命一击'){
            skill = self,
        }
    end
end

function mt:on_enable()
    local unit = self.owner
    unit:add_buff('潜影者-致命一击'){
        skill = self,
    }
end

function mt:on_disable()
    local unit = self.owner
    unit:remove_buff('潜影者-致命一击')
end

local mt = ac.buff['潜影者-致命一击']{

}

function mt:on_add()
    local unit = self.target
    local skill = self.skill
    local pro = skill.crit_pro
    unit:add_crit_probability(pro)
    self.last_crit_probability = pro

    local rate = skill.crit_rate
    unit:add_crit_rate(rate)
    self.last_crit_rate = rate
end

function mt:on_remove()
    local unit = self.target
    unit:add_crit_probability(-self.last_crit_probability)
    self.last_crit_probability = 0

    unit:add_crit_rate(-self.last_crit_rate)
    self.last_crit_rate = 0
end