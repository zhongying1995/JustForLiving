local Game = Router.game

local Map_game = Map_game
setmetatable(Map_game, Map_game)

local mt = {}
Map_game.__index = mt


function mt:set_round( type, round )
    if not self._round then
        self._round = {}
    end
    self._round[type] = round
end

function mt:get_round(type)
    return self._round[type]
end

--获取控制玩家的电脑盟友
function mt:get_ally_com_player()
    return ac.player[1]:get_ally_com_player()
end

--获取进攻怪玩家
function mt:get_invade_creep_player()
    return ac.player[1]:get_invade_creep_player()
end

--获得副本怪玩家
function mt:get_wild_creep_player()
    return ac.player[1]:get_wild_creep_player()
end

--是否从rpg大厅来的
function mt:is_rpg_robby(  )
    return Game.is_rpg_robby()
end

--获取游戏时间
--(要正式上架的地图才能获取，本地测试@0)
function mt:get_game_stated_time(  )
    return Game.get_game_stated_time()
end


return Map_game