local mt = ac.unit_button['普通入侵怪任务']{
    war3_id = 'h50C',
}

function mt:on_click()
    local unit = self.clicker
    local player = unit:get_owner()
    player:add_mission('普通入侵怪任务')

end