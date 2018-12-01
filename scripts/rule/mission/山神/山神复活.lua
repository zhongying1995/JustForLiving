local Creep_revive = require 'rule.creep.revive.creep_revive'
local Game_time = require 'base.time.game_time'

local mt = Creep_revive['山神']{
    war3_id = 'h400',

    revive_time = 30,

    --开始不再掉落神石
    drop_item_fork_time = 30,

    time_factor = 4,

    base_rate = 20,
}

mt.drop_item_list = {
    '神石',
    '通行证',
}

function mt:death_callback( unit, killer )
    local time = Game_time:get_time()
    local rate = time * self.time_factor + self.base_rate
    local index = 1
    if time > self.drop_item_fork_time then
        rate = rate / 2
        index = 2
    end
    local item_list
    local is_lucky = killer:roll_fortune(rate)
    if is_lucky then
        local point = unit:get_point()
        point:add_item(self.drop_item_list[index])
    end

end