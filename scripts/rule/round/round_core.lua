local Normal_round = require 'rule.round.normal_round'
local Boss_round = require 'rule.round.boss_round'
local Special_round = require 'rule.round.special_round'
local Final_round = require 'rule.round.final_round'
local Fogmodifier = Router.fogmodifier
local Rects = require 'base.rects'

--负责回合的切换与运行
local Round_core = {}
setmetatable(Round_core, Round_core)

local mt = {}
Round_core.__index = mt

--每间隔 6 回合，出现一次boss
local normal_round_switch_interval = 6

--初始化-切换(调度算法)-创建-结束-切换

--切换回合，核心调度算法，决定下一回合由谁来启动
--调度算法不应该被外界调用
--  回合调度self
--  上一个结束的回合
local function switch_round(self, finish_round)

    local type = finish_round and finish_round.type

    if type == '普通回合' then
        local round_index = finish_round.index
        print('普通回合结束', round_index)
        if round_index % normal_round_switch_interval == 0 then
            self.current_round = Boss_round
        else
            self.current_round = Normal_round
        end
    elseif type == 'boss回合' then
        print('boss回合')
        local n = Normal_round:get_round_number()
        if n == Normal_round:get_max_round_number() then
            self.current_round = Final_round
        else
            self.current_round = Normal_round
        end
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

--创建战斗区域视野
function mt:create_battle_fog()
    local rect = Rects['战斗区域']
    self.battle_fog = Fogmodifier:new(ac.player.self, rect)
end

--目标回合已经结束，进行调度，准备下一回合
--  已经结束的回合
function mt:finish( finish_round )
    switch_round(self, finish_round)
end

function mt:init(  )
    Normal_round:init()
    Boss_round:init()
    self.round_finish_trg = ac.game:event '回合-结束-上交权限'(function ( trg, round )
        print('回合上交权限', round.type)
        self:finish(round)
    end)
    self:init_default_round()
    self:create_battle_fog()
end

ac.game:event '游戏-开始回合逻辑'(function ()
    Round_core:init()
end)

return Round_core