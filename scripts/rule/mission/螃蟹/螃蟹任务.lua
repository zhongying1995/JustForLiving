local Player = Router.player
local Mission = require 'base.mission'

local mt = Mission.register('螃蟹任务'){
    max_crab_count = 8,
    max_mission_times = 10,
    base_rate = 5,
    reward_gold = 600,
    reward_item = '破布甲',
}

function mt:on_start()
    local player = self.owner
    local times = player:get_finish_mission_times(self.name)
    if player:get_finish_mission_times(self.name) > self.max_mission_times then
        local reason = ('已达完成任务上限[|cffff9900%s|r/|cffff9900%s|r]'):format(self.max_mission_times, times)
        return false, reason
    end
    player:send_msg(('[|cffff9900%s|r/|cffff9900%s|r]你接受了[%s]，请击杀%s个螃蟹！') 
            :format(self.max_mission_times, times, self.name, self.max_crab_count),
        10)
end

function mt:on_update()
    if not self.crab_count then
        self.crab_count = 0
    end
    self.crab_count = self.crab_count + 1
    local msg
    local is_finish
    if self.crab_count == self.max_crab_count then
        msg = ('恭喜完成%s'):format(self.name)
        is_finish = true
    else
        msg = ('当前击杀螃蟹[%s/%s]'):format(self.crab_count, self.max_crab_count)
    end
    self.player:send_msg(msg, 3)
    return is_finish and true
end

function mt:on_finish()
    local msg = ('[|cffff9900%s|r/|cffff9900%s|r]恭喜你完成了[%s]！')
        :format(self.max_mission_times, self.owner:get_finish_mission_times(self.name), self.name)
    self.player:send_msg(msg, 5)
    self:reward()
end

function mt:reward(  )
    local player = self.owner
    player:add_gold_text(self.reward_gold, player.hero)
    local times = player:get_finish_mission_times(self.name)
    local is_luck = player:roll_fortune(times*self.base_rate )
    local msg
    if is_luck then
        msg = ('恭喜获得[%s]'):format(ac.get_color_string(self.reward_item, 'reward'))
        player.hero:add_item(self.reward_item)
    else
        msg = '很遗憾，请再接再厉！'
    end
    player:send_msg(msg, 3)
end