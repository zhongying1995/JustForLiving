local Rects = require 'base.rects'
local Game_time = require 'base.time.game_time'

local Field = {}

Field.seeds = {
    '一级种子',
    '二级种子',
    '三级种子',
    '四级种子',
    '五级种子',
}

Field.rate = 0.6

function Field:start(  )
    self.refresh_timer = ac.loop(self.refresh_pulse*1000, function (  )
        if math.random() < self.rate then
            local time = Game_time:get_minute()
            local index = math.floor(time/self.upgrade_seed_pulse)+1
            if index > #self.seeds then
                index = #self.seeds
            end
            local seed = self.seeds[index]
            print(seed, #self.seeds, time, index)
            local rct = self.rects[math.random(1, #self.rects)]
            ac.player[16]:create_unit(seed, rct:get_random_point())
        end
    end)
    self.refresh_timer:on_timer()
end


function Field:init( pulse )
    self.rects = Rects['野外']
    self.refresh_pulse = pulse
    self.upgrade_seed_pulse = 8
    self:start()
end

return Field