local mt = ac.skill['追击']{
    war3_id = 'A305',
    rate = {20, 25, 30, 35, 40},
    passive = true,
}

function mt:on_enable()
    local unit = self.owner
    unit:add_buff('黑暗游侠-追击'){
        skill = self,
    }
end

function mt:on_disable()
    local unit = self.owner
    unit:remove_buff('黑暗游侠-追击')
end

function mt:on_upgrade()
    if self:is_enable() then
        local unit = self.owner
        unit:remove_buff('黑暗游侠-追击')
        unit:add_buff('黑暗游侠-追击'){
            skill = self,
        }
    end
end


local mt = ac.buff['黑暗游侠-追击']{
    effect_model = [[Abilities\Spells\Other\BlackArrow\BlackArrowMissile.mdl]],
    speed = 900,
}

function mt:on_add()
    local unit = self.target
    local skill = self.skill
    self.trg = unit:event '单位-即将造成伤害'(function(trg, damage)
        if not damage:is_attack() then
            return
        end
        local rate = skill.rate
        if rate <= math.random(1, 100) then
            return
        end
        local target = damage.target
        local high = unit:get_slk('launchZ', 60) + unit:get_high()
        local mvr = ac.mover.target{
            start = unit,
            model = self.effect_model,
            target = target,
            high = high,
            speed = self.speed,
            skill = skill,
        }
        if mvr then
            function mvr:on_finish()
                unit:damage{
                    target = self.target,
                    damage = unit:get_agi(true),
                    damage_type = '魔法',
                }
            end
        end
    end)
end

function mt:on_remove()
    if self.trg then
        self.trg:remove()
    end
end