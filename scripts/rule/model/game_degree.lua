local Game_degree = {}
setmetatable(Game_degree, Game_degree)

local mt = {}
Game_degree.__index = mt


mt['小白过家家级'] = function(player)
    print(player:tostring(), '点击了 小白过家家级 难度')
end

mt['老鸟各自飞级'] = function(player)
    print(player:tostring(), '点击了 老鸟各自飞级 难度')
end

mt['老鸟劝退级'] = function(player)
    print(player:tostring(), '点击了 老鸟劝退级 难度')
end


return Game_degree