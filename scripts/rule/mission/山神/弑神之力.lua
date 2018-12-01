
local mt = ac.buff['弑神之力']{
    model = [[Abilities\Spells\Human\ManaFlare\ManaFlareMissile.mdl]],
}

function mt:on_add(  )
    local unit = self.target
    self.effect = unit:add_effect(self.effect_model, 'right hand')
end

function mt:on_remove(  )
    if self.effect then
        self.effect:remove()
    end
end