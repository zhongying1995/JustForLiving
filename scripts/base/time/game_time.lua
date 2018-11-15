local Game_time = {}
setmetatable(Game_time, Game_time)

local mt = {}
Game_time.__index = mt

--游戏时间运行的秒钟数
mt.second = 0

--计时器
mt.timer = nil

--获取当前游戏时间
--  @分钟，秒钟
function mt:get_time(  )
    local min = self:get_minute()
    local sec = self:get_second() - min*60
    return min, sec
end

--获得游戏进行了多少分钟
function mt:get_minute()
    local min = math.floor(self.second / 60)
    return min
end

--获得游戏进行了多少秒钟
function mt:get_second()
    return self.second
end

--开始记录游戏时间
function mt:start()
    self.second = 0
    if not self.timer then
        self.timer = ac.loop(self.pulse*1000, function()
            self.second = self.second + 1
        end)
    end
end


return Game_time