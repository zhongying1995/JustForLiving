local mt = ac.skill['集中']{
    war3_id = 'A307',
    attack_speed = {200, 250, 300, 300, 300},
    time = {10, 10, 10, 15, 20},
}

function mt:on_effect()
    local unit = self.owner
    local target = self.target

    unit:issue_order('attack', target)
    unit:add_buff('集中-攻击'){
        skill = self,
        time = self.time,
        attacked = target
    }
end

local mt = ac.buff['集中-攻击']{
    effect_model = [[effect\snipe_target.mdx]],
}

function mt:on_add()
    local skill = self.skill
    local unit = self.target
    local attacked = self.attacked
    self.attacked_ef = attacked:add_effect(self.effect_model, 'overhead')
    self.trg = unit:event '单位-攻击'(function(trg, atter, atted)
        if atted == attacked then
            self.buff = unit:add_buff('集中-攻速加成'){
                skill = skill,
            }
        else
            if self.buff then
                self.buff:remove()
            end
        end
    end)
end

function mt:on_remove()
    if self.trg then
        self.trg:remove()
    end
    if self.buff then
        self.buff:remove()
    end
    if self.attacked_ef then
        self.attacked_ef:remove()
    end
end

local mt = ac.buff['集中-攻速加成']{
    effect_model_left = [[Abilities\Spells\Orc\TrollBerserk\HeadhunterWEAPONSLeft.mdl]],
    effect_model_right = [[Abilities\Spells\Orc\TrollBerserk\HeadhunterWEAPONSLeft.mdl]],
}

function mt:on_add()
    local unit = self.target
    self.atk_spd = self.skill.attack_speed
    unit:add_attack_speed(self.atk_spd)
    self.ef_left = unit:add_effect(self.effect_model_left, 'hand left')
    self.ef_right = unit:add_effect(self.effect_model_right, 'hand right')
end

function mt:on_remove()
    local unit = self.target
    unit:add_attack_speed(-self.atk_spd)
    self.ef_left:remove()
    self.ef_right:remove()
end