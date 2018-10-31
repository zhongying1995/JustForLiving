local Round = require 'rule.round.round'
local Creep_datas = require 'rule.round.normal_round.normal_round_datas'
local Map_rects = require 'base.rects'
local Timerdialog = Router.timerdialog
local Player = Router.player
local table_insert = table.insert

local Normal_round_guard = {}
setmetatable(Normal_round_guard, Normal_round_guard)

local mt = {}
Normal_round_guard.__index = mt

Map_game.normal_round_guard = Normal_round_guard

--继承Round
setmetatable(mt, mt)
mt.__index = Round
mt.super = Round

--类型
mt.type = '普通回合'

--附加的类型
mt.additive_type = '防守模式'

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

function mt:init()
    if not self.timerdialog then
        self.timerdialog = Timerdialog:new()
            :set_title_color(255, 0, 0)
            :set_bg_color()
    end
    self.index = 0
    local tower_data = Creep_datas:get_guarded_tower()
    self.tower_data = tower_data
    self.main_tower = ac.player[1]:get_ally_com_player():create_unit(tower_data.name, tower_data.point)
    Map_game.main_tower = self.main_tower
end

function mt:create()
    self.state = '创建'
    self.index = self.index + 1
    self.creep_datas = Creep_datas:get_datas_by_index( self.index )
    self:prepare()
end

function mt:prepare()
    self.state = '创建'
    --生存模式的清怪时间为防守模式的准备时间
    local prepare_time = self.creep_datas.clear_time * 0.5
    self.timerdialog:set_time(10 or prepare_time)
        :set_title(('第%s回合出兵：'):format(self.index))
        :set_title_color(255, 0, 0)
        :set_on_expire_listener(function (  )
            self.timerdialog:show(false)
            self:start()
        end)
        :show()
        :run()
end

--回合开始，发布相关信息
function mt:show_start_round_msg(  )
    local datas = self.creep_datas
    Player.self:send_msg('[敌人进攻]：' .. datas.msg, 5)
end


--进攻单位获取进攻目标
function mt:get_attack_target(u)
    return self.main_tower:get_point()
end

--创建一个进攻单位
function mt:create_attack_unit(point)
    local name = self.creep_datas.name
    local u = Player.force[2][1]:create_unit(name, point, math.random(0,360))
    local target = self:get_attack_target(u)
    if not target then
        target = u:get_point()
    end
    u:issue_order('attack', target)
end

--出现时的特效
mt.invade_effect_model = [[Doodads\Cinematic\ShimmeringPortal\ShimmeringPortal.mdl]]
--创建一个进攻单位的时间间隔
mt.invade_gap_time = 0.1

--发兵
function mt:create_invades()
    local datas = self.creep_datas
    local numbers = datas.count

    local creep_birth_rects = Map_rects['进攻怪物出生点-防守']
    local birth_rect_count = #creep_birth_rects
    local number_1 = math.floor(numbers / birth_rect_count )
    local number_2 = numbers - number_1 * birth_rect_count
    
    for i = 1, birth_rect_count do
        local number = number_1
        if i == 1 then
            number = number + number_2
        end
        local rct = creep_birth_rects[i]
        local ef = rct:get_point():add_effect(self.focus_effect_model)
        local index = 0
        ac.loop(self.invade_gap_time * 1000, function ( t )
            self:create_attack_unit( rct:get_point() )
            index = index + 1
            if index == number then
                t:remove()
                ef:remove()
                if i == 1 then
                    --创建完所有的进攻怪物了，进入回合下一阶段
                    --生存模式的准备时间为防守模式的结束时间
                    local time = self.creep_datas.prepare_time
                    self.timerdialog:set_time(10 or prepare_time)
                            :set_title('回合结束：')
                            :set_title_color(255, 0, 0)
                            :set_on_expire_listener(function (  )
                                self:finish()
                            end)
                            :show()
                            :run()
                end
            end
        end)
    end
end

function mt:start()
    self.state = '开始'
    self:show_start_round_msg()
    self:create_invades()
end

function mt:finish(is_reward)
    self.state = '结束'
    self.timerdialog:pause()
    self.timerdialog:show(false)

    --回合结束，应该向上交出回合处理权
    ac.game:event_notify( '回合-结束-上交权限', self)
end


return Normal_round_guard