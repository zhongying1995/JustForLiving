local mt = ac.skill['钢铁之躯']{
    war3_id = 'A302',
    recovery = {3, 5, 10, 15, 20},
    layer = {5, 10, 15, 20, 25},
    time = {10, 12, 14, 16, 20},
    passive = true,
}

function mt:on_enable()
    local unit = self.owner
    unit:add_buff('龙骑士-钢铁之躯'){
        skill = self,
    }
end

function mt:on_disable()
    local unit = self.owner
    unit:remove_buff('龙骑士-钢铁之躯')
end

function mt:on_upgrade()
    if self:is_enable() then
        local unit = self.owner
        unit:remove_buff('龙骑士-钢铁之躯')
        unit:add_buff('龙骑士-钢铁之躯'){
            skill = self,
        }
    end
end

local mt = ac.buff['龙骑士-钢铁之躯']{

}

function mt:on_add()
    local unit = self.target
    local skill = self.skill
    self.trg = unit:event '单位-即将受到伤害'(function(trg, damage)
        unit:add_buff('龙骑士-钢铁之躯-恢复'){
            skill = skill,
            cover_max = skill.layer,
            recovery = skill.recovery,
            time = skill.time,
        }
    end)
end

function mt:on_remove()
    if self.trg then
        self.trg:remove()
    end
end


local mt = ac.buff['龙骑士-钢铁之躯-恢复']{
    cover_type = 1,
}

function mt:on_add()
    local unit = self.target
    local skill = self.skill
    unit:add_life_recovery(self.recovery)
end

function mt:on_remove()
    local unit = self.target
    local skill = self.skill
    unit:add_life_recovery(-self.recovery)
end