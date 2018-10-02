local Dialog = Rount.dialog
local Player = Rount.player
local Game_degree = require 'rule.model.game_degree'
local Game_model = require 'rule.model.game_model'

local degree_dialog, model_dialog

local function choose_degree(degree, player)
    player:send_msg_to_force(('%s 选择了 %s 难度'):format(player:get_name(), degree), 10)
    Game_degree[degree](player)
end

local function choose_model(model, player)
    player:send_msg_to_force(('%s 选择了 %s 模式'):format(player:get_name(), model), 10)
    Game_model[model](player)
end

local function close_dialog(dialog)
    if dialog and dialog.type == 'dialog' then
        dialog:remove()
    end
end

local function open_model_dialog(player)
    local dialog = Dialog:new(model_dialog)
    dialog:show(player)
        :set_life(10)
        :run()
end

local function end_choose_game_model()
    ac.game:event_notify('游戏-开始选择英雄')
end


degree_dialog = {

    title = '请选择游戏难度',

    buttons = {
        [1] = {
            title = '小白过家家级',
            key = nil,
            on_click = function(dialog, player)
                print(player:tostring(), '点击了 小白过家家级 难度')
                choose_degree('小白过家家级', player)
                choose_model('生存模式', player)
                close_dialog(dialog)
                end_choose_game_model()
            end,
        },
        [2] = {
            title = '老鸟各自飞级',
            key = nil,
            on_click = function(dialog, player)
                print(player:tostring(), '点击了 老鸟各自飞级 难度')
                choose_degree('老鸟各自飞级', player)
                close_dialog(dialog)
                open_model_dialog(player)
            end,
        },
        [3] = {
            title = '老鸟劝退级',
            key = nil,
            on_click = function(dialog, player)
                print(player:tostring(), '点击了 老鸟劝退级 难度')
                choose_degree('老鸟劝退级', player)
                close_dialog(dialog)
                open_model_dialog(player)
            end,
        },
    },

}

model_dialog = {

    title = '请选择游戏模式',

    buttons = {
        [1] = {
            title = '生存模式',
            key = nil,
            on_click = function(dialog, player)
                choose_model('生存模式', player)
                close_dialog(dialog)
                end_choose_game_model()
            end,
        },
        [2] = {
            title = '防守模式',
            key = nil,
            on_click = function(dialog, player)
                choose_model('防守模式', player)
                close_dialog(dialog)
                end_choose_game_model()
            end,
        },
        [3] = {
            title = '生存+防守模式',
            key = nil,
            on_click = function(dialog, player)
                choose_model('生存+防守模式', player)
                close_dialog(dialog)
                end_choose_game_model()
            end,
        },
    },

}

local function open_degree_dialog(player)
    local dialog = Dialog:new(degree_dialog)
    dialog:show(player)
        :set_life(12)
        :run()
end

local function init()
    local player
    for _, p in pairs(Player.force[1]) do
        if p:is_player() then
            player = p
            break
        end
    end
    open_degree_dialog(player)
end

ac.game:event '游戏-选择难度'(function()
    print('游戏-选择难度')
    init()
end)
