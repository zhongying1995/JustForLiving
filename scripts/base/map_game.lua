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


return Map_game