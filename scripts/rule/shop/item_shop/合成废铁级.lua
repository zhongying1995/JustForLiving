local Unit = Router.unit

local mt = ac.unit_button['合成废铁级']{
    war3_id = 'h500',
    effect_model = [[Abilities\Spells\Items\AIsm\AIsmTarget.mdl]],
}

function mt:on_click()
    local unit = self.clicker
    if not unit:has_item('精铁') then
        self:failed('[合成失败]:你没有精铁！')
        return
    end

    if unit:has_item('桃木魂珠') then
        unit:remove_item('桃木魂珠')
        unit:add_item('精铁魂珠')
        self:succeed()
        return
    end

    if unit:has_item('桃木项链') then
        unit:remove_item('桃木项链')
        unit:add_item('精铁项链')
        self:succeed()
        return
    end

    if unit:has_item('桃木剑') then
        unit:remove_item('桃木剑')
        unit:add_item('精铁剑')
        self:succeed()
        return
    end

    if unit:has_item('桃木弓') then
        unit:remove_item('桃木弓')
        unit:add_item('精铁弓')
        self:succeed()
        return
    end

    if unit:has_item('桃木杖') then
        unit:remove_item('桃木杖')
        unit:add_item('精铁杖')
        self:succeed()
        return
    end

    if unit:has_item('桃木铃') then
        unit:remove_item('桃木铃')
        unit:add_item('精铁铃')
        self:succeed()
        return
    end

    if unit:has_item('桃木镰') then
        unit:remove_item('桃木镰')
        unit:add_item('精铁镰')
        self:succeed()
        return
    end
    self:failed('[合成失败]:你没有桃木级别的装备！')
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
    unit:remove_item('精铁')
end