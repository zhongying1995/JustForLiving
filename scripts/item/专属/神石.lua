local mt = ac.item['神石']{
    war3_id = 'I100'
}

function mt:on_add()
    local unit = self.owner
    print(unit:get_name(), self.name)
end