local Game_model = {}
setmetatable(Game_model, Game_model)

local mt = {}
Game_model.__index = mt


mt['生存模式'] = function(self, player)
    print(player:tostring(), '点击了 生存模式')
    local msg = [[
        |cffff0000生存模式|r：
        回合内死亡不会复活，直到新的回合开始
    ]]
    ac.player.self:send_msg(msg, 20)
end

mt['防守模式'] = function(self, player)
    print(player:tostring(), '点击了 防守模式')
    local msg = [[
        |cffff0000防守模式|r：
        玩家需要守护中心区域的基地
        进攻怪会直接对建筑发起进攻
    ]]
    ac.player.self:send_msg(msg, 20)
end

mt['生存+防守模式'] = function(self, player)
    print(player:tostring(), '点击了 生存+防守模式')
    local msg = [[
        |cffff0000生存+防守模式|r：
        年轻？？？
    ]]
    ac.player.self:send_msg(msg, 30)
end

return Game_model