local Game_model = {}
setmetatable(Game_model, Game_model)

local mt = {}
Game_model.__index = mt


mt['生存模式'] = function(player)
    print(player:tostring(), '点击了 生存模式')
end

mt['防守模式'] = function(player)
    print(player:tostring(), '点击了 防守模式')
end

mt['生存+防守模式'] = function(player)
    print(player:tostring(), '点击了 生存+防守模式')
end

return Game_model