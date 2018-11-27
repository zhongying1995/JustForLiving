local Round = require 'rule.round.round'
local Boss_datas = require 'rule.round.boss_round.boss_round_datas'
local Map_rects = require 'base.rects'
local Timerdialog = Router.timerdialog
local Player = Router.player

local Boss_round_exist = {}
setmetatable(Boss_round_exist, Boss_round_exist)

local mt = {}
Boss_round_exist.__index = mt

--继承Round
setmetatable(mt, mt)
mt.__index = Round
mt.super = Round

--类型
mt.type = 'Boss回合'

--父类型
mt.super_type = mt.super.type


--附加的类型
mt.additive_type = '生存模式'

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
    self.boss_datas = Boss_datas:get_datas_by_index( self.index )
    self:prepare()
end

--回合准备，发布相关信息
function mt:show_prepare_round_msg(  )
    local datas = self.boss_datas
    Player.self:send_msg('[Boss回合准备]：' .. datas.msg, 10)
end

function mt:prepare(  )
    self.state = '准备'
    self:show_prepare_round_msg()
    self.timerdialog:set_time(self.boss_datas.prepare_time)
        :set_title(('第%s个Boss回合倒计时：'):format(self.index))
        :set_title_color(255, 0, 0)
        :set_on_expire_listener(function (  )
            self:start()
        end)
        :show()
        :run()
end

--回合开始，发布相关信息
function mt:show_start_round_msg(  )
    local datas = self.boss_datas
    Player.self:send_msg('[Boss回合开始]：' .. datas.msg, 5)
end

--获取一个进击的目标
local function get_attack_hero(  )
    --临时方案
    return ac.player[1].hero
end

function mt:create_invade_creep( point )
    local target = get_attack_hero()
    if not target then
        target = ac.point(0, 0)
    end
    
    local datas = self.boss_datas
    local numbers = 0
    local num = datas.boss_count
    local id = datas.boss_name
    for i = 1, num do
        local boss = Player.force[2][1]:create_unit(id, point)
        boss:issue_order('attack', target)
        boss._is_invade_boss = true
    end
    numbers = numbers + num
    
    if datas.henchmans then
        for _, henchman_data in pairs(datas.henchmans) do
            local id = henchman_data.id
            local num = henchman_data.count
            for i = 1, num do
                local u = Player.force[2][1]:create_unit(id, point)
                u:issue_order('attack', target)
                u._is_invade_boss = true
            end
            numbers = numbers + num
        end
    end
    return numbers
end

local focus_style_time = 0.1 * 1000
local disperse_style_time = 0.3 * 1000
--回合开始，创建进攻怪物
--  @本回合应该创建多少野怪
function mt:create_invades(  )

    local creep_birth_rects = Map_rects['进攻怪物出生点-生存']
    local birth_rect_index = math.random(1, #creep_birth_rects)
    local rect = creep_birth_rects[birth_rect_index]
    local numbers = self:create_invade_creep( rect:get_point() )

    return numbers
end

--回合无法完全清空野怪
function mt:fail_clear_invades(  )
    Player.self:send_msg('无法击败boss，你输了！')
    ac.game:event_notify( '回合-失败', self ) 
end

function mt:start(  )
    self.state = '开始'
    self:show_start_round_msg()
    self.invade_unit_counts = self:create_invades()
    self.timerdialog:set_time(self.boss_datas.clear_time)
        :set_title('清除Boss倒计时：')
        :set_on_expire_listener(function (  )
            self:fail_clear_invades()
        end)
        :show()
        :run()
    self.invade_unit_dead_counts = 0
    self.invade_unit_dead_trg = ac.game:event '单位-死亡'(function ( trg, unit, killer )
        if unit._is_invade_boss then
            self.invade_unit_dead_counts = self.invade_unit_dead_counts + 1
            if self.invade_unit_dead_counts >= self.invade_unit_counts then
                self:finish()
            end
        end
    end)
end


--回合完成，创建回合奖励
function mt:create_round_reward(  )
    Player.self:send_msg('国家奖励你一个女Boss，快去领取吧！')
end

function mt:finish(  )
    self.state = '结束'
    self.timerdialog:pause()
    self.timerdialog:show(false)
    if self.invade_unit_dead_trg then
        self.invade_unit_dead_trg:remove()
    end
    self:create_round_reward()
    --回合结束，应该向上交出回合处理权
    ac.game:event_notify( '回合-结束-上交权限', self)
end

function mt:remove(  )
    
end


return Boss_round_exist