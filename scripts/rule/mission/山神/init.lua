local Rects = require 'base.rects'
local Player = Router.player


local function init(  )
    local Creep_revive = require 'rule.creep.revive.creep_revive'

    local player_count = Player.count_alive()
    local rate = 4
    local base_number = 5
    local rct = Rects['山神']
    local minx, miny, maxx, maxy = rct:get()
    local point = ac.point(minx + (maxx-minx)/4, (maxy+miny)/2)
    local u = ac.player[1]:get_wild_creep_player():create_unit('山神', point)
    Creep_revive:init_creep_revive(u)
    
end

ac.game:event '游戏-开始'(function(trg)
    init()
end)
