local Creep_revive = require 'rule.creep.revive.creep_revive'

local mt = Creep_revive['地狱之火']{
    war3_id = 'h407',

    revive_time = 30,

    --保留的概率
    base_rate = 20,

    --增加的概率
    add_rate = 10,

    --当前概率
    retain_rate = 0,

    --离上一次掉落钻石，击杀个数
    kill_count = 0,

}

mt.drop_item_list = {
    '元素法杖锻造书',
    '割魂之刃锻造书',
    -- '拯救之书锻造书',
    '漆黑之弓锻造书',
    '龙之盾锻造书',
}

function mt:death_callback( unit, killer )
    local is_luck, rate = killer:roll_fortune(self.base_rate+self.retain_rate)
    if is_luck then
        unit:get_point():add_item(self.drop_item_list[math.random(1, #self.drop_item_list)])
        self.retain_rate = 0
        return
    end
    self.retain_rate = self.retain_rate + self.add_rate
end