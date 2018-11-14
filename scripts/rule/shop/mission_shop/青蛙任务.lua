local mt = ac.unit_button['青蛙任务']{
    war3_id = 'h507',
}

function mt:on_click()
    local unit = self.clicker
    local player = unit:get_owner()
    player:add_mission('青蛙任务')

end