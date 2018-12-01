local mt = ac.unit_button['山神任务']{
    war3_id = 'h50A',
    duration = 30,
    skill_name = '弑神之力',
}

function mt:on_click()
    local unit = self.clicker
    unit:add_buff('弑神之力'){
        time = self.duration
    }
end