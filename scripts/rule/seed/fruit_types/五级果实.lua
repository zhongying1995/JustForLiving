local mt = ac.item['五级果实']{
    war3_id = 'I131',
    all_attr = 50,
    is_fruit = true,
}

function mt:on_use(  )
    local unit = self.owner
    local hero = unit:get_owner().hero
    hero:add_str(self.all_attr)
    hero:add_agi(self.all_attr)
    hero:add_int(self.all_attr)
end