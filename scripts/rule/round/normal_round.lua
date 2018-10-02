local Round = require 'rule.round.round'
local Creep_datas = require 'rule.round.normal_round_datas'
local Map_rects = require 'base.rects'
local Timerdialog = Rount.timerdialog
local Player = Rount.player

local Normal_round = {}
setmetatable(Normal_round, Normal_round)

local mt = {}
Normal_round.__index = mt

--继承Round
setmetatable(mt, mt)
mt.__index = Round
mt.super = Round

--类型
mt.type = '普通回合'

--父类型
mt.super_type = mt.super.type

--回合数
mt.index = 0

--回合状态，四种状态，创建、准备、开始、结束
mt.state = nil

--计时器窗口
mt.timerdialog = nil


--回合初始化->回合创建->回合准备->回合开始->回合结束->回合创建

function mt:init(  )
    if not self.timerdialog then
        self.timerdialog = Timerdialog:new()
            :set_title_color(255, 0, 0)
            :set_bg_color()
    end
    self.index = 0
end

function mt:set_timerdialog(  )
    if not self.timerdialog then
        log.warn('[普通回合]还没有初始化回合，便设置回合计时器窗口！')
        return
    end
end

function mt:create(  )
    self.state = '创建'
    self.index = self.index + 1
    self.creep_datas = Creep_datas:get_datas_by_index( self.index )
    self:prepare()
end

--回合准备，发布相关信息
function mt:show_prepare_round_msg(  )
    local datas = self.creep_datas
    Player.self:send_msg('[回合准备]：' .. datas.msg)
end

function mt:prepare(  )
    self.state = '准备'
    self:show_prepare_round_msg()
    self.timerdialog:set_time(self.creep_datas.prepare_time)
        :set_title(('第%s回合倒计时：'):format(self.index))
        :set_title_color(255, 0, 0)
        :set_on_click_listener(function (  )
            self:start()
        end)
        :show()
        :run()
end

--回合开始，发布相关信息
function mt:show_start_round_msg(  )
    local datas = self.creep_datas
    Player.self:send_msg('[回合开始]：' .. datas.msg)
end

--获取一个进击的目标
local function get_attack_hero(  )
    --临时方案
    return ac.player[1].hero
end

local function create_attack_unit( unit_id, point )
    -- local u = Player.force[2][1]:create_unit(unit_id, point, math.random(0,360))
    local u = ac.player[12]:create_unit(unit_id, point, math.random(0,360))
    u._is_invade_unit = true
    local target = get_attack_hero()
    if not target then
        target = ac.point(0, 0)
    end
    u:issue_order('attack', target)
end

local focus_style_time = 0.1 * 1000
local disperse_style_time = 0.3 * 1000
--回合开始，创建进攻怪物
--  @本回合应该创建多少野怪
function mt:create_invades(  )
    local datas = self.creep_datas
    local numbers = datas.count
    local unit_id = datas.unit_id

    local creep_birth_rects = Map_rects['进攻怪物出生点']
    local birth_rect_count = #creep_birth_rects
    local number_1 = math.floor(numbers * (birth_rect_count-1) / birth_rect_count)
    local number_2 = numbers - number_1 * (birth_rect_count-1)
    local inexpectant_index = math.random(1, birth_rect_count)
    for i = 1, birth_rect_count do
        local rct = creep_birth_rects[i]
        ac.timer(focus_style_time, number_1, function ( t )
            create_attack_unit( unit_id, rct:get_random_point() )
        end)
    end
    ac.wait(5*1000, function (  )
        local rct = Map_rects['战斗区域'][1]
        ac.timer(disperse_style_time, number_2, function ( t )
            create_attack_unit( unit_id, rct:get_random_point() )
        end)
    end)
    return numbers
end

--回合无法完全清空野怪
function mt:fail_clear_invades(  )
    Player.self:send_msg('无法清空野怪，你输了！')
    ac.game:event_notify( '回合-失败', self ) 
end

function mt:start(  )
    self.state = '开始'
    self:show_start_round_msg()
    self.invade_unit_counts = self:create_invades()
    self.timerdialog:set_time(self.creep_datas.clear_time)
        :set_on_click_listener(function (  )
            -- self:fail_clear_invades()
            self:finish( false )
        end)
        :show()
        :run()
    self.invade_unit_dead_counts = 0
    self.invade_unit_dead_trg = ac.game:event '单位-死亡'(function ( trg, unit, killer )
        if unit._is_invade_unit then
            self.invade_unit_dead_counts = self.invade_unit_dead_counts + 1
            print(self.invade_unit_dead_counts, self.invade_unit_counts)
            if self.invade_unit_dead_counts >= self.invade_unit_counts then
                self:finish()
            end
        end
    end)
end


--回合完成，创建回合奖励
function mt:create_round_reward(  )
    Player.self:send_msg('国家奖励你一个女朋友，快去领取吧！')
end

function mt:finish( is_reward )
    self.state = '结束'
    self.timerdialog:show(false)
    if self.invade_unit_dead_trg then
        self.invade_unit_dead_trg:remove()
    end
    if is_reward == nil then
        is_reward = true
    end
    if is_reward then
        self:create_round_reward()
    end
    --回合结束，应该向上交出回合处理权
    ac.game:event_notify( '回合-结束-上交权限', self)
end

function mt:remove(  )
    
end




return Normal_round