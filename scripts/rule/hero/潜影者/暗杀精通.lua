local mt = ac.skill['暗杀精通']{
    war3_id = 'A30D',
    rate = {20, 8, 11, 14, 17},
    minion_damage_rate = {100},
    boss_damage_rate = {10, 15, 20, 25, 30},
    time = {10, 12, 14, 16, 18},
    effect_model = [[Abilities\Weapons\AvengerMissile\AvengerMissile.mdl]],
}

function mt:on_add()
    local unit = self.owner
    self.ef = unit:add_effect(self.effect_model, 'weapon')
    self.trg = unit:event '单位-即将造成伤害'(function(trg, damage)
        if damage:is_attack() then
            if self.rate >= math.random(0, 100) then
                local target = damage.target
                local val
                if target:is_type_hero() then
                    val = target:get_max_life() * self.boss_damage_rate / 100
                else
                    val = target:get_max_life() * self.minion_damage_rate / 100
                end
                damage.damage = damage.damage + val
                ac.texttag:new{
                    text = '暗杀！',
                    point = damage.source:get_point() - {135, 120},
                    angle = 90,
                    speed = 30,
                    size = 18,
                    red = 255,
                    blue = 0,
                    green = 0,
                    life = 1,
                    show = ac.texttag.SHOW_ALL,
                }
            end
        end
    end)
end

function mt:on_effect()
    local lv = self:get_level()
    local rate = self.rate * 2
    self:set('rate', rate)
    ac.wait(self.time * 1000, function()
        if lv == self:get_level() then
            self:set('rate', rate/2)
        end
    end)
end

function mt:remove()
    if self.trg then
        self.trg:remove()
    end
    if self.ef then
        self.ef:remove()
    end
end