local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '烈焰风暴'
local mt = ac.skill[skill_name]{
    war3_id = 'A204',
    range = 300,

    --附带的属性比例
    attr_rate = {0.2, 0.3, 0.4, 0.5, 0.6},

    --基础伤害
    base_damage = {20, 100, 300, 600, 1000},

    --触发次数
    duration_times = 4,

    --触发间隔
    interval_cool = 1,

    --地面的烟雾旋转特效
    strike_effect_model = [[Abilities\Spells\Human\FlameStrike\FlameStrikeTarget.mdl]],
    --火焰柱
    flame_effect_model = [[Abilities\Spells\Human\FlameStrike\FlameStrike.mdx]]
}

function mt:on_effect()
    local unit = self.owner
    local point = self.target
    local ef_1 = point:add_effect(self.strike_effect_model)
    local ef_2 = point:add_effect(self.flame_effect_model)
    local dmg = self.base_damage + unit:get_int(true) * self.attr_rate
    local timer = ac.timer(self.interval_cool*1000, self.duration_times, function(t, index)
        for _, u in ac.selector()
            :in_range(point, self.range)
            :is_enemy(unit)
            :ipairs()
        do
            unit:damage{
                target = u,
                damage = dmg,
                damage_type = '魔法',
            }
        end
    end)
    function timer:on_remove(  )
        ef_1:remove()
        ef_2:remove()
    end
    timer:on_timer()
end


Skill_shop:register{
    name = skill_name,
    war3_id = 'h254',
    skill_name = skill_name,
    max_level = 5,
}
