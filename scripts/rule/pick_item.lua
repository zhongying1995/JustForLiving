
ac.game:event '单位-获得物品'(function (trg, unit, it)
    local is_drop
    local fail_msg
    if it:is_weapon() then
        if not unit:is_enable_hold_weapon(it) then
            is_drop = true
            fail_msg = ('你不能捡起非|cffff0000%s|r类型的武器!'):format(unit:get_weapon_type())
        elseif unit:is_has_weapon(it) then
            is_drop = true
            fail_msg = ('你只能拥有一件|cffff0000%s|r类型的武器!'):format(unit:get_weapon_type())
        end
        
    elseif it:is_necklace() then
        if unit:is_has_necklace(it) then
            fail_msg = ('你只能拥有一件|cffff0000%s|r!'):format('项链')
            is_drop = true
        end
        
    elseif it:is_soul_bead() then
        if unit:is_has_soul_bead(it) then
            fail_msg = ('你只能拥有一件|cffff0000%s|r!'):format('魂珠')
            is_drop = true
        end
        
    elseif it:is_corselet() then
        if unit:is_has_corselet(it) then
            fail_msg = ('你只能拥有一件|cffff0000%s|r!'):format('套装')
            is_drop = true
        end
        
    end
    
    if is_drop then
        unit:drop_item_down(it)
        unit:get_owner():send_msg(fail_msg, 2)
    end
    
end)