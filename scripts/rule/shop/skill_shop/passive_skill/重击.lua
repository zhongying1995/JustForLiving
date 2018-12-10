local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '重击-购买的'

local mt = ac.skill[skill_name]{
    war3_id = 'A20L',
    damage = {10, 100, 200, 400, 600},
    model = [[Abilities\Spells\Orc\LightningBolt\LightningBoltMissile.mdl]],
}

function mt:on_add()
    local unit = self.owner
    self.attack_trg = unit:event '单位-即将造成伤害效果'(function ( trg, damage )
        if damage:is_attack() then
            unit:damage{
                target = damage.target,
                damage_type = '魔法',
                skill = self,
                damage = self.damage,
            }
            damage.target:add_effect(self.model):remove()
        end
    end)
end

function mt:on_remove()
    if self.attack_trg then
        self.attack_trg:remove()
    end
end

Skill_shop:register{
    name = skill_name,
    war3_id = 'h25M',
    skill_name = skill_name,
    max_level = 5,
}
