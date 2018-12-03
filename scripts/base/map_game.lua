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

return Map_game