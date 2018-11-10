local Unit = Router.unit

local mt = ac.unit_button['合成钻石级']{
    war3_id = 'h505',
    --合成失败的概率
    failed_rate = 30,
    effect_model = [[Abilities\Spells\Items\AIsm\AIsmTarget.mdl]],
}

function mt:on_click()
    local unit = self.clicker
    if not unit:has_item('钻石') then
        self:failed('你没有钻石！')
        return
    end
    local i = math.random( 1, 100 )
    if unit:has_item('铂金魂珠') then
        if i <= self.failed_rate then
            self:failed('合成失败！钻石被融化了！', false)
            return
        end
        unit:remove_item('铂金魂珠')
        unit:add_item('钻石魂珠')
        self:succeed()
        return
    end

    if unit:has_item('铂金项链') then
        if i <= self.failed_rate then
            self:failed('合成失败！钻石被融化了！', false)
            return
        end
        unit:remove_item('铂金项链')
        unit:add_item('钻石项链')
        self:succeed()
        return
    end

    if unit:has_item('铂金套装') then
        if i <= self.failed_rate then
            self:failed('合成失败！钻石被融化了！', false)
            return
        end
        unit:remove_item('铂金套装')
        unit:add_item('钻石套装')
        self:succeed()
        return
    end

    if unit:has_item('铂金剑') then
        if i <= self.failed_rate then
            self:failed('合成失败！钻石被融化了！', false)
            return
        end
        unit:remove_item('铂金剑')
        unit:add_item('钻石剑')
        self:succeed()
        return
    end

    if unit:has_item('铂金弓') then
        if i <= self.failed_rate then
            self:failed('合成失败！钻石被融化了！', false)
            return
        end
        unit:remove_item('铂金弓')
        unit:add_item('钻石弓')
        self:succeed()
        return
    end

    if unit:has_item('铂金杖') then
        if i <= self.failed_rate then
            self:failed('合成失败！钻石被融化了！', false)
            return
        end
        unit:remove_item('铂金杖')
        unit:add_item('钻石杖')
        self:succeed()
        return
    end

    if unit:has_item('铂金铃') then
        if i <= self.failed_rate then
            self:failed('合成失败！钻石被融化了！', false)
            return
        end
        unit:remove_item('铂金铃')
        unit:add_item('钻石铃')
        self:succeed()
        return
    end

    if unit:has_item('铂金镰') then
        if i <= self.failed_rate then
            self:failed('合成失败！钻石被融化了！', false)
            return
        end
        unit:remove_item('铂金镰')
        unit:add_item('钻石镰')
        self:succeed()
        return
    end

end

--  提示信息
--  是否返利
function mt:failed( msg , rebate)
    local unit = self.clicker
    local p = unit:get_owner()
    p:send_msg(msg, 3)
    if rebate == nil or rebate then
        local gold = Unit.get_slk_by_id(self.war3_id, 'goldcost', 0)
        local lumber = Unit.get_slk_by_id(self.war3_id, 'lumbercost', 0)
        p:add_gold(gold)
        p:add_lumber(lumber)
    else
        unit:remove_item('钻石')
    end
end

function mt:succeed()
    local unit = self.clicker
    unit:add_effect(self.effect_model):remove()
    unit:remove_item('钻石')
end