local Creep_revive = require 'rule.creep.revive.creep_revive'

local mt = Creep_revive['炎魔']{
    war3_id = 'h40B',

    revive_time = 30,

    --保留的概率
    retain = 0,

    --掉落钻石的概率
    drop_rate = 65,

    --掉落的物品
    drop_item = '钻石',

}

function mt:death_callback( unit, killer )
    
    local is_luck, rate = killer:roll_fortune(self.drop_rate+self.retain)
    if is_luck then
        unit:get_point():add_item(self.drop_item)
        self.retain = 0
        return
    end
    self.retain = self.retain + 10
    
end