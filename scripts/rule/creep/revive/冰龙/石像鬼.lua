local Creep_revive = require 'rule.creep.revive.creep_revive'

local mt = Creep_revive['攻城傀儡']{
    war3_id = 'h406',

    revive_time = 20,

    --保留的概率
    retain = 0,

    --击杀次数，判断一次
    kill_count_criticality = 10,

    --离上一次掉落钻石，击杀个数
    kill_count = 0,

    --掉落的物品
    drop_item = '黑耀',

}

function mt:death_callback( unit, killer )
    self.kill_count = self.kill_count + 1
    if self.kill_count > self.kill_count_criticality then
        self.kill_count = 0
        local is_luck, rate = killer:roll_fortune(self.kill_count_criticality+self.retain)
        if is_luck then
            unit:get_point():add_item(self.drop_item)
            self.retain = 0
            return
        end
        self.retain = self.retain + self.kill_count * (1 - rate/100)
    end
end