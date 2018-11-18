local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '腐臭蜂群'
local mt = ac.skill[skill_name]{
    war3_id = 'A206',
    base_damage = {100, 200, 300, 400, 500},
    str_rate = {0.2, 0.25, 0.3, 0.35, 0.4},
    effect = [[Abilities\Spells\Undead\CarrionSwarm\CarrionSwarmMissile.mdl]],
    hit_area = 225,
    range = {700, 800, 900, 1050, 1300},
    speed = 1000,
}

function mt:on_effect()
    local unit = self.owner
    local target = self.target
    local point = unit:get_point()
    local ang = point / target
    local dmg = self.base_damage + unit:get_str(true) * self.str_rate
    local mvr = ac.mover.line{
        source = unit,
        model = self.effect,
        start = point,
        distance = self.range,
        speed = self.speed,
        angle = ang,
        hit_area = self.hit_area,
        skill = self,
    }
    if mvr then
        function mvr:on_hit( u )
            if u:is_enemy(unit) then
                unit:damage{
                    target = u,
                    damage = dmg,
                    damage_type = '魔法',
                }
            end
        end
    end
end


Skill_shop:register{
    name = skill_name,
    war3_id = 'h256',
    skill_name = skill_name,
    max_level = 5,
}
