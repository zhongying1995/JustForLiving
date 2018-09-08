local Round = {}
setmetatable(Round, Round)

local mt = {}
Round.__index = mt

mt.type = '回合'


return Round