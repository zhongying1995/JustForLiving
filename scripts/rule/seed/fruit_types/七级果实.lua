local mt = ac.item['七级果实']{
    war3_id = 'I132',
    all_attr = 200,
}

function mt:on_use(  )
    local unit = self.owner
    local hero = unit:get_owner().hero
    hero:add_str(self.all_attr)
    hero:add_agi(self.all_attr)
    hero:add_int(self.all_attr)
end