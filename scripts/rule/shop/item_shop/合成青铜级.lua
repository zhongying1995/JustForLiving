local Unit = Router.unit

local mt = ac.unit_button['合成青铜级']{
    war3_id = 'h501',
    effect_model = [[Abilities\Spells\Items\AIsm\AIsmTarget.mdl]],
}

function mt:on_click()
    local unit = self.clicker
    if not unit:has_item('黄铜') then
        self:failed('你没有黄铜！')
        return
    end

    if unit:has_item('精铁魂珠') then
        unit:remove_item('精铁魂珠')
        unit:add_item('黄铜魂珠')
        self:succeed()
        return
    end

    if unit:has_item('精铁项链') then
        unit:remove_item('精铁项链')
        unit:add_item('黄铜项链')
        self:succeed()
        return
    end

    if unit:has_item('废铁套装') then
        unit:remove_item('废铁套装')
        unit:add_item('黄铜套装')
        self:succeed()
        return
    end

    if unit:has_item('精铁剑') then
        unit:remove_item('精铁剑')
        unit:add_item('黄铜剑')
        self:succeed()
        return
    end

    if unit:has_item('精铁弓') then
        unit:remove_item('精铁弓')
        unit:add_item('黄铜弓')
        self:succeed()
        return
    end

    if unit:has_item('精铁杖') then
        unit:remove_item('精铁杖')
        unit:add_item('黄铜杖')
        self:succeed()
        return
    end

    if unit:has_item('精铁铃') then
        unit:remove_item('精铁铃')
        unit:add_item('黄铜铃')
        self:succeed()
        return
    end

    if unit:has_item('精铁镰') then
        unit:remove_item('精铁镰')
        unit:add_item('黄铜镰')
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
    unit:remove_item('黄铜')
end