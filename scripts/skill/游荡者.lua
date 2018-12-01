
local mt = ac.skill['游荡者']{
    pulse = 1,
    far_range = 500,
    passive = true
}

function mt:on_enable()
    local unit = self.owner
    self.wander_birth_point = unit:get_point()
    self.move_timer = ac.loop(self.pulse*1000, function()
        
        local is_not_meet = true
        local next_point
        for _, u in ac.selector()
            :in_range(unit:get_point(), self.far_range)
            :add_filter(function(u)
                if u:is_hero() and u:get_team() == 1 then
                    return true
                end
            end)
            :ipairs()
        do
            is_not_meet = false
            local point = unit:get_point()
            local face = u:get_point() / point
            next_point = point - {face, 128}
            break
        end
        if is_not_meet then
            next_point = self.wander_birth_point + {math.random(-200, 200), math.random(-200, 200)}
        end
        unit:issue_order('move', next_point)
    end)
end

function mt:on_disable()
    if self.move_timer then
        self.move_timer:remove()
    end
end