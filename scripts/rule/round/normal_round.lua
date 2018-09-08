local Round = require 'rule.round.round'
local Timerdialog = Rount.timerdialog

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
    self:prepare()
end

--回合准备，发布相关信息
function mt:show_prepare_round_msg(  )
    
end

function mt:prepare(  )
    self.state = '准备'
    self:show_prepare_round_msg()
    self.timerdialog:set_time()
        :set_on_click_listener(function (  )
            self:start()
        end)
        :show()
        :run()
end

--回合开始，发布相关信息
function mt:show_start_round_msg(  )
    
end

--回合开始，创建进攻怪物
function mt:create_invades(  )
    
end

--回合无法完全清空野怪
function mt:fail_clear_invades(  )
    
end

function mt:start(  )
    self.state = '开始'
    self:show_start_round_msg()
    self:create_invades()
    self.timerdialog:set_time()
        :set_on_click_listener(function (  )
            self:fail_clear_invades()
        end)
        :run()
end


--回合完成，创建回合奖励
function mt:create_round_reward(  )
    
end

function mt:finish(  )
    self.state = '结束'
    self.timerdialog:show(false)
    self:create_round_reward()
    --回合结束，应该向上交出回合处理权
    ac.game:event_notify( '回合-结束-上交权限', self)
end

function mt:remove(  )
    
end




return Normal_round