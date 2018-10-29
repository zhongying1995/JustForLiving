local Round = {}
setmetatable(Round, Round)

local mt = {}
Round.__index = mt

mt.type = '回合'

--回合状态，四种状态，创建、准备、开始、结束
mt.state = nil

function mt:init()

end

function mt:create()
    self.state = '创建'
end

function mt:prepare()
    self.state = '准备'
end

function mt:start()
    self.state = '开始'
end

function mt:stop()
    self.state = '结束'
end

return Round