local Creep_revive = {}

--所有注册了野怪复活系统的野怪
local all_revive_creeps = {}


local mt = {}

function mt:revive_unit()
    local birth_point
    if self.get_birth_point then
        birth_point = self:get_birth_point()
    else
        birth_point = self.birth_point
    end

    local birth_angle = self.birth_angle
    local birth_player = self.birth_player
    local u = birth_player:create_unit(self.war3_id, birth_point, birth_angle)
                
    if self.revive_callback then
        self:revive_callback(u)
    end
    
    self:register_creep_revive_trg(u)
end

function mt:register_creep_revive_trg( unit )
    unit:event '单位-死亡'(function(trg, killed, killer)

        if self.death_callback then
            self:death_callback(u)
        end

        ac.wait(self.revive_time * 1000, function()
            if not self.is_enable_revive or self:is_enable_revive() then
                self:revive_unit()
            end
        end)
    end)
end

local function register_creep_revive(self, name, data)
    local war3_id = data.war3_id
    if not war3_id or war3_id == '' then
        Log.error(('注册%s野怪复活时，不能没有war3_id'):format(name) )
        return
    end
    all_revive_creeps[war3_id] = true
    
    setmetatable(data, data)
    data.__index = mt

    self[war3_id] = data

    if not data.revive_time then
        data.revive_time = 20
    end

    return data
end

setmetatable(Creep_revive, {__index = function(self, name)
    return function(data)
        return register_creep_revive(self, name, data)
    end
end})

--初始化一个野怪单位的复活
function Creep_revive:init_creep_revivie(unit)
    local type_data = self[unit:get_id()]

    if type(type_data) == 'function' then
        Log.error(('对一个没有注册过的野怪类型[%s]，进行复活监听操作'):format(name) )
        return
    end

    local point = unit:get_point()
    local angle = unit:get_facing()
    local player = unit:get_player()
    local data = {birth_point = point,
        birth_angle = angle,
        birth_player = player}


    setmetatable(data, data)
    data.__index = type_data

    data:register_creep_revive_trg(unit)
end

function Creep_revive:save_default_creeps()

    for _, u in ac.selector()
        :add_filter(function(u)
            print('filter:', u:get_name())
            if all_revive_creeps[u:get_id()] then
                return true
            end
        end)
        :ipairs()
    do
        
        self:init_creep_revivie(u)
    end

end



return Creep_revive