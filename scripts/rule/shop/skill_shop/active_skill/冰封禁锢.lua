local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '冰封禁锢'
local mt = ac.skill[skill_name]{
    war3_id = 'A205',
    
    --buff持续时间，眩晕时间为一半
    duration = 3,
    --霜冻新星
    effect_model_frost = [[Abilities\Spells\Undead\FrostNova\FrostNovaTarget.mdl]],
    --减速buff
    effect_model_slow = [[Abilities\Spells\Other\FrostDamage\FrostDamage.mdl]],
    range = 150,
    base_damage = {80, 200, 400, 600, 800},
    attr_rate = {50, 60, 70, 80, 90},
    --降低的攻速
    attack_speed = 50,
    --降低的移速
    move_speed = 30,
}

function mt:on_effect()
    local unit = self.owner
    local target = self.target
    local dmg = self.base_damage + unit:get_int() * self.attr_rate / 100
    print('霜冻新星')
    for _, u in ac.selector()
        :in_range(target, self.range)
        :is_enemy(unit)
        :ipairs()
    do
        local new_dmg = dmg / 2
        if u == target then
            new_dmg = dmg
            u:add_buff('晕眩'){
                skill = self,
                model = self.effect_model_frost,
                time = self.duration/2,
                ref = 'chest',
            }
        end
        unit:damage{
            target = u,
            damage = dmg,
            damage_type = '魔法',
        }
        u:add_buff('减攻速'){
            skill = self,
            model = self.effect_model_slow,
            time = self.duration,
            attack_speed = self.attack_speed,
            ref = 'right foot',
        }
        u:add_buff('减速'){
            skill = self,
            model = self.effect_model_slow,
            time = self.duration,
            move_speed = self.move_speed,
            ref = 'left foot',
        }
    end
end


Skill_shop:register {
    war3_id = 'h255',
    name = skill_name,
    skill_name = skill_name,
    max_level = 5,
}
