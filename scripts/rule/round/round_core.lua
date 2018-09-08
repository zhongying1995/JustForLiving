local Normal_round = require 'rule.round.normal_round'
local Boss_round = require 'rule.round.boss_round'
local Special_round = require 'rule.round.special_round'

--负责回合的切换与运行
local Round_core = {}
setmetatable(Round_core, Round_core)

local mt = {}
Round_core.__index = mt

--初始化-切换(调度算法)-创建-结束-切换

--切换回合，核心调度算法，决定下一回合由谁来启动
--调度算法不应该被外界调用
--  回合调度self
--  上一个结束的回合
local function switch_round(self, finish_round)

    local type = finish_round and finish_round.type

    if type == '普通回合' then
        self.current_round = Normal_round
    elseif type == 'boss回合' then

    else
        log.error('未知的回合触发回合调度算法！请检查！')
        return
    end

    --xxx
    --运算运算
    --xxx

    self:create()
end

function mt:init_default_round(  )
    self.current_round = Normal_round
    self:create()
end

--调度目标回合开始创建
function mt:create(  )
    self.current_round:create()
end

--目标回合已经结束，进行调度，准备下一回合
--  已经结束的回合
function mt:finish( finish_round )
    switch_round(self, finish_round)
end

function mt:init(  )
    Normal_round:init()
    self.round_finish_trg = ac.game:event '回合-结束-上交权限'(function ( trg, round )
        self:finish(round)
    end)
    self:init_default_round()
end

ac.game:event '游戏-开始'(function (  )
    Round_core:init()
end)

return Round_core