local Skill_shop = require 'rule.shop.skill_shop.skill_shop'

local skill_name = '赏金猎人'

local mt = ac.skill[skill_name]{
    war3_id = 'A20H',
    gold = {10, 30, 60, 100, 200},
    lumber_rate = {0, 4, 8, 11, 15},
    lumber = 1,
}

function mt:on_add(  )
    local unit = self.owner
    unit:add_buff('赏金猎人'){
        skill = self,
    }
end

function mt:on_remove(  )
    local unit = self.owner
    unit:remove_buff('赏金猎人')
end

local buff = ac.buff['赏金猎人']{

}

function buff:on_add(  )
    local unit = self.target
    local player = unit:get_owner()
    self.kill_trg = unit:event '单位-杀死单位'(function ( trg, killer, killed )
        player:add_gold_text(skill.gold, unit)
        if skill.lumber_rate > 0 then
            local is_lucky = player:roll_fortune(skill.lumber_rate)
            if is_lucky then
                player:add_lumber(skill.lumber)
            end
        end
    end)
end

function buff:on_remove(  )
    if self.kill_trg then
        self.kill_trg:remove()
    end
end



Skill_shop:register{
    name = skill_name,
    war3_id = 'h25K',
    skill_name = skill_name,
    max_level = 5,
}
