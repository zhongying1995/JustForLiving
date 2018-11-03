local mt = ac.unit_button['山神任务']{
    war3_id = 'h25B',
}

function mt:on_click()
    local unit = self.clicker
    
    local trg = unit:event '单位-杀死单位'(function(trg, killer, killed)
        if killed:get_id() == 'h400' then
            trg:remove()
            unit:add_item('神石')
        end
    end)

end
