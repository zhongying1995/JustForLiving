local Unit = Router.unit

local mt = ac.unit_button['合成星耀级']{
    war3_id = 'h506',
    --合成失败的概率
    failed_rate = 50,
    effect_model = [[Abilities\Spells\Items\AIsm\AIsmTarget.mdl]],
}

function mt:on_click()
    local unit = self.clicker
    if not unit:has_item('黑耀') then
        self:failed('你没有黑耀！')
        return
    end
    local i = math.random( 1, 100 )
    if unit:has_item('钻石魂珠') then
        if i <= self.failed_rate then
            self:failed('[合成失败]:黑耀被融化了！', false)
            return
        end
        unit:remove_item('钻石魂珠')
        unit:add_item('黑耀魂珠')
        self:succeed()
        return
    end

    if unit:has_item('钻石项链') then
        if i <= self.failed_rate then
            self:failed('[合成失败]:黑耀被融化了！', false)
            return
        end
        unit:remove_item('钻石项链')
        unit:add_item('黑耀项链')
        self:succeed()
        return
    end

    if unit:has_item('钻石套装') then
        if i <= self.failed_rate then
            self:failed('[合成失败]:黑耀被融化了！', false)
            return
        end
        unit:remove_item('钻石套装')
        unit:add_item('黑耀套装')
        self:succeed()
        return
    end

    if unit:has_item('钻石剑') then
        if i <= self.failed_rate then
            self:failed('[合成失败]:黑耀被融化了！', false)
            return
        end
        unit:remove_item('钻石剑')
        unit:add_item('黑耀剑')
        self:succeed()
        return
    end

    if unit:has_item('钻石弓') then
        if i <= self.failed_rate then
            self:failed('[合成失败]:黑耀被融化了！', false)
            return
        end
        unit:remove_item('钻石弓')
        unit:add_item('黑耀弓')
        self:succeed()
        return
    end

    if unit:has_item('钻石杖') then
        if i <= self.failed_rate then
            self:failed('[合成失败]:黑耀被融化了！', false)
            return
        end
        unit:remove_item('钻石杖')
        unit:add_item('黑耀杖')
        self:succeed()
        return
    end

    if unit:has_item('钻石铃') then
        if i <= self.failed_rate then
            self:failed('[合成失败]:黑耀被融化了！', false)
            return
        end
        unit:remove_item('钻石铃')
        unit:add_item('黑耀铃')
        self:succeed()
        return
    end

    if unit:has_item('钻石镰') then
        if i <= self.failed_rate then
            self:failed('[合成失败]:黑耀被融化了！', false)
            return
        end
        unit:remove_item('钻石镰')
        unit:add_item('黑耀镰')
        self:succeed()
        return
    end
    self:failed('[合成失败]:你没有钻石级别的装备！')
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
        unit:remove_item('黑耀')
    end
end

function mt:succeed()
    local unit = self.clicker
    unit:add_effect(self.effect_model):remove()
    unit:remove_item('黑耀')
end