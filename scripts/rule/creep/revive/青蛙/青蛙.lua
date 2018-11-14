local Rects = require 'base.rects'
local Player = Router.player

local Creep_revive = require 'rule.creep.revive.creep_revive'

local mt = Creep_revive['青蛙']{
    war3_id = 'h600',

    revive_rects = Rects['青蛙区域'],

    revive_time = 10,

    mission_name = '青蛙任务',

    revive_callback = function(self, unit)
        
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
