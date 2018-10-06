local Timerdialog = Router.timerdialog
local table_insert = table.insert
local Fogmodifier = Router.fogmodifier
local Map_rects = require 'base.rects'
local Player = Router.player

local Choose_hero = {}
setmetatable(Choose_hero, Choose_hero)

local mt = {}
Choose_hero.__index = mt

--选择英雄窗口
mt.timerdialog = nil

--选择英雄时间
mt.prepare_time = 10

--英雄出生的点
mt.hero_show_point = nil

--被选择的英雄
mt.all_chosen_hero_data = {
    {
        id = 'Hmkg',
        tips = "这是一个很傻逼的英雄，千万别选！1",
    },
    {
        id = 'Hmkg',
        tips = "这是一个很傻逼的英雄，千万别选！2",
    },
    {
        id = 'Hmkg',
        tips = "这是一个很傻逼的英雄，千万别选！3",
    },
    {
        id = 'Hmkg',
        tips = "这是一个很傻逼的英雄，千万别选！4",
    },
    {
        id = 'Hmkg',
        tips = "这是一个很傻逼的英雄，千万别选！5",
    },
}

function mt:init()
    self.timerdialog = Timerdialog:new()
                        :set_title_color(255, 0, 0)
                        :set_bg_color()
                        :set_title('选择英雄倒计时')
                        :set_time(self.prepare_time)
                        :set_on_expire_listener(function()
                            self:stop()
                        end)
                        :show()
                        :run()
    self:prepare()
end

function mt:prepare_chosen_heros()
    local central_point = self.choose_hero_rects:get_point()
    local radius = 400
    local hero_numbers = #(self.all_chosen_hero_data)
    local angle_gap = 360 / hero_numbers
    local angle = 0
    for _, hero_data in pairs(self.all_chosen_hero_data) do
        local point = central_point - {angle, radius}
        local hero = ac.player[16]:create_unit(hero_data.id, point, angle + 180)
        hero_data.hero = hero
        hero:remove_ability('Amov')
        hero:add_alpha(-100)
        angle = angle + angle_gap
    end
end

function mt:prepare_fog()
    local rect = self.choose_hero_rects
    self.choose_hero_fog = Fogmodifier:new(Player.self, rect)
    Player.self:set_camera(rect)
end

function mt:offer_hero_to_player(id, player)
    if not self.hero_show_point then
        self.hero_show_point = Map_rects['默认视野']:get_point()
    end
    local point = self.hero_show_point
    local hero = player:create_hero(id, point)
    player.hero = hero
    player:set_camera(point)
    player:select_unit(hero)
end

function mt:prepare_chosen_hero_trg()
    self.choose_hero_trgs = {}
    self.choose_hero_trgs[1] = {}
    self.choose_hero_trgs[2] = {}
    for i, hero_data in pairs(self.all_chosen_hero_data) do
        local hero = hero_data.hero
        self.choose_hero_trgs[1][i] = hero:event '单位-被选择'(function(trg, unit, player)
            player:clear_msg()
            player:send_msg(hero_data.tips)
        end)
        self.choose_hero_trgs[2][i] = hero:event '单位-被双击'(function(trg, unit, player)
            if player.hero then
                return
            end
            local id = hero_data.id
            self:offer_hero_to_player(id, player)
        end)
    end
end

function mt:prepare_trgs()
    self:prepare_chosen_hero_trg()
end

function mt:prepare()
    Player.self:send_msg('请选择您想要的英雄，时间到期后，游戏就会开始！', 30)
    self.choose_hero_rects = Map_rects['选英雄区域']
    self:prepare_chosen_heros()
    self:prepare_fog()
    self:prepare_trgs()
    self:start()
end


function mt:start()
    
end

function mt:force_player_choose_hero()
    local id
    for _, player in pairs(Player.force[1]) do
        if player:is_player() and not player.hero then
            if not id then
                id = self.all_chosen_hero_data[1].id
            end
            self:offer_hero_to_player(id, player)
        end
    end
end

function mt:stop()
    self:force_player_choose_hero()
    Player.self:send_msg('选择英雄结束，游戏即将开始！', 5)
    self.choose_hero_fog:stop()
    self:destory()
end

function mt:destory()
    self:remove()
    ac.game:event_notify('游戏-开始回合逻辑')
end

function mt:remove()
    if self.timerdialog then
        self.timerdialog:remove()
    end
    if self.choose_hero_fog then
        self.choose_hero_fog:remove()
    end
    if self.all_chosen_hero_data then
        for _, hero_data in pairs(self.all_chosen_hero_data) do
            hero_data.hero:remove()
        end
    end
    if self.choose_hero_trgs then
        if self.choose_hero_trgs[1] then
            for _, trg in pairs(self.choose_hero_trgs[1]) do
                trg:remove()
            end
        end
        if self.choose_hero_trgs[2] then
            for _, trg in pairs(self.choose_hero_trgs[2]) do
                trg:remove()
            end
        end
    end
end

ac.game:event '游戏-开始选择英雄'(function()
    Choose_hero:init()
end)