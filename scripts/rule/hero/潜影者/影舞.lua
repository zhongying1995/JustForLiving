local mt = ac.skill['影舞']{
    war3_id = 'A30C',
    time = {10, 14, 18, 22, 26},
}

function mt:on_effect()
    local unit = self.owner
    unit:add_buff '影舞-隐身'{
        time = self.time,
        skill = self,
    }
end


local mt = ac.buff['影舞-隐身']{
    effect_model = [[Abilities\Spells\Undead\DeathCoil\DeathCoilSpecialArt.mdl]],
}

function mt:on_add()
    local unit = self.target
    unit:add_effect(self.effect_model, 'origin'):remove()
    unit:add_restriction '隐身'
    unit:set_crit()
    local skill = self.skill
    self.trg = unit:event '单位-即将造成致命伤害'(function(trg, damage)
        if damage:is_attack() then
            local target = damage.target
            local source = damage.source
            unit:add_buff '影舞-隐身'{
                time = skill.time,
                skill = skill,
            }
            self:remove()
        end
    end)
end

function mt:on_remove()
    local unit = self.target
    unit:remove_restriction '隐身'
    unit:set_crit(false)
    if self.trg then
        self.trg:remove()
    end
end