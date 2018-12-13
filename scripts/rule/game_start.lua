local Game_start = {}
setmetatable(Game_start, Game_start)

local mt = {}
Game_start.__index = mt

mt.reward_gold = 2000
mt.reward_lumber = 1

--加载完游戏的等待时间
mt.prepare_time = 1

function mt:start_game(  )
    if not self.open then
        self.open = true
        for i = 1, ac.cpn do
            local p = ac.player.force[1][i]
            if p:is_player() then
                p:add_gold(self.reward_gold)
                p:add_lumber(self.reward_lumber)
            end
        end
        ac.game:event_notify('游戏-选择难度')
    end
end


return Game_start