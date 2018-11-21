local table_insert = table.insert

local mt = ac.unit_button['专属合成']{
    war3_id = 'h509',
    
    --合成所需要的层数
    fuse_stack = 100,
}

function mt:on_click(  )
    local unit = self.clicker
    local it = unit:has_item('神石')
    if it then
        local stack = it:get_stack()
        if stack < self.fuse_stack then
            local msg = ('合成专属需要神之石%.f层！'):format(stack)
            self:fail(msg)
        else
            local data = it.synthetic_list[unit:get_name()]
            if data then
                local mix_items = data.mixture
                local refiner = data.refiner
                local its = {}
                local is_fuse = true
                for name in mix_items:gmatch('%S+') do
                    local it = unit:has_item(name)
                    if it then
                        table_insert(its, it)
                    else
                        is_fuse = false
                    end
                end
                if is_fuse then
                    unit:remove_item(it)
                    for _, it in ipairs(its) do
                        unit:remove_item(it)
                    end
                    unit:add_item(refiner)
                else
                    local msg = '你没有足够的合成配件！'
                    self:fail(msg)
                end
            end
        end
    else
        local msg = '没有携带神石，无法合成!'
        self:fail(msg)
    end
end

function mt:fail(msg)
    local unit = self.clicker
    unit:get_owner():send_msg(msg, 3)
end