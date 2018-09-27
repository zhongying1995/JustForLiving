local Timerdialog = Rount.timerdialog
local table_insert = table.insert
local Fogmodifier = Rount.fogmodifier
local Map_rects = require 'base.rects'
local Player = Rount.player

local Choose_hero = {}
setmetatable(Choose_hero, Choose_hero)

local mt = {}
Choose_hero.__index = mt

--选择英雄窗口
mt.timerdialog = nil

--英雄商店
_HERO_SHOP_ID = ''

--购买英雄单位
_CUSTOMER_ID = ''

function mt:init()
    self.timerdialog = Timerdialog:new()
                        :set_title_color(255, 0, 0)
                        :set_bg_color()
                        :set_title('选择英雄倒计时')
                        :set_time(45)
                        :set_on_click_listener(function()
                            self:stop()
                        end)
                        :show()
                        :run()
    self:prepare()
end

function mt:prepare_choose_hero_shop()
    local central_point = ac.point(512, 256)
    self.hero_shop = ac.player[16]:create_unit(_HERO_SHOP_ID, central_point)
    for i = 1, ac.cpn do
        local p = ac.player.force[1]
        if p:is_player() then
            local u = p:create_unit(_CUSTOMER_ID, central_point)
            u:add_high(10000)
            if not self.customer_units then
                self.customer_units = {}
            end
            table_insert(self.customer_units, u)
        end
    end
end

function mt:prepare_fog()
    local rect = Map_rects['默认视野']
    local fog = Fogmodifier:new(Player.self, rect)
end

function mt:prepare_trg()
    -- self.trg_1 = 
end

function mt:prepare()
    self:prepare_choose_hero_shop()
    self:prepare_fog()
    self:prepare_trg()
end

function mt:start()

end

function mt:stop()

end

ac.game:event '游戏-选择模式结束'(function()
    Choose_hero:init()
end)