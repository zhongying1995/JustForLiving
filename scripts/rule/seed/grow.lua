local mt = ac.skill['生长']{
    grow_size = 1,
    grow_duration = 30,
    --一级种子
    fruit = 'I12X',
}

function mt:on_add(  )
    local unit = self.owner
    local duration = unit.grow_duration or self.grow_duration
    local size = unit:get_size()
    local max_size = unit.grow_size or self.grow_size
    local fruit = unit.fruit or self.fruit

    unit:add_buff('生长'){
        skill = self,
        duration = math.floor(duration),
        size = size,
        grow_size = max_size,
    }
end

function mt:on_remove(  )
    local unit = self.owner
    if unit:find_buff('生长') then
        unit:remove_buff('生长')
    end
end



local buff_mt = ac.buff['生长']{
    model = [[Abilities\Spells\Other\StrongDrink\BrewmasterTarget.mdl]],
    finish_model = [[Abilities\Spells\NightElf\FaerieFire\FaerieFireTarget.mdl]],
}

function buff_mt:on_add(  )
    local unit = self.target
    unit:add_effect(self.model):remove()
    local size = self.size / 2
    unit:set_size(size)
    local interval_size = (self.grow_size - size) / self.duration
    self.grow_timer = ac.timer(1000, self.duration, function (  )
        unit:add_size(interval_size)
    end)
    function self.grow_timer.on_remove(  )
        unit:add_effect(self.finish_model):remove()
        unit:add_buff('果实'){
            duration = self.duration,
            skill = self.skill,
        }
        self:remove()
    end
end

function buff_mt:on_remove(  )
    if self.grow_timer then
        self.grow_timer:remove()
    end
end


local buff_mt_1 = ac.buff['果实']{
    radius = 256,
}

function buff_mt_1:on_add(  )
    local unit = self.target
    self.trg = unit:event '单位-被指向'(function ( trg, u, order, who, order_id )
        if order == 'smart' and (who:get_point() * u:get_point()) < self.radius then
            local item = unit:get_point():add_item(unit.fruit)
            item:set_player(unit:get_owner())
            unit:killed()
            self:remove()
        end
    end)
end

function buff_mt_1:on_remove( )
    if self.trg then
        self.trg:remove()
    end
end
