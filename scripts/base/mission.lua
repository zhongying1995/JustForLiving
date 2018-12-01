local Player = Router.player

local Mission = {}
setmetatable(Mission, Mission)

local mt = {}
Mission.__index = mt

--类型
mt.type = '任务'

--具体类型
mt.specific_type = nil

local function register_new_mission(self, name, data)
    if not self._register_list then
        self._register_list = {}
    end
    self._register_list[name] = data

    setmetatable(data, data)
    data.__index = mt
    data.name = name
    data.specific_type = name

    return data
end

--注册一个任务
function Mission.register(name)
    return function ( data )
        return register_new_mission(Mission, name, data)
    end
end

--查找一个已经注册的任务
--  name
function Mission.find(name)
    if not Mission._register_list then
        Mission._register_list = {}
    end
    return Mission._register_list[name]
end

--创建一个任务对象
--  name
function Mission:new(name)
    local mission_parent = Mission.find(name)
    if not mission_parent then
        Log.error(('尝试创建一个未注册的任务[%s]，请检查！'):format(name))
        return
    end
    local o = {}
    setmetatable(o, o)
    o.__index = mission_parent

    return o
end

--任务开始
function mt:start()
    if self.on_start then
        self:on_start()
    end
end

--任务更新
--  true:完成任务；false：没有完成
function mt:update(...)
    local is_finish
    if self.on_update then
        is_finish = self:on_update(...)
    end
    return is_finish and true
end

--任务完成
function mt:finish()
    if self.on_finish then
        self:on_finish()
    end
end

--移除任务
function mt:remove(...)
    if self.on_remove then
        self:on_remove(...)
    end
    self.player._mission_list[self.name] = nil
end


--单位添加任务
--  任务名称
--  @任务对象
function Player.__index:add_mission( name )
    if not self._mission_list then
        self._mission_list = {}
    end
    if self._mission_list[name] then
        return self._mission_list[name]
    end
    local mission = Mission:new(name)
    if not mission then
        return
    end
    self._mission_list[name] = mission
    mission.owner = self
    mission.player = self
    mission:start()
    return mission
end

--找到任务
--  任务名称
function Player.__index:has_mission(name)
    if not self._mission_list then
        self._mission_list = {}
    end
    return self._mission_list[name]
end

--单位完成任务
--  任务名称
--  是否保留任务
function Player.__index:finish_mission( name, is_keep, ... )
    local mission = self:has_mission(name)
    if mission then
        self:add_finish_mission_times(name)
        mission:finish(...)
        if not is_keep then
            self:remove_mission(name)
        end
    end
end

--获取玩家完成任务的次数
function Player.__index:get_finish_mission_times( name )
    if not self._finish_mission_list then
        self._finish_mission_list = {}
    end
    if not self._finish_mission_list[name] then
        self._finish_mission_list[name] = 0
    end
    return self._finish_mission_list[name]
end

--设置玩家完成任务的次数
function Player.__index:set_finish_mission_times( name, times )
    if not self._finish_mission_list then
        self._finish_mission_list = {}
    end
    if not self._finish_mission_list[name] then
        self._finish_mission_list[name] = 0
    end
    self._finish_mission_list[name] = times
end

--增加玩家完成任务的次数
function Player.__index:add_finish_mission_times( name, times )
    self:set_finish_mission_times(name, self:get_finish_mission_times(name) + (times or 1) )
end


--单位刷新任务
--  任务名称
function Player.__index:update_mission( name, ... )
    local mission = self:has_mission(name)
    if mission then
        return mission:update(...)
    end
end

--单位移除任务
function Player.__index:remove_mission(name, ...)
    local mission = self:has_mission(name)
    if mission then
        mission:remove(...)
    end
end

return Mission