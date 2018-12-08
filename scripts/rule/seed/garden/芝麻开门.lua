local mt = ac.skill['芝麻开门']{
    war3_id = 'A408',
    duration = 5,
}

function mt:on_effect( )
    local unit = self.owner
    local target = self.target
    target:open()
    ac.wait(self.duration*1000, function(  )
        target:close()
    end)
end