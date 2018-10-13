local mt = ac.skill['追击']{
    war3_id = 'A305',
    effect_model = [[Abilities\Spells\Other\BlackArrow\BlackArrowMissile.mdl]],
    rate = {20, 25, 30, 35, 40},
}

function mt:on_add()
    local unit = self.owner
    self.trg = unit:event '单位-即将造成伤害'(function(trg, damage)
        if not damage:is_attack() then
            return
        end
        local level = self:get_level()
        local rate = self.rate
        if rate < math.random(1, 100) then
            return
        end
        local target = damage.target
        local high = unit:get_slk('launchZ', 60) + unit:get_high()
        local mvr = ac.mover.target{
            start = unit,
            model = self.effect_model,
            target = target,
            high = high,
            speed = 900,
            skill = self,
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