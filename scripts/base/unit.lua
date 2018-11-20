
local Unit = Router.unit

local mt = Unit.__index

--抽点
--  期待的概率
--  [最小的概率]
--  [最大的概率]
function mt:roll_fortune( rate, min, max )
    return self:get_owner():roll_fortune(rate, min, max)
end

--获取单位可以拿去的武器类型
function mt:is_enable_hold_weapon( it )
    local type = it:get_weapon_type()
    if self.weapon_type == type then
        return true
    end
end