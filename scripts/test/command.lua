local Map_rects = require 'base.rects'

local Debug_command = Router.debug_command
local mt = Debug_command.__index

mt['item'] = {
    action = function (player, name, n)
        local u = player:get_selecting_unit()
        if u then
            local n = n or 1
            for i = 1, n do
                local it = u:add_item(name)
                if not it then
                    player:send_msg('请检查物品名称是否正确：', name)
                end
            end
        else
            player:send_msg('请选择您的英雄！')
        end
    end
}

mt['minion'] = {
    action = function ( player, index, number )
        local index = index or 1
        local number = number or 1
        local name = '普通进攻怪-第' .. index .. '波'
        local point = Map_rects['进攻怪物出生点-生存'][1]:get_point()
        for i = 1, number do
            ac.player[12]:create_unit(name, point)
        end
    end
}