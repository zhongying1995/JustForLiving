local Rects = require 'base.rects'
local Player = Router.player

local Creep_revive = require 'rule.creep.revive.creep_revive'

local mt = Creep_revive['螃蟹']{
    war3_id = 'h601',

    revive_rects = Rects['螃蟹区域'],

    revive_time = 14,

    base_move_speed = 8,

    max_move_speed = 100,

    base_extra_life = 10,

    mission_name = '螃蟹任务',

    revive_callback = function(self, unit)
        if not self.move_speed then
            self.move_speed = self.base_move_speed
        end
        if not self.extra_life then
            self.extra_life = self.base_extra_life
        end

        unit:add_move_speed(self.move_speed)
        unit:add_max_life(self.extra_life)

        self.extra_life = self.extra_life + self.base_extra_life
        if self.move_speed < self.max_move_speed then
            self.move_speed = self.move_speed + self.base_move_speed
        end
    end,

    death_callback = function(self, unit, killer)
        local p = killer:get_owner()
        local is_finish = p:update_mission(self.mission_name)
        if is_finish then
            p:finish_mission(self.mission_name)
        end
    end,
}

function mt:get_birth_point()
    local rect = self.revive_rects[math.random(1, #self.revive_rects)]
    return rect:get_random_point()
end
