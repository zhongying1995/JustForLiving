local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '浪潮'
local mt = ac.skill[skill_name]{
    war3_id = 'A208',
    base_damage = {50, 150, 250, 350, 450},
    str_rate = {0.2, 0.3, 0.4, 0.5, 0.6},
    range = {500, 600, 700, 800, 900},
    speed = 1000,
    hit_area = 150,
    effect = [[Objects\Spawnmodels\Naga\NagaDeath\NagaDeath.mdl]],
}

function mt:on_effect()
    local unit = self.owner
    local target = self.target
    local point = unit:get_point()
    local dis = point * target
    local ang = point / target
    local dmg = unit:get_str(true) * self.str_rate + self.base_damage
    if dis > self.range then
        dis = self.range
    end
    local mvr = ac.mover.line{
        mover = unit,
        distance = dis,
        angle = ang,
        speed = self.speed,
        skill = self,
        hit_area = self.hit_area,
    }
    if mvr then
        unit:pause()
        function mvr:on_hit( u )
            if u:is_enemy(unit) then
                unit:damage{
                    target = u,
                    damage = dmg,
                    damage_type = '魔法',
                }
            end
        end

        function mvr:on_move(  )
            unit:get_point():add_effect(self.skill.effect):remove()
        end

        function mvr:on_finish(  )
            unit:pause(false)
        end
    end
end


Skill_shop:register{
    name = skill_name,
    war3_id = 'h258',
    skill_name = skill_name,
    max_level = 5,
}
