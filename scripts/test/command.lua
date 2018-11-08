local Debug_command = Router.debug_command
local mt = Debug_command.__index

mt['item'] = {
    action = function (player, name)
        local u = player:get_selecting_unit()
        if u then
            local it = u:add_item(name)
            if not it then
                player:send_msg('请检查物品名称是否正确：', name)
            end
        else
            player:send_msg('请选择您的英雄！')
        end
    end
}