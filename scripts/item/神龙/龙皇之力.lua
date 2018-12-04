local mt = ac.item['龙皇之力']{
    war3_id = 'I12P',
    need_item_list = {
        '智慧',
        '狂暴',
        '神灵',
    },
    item = '真龙皇之翼',
}

function mt:on_add(  )
    local unit = self.owner
    if self:check_synthesize() then
        self:synthesize()
        unit:remove_item(self)
    else
        self.check_trg = unit:event '单位-获得物品'(function ( trg, unit, it )
            if self:check_synthesize() then
                self:synthesize()
                unit:remove_item(self)
            end
        end)
    end
    
end

function mt:on_drop(  )
    if self.check_trg then
        self.check_trg:remove()
    end
end

function mt:check_synthesize(  )
    local unit = self.owner
    local is_all = true
    for _, name in pairs(self.need_item_list) do
        if not unit:has_item(name) then
            is_all = false
            break
        end
    end
    return is_all
end

function mt:synthesize()
    local unit = self.owner
    for _, name in pairs(self.need_item_list) do
        unit:remove_item(name)
    end
    unit:add_item(self.item)
end