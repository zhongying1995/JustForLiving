local mt = ac.skill['灵魂收集']{
    war3_id = 'A300',
    int_upper_limit = {100, 200, 300, 400, 500},
    passive = true,
}

function mt:on_enable()
    local unit = self.owner
    unit:add_buff('元素法师-灵魂收集'){
        skill = self,
    }
end

function mt:on_disable()
    local unit = self.owner
    unit:remove_buff('元素法师-灵魂收集')
end


local mt = ac.buff['元素法师-灵魂收集']{
    effect_model = [[Abilities\Spells\NightElf\SpiritOfVengeance\SpiritOfVengeanceBirthMissile.mdl]],
}

function mt:on_add()
    local unit = self.target
    local skill = self.skill
    self.add_int_trg = unit:event '单位-杀死单位'(function(trg, killer, killed)
        local mvr = ac.mover.target{
			source = killed,
			target = killer,
			model = self.effect_model,
            speed = 500,
            high = 50,
			angle = killed:get_point() / killer:get_point(),
			max_distance = 3000,
			skill = skill,
        }
        
        if mvr then
            function mvr:on_finish()
                if killed:is_type_hero() then
                    unit:add_add_int(1)
                    return
                end
                if not unit._linghunshouji_extra_int then
                    unit._linghunshouji_extra_int = 0
                    unit._linghunshouji_extra_int_sum = 0
                end
                unit._linghunshouji_extra_int = unit._linghunshouji_extra_int + 1
                local int = math.floor(unit._linghunshouji_extra_int / 10)
                if int ~= 0 then
                    unit:add_add_int(int)
                    unit._linghunshouji_extra_int = unit._linghunshouji_extra_int - int * 10
                    unit._linghunshouji_extra_int_sum = unit._linghunshouji_extra_int_sum + int
                end
            end
        end
    end)
end

function mt:on_remove()
    if self.add_int_trg then
        self.add_int_trg:remove()
    end
end