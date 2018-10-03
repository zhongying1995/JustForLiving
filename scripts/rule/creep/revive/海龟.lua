local Creep_revive = require 'rule.creep.revive.creep_revive'

Creep_revive['小海龟']{
    war3_id = 'hrif',

    revive_time = 10,

    revive_callback = function(unit)
        print('小海龟复活啦！！！')
    end,

    death_callback = function(unit)
        print('小海龟刚刚死亡，等等复活！')
    end,
}