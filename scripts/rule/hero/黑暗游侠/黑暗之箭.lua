local mt = ac.skill['黑暗之箭']{
    war3_id = 'A306',
    effect_model = [[Abilities\Spells\Other\BlackArrow\BlackArrowMissile.mdl]],
    hit_radius = 128,
}

function mt:on_effect()
    local unit = self.owner
    local target = self.target
    local ang = unit:get_point() / target
    local high = unit:get_slk('launchZ') + unit:get_high()
    local mvr = ac.mover.line{
        source = unit,
        model = self.effect_model,
        angle = ang,
        distance = 2000,
        high = high,
        speed = 900,
        skill = self,
        hit_area = self.hit_radius,
        hit_type = ac.mover.HIT_TYPE_ENEMY,
    }
    if mvr then
        local damage = unit:get_agi(true) * 0.5
        local skill = self
        function mvr:on_hit(target)
            unit:damage{
                target = target,
                damage = damage,
                skill = skill,
                damage_type = '魔法',
            }
        end
    end

end