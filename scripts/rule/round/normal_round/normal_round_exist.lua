local Round = require 'rule.round.round'
local Creep_datas = require 'rule.round.normal_round.normal_round_datas'
local Map_rects = require 'base.rects'
local Timerdialog = Router.timerdialog
local Player = Router.player
local table_insert = table.insert

local Normal_round_exist = {}
setmetatable(Normal_round_exist, Normal_round_exist)

local mt = {}
Normal_round_exist.__index = mt

Map_game.normal_round_exist = Normal_round_exist

--继承Round
setmetatable(mt, mt)
mt.__index = Round
mt.super = Round

--类型
mt.type = '普通回合'

--附加的类型
mt.additive_type = '生存模式'

--父类型
mt.super_type = mt.super.type

--回合数
mt.index = 0

--最大回合数量，默认36回合
mt._max_round_number = 36

--回合状态，四种状态，创建、准备、开始、结束
mt.state = nil

--计时器窗口
mt.timerdialog = nil

--回合奖励
mt.reward_gold = 1000
mt.reward_lumbers = {
    1,
    2,
    3,
}


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
    Player.self:send_msg('[回合准备]：' .. datas.msg, 10)
end

function mt:prepare(  )
    self.state = '准备'
    self:show_prepare_round_msg()
    self.all_creeps = {}
    if not self.remainder_creeps then
        self.remainder_creeps = {}
    end
    local time = self.creep_datas.prepare_time
    if self.index == 1 then
        time = time + 60
    end
    
    self.timerdialog:set_time(time)
        :set_title(('第%s回合倒计时：'):format(self.index))
        :set_title_color(255, 0, 0)
        :set_on_expire_listener(function (  )
            self:start()
        end)
        :show()
        :run()
end

--回合开始，发布相关信息
function mt:show_start_round_msg(  )
    local datas = self.creep_datas
    Player.self:send_msg('[回合开始]：' .. datas.msg, 5)
end

--获取一个进击的目标
function mt:get_attack_target( u )
    local heros = {}
    for i = 1, ac.cpn do
        local p = ac.player.force[1][i]
        if p:is_player() and p.hero and p.hero:is_alive() then
            table_insert(heros, p.hero)
        end
    end
    local hero = nil
    if #heros > 0 then
        local dis
        for i = 1, #heros do
            local temp = u:get_point() * heros[i]
            if not dis then
                dis = temp
                hero = heros[i]
            end
            if temp < dis then
                hero = heros[i]
            end
        end
    end
    return hero
end

function mt:create_invade_creep( point )
    local name = self.creep_datas.name
    local u = Player.force[2][1]:create_unit(name, point, math.random(0,360))
    local target = self:get_attack_target(u)
    if not target then
        target = u:get_point()
    end
    u:issue_order('attack', target)
    table_insert(self.all_creeps, u)
end

--聚集出现时的特效和时间
mt.focus_effect_model = [[Doodads\Cinematic\ShimmeringPortal\ShimmeringPortal.mdl]]
mt.focus_style_time = 0.1 * 1000

--离散出现时的特效和时间
mt.disperse_effect_model = [[Abilities\Spells\Orc\MirrorImage\MirrorImageDeathCaster.mdl]]
mt.disperse_style_time = 0.3 * 1000
--回合开始，创建进攻怪物
--  @本回合应该创建多少野怪
function mt:create_invades(  )
    local datas = self.creep_datas
    local numbers = datas.count

    local creep_birth_rects = Map_rects['进攻怪物出生点-生存']
    local birth_rect_count = #creep_birth_rects
    local number_1 = math.floor(numbers / birth_rect_count )
    local number_2 = numbers - number_1 * (birth_rect_count-1)
    local inexpectant_index = math.random(1, birth_rect_count)
    for i = 1, birth_rect_count do
        if i ~= inexpectant_index then
            local rct = creep_birth_rects[i]
            local ef = rct:get_point():add_effect(self.focus_effect_model)
            ac.wait(2*1000, function()
                ef:remove()
            end)
            ac.timer(self.focus_style_time, number_1, function ( t )
                self:create_invade_creep( rct:get_random_point() )
            end)
        end
    end
    ac.wait(5*1000, function (  )
        local rct = Map_rects['战斗区域']
        ac.timer(self.disperse_style_time, number_2, function ( t )
            local point = rct:get_random_point()
            point:add_effect(self.disperse_effect_model):remove()
            self:create_invade_creep( point )
        end)
    end)
    print('创建的野怪数量：', numbers, number_1, number_1 * (birth_rect_count-1), number_2)
    return numbers
end


function mt:start(  )
    self.state = '开始'
    self:show_start_round_msg()
    self:create_invades()
    self.timerdialog:set_time(self.creep_datas.clear_time)
        :set_title('清除怪物倒计时：')
        :set_on_expire_listener(function (  )
            self:finish( false )
        end)
        :show()
        :run()

    self.invade_unit_dead_counts = 0
    self.invade_unit_counts = 0
    self.invade_unit_dead_trg = ac.game:event '单位-死亡'(function ( trg, unit, killer )
        if unit._is_invade_unit then
            self.invade_unit_dead_counts = self.invade_unit_dead_counts + 1
            print('进攻怪死亡：', self.invade_unit_dead_counts, self.invade_unit_counts)
            if self.invade_unit_dead_counts >= self.invade_unit_counts then
                self:finish()
            end
        end
    end)

    --监听动态增加进攻怪数量
    self.invade_unit_create_trg = ac.game:event '单位-创建'(function(trg, unit)
        if unit:get_owner() == Player.force[2][1] and unit.is_invade_creep then
            unit._is_invade_unit = true
            print('进攻怪创建：', self.invade_unit_dead_counts, self.invade_unit_counts)
            self.invade_unit_counts = self.invade_unit_counts + 1
        end
    end)

    self.invade_unit_attack_timer = ac.loop(1*1000, function(t)
        for _, u in pairs(self.all_creeps) do
            if u:get_order() ~= 'attack' then
                local target = self:get_attack_target(u)
                if not target then
                    target = u:get_point()
                end
                u:issue_order('attack', target)
            end
        end
        for _, u in pairs(self.remainder_creeps) do
            if u:get_order() ~= 'attack' then
                local target = self:get_attack_target(u)
                if not target then
                    target = u:get_point()
                end
                u:issue_order('attack', target)
            end
        end
    end)

end

function mt:get_remainder_creeps(  )
    if not self.remainder_creeps then
        self.remainder_creeps = {}
    end
    return self.remainder_creeps
end


--回合完成，创建回合奖励
function mt:award(  )
    for i = 1, ac.cpn do
        local p = ac.player.force[1][i]
        if p:is_player() then
            local gold = self.reward_gold * self.index
            p:add_gold(gold)
            local lumber = self.reward_lumbers[self.index/10] or 0
            p:add_lumber(lumber)
        end
    end
end

--回合完成，进行回合惩罚
function mt:mete_out_punishment()
    if #self.remainder_creeps > 0 then
        Player.self:send_msg('没有在有限时间内击杀所有的怪物，怪物得到增强！！', 10)
        for _, u in pairs(self.remainder_creeps) do
            if u:is_alive() then
                u:add_attack(u:get_attack())
                u:add_life(u:get_max_life())
                u:add_max_life(u:get_max_life())
                u:add_size(0.5)
                u:add_color(0, -50, -50)
            end
        end
    end
end

function mt:finish( is_reward )
    self.state = '结束'
    self.timerdialog:pause()
    self.timerdialog:show(false)

    if self.invade_unit_dead_trg then
        self.invade_unit_dead_trg:remove()
    end

    if self.invade_unit_create_trg then
        self.invade_unit_create_trg:remove()
    end

    if self.invade_unit_attack_timer then
        self.invade_unit_attack_timer:remove()
    end
    local tmp = {}
    for _, u in pairs(self.remainder_creeps) do
        if not u:is_alive() then
            u:remove()
            u._is_remainder_invade_unit = nil
        else
            table_insert(tmp, u)
        end
    end
    self.remainder_creeps = tmp

    for _, u in pairs(self.all_creeps) do
        if not u:is_alive() then
            u:remove()
        else
            u._is_invade_unit = nil
            u._is_remainder_invade_unit = true
            table_insert(self.remainder_creeps, u)
        end
    end

    if is_reward == nil or is_reward then
        self:award()
    end
    
    self:mete_out_punishment()

    --回合结束，应该向上交出回合处理权
    ac.game:event_notify( '回合-结束-上交权限', self)
end

--设置最大回合数
function mt:set_max_round_number(n)
    self._max_round_number = n
end

function mt:get_max_round_number()
    return self._max_round_number
end

--获取当前回合数
function mt:get_round_number()
    return self.index
end

function mt:remove(  )
    
end




return Normal_round_exist