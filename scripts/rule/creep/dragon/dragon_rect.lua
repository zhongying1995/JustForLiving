local Region = Router.region
local Texttag = Router.texttag

local Rects = require 'base.rects'

local Dragon_rect = {}
setmetatable(Dragon_rect, Dragon_rect)

local mt = {}
Dragon_rect.__index = mt

--单位没有通行证进入时,阻隔特效
mt.reject_model = [[Abilities\Spells\Orc\LightningBolt\LightningBoltMissile.mdl]]

--单位没有通行证进入时,生命保留比例
mt.life_retain = 0.9

--龙王数据表
mt.dragon_datas = {
    ['black'] = {
        ['birth'] = Rects['龙复活区域'][1]:get_point(),
        ['name'] = '黑龙王',
        ['face'] = 60,
        ['item'] = '智慧',
    },
    ['greed'] = {
        ['birth'] = Rects['龙复活区域'][3]:get_point(),
        ['name'] = '绿龙王',
        ['face'] = 120,
        ['item'] = '狂暴',
    },
    ['red'] = {
        ['birth'] = Rects['龙复活区域'][2]:get_point(),
        ['name'] = '红龙王',
        ['face'] = 90,
        ['item'] = '神灵',
    },
    ['king'] = {
        ['birth'] = Rects['龙复活区域'][2]:get_point(),
        ['name'] = '龙皇',
        ['face'] = 90,
        ['item'] = '龙皇之力',
    },
}

--英雄进入龙王区域
--注：英雄进来后，筛选出来的龙可能已经处于战斗状态
function mt:hero_enter(  )
    local dragon = self:get_candidate_dragon()
    if not dragon or not dragon:is_alive() then
        dragon = self:create_king_dragon()
    end

    if self:is_lock(dragon) then
        self:unlock_dragon(dragon)
    end

end

--增加候选龙王
function mt:add_candidate_dragon( type, u )
    if not self.candidates then
        self.candidates = {}
    end
    self.candidates[type] = {
        ['unit'] = u,
        ['stand_by'] = true,
    }
end

--删除候选龙王
function mt:remove_candidate_dragon( unit )
    local type = unit.dragon_type
    self.candidates[type]['stand_by'] = false
end

--获取候选龙王
--  [指定的类型]
function mt:get_candidate_dragon(type)
    local u
    if type then
        if self.candidates[type] then
            u = self.candidates[type]['unit']
        end
    else
        for type, v in pairs(self.candidates) do
            if v['stand_by'] then
                u = v['unit']
                break
            end
        end
    end

    return u
end


--锁定龙王
function mt:lock_dragon( u )
    u:add_restriction('无敌')
    u:pause()
    u._is_locking_dragon = true
end

--解锁龙王
function mt:unlock_dragon( u )
    u:remove_restriction('无敌')
    u:pause(false)
    u._is_locking_dragon = false
end

--是否被锁定
function mt:is_lock( u )
    return u._is_locking_dragon
end

--创建龙
function mt:create_type_dragon( type )
    local data = self.dragon_datas[type]
    local player = Map_game:get_wild_creep_player()
    local u = player:create_unit(data['name'], data['birth'], data['face'])
    u.is_dragon_creep = true
    u.dragon_type = type
    self:add_candidate_dragon(type, u)
    self:lock_dragon(u)
    return u
end

--创建红龙
function mt:create_red_dragon()
    local u = self:create_type_dragon('red')

    return u
end

--创建黑龙
function mt:create_black_dragon()
    local u = self:create_type_dragon('black')

    return u
end

--创建绿龙
function mt:create_greed_dragon()
    local u = self:create_type_dragon('greed')

    return u
end

--创建龙皇
function mt:create_king_dragon()
    local u = self:create_type_dragon('king')
    u.is_king_dragon = true
    self.is_king_dragon_show = true
    return u
end

--创建默认的龙王单位
function mt:create_default_dragon()
    self:create_black_dragon()
    self:create_greed_dragon()
    self:create_red_dragon()
end


function mt:init(  )
    self.region = Region:new(Rects['龙王区域'][1], Rects['龙王区域'][2])
    self.region_enter_trg = self.region:event '区域-进入'(function(trg, unit)
        if unit:get_team() == 1 then
            local text
            if unit:has_item('通行证') then
                text = ac.get_color_string('通行证没收了！', 'reward')
                self:hero_enter()
                unit:remove_item('通行证')
            else
                text = ac.get_color_string('无通行证，乱闯者死！', 'warn')
                local face = unit:get_facing()
                local point = unit:get_point()
                while(self.region<point)
                do
                    point = point - {-face, 128}
                    point:add_effect(self.reject_model):remove()
                    unit:set_life(unit:get_life()*self.life_retain)
                end
                unit:set_point(point)
                unit:issue_order('stop')
            end
            local tt = Texttag:new{
                text = text,
                player = unit:get_owner(),
                angle = math.random(45, 135),
                speed = 20,
                size = 14,
                show = Texttag.SHOW_SELF,
                point = unit:get_point(),
            }
        end
    end)
    self.unit_dead_trg = ac.game:event '单位-死亡'(function ( trg, unit, killer )
        if unit.is_dragon_creep then
            self:remove_candidate_dragon(unit)
            local item_name = self.dragon_datas[unit.dragon_type]['item']
            local it = unit:get_point():add_item(item_name)
            it:set_player(killer:get_owner())
            if self.is_king_dragon_show then
                self.is_king_dragon_show = false
                ac.wait(30*1000, function (  )
                    local u = self:get_candidate_dragon()
                    --没有候选的战斗龙王，创建新的候选龙王
                    if not u then
                        self:create_default_dragon()
                    end
                end)
            end
        end
    end)

    self:create_default_dragon()
    
end


return Dragon_rect