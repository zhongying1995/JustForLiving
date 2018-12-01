local mt = ac.unit_button['螃蟹任务']{
    war3_id = 'h508',
}

function mt:on_click()
    local unit = self.clicker
    local player = unit:get_owner()
    player:add_mission('螃蟹任务')

end