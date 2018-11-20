local Item = Router.item
local mt = Item.__index
local Unit = Router.unit

--物品是否是武器
function mt:is_weapon(  )
    return self:get_item_type() == '武器'
end

--物品是否是项链
function mt:is_necklace(  )
    return self:get_item_type() == '项链'
end

--物品是否是魂珠
function mt:is_soul_bead(  )
    return self:get_item_type() == '魂珠'
end

--物品是否是套装
function mt:is_corselet(  )
    return self:get_item_type() == '套装'
end

--单位是否拥有武器
--  [应该被忽略的物品表]
function Unit.__index:is_has_weapon( igorn_items )
    local igorn_items = igorn_items or {}
    for it in self:each_item() do
        if it:is_weapon() then
            local result = true
            for _, igorn_item in pairs(igorn_items) do
                if it == igorn_item then
                    result = false
                end
            end

            if result then
                return it
            end
        end
    end
end

--单位是否拥有项链
--  [应该被忽略的物品表]
function Unit.__index:is_has_necklace( igorn_items )
    local igorn_items = igorn_items or {}
    for it in self:each_item() do
        if it:is_necklace() then
            local result = true
            for _, igorn_item in pairs(igorn_items) do
                if it == igorn_item then
                    result = false
                end
            end

            if result then
                return it
            end
        end
    end
end

--单位是否拥有魂珠
--  [应该被忽略的物品表]
function Unit.__index:is_has_soul_bead( igorn_items )
    local igorn_items = igorn_items or {}
    for it in self:each_item() do
        if it:is_soul_bead() then
            local result = true
            for _, igorn_item in pairs(igorn_items) do
                if it == igorn_item then
                    result = false
                end
            end

            if result then
                return it
            end
        end
    end
end

--单位是否拥有套装
--  [应该被忽略的物品表]
function Unit.__index:is_has_corselet( igorn_items )
    local igorn_items = igorn_items or {}
    for it in self:each_item() do
        if it:is_corselet() then
            local result = true
            for _, igorn_item in pairs(igorn_items) do
                if it == igorn_item then
                    result = false
                end
            end

            if result then
                return it
            end
        end
    end
end