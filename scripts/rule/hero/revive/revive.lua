local table_insert = table.insert
local table_remove = table.remove
local Unit = Router.unit

local Revive = {}
setmetatable(Revive, Revive)

local mt = {}
Revive.__index = mt

--所有死亡的英雄
mt._dead_unit_list = {}

--复活英雄计时器
mt._revive_timers = nil

--复活英雄所需要的时间
mt._revive_time = 5

--单位复活的默认点
mt._revive_point = nil

--剩余的复活次数
mt._remaining_revive_times = 2

--复活流程：单位死亡->为单位分配复活计时器->计时器到期->复活单位

--创建复活英雄模块
function mt:create()
    self.hero_revive_listener_trg = ac.game:event '单位-死亡'(function(trg, unit, killer)
        print(unit:tostring(), unit:get_team())
        if unit:is_hero() and not unit:is_illusion() and unit:get_team() == 1 then
            self:add_dead_unit(unit)
        end
    end)
    self._revive_point = ac.point(100, 100)
end

--移除复活英雄模块
function mt:remove()
    if self.hero_revive_listener_trg then
        self.hero_revive_listener_trg:remove()
    end

    --清空死亡单位表
    self._dead_unit_list = {}
end

--增加一个死亡单位
function mt:add_dead_unit(unit)
    table_insert(self._dead_unit_list, unit)
    self:prepare_revive_unit(unit)
end

function mt:get_dead_units()
    return self._dead_unit_list
end

function mt:get_random_dead_unit()
    if #self._dead_unit_list > 0 then
        return self._dead_unit_list[math.random(1, #self._dead_unit_list)]
    end
    return nil
end

--准备复活一个英雄
function mt:prepare_revive_unit(unit)
    if self:get_remaining_revive_times() > 0 then
        self:add_remaining_revive_times(-1)
        self:prepare_revive_timer(unit)
    else
        ac.game:event_notify('游戏-复活次数用完', unit)
    end
    self:show_remaining_revive_times()
end

--开始复活一个单位
--  被复活的单位
--  强行复活，不减少复活次数计数
function mt:revive_unit(unit, is_force)
    if is_force then
        if self._revive_timers[unit] then
            self._revive_timers[unit]:remove()
        end
        self:add_remaining_revive_times(1)
    end
    self:force_revive_unit(unit, unit:get_revive_point())
end

--为单位分配一个复活计时器
function mt:prepare_revive_timer(unit)
    if not self._revive_timers then
        self._revive_timers = {}
    end
    --如果一个单位被其他途径复活了，而复活计时器又在，则删除计时器
    if self._revive_timers[unit] then
        self._revive_timers:remove()
    end
    local time = unit:get_revive_time()
    unit:get_owner():send_msg(('[%s]将在%s后复活！'):format(unit:get_name(), time), 4)
    self._revive_timers[unit] = ac.wait(time * 1000, function()
        self:revive_unit(unit)
        self._revive_timers[unit] = nil
    end)
end

--设置系统的复活时间
function mt:set_revive_time(time)
    self._revive_time = time
end

function mt:get_revive_time()
    return self._revive_time
end

--获取剩下的可复活次数
function mt:get_remaining_revive_times()
    return self._remaining_revive_times
end

--设置可剩下的可复活次数
function mt:set_remaining_revive_times(times)
    self._remaining_revive_times = times
end

--增加可剩下的可复活次数
function mt:add_remaining_revive_times(times)
    self:set_remaining_revive_times(self:get_remaining_revive_times() + times)
end

--对玩家显示剩下的可复活次数
function mt:show_remaining_revive_times()
    if self:get_remaining_revive_times() > 0 then
        ac.player.self:send_msg(('复活次数还剩下|cffff0000%s|r次'):format(self:get_remaining_revive_times()), 10)
    else
        ac.player.self:send_msg('|cffff0000复活次数使用完，暂时无法再次复活！|r')
    end
end

--复活一个单位
function mt:force_revive_unit(unit, where)
    local where = where or unit:get_revive_point()
    unit:revive(unit, where)
end


--获取单位复活点
function Unit.__index:get_revive_point()
    return self._revive_point or Revive._revive_point
end

function Unit.__index:set_revive_point(point)
    self._revive_point = point
end

--设置单位的复活时间
Unit.__index._revive_time = 1
function Unit.__index:get_revive_time()
    return self._revive_time + Revive:get_revive_time()
end

function Unit.__index:set_revive_time(time)
    local time = time
    if time == nil or time < 1 then
        time = 1
    end
    self._revive_time = time
end

function Unit.__index:add_revive_time(time)
    self:set_revive_time(self._revive_time + time)
end


local function init()
    ac.game:event '游戏-开始'(function(trg)
        Revive:create()
    end)
end

init()

return Revive