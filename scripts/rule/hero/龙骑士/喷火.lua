local mt = ac.skill['喷火']{
    war3_id = 'A304',
    effect_model = [[Abilities\Spells\Other\BreathOfFire\BreathOfFireMissile.mdl]],
    radius = 250,
    damages = {100, 200, 300, 400, 500},
    de_attack_rate = 25,
    time = 10,
}

function mt:on_effect()
    local unit = self.owner
    local ang = unit:get_facing()
    local lv = self:get_level()
    local damage = self.damages[lv]
    local high = unit:get_high()
    local mvr = ac.mover.line{
        start = (unit:get_point() - {ang, 80}),
        angle = ang,
        distance = 800,
        model = self.effect_model,
        speed = 1200,
        height = 50 + high / 3,
        skill = self,
    }
    if mvr then
        local skill = self
        local g = {}
        function mvr:on_move()
            local p = self.mover:get_point()
            for _, u in ac.selector()
            :in_sector(p, skill.radius, ang, 120)
            :add_filter(function(u)
                return not g[u]
            end)
            :is_enemy(unit)
            :ipairs()
            do
                g[u] = true
                unit:damage{
                    target = u,
                    damage = damage,
                    skill = skill,
                    damage_type = '魔法',
                }
                local atk = u:get_attack() * skill.de_attack_rate / 100
                u:add_add_attack(-atk)
                ac.wait(skill.time * 1000, function()
                    u:add_add_attack(atk)
                end)
            end
        end

    end
end