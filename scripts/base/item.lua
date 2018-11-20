local Item = Router.item
local mt = Item.__index

--物品是否是武器
function mt:is_weapon(  )
    return self:get_item_type() == '武器'
end

--物品是否是项链
function mt:is_Necklace(  )
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