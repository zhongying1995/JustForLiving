local Texttag = Router.texttag

local mt = ac.skill['山神之力']{
    buff_name = '山神之力',
}

function mt:on_add(  )
    local unit = self.owner
    self.buff = unit:add_buff(self.buff_name){}
end

function mt:on_remove()
    local unit = self.owner
    unit:remove_buff(self.buff_name)
end


local buff = ac.buff['山神之力']{
    model = [[Abilities\Spells\Items\StaffOfSanctuary\Staff_Sanctuary_Target.mdl]],
    debuff_name = '弑神之力',
    debuff_time = 5,
    dmg_model = [[Abilities\Spells\Items\SpellShieldAmulet\SpellShieldCaster.mdl]],
}

function buff:on_add(  )
    local unit = self.target
    self.effect = unit:add_effect(self.model, 'chest')
    self.damage_trg = unit:event '单位-即将受到伤害-乘除'(function ( trg, damage )
        local source = damage.source
        if source:find_buff(self.debuff_name) then
            self:disable()
            ac.wait(self.debuff_time*1000, function ( trg )
                self:enable()
            end)
        else
            damage.damage = 0
            unit:add_effect(self.dmg_model):remove()
            Texttag:new{
                text = '格挡',
                player = unit:get_owner(),
                angle = 90,
                speed = 5,
                size = 12,
                show = Texttag.SHOW_ALL,
                point = unit:get_point()
            }
        end
    end)
end

function buff:on_remove(  )
    if self.effect then
        self.effect:remove()
    end
    if self.damage_trg then
        self.damage_trg:remove()
    end
end