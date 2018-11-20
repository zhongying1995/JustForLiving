
ac.game:event '单位-获得物品'(function (trg, unit, it)
    local is_drop
    if it:is_weapon() then
        if not unit:is_enable_hold_weapon(it) then
            is_drop = true
            local msg = ('你不能捡起非|cffff0000%s|r类型的武器!'):format(unit:get_weapon_type())
            unit:get_owner():send_msg(msg, 2)
        elseif unit:is_has_weapon(it) then
            is_drop = true
            local msg = ('你只能拥有一件|cffff0000%s|r类型的武器!'):format(unit:get_weapon_type())
            unit:get_owner():send_msg(msg, 2)
        end
        
    elseif it:is_necklace() then
        if unit:is_has_necklace() then
            is_drop = true
        end
        
    elseif it:is_soul_bead() then
        if unit:is_has_soul_bead() then
            is_drop = true
        end
        
    elseif it:is_corselet() then
        if unit:is_has_corselet() then
            is_drop = true
        end
        
    end
    
    if is_drop then
        unit:drop_item_down(it)
    end
    
end)