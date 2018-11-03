local mt = ac.item['神石']{
    war3_id = 'I100',
    --最大的可用次数
    max_stack = 100,
}

function mt:on_add()
    local unit = self.owner
    self.kill_unit_trg = unit:event '单位-杀死单位'(function(trg, killer, killed)
        if self:get_stack() < self.max_stack then
            self:add_stack()
        end
    end)
end

function mt:on_drop()
    if self.kill_unit_trg then
        self.kill_unit_trg:remove()
    end
end