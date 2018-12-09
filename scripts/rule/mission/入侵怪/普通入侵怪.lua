local Player = Router.player
local Mission = require 'base.mission'

local mt = Mission.register('普通入侵怪任务'){
    max_count = 50,
    reward_gold = 5000,
    reward_lumber = 1,
}

function mt:on_start()
    local player = self.owner
    local msg = ('你接受了[%s]，请击杀%s个入侵怪物！'):format( self.name, self.max_count)
    player:send_msg(msg, 10)
    self.kill_trg = player.hero:event '单位-杀死单位'(function( trg, killer, killed )
        if killed.is_invade_creep then
            local is_finish = self:on_update()
            if is_finish then
                player:finish_mission(self.name)
            end
        end
    end)
end

function mt:on_update()
    if not self.kill_count then
        self.kill_count = 0
    end
    self.kill_count = self.kill_count + 1
    local msg
    local is_finish
    if self.kill_count == self.max_count then
        msg = ('恭喜完成[%s]'):format(self.name)
        is_finish = true
    else
        msg = ('当前击杀普通入侵怪[%s/%s]'):format(self.kill_count, self.max_count)
    end
    self.player:send_msg(msg, 3)
    return is_finish and true
end

function mt:on_finish()
    local msg = ('恭喜你完成了[%s]！'):format( self.name)
    self.player:send_msg(msg, 5)
    self:reward()
end

function mt:on_remove(  )
    if self.kill_trg then
        self.kill_trg:remove()
    end
end

function mt:reward(  )
    local player = self.owner
    player:add_gold_text(self.reward_gold, player.hero)
    player:add_lumber(self.reward_lumber)
end