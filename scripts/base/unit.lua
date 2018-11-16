
local Unit = Router.unit

local mt = Unit.__index

--抽点
--  期待的概率
--  [最小的概率]
--  [最大的概率]
function mt:roll_fortune( rate, min, max )
    return self:get_owner():roll_fortune(rate, min, max)
end