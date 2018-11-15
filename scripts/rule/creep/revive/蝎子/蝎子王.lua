local Creep_revive = require 'rule.creep.revive.creep_revive'
local Game_time = require 'base.time.game_time'

local mt = Creep_revive['蝎子王']{
    war3_id = 'h404',

    revive_time = 20,

    revive_callback = function ( self, unit )
        local msg = '蝎子王复活了！'
        ac.player.self:send_msg(msg, 1.5)
    end,

    --超出这个时间不会掉落装备
    drop_superior_limit = 35,

     --时间影响因子
     time_factor = 5,
}

local drop_item_list = {
    '黄铜',
    '纯银',
    '真金',
    '铂金',
}

function mt:death_callback( unit, killer )
    local time = Game_time:get_time()
    if time > self.drop_superior_limit then
        return
    end
    local rate = time * self.time_factor
    local i
    local is_lucky, roll = killer:get_owner():roll_fortune(rate)
    if is_lucky then
        i = 1
        if time > 10 then
            i = 2
        end
        if roll > rate / 2 then
            if time > 28 or roll > rate/1.5 then
                i = 4
            else
                i = 3
            end
        end
    end
    if i then
        local point = unit:get_point()
        point:add_item(drop_item_list[i])
    end
end