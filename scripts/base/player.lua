
local Player = Router.player

Player.force = {}
Player.force[1] = {
    [1] = Player[1],
    [2] = Player[2],
    [3] = Player[3],
    [4] = Player[4],
    [5] = Player[5],
    [6] = Player[6],
    [7] = Player[7],
    [8] = Player[8],
    ['enemy'] = Player[12],
}
Player.force[2] = {
    Player[12]
}
--computer Player numbers
ac.cpn = 8

local function alliance(  )
    for i = 1, ac.cpn do
        Player.force[1][i]:set_team(1)

        for j = 1, ac.cpn do
            Player.force[1][i]:set_alliance_ally(Player.force[1][j])
        end
        --与玩家12敌对
        Player.force[1][i]:set_alliance_ally(Player.force[1]['enemy'], false)
        Player.force[1]['enemy']:set_alliance_ally(Player.force[1][i], false)
        
        --与玩家16普通结盟
        Player.force[1][i]:set_alliance(ac.player[16], 0, true)
        ac.player[16]:set_alliance(Player.force[1][i], 0, true)
    end

    Player.force[2][1]:set_team(2)
    Player.force[2][1]:set_alliance(ac.player[16], 0, true)
    ac.player[16]:set_alliance(Player.force[2][1], 0, true)
end


local function init(  )
    alliance()
end


init()