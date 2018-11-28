local Game_degree = require 'rule.model.game_degree'
local Game_model = require 'rule.model.game_model'
local Fogmodifier = Router.fogmodifier
local Rects = require 'base.rects'

--负责回合的切换与运行
local Round_core = {}
setmetatable(Round_core, Round_core)

local mt = {}
Round_core.__index = mt

--回合一共运行了几次
mt.round_run_times = 0

--初始化-切换(调度算法)-创建-结束-切换

--切换回合，核心调度算法，决定下一回合由谁来启动
--调度算法不应该被外界调用
--  回合调度self
--  上一个结束的回合
function mt:switch_round(self, finish_round)
    self.last_round = finish_round

    local type = finish_round and finish_round.type

    if type == '普通回合' then
        local round_index = finish_round.index
        if round_index % self.normal_round_switch_interval == 0 then
            self.next_round = self.boss_round
        else
            self.next_round = self.normal_round
        end
    elseif type == 'boss回合' then
        local n = self.normal_round:get_round_number()
        if n == self.normal_round:get_max_round_number() then
            self.next_round = self.final_round
        else
            self.next_round = self.normal_round
        end
    else
        log.error('未知的回合触发回合调度算法！请检查！')
        return
    end

    self:switch_special_round()

    self:create()
end

function mt:init_default_round(  )
    self.next_round = self.normal_round
    self.last_round = self.next_round
    self:create()
end

--调度目标回合开始创建
function mt:create(  )
    self.round_run_times = self.round_run_times + 1
    self.current_round = self.next_round
    self.current_round:create(self.last_round)
end


--切换特殊回合
function mt:switch_special_round( is_force )
    if not self.special_round then
        return
    end
    if self.next_round ~= self.final_round then
        local rate = math.random(1, 100)
        if is_force or self.special_round_rate <= rate and self.round_run_times % 2 == 0 then
            self.run_special_round()
            self.special_round_rate = self.special_round_base_rate
        else
            self.special_round_rate = self.special_round_rate + self.special_round_base_rate
        end
    end
end


--开启特殊回合（非最终回合）
function mt:run_special_round(  )
    self.special_round:create(self.last_round, self.current_round)
end

--创建战斗区域视野
function mt:create_battle_fog()
    local rect = Rects['战斗区域']
    self.battle_fog = Fogmodifier:new(ac.player.self, rect)
end

--目标回合已经结束，进行调度，准备下一回合
--  已经结束的回合
function mt:finish( finish_round )
    self:switch_round(self, finish_round)
end

function mt:init(  )
    local Normal_round
    local Boss_round
    local Special_round
    local Final_round = require 'rule.round.special_round.final_round'
    local game_degree = Game_degree:get_game_degree()
    local game_model = Game_model:get_game_model()

    local lv = game_degree:get_game_degree_level()
    if lv == 1 then
        self.normal_round_switch_interval = 5
    else
        self.normal_round_switch_interval = 6
        Special_round = require 'rule.round.special_round.special_round'
        if lv == 2 then
            self.special_round_base_rate = 5
        else
            self.special_round_base_rate = 20
        end
        self.special_round_rate = self.special_round_base_rate
    end

    if game_model:get_game_model_name() == '生存模式' then
        Normal_round = require 'rule.round.normal_round.normal_round_exist'
        Boss_round = require 'rule.round.boss_round.boss_round_exist'
    else
        Normal_round = require 'rule.round.normal_round.normal_round_guard'
        Boss_round = require 'rule.round.boss_round.boss_round_exist_guard'
    end
    Normal_round:init()
    Boss_round:init()
    Final_round:init()

    self.normal_round = Normal_round
    self.boss_round = Boss_round
    self.special_round = Special_round
    self.final_round = Final_round
    if self.special_round then
        self.special_round:init()
    end

    self.round_finish_trg = ac.game:event '回合-结束-上交权限'(function ( trg, round )
        print('回合上交权限', round.type)
        self:finish(round)
    end)
    self:init_default_round()
    self:create_battle_fog()
end


return Round_core