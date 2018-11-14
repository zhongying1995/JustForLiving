local Creep_revive = require 'rule.creep.revive.creep_revive'

local mt = Creep_revive['青蛙']{
    war3_id = 'h600',

    revive_time = 10,

    revive_callback = function(self, unit)
        
    end,

    death_callback = function(self, unit)
        
    end,
}

function mt:get_birth_point()
    
end