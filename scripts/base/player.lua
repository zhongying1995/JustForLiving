
local Player = Router.player

local mt = Player.__index

------------------结盟解释----------------------
--玩家1-6为控制玩家
--玩家7为控制玩家的电脑盟友玩家
--玩家11为副本野怪玩家
--玩家12为进攻怪玩家
-----------------------------------------------

Player.force = {}
Player.force[1] = {
    [1] = Player[1],
    [2] = Player[2],
    [3] = Player[3],
    [4] = Player[4],
    [5] = Player[5],
    [6] = Player[6],
    ['com'] = Player[7],
    ['ally'] = Player[7],
    ['enemy'] = Player[12],
    ['wild_enemy'] = Player[11],
}
Player.force[2] = {
    [1] = Player[11],
    [2] = Player[12],
}
--computer Player numbers
ac.cpn = 6

--获取控制玩家的电脑盟友
function mt:get_ally_com_player()
    return Player.force[1]['com']
end

--获得进攻怪玩家
function mt:get_invade_creep_player()
    return Player.force[2][2]
end

--获得副本怪玩家
function mt:get_wild_creep_player()
    return Player.force[2][1]
end

--抽点
--  期待的概率
--  [最小的概率]
--  [最大的概率]
function mt:roll_fortune( roll, min, max )
    local roll = roll or 50
    local min = min or 1
    local max = max or 100
    local rate = math.random(min, max)
    return roll >= rate
end


local function alliance(  )
    --控制玩家结盟
    for i = 1, ac.cpn do
        Player.force[1][i]:set_team(1)

        for j = 1, ac.cpn do
            Player.force[1][i]:set_alliance_simple(Player.force[1][j])
        end

        --与阵营2敌对
        for j = 1, #Player.force[2] do
            Player.force[1][i]:set_alliance_simple(Player.force[2][j], false)
            Player.force[2][j]:set_alliance_simple(Player.force[1][i], false)
        end
        
        --与玩家16普通结盟
        Player.force[1][i]:set_alliance(ac.player[16], 0, true)
        ac.player[16]:set_alliance(Player.force[1][i], 0, true)
    end

    --敌人玩家结盟
    for i = 1, #Player.force[2] do
        Player.force[2][i]:set_team(2)

        for j = 1, #Player.force[2] do
            Player.force[2][i]:set_alliance_simple(Player.force[2][j], true)
            Player.force[2][j]:set_alliance_simple(Player.force[2][i], true)
        end
        
        Player.force[2][i]:set_alliance(ac.player[16], 0, true)
        ac.player[16]:set_alliance(Player.force[2][i], 0, true)
    end

    ac.player[16]:set_team(3)

    Map_game.ally_com_player = ac.player[1]:get_ally_com_player()
    Map_game.invade_creep_player = ac.player[1]:get_invade_creep_player()
    Map_game.wild_creep_player = ac.player[1]:get_wild_creep_player()

end


local function init(  )
    alliance()
end


init()