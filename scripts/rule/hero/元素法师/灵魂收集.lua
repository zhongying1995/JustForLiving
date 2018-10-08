local mt = ac.skill['灵魂收集']{
    war3_id = 'A300',
    int_upper_limits = {
        100,
        200,
        300,
        400,
        500
    },
    int_upper_limit = 100,
    effect_model = [[Abilities\Spells\NightElf\SpiritOfVengeance\SpiritOfVengeanceBirthMissile.mdl]],
}

function mt:on_add()
    local unit = self.owner
    self.add_int_trg = unit:event '单位-杀死单位'(function(trg, killer, killed)
        local mvr = ac.mover.target{
			source = killed,
			target = killer,
			model = self.effect_model,
            speed = 500,
            high = 50,
			angle = killed:get_point() / killer:get_point(),
			max_distance = 3000,
			skill = self,
        }
        
        function mvr:on_finish()
            if killed:is_type_hero() then
                unit:add_add_int(1)
                return
            end
            if not unit._linghunshouji_extra_int then
                unit._linghunshouji_extra_int = 0
            end
            unit._linghunshouji_extra_int = unit._linghunshouji_extra_int + 1
            local int = math.floor(unit._linghunshouji_extra_int / 10)
            unit:add_add_int(int)
            if int ~= 0 then
                unit._linghunshouji_extra_int = unit._linghunshouji_extra_int - int * 10
            end
        end
    end)
end

function mt:on_upgrade()
    self.int_upper_limit = self.int_upper_limits[self.level]
end

function mt:on_remove()
    if self.add_int_trg then
        self.add_int_trg:remove()
    end
end