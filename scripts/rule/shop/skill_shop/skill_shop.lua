local Unit_button = Router.unit_button

local Skill_shop = {}
setmetatable(Skill_shop, Skill_shop)

local mt = Unit_button
Skill_shop.__index = mt

local function default_on_click(self, hero)
    local player = hero:get_owner()
    local msg
    local skill_name = self.skill_name
    local skl = hero:find_skill(skill_name)
    if not skl then
        -- print('增加技能')
        if hero:is_enable_add_bought_skill() then
            hero:add_bought_skill(skill_name)
            msg = ('|cffff0000英雄[%s]成功学习了[%s]技能|r'):format(hero:get_name(), skill_name)
        else
            msg = ('|cffff0000英雄[%s]购买技能已满，无法再次学习|r'):format(hero:get_name(), skill_name)
        end
    else
        -- print('技能升级')
        local lv = skl:get_level()
        local max_level = self.max_level
        if lv < max_level and hero:get_level() > lv * 2 then
            skl:add_level()
            msg = ('|cffff9900[%s]把[%s]技能升级到%d|r'):format(hero:get_name(), skill_name, lv+1)
        else
            if lv == max_level then
                msg = ('|cffee0000[%s]无法升级[%s]技能，该等级已达升级上限|r'):format(hero:get_name(), skill_name)
            else
                msg = ('|cffee0000[%s]无法升级[%s]技能，需要升级英雄等级|r'):format(hero:get_name(), skill_name)
            end
        end
    end
    player:send_msg(msg)
end

function mt:register(data)
    local name = data.name
    self[name] = data
    if not data.on_click then
        data.on_click = default_on_click
    end
    data.old_on_click = data.on_click

    data.on_click = function(self)
        local hero
        local unit = self.clicker
        if unit:is_hero() then
            hero = unit
        else
            local player = unit:get_owner()
            hero = player.hero
            if not hero then
                hero = unit
            end
        end
        self:old_on_click(hero)
    end

    ac.unit_button[name](data)
end


return Skill_shop