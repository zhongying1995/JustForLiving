local table_insert = table.insert
local table_getn = table.getn

local Hero = Router.hero

local mt = Hero.__index


function mt:get_bought_skill_count()
    if not self._bought_skills then
        self._bought_skills = {}
    end
    for k, v in pairs(self._bought_skills) do
        print('bought_skill:', k, v)
    end
    return table_getn(self._bought_skills)
end

function mt:each_bought_skill()
    if not self._bought_skills then
		return function () end
	end
	local result = {}
	
	for _, v in pairs(self._bought_skills) do
		table_insert(result, v)
	end
	 
	local n = 0
	return function (t, v)
		n = n + 1
		return t[n]
	end, result
end

function mt:get_bought_skill(name)
    return self._bought_skills[name]
end

function mt:add_bought_skill(name, data)
    if not self._bought_skills then
        self._bought_skills = {}
    end
    local data = data or {}
    local skill = self:add_skill(name)(data)
    self._bought_skills[skill:get_name()] = skill
    return skill
end

function mt:remove_bought_skill(name)
    self._bought_skills[name] = nil
    self:remove_skill(name)
end

mt.max_enable_bought_skill = 2
function mt:is_enable_add_bought_skill()
    print('get_bought_skill_count:', self:get_bought_skill_count())
    return self:get_bought_skill_count() < self.max_enable_bought_skill
end


--获取英雄的武器类型
--  @英雄的武器，如果没有，则默认返回剑类型
function mt:get_weapon_type()
    return self.weapon_type or '剑'
end