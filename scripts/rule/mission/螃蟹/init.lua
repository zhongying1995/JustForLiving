local Rects = require 'base.rects'
local Player = Router.player


local function init(  )
    local Creep_revive = require 'rule.creep.revive.creep_revive'

    local player_count = Player.count_alive()
    local rate = 4
    local base_number = 5
    local rcts = Rects['螃蟹区域']
    for i = 1, base_number+rate*player_count do
        local point = rcts[math.random(1, #rcts)]:get_random_point()
        local u = ac.player[16]:create_unit('螃蟹', point)
        Creep_revive:init_creep_revive(u)
    end
end

ac.game:event '游戏-开始'(function(trg)
    init()
end)
