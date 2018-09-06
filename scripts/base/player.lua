
local player = Rount.player

player.force = {}
player.force[1] = {
    [1] = player[1],
    [2] = player[2],
    [3] = player[3],
    [4] = player[4],
    [5] = player[5],
    [6] = player[6],
    [7] = player[7],
    [8] = player[8],
    ['enemy'] = player[12],
}
player.force[2] = {
    player[12]
}
--computer player numbers
ac.cpn = 8

local function alliance(  )
    for i = 1, ac.cpn do
        --设置队伍
        player.force[1][i]:set_team(1)

        --默认结盟
        for j = 1, ac.cpn do
            --与队友结盟
            player.force[1][i]:set_alliance_ally(player.force[1][j])
        end
        --与玩家12敌对
        player.force[1][i]:set_alliance_ally(player.force[1]['enemy'], false)
        player.force[1]['enemy']:set_alliance_ally(player.force[1][1], false)
        
        --与玩家16普通结盟
        player.force[1][i]:set_alliance(ac.player[16], 0, true)
        ac.player[16]:set_alliance(player.force[1][i], 0, true)
    end
    player.force[2][1]:set_team(2)
    player.force[2][1]:set_alliance(ac.player[16], 0, true)
    ac.player[16]:set_alliance(player.force[2][1], 0, true)
end


local function init(  )
    alliance()
end


init()