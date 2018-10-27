local Game_model = {}
setmetatable(Game_model, Game_model)

local mt = {}
Game_model.__index = mt

setmetatable(mt, {
    __newindex = function ( t, k, v )
        if type(v) == 'table' and v.action then
            setmetatable(v, v)
            v.__index = t
        end
        rawset(t, k, v)
    end
})

mt['生存模式'] = {
    msg = [[
        |cffff0000生存模式|r：
        回合内死亡不会复活，直到新的回合开始
    ]],
    action = function(self, player)
        print(player:tostring(), '点击了 生存模式')
        ac.player.self:send_msg(self.msg, 20)
    end
}

mt['防守模式'] = {
    msg = [[
        |cffff0000防守模式|r：
        玩家需要守护中心区域的基地
        进攻怪会直接对建筑发起进攻
    ]],
    action = function(self, player)
        print(player:tostring(), '点击了 防守模式')
        ac.player.self:send_msg(self.msg, 20)
    end
}

mt['生存+防守模式'] = {
    msg = [[
        |cffff0000生存+防守模式|r：
        年轻？？？
    ]],
    action = function(self, player)
        print(player:tostring(), '点击了 生存+防守模式')
        ac.player.self:send_msg(self.msg, 30)
end
}

return Game_model