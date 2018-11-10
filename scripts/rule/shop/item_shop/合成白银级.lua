local Unit = Router.unit

local mt = ac.unit_button['合成白银级']{
    war3_id = 'h502',
    effect_model = [[Abilities\Spells\Items\AIsm\AIsmTarget.mdl]],
}

function mt:on_click()
    local unit = self.clicker
    if not unit:has_item('纯银') then
        self:failed('你没有纯银！')
        return
    end

    if unit:has_item('黄铜魂珠') then
        unit:remove_item('黄铜魂珠')
        unit:add_item('纯银魂珠')
        self:succeed()
        return
    end

    if unit:has_item('黄铜项链') then
        unit:remove_item('黄铜项链')
        unit:add_item('纯银项链')
        self:succeed()
        return
    end

    if unit:has_item('黄铜套装') then
        unit:remove_item('黄铜套装')
        unit:add_item('纯银套装')
        self:succeed()
        return
    end

    if unit:has_item('黄铜剑') then
        unit:remove_item('黄铜剑')
        unit:add_item('纯银剑')
        self:succeed()
        return
    end

    if unit:has_item('黄铜弓') then
        unit:remove_item('黄铜弓')
        unit:add_item('纯银弓')
        self:succeed()
        return
    end

    if unit:has_item('黄铜杖') then
        unit:remove_item('黄铜杖')
        unit:add_item('纯银杖')
        self:succeed()
        return
    end

    if unit:has_item('黄铜铃') then
        unit:remove_item('黄铜铃')
        unit:add_item('纯银铃')
        self:succeed()
        return
    end

    if unit:has_item('黄铜镰') then
        unit:remove_item('黄铜镰')
        unit:add_item('纯银镰')
        self:succeed()
        return
    end
    self:failed('[合成失败]:你没有青铜级别的装备！')
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
    unit:remove_item('纯银')
end