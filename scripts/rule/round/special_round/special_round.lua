local Round = require 'rule.round.round'
local Creep_datas = require 'rule.round.special_round.special_round_datas'
local Map_rects = require 'base.rects'
local Timerdialog = Router.timerdialog
local Player = Router.player
local table_insert = table.insert

local Special_round = {}
setmetatable(Special_round, Special_round)

local mt = {}
Special_round.__index = mt

--继承Round
setmetatable(mt, mt)
mt.__index = Round
mt.super = Round

--类型
mt.type = '特殊回合'

--父类型
mt.super_type = mt.super.type


--最大回合数量，
mt._max_round_number = 7


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
    self.birth_rects = {
        Map_rects['进攻怪物出生点-生存'][4],
        Map_rects['进攻怪物出生点-防守'][2],
    }
end

function mt:create()
    self.state = '创建'
    self.index = self.index + 1
    self.creep_datas = Creep_datas:get_datas_by_index( self.index )
    self:prepare()
end

--特殊进攻怪即将来临
function mt:show_prepare_round_msg(  )
    local datas = self.creep_datas
    Player.self:send_msg(datas.msg, 10)
end

function mt:prepare()
    self.state = '准备'
    self:show_prepare_round_msg()
    self.all_creeps = {}
    local time = self.creep_datas.prepare_time
    self.timerdialog:set_time(time)
        :set_title('特殊进攻怪')
        :set_title_color(255, 0, 0)
        :set_on_expire_listener(function (  )
            self:start()
        end)
        :show()
        :run()
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


function mt:create_invade_creep(point)
    local name = self.creep_datas.name
    local u = Player.force[2][1]:create_unit( name, point, math.random(0,360))
    local target = self:get_attack_target(u)
    if not target then
        target = u:get_point()
    end
    u:issue_order('attack', target)
    table_insert(self.all_creeps, u)
end


--出怪的特效和时间
mt.creep_create_effect_model = [[Doodads\Cinematic\ShimmeringPortal\ShimmeringPortal.mdl]]
mt.creep_create_interval_time = 0.25
function mt:create_invades(  )
    local point = self.birth_rects[math.random(1, #self.birth_rects)]:get_point()
    local n = self.creep_datas.count
    local ef = point:add_effect(self.creep_create_effect_model)
    local t = ac.timer(self.creep_create_interval_time * 1000, n, function (  )
        self:create_invade_creep(point)
    end)

    function t:on_remove(  )
        ef:remove()
    end

end

function mt:start()
    self.state = '开始'
    self:create_invades()
    self:finish()
end

--特殊回合模式，没有结束
function mt:finish()

end


return Special_round