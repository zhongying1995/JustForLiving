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

--进攻怪死亡的最小掉落概率
Field.base_drop_rate = 5

--进攻怪死亡的最大掉落概率
Field.max_drop_rate = 60

--时间影响因素
Field.drop_time_factor = 1

function Field:start(  )
    self.refresh_timer = ac.loop(self.refresh_pulse*1000, function (  )
        if math.random() < self.rate then
            local time = Game_time:get_minute()
            local index = math.floor(time/self.upgrade_seed_pulse)+1
            if index > #self.seeds then
                index = #self.seeds
            end
            local seed = self.seeds[index]
            local rct = self.rects[math.random(1, #self.rects)]
            ac.player[16]:create_unit(seed, rct:get_random_point())
        end
    end)
    self.refresh_timer:on_timer()
    self.pick_trg = ac.game:event '单位-获得物品'(function ( trg, unit, it )
        if not unit.is_farmer and it.is_seed then
            local player = unit:get_owner()
            local garden = player:get_garden()
            local rct = garden:get_garden_rect()
            it:set_point(rct:get_point())
        end
    end)
    self.drop_trg = ac.game:event '单位-死亡'(function ( trg, killed, killer )
        if killed.is_invade_creep then
            local min = Game_time:get_minute()
            local rate = min*self.drop_time_factor + self.base_drop_rate
            if rate > self.max_drop_rate then
                rate = self.max_drop_rate
            end
            local is_lucky = killer:get_owner():roll_fortune(rate)
            if is_lucky then
                local index = math.floor(min/self.upgrade_seed_pulse)+1
                if index > #self.seeds then
                    index = #self.seeds
                end
                local seed = self.seeds[index]
                local it = killed:get_point():add_item(seed)
                it:set_player(killed:get_owner())
            end
        end
    end)
end


function Field:init( pulse )
    self.rects = Rects['野外']
    self.refresh_pulse = pulse
    self.upgrade_seed_pulse = 8
    self:start()
end

return Field