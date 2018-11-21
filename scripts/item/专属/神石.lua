local mt = ac.item['神石']{
    war3_id = 'I100',
    --最大的可用次数
    max_stack = 100,

    --合成列表
    synthetic_list = {
        ['龙骑士'] = {
            mixture = '龙之盾锻造书',
            refiner = '龙之盾',
        },
        ['黑暗游侠'] = {
            mixture = '漆黑之弓锻造书',
            refiner = '漆黑之弓',
        },
        ['潜影者'] = {
            mixture = '割魂之刃锻造书',
            refiner = '割魂之刃',
        },
        ['元素法师'] = {
            mixture = '元素法杖锻造书',
            refiner = '元素法杖',
        },
        ['神圣牧师'] = {
            mixture = '拯救之书锻造书',
            refiner = '拯救之书',
        },
    }
}

function mt:on_add()
    local unit = self.owner
    self.kill_unit_trg = unit:event '单位-杀死单位'(function(trg, killer, killed)
        if self:get_stack() < self.max_stack then
            self:add_stack()
        end
    end)
end

function mt:on_drop()
    if self.kill_unit_trg then
        self.kill_unit_trg:remove()
    end
end