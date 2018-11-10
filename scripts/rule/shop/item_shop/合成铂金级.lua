local Unit = Router.unit

local mt = ac.unit_button['合成铂金级']{
    war3_id = 'h504',
    effect_model = [[Abilities\Spells\Items\AIsm\AIsmTarget.mdl]],
}

function mt:on_click()
    local unit = self.clicker
    if not unit:has_item('铂金') then
        self:failed('你没有铂金！')
        return
    end

    if unit:has_item('真金魂珠') then
        unit:remove_item('真金魂珠')
        unit:add_item('铂金魂珠')
        self:succeed()
        return
    end

    if unit:has_item('真金项链') then
        unit:remove_item('真金项链')
        unit:add_item('铂金项链')
        self:succeed()
        return
    end

    if unit:has_item('真金套装') then
        unit:remove_item('真金套装')
        unit:add_item('铂金套装')
        self:succeed()
        return
    end

    if unit:has_item('真金剑') then
        unit:remove_item('真金剑')
        unit:add_item('铂金剑')
        self:succeed()
        return
    end

    if unit:has_item('真金弓') then
        unit:remove_item('真金弓')
        unit:add_item('铂金弓')
        self:succeed()
        return
    end

    if unit:has_item('真金杖') then
        unit:remove_item('真金杖')
        unit:add_item('铂金杖')
        self:succeed()
        return
    end

    if unit:has_item('真金铃') then
        unit:remove_item('真金铃')
        unit:add_item('铂金铃')
        self:succeed()
        return
    end

    if unit:has_item('真金镰') then
        unit:remove_item('真金镰')
        unit:add_item('铂金镰')
        self:succeed()
        return
    end

end

function mt:failed( msg )
    local unit = self.clicker
    local p = unit:get_owner()
    p:send_msg(msg, 3)
    local gold = Unit.get_slk_by_id(self.war3_id, 'goldcost', 0)
    local lumber = Unit.get_slk_by_id(self.war3_id, 'lumbercost', 0)
    p:add_gold(gold)
    p:add_lumber(lumber)
end

function mt:succeed()
    local unit = self.clicker
    unit:add_effect(self.effect_model):remove()
    unit:remove_item('铂金')
end