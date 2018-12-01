local Player = Router.player
local Mission = require 'base.mission'

local mt = Mission.register('青蛙任务'){
    max_frog_count = 10,
    max_mission_times = 10,
}

function mt:on_start()
    self.owner:send_msg(('[|cffff9900%s|r/|cffff9900%s|r]你接收了[%s]，请击杀%s个青蛙！') 
            :format(self.max_mission_times, self.owner:get_finish_mission_times(self.name), self.name, self.max_frog_count),
        10)
end

function mt:on_update()
    if not self.frog_count then
        self.frog_count = 0
    end
    self.frog_count = self.frog_count + 1
    local msg
    local is_finish
    if self.frog_count == self.max_frog_count then
        msg = ('恭喜完成%s'):format(self.name)
        is_finish = true
    else
        msg = ('当前击杀青蛙[%s/%s]'):format(self.frog_count, self.max_frog_count)
    end
    self.player:send_msg(msg, 3)
    return is_finish and true
end

function mt:on_finish()
    local msg = ('[|cffff9900%s|r/|cffff9900%s|r]恭喜你完成了[%s]！牛逼！！！')
        :format(self.max_mission_times, self.owner:get_finish_mission_times(self.name), self.name)
    self.player:send_msg(msg)
end