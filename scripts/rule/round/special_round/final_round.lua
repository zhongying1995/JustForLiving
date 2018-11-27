local Round = require 'rule.round.round'
local Boss_datas = require 'rule.round.special_round.final_round_datas'
local Map_rects = require 'base.rects'
local Timerdialog = Router.timerdialog
local Player = Router.player
local table_insert = table.insert

local Final_round = {}
setmetatable(Final_round, Final_round)

local mt = {}
Final_round.__index = mt

--继承Round
setmetatable(mt, mt)
mt.__index = Round
mt.super = Round

--类型
mt.type = '最终回合'

--父类型
mt.super_type = mt.super.type

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
    self.birth_rects = {
        Map_rects['进攻怪物出生点-生存'][4],
        Map_rects['进攻怪物出生点-生存'][1],
        Map_rects['进攻怪物出生点-防守'][2],
        Map_rects['进攻怪物出生点-生存'][3],
    }
end

function mt:create()
    self.state = '创建'
    self.creep_datas = Boss_datas:get_datas( )
    self:prepare()
end

function mt:show_prepare_round_msg(  )
    Player.self:send_msg('[最终话]：众神降临！！', 10)
end

function mt:prepare()
    self.state = '准备'
    self:show_prepare_round_msg()
    local time = self.creep_datas.prepare_time
    self.timerdialog:set_time(time)
        :set_title('众神降临：')
        :set_title_color(255, 0, 0)
        :set_on_expire_listener(function (  )
            self:start()
        end)
        :show()
        :run()
end

function mt:show_start_round_msg()
    Player.self:send_msg('[最终话]：众神降临！！', 10)
end

function mt:get_attack_target( point )
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
            local temp = point * heros[i]
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

mt.boss_create_candy_effect_model = [[Abilities\Spells\Human\Thunderclap\ThunderClapCaster.mdl]]
--展示boss创建的特效
function mt:show_boss_create_candy( point )
    ac.player.self:ping_minimap(point, 3, 255, 0, 0)
    ac.timer(0.25*1000, 3, function ()
        point:add_effect(self.boss_create_candy_effect_model):remove()
    end)
end


function mt:create_invades(  )
    local datas = self.creep_datas
    local boss_datas = datas.boss_datas
    for i = 1, #boss_datas do
        local current_point = self.birth_rects[math.random(1, #self.birth_rects)]:get_point()
        self:show_boss_create_candy(current_point)
        local target = self:get_attack_target(current_point)

        local data = datas.boss_datas[i]
        local boss_data = data.boss
        local name = boss_data.name
        local u = Player.force[2][1]:create_unit(name, current_point, math.random(0,360))
        u:issue_order('attack', target)

    end

end

function mt:start()
    self.state = '开始'
    self:show_start_round_msg()
    self:create_invades()

    local time = self.creep_datas.clear_time
    self.timerdialog:set_time(time)
        :set_title('泯灭：')
        :set_on_expire_listener(function (  )
            self:finish( false )
        end)
        :show()
        :run()
    
    self.invade_unit_counts = 0
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

    --监听动态增加进攻怪数量
    self.invade_unit_create_trg = ac.game:event '单位-创建'(function(trg, unit)
        if unit:get_owner() == Player.force[2][1] and not unit._is_invade_unit then
            self.invade_unit_counts = self.invade_unit_counts + 1
        end
    end)
end

--游戏胜利
function mt:win_game(  )
    ac.player.self:send_msg('恭喜你赢了！！！')
end

--游戏失败
function mt:fail_game(  )
    ac.player.self:send_msg('对不起你失败了！')
end

function mt:finish()
    self.state = '结束'
    self.timerdialog:pause()
    self.timerdialog:show(false)
    
    if self.invade_unit_dead_trg then
        self.invade_unit_dead_trg:remove()
    end

    if self.invade_unit_attack_timer then
        self.invade_unit_attack_timer:remove()
    end

    if is_reward == nil then
        is_reward = true
    end
    if is_reward then
        self:win_game()
    else
        self:fail_game()
    end

end


return Final_round