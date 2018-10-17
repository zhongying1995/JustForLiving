local Game_degree = {}
setmetatable(Game_degree, Game_degree)

local mt = {}
Game_degree.__index = mt


mt['小白过家家级'] = function(player)
    print(player:tostring(), '点击了 小白过家家级 难度')
    local msg = [[
        |cffff0000小白过家家难度|r：
        地图敌对怪物不会变异
        生存30波后会迎来最终回合
        无特殊怪物进攻
    ]]
    ac.player.self:send_msg(msg, 20)
end

mt['老鸟各自飞级'] = function(player)
    print(player:tostring(), '点击了 老鸟各自飞级 难度')
    local msg = [[
        |cffff0000老鸟各自飞难度|r：
        可以选择 生存 | 防守 | 生存+防守模式
        地图敌对怪物会变异
        36波后，迎来最终回合
        小概率触发特殊怪物进攻
    ]]
    ac.player.self:send_msg(msg, 20)
end

mt['老鸟劝退级'] = function(player)
    print(player:tostring(), '点击了 老鸟劝退级 难度')
    local msg = [[
        |cffff0000老鸟劝退飞难度|r：
        可以选择 生存 | 防守 | 生存+防守模式
        地图敌对怪物会大幅变异
        36波后，迎来最终回合
        概率触发特殊怪物进攻
        触发游戏彩蛋
    ]]
    ac.player.self:send_msg(msg, 20)
end


return Game_degree