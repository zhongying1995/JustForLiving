local Round = require 'rule.round.round'
local Boss_datas = require 'rule.round.boss_round.boss_round_datas'
local Map_rects = require 'base.rects'
local Timerdialog = Router.timerdialog
local Player = Router.player

local Boss_round_guard = {}
setmetatable(Boss_round_guard, Boss_round_guard)

local mt = {}
Boss_round_guard.__index = mt

--继承Round
setmetatable(mt, mt)
mt.__index = Round
mt.super = Round

--类型
mt.type = 'Boss回合'

--附加的类型
mt.additive_type = '防守模式'

--父类型
mt.super_type = mt.super.type

--回合数
mt.index = 0

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
    if Map_game.main_tower then
        self.main_tower = Map_game.main_tower
    else
        Log.error('初始化防守模型的Boss回合时，没有主城！！')
    end
end


function mt:create()
    self.state = '创建'
    self.index = self.index + 1
    self.boss_datas = Boss_datas:get_datas_by_index( self.index )
    self:prepare()
end

function mt:show_prepare_round_msg()
    local datas = self.boss_datas
    Player.self:send_msg('[Boss即将来临]！！！', 10)
end

function mt:prepare()
    self.state = '准备'
    self:show_prepare_round_msg()
    local time = self.boss_datas.prepare_time
    self.timerdialog:set_time(time)
        :set_title('Boss降临：')
        :set_title_color(255, 0, 0)
        :set_on_expire_listener(function (  )
            self.timerdialog:show(false)
            self:start()
        end)
        :show()
        :run()
end


function mt:show_start_round_msg(  )
    local datas = self.boss_datas
    Player.self:send_msg('[Boss降临]：' .. datas.msg, 5)
end


function mt:get_attack_target(u)
    return self.main_tower
end


function mt:create_attack_boss(point)

    local tower_target = self.main_tower

    local datas = self.boss_datas
    local num = datas.boss_count
    local name = datas.boss_name
    for i = 1, num do
        local boss = Map_game.invade_creep_player:create_unit(name, point)
        point:add_effect(self.boss_create_effect_model_4):remove()
        local target = self:get_attack_target(boss)
        if not target then
            target = tower_target
        end
        boss:issue_order('attack', target)
        boss._is_invade_boss = true
    end
    
    if datas.henchmans then
        for _, henchman_data in pairs(datas.henchmans) do
            local id = henchman_data.id
            local num = henchman_data.count
            for i = 1, num do
                local p1 = point - {math.random(0, 360), math.random(100, 250)}
                p1:add_effect(self.henchman_create_effect_model_1):remove()
                local u = Map_game.invade_creep_player:create_unit(id, p1)
                local target = self:get_attack_target(boss)
                if not target then
                    target = tower_target
                end
                u:issue_order('attack', target)
                u._is_invade_boss = true
            end
        end
    end
end

mt.boss_create_effect_model_1 = [[Abilities\Spells\Undead\Darksummoning\DarkSummonTarget.mdl]]
mt.boss_create_effect_model_2 = [[SharedModels\UBirth.mdl]]
mt.boss_create_effect_model_3 = [[units\undead\Acolyte\Acolyte]]
mt.boss_create_effect_model_4 = [[Abilities\Spells\Demon\DarkPortal\DarkPortalTarget.mdl]]
mt.henchman_create_effect_model_1 = [[Abilities\Spells\Items\AIil\AIilTarget.mdl]]

function mt:boss_come_down_show(point)

    ac.timer(0.3*1000, 5, function()
        ac.player.self:ping_minimap(point, 1, 255, 255, 255)
    end)

    ac.wait(2*1000, function()
    
        local ef_1 = point:add_effect(self.boss_create_effect_model_1)
        local ef_2 = point:add_effect(self.boss_create_effect_model_2)
        local ef_3 = {}
        local ang = math.random(0, 360)
        for i = 1, 5 do
            local p1 = point - {ang, 100}
            ef_3[i] = p1:add_effect(self.boss_create_effect_model_3, {ang = p1:angle(point)})
            ef_3[i]:set_animation('stand work gold')
        end

        ac.wait(2*1000, function()
            ef_1:remove()
            ef_2:remove()
            for i = 1, #ef_3 do
                ef_3[i]:remove()
            end
            self:create_attack_boss(point)
        end)
        
    end)

end

function mt:create_invades(  )

    local creep_birth_rects = Map_rects['进攻怪物出生点-防守']
    local birth_rect_index = math.random(1, #creep_birth_rects)
    local rect = creep_birth_rects[birth_rect_index]
    local point = rect:get_point()

    self:boss_come_down_show(point)

end


function mt:start()
    self.state = '开始'
    self:show_start_round_msg()
    self:create_invades()
    local time = self.boss_datas.clear_time
    self.timerdialog:set_time(time)
        :set_title('大清洗：')
        :set_title_color(255, 0, 0)
        :set_on_expire_listener(function (  )
            self:finish()
        end)
        :show()
        :run()
end

function mt:create_round_reward()
    Player.self:send_msg('国家奖励你一个女Boss，快去领取吧！')
end

function mt:finish()
    self.state = '结束'
    self.timerdialog:pause()
    self.timerdialog:show(false)
    self:create_round_reward()
    --回合结束，应该向上交出回合处理权
    ac.game:event_notify( '回合-结束-上交权限', self)
end


return Boss_round_guard