local jass = require 'jass.common'
local japi = require 'jass.japi'
local Dialog = Router.dialog
local Player = Router.player
local Game_degree = require 'rule.model.game_degree'
local Game_model = require 'rule.model.game_model'

local function check_multiboard(  )
    local Multiboard = Router.multiboard
    local mb = Multiboard:new(3,3)
        :set_title('活下去')
        :set_all_width(20)
        :set_all_style(true, false)
    mb:set_text(1, 1, '玩家')
    mb:set_text(1, 2, '一中')
    mb:set_style(1, 2, true, true)
    mb:set_icon(1, 2, [[ReplaceableTextures\CommandButtons\BTNRifleman.blp]])
end

local function check_point(  )
    local p = ac.point(0,0,0)
    local p2 = ac.point( 100, 100)
    local ang = p / p2
    local dis = p * p2
    print( 'ang:', ang, 'dis:', dis)
end

local function check_region(  )
    local Rect = Router.rect
    local Region = Router.region
    local rect = Rect:new( 0, 0, 1000, 1000)
    local region = Region:new(rect)
    region:event '区域-进入' (function ( trg, unit )
        print('区域进入：', unit:get_name())
    end)
    region:event '区域-离开' (function ( trg, unit )
        print('区域-离开：', unit:get_name())
    end)
end

local function check_fogmodifier(  )
    local Fogmodifier = Router.fogmodifier
    local Rect = Router.rect
    local rect = Rect:new(0,0,1000,1000)
    local fog = Fogmodifier:new(ac.player[2], rect)
end

local function check_lightning( u1, u2)
    local Lightning = Router.lightning
    local ln = Lightning:new('SPLK', u1, u2, 20, 80)
    ln:set_color(0, 0, 100)
    ln:fade(-1)
end

local function check_texttag(u)
    local Texttag = Router.texttag
    local tt = Texttag:new{
        text = '+666!',
        player = ac.player[1],
        angle = 45,
        speed = 20,
        size = 16,
        show = Texttag.SHOW_SELF,
        point = u:get_point(),
        -- target = u,
    }
    tt:jump(0.5, -0.1)
end

local function check_heal(u)
    ac.wait(2000, function()
        print('8秒到，开始治疗')
        u:heal({
            heal = 1000,
            skill = true,
        })
        ac.wait(500, function()
            u:heal({
                heal = 5000,
                skill = true,
            })
        end)
    end)
end

local function check_selector(u1)
    print('检查 selector模块')
    for _, u in ac.selector()
		: in_range(u1, 800)
		: ipairs()
    do
		print('单位：', u:tostring(), jass.IsUnitIllusion(u.handle))
	end
end

local function check_effect(u)
    local model = [[Abilities\Spells\Human\MagicSentry\MagicSentryCaster.mdl]]
    -- local ef1 = u:add_effect(model, 'overhead')
    local ef2 = u:get_point():add_effect(model)
    ac.wait(3000, function()
        -- ef1:kill()
        ef2:kill()
    end)
end

local function check_buff(u)
    local mt = ac.buff['超生命体']{
        on_add = function(self)
            local unit = self.target
            unit:add_max_life(1000)
            print('on_add()被调用啦')
        end,

        on_remove = function(self)
            local unit = self.target
            unit:add_max_life(-100)
            print('on_remove()被调用啦')
        end
    }

    local mt = ac.buff['超生命体']{
        on_add = function(self)
            local unit = self.target
            unit:add_max_life(1000)
            print('on_add()被调用啦')
        end,

        on_remove = function(self)
            local unit = self.target
            unit:add_max_life(-100)
            print('on_remove()被调用啦')
        end
    }

    -- u:add_buff('超生命体'){}

    -- ac.wait(10000, function()
    --     u:remove_buff('超生命体')
    -- end)
end

local function check_skill(u)
    local mt = ac.skill['牛逼的风暴锤']{
        war3_id = 'AHtc',
        damage = function(self)
            return 5
        end,
        life = function(self)
            print('life:', self.owner:tostring())
            return self.owner:get_life()
        end,
        attacks = {3, 5, 7, 9}
    }
    function mt:on_add()
        local unit = self.owner
        unit:add_buff('超生命体'){}
        print('on_add:', self, unit:get_name(), self.damage, self.life, self.attacks)
    end

    function mt:on_remove()
        local unit = self.owner
        print()
        unit:remove_buff('超生命体')
        print('on_remove:', self, unit:get_name(), self.damage, self.life)
    end

    function mt:on_effect()
        local unit = self.owner
        print('单位发动技能效果啦！', self, unit:tostring(), self.damage, self.life, self.attacks)
        ac.wait(3000, function()
            local skl = unit:find_skill('牛逼的风暴锤')
            skl:set_level(skl:get_level() + 1)
        end)
    end

    function mt:on_end()
        local unit = self.owner
        print('单位结束使用技能！', self, unit:tostring(), self.damage, self.life)
    end
    
    print('添加的技能：', u:add_skill('牛逼的风暴锤'){})
    -- ac.wait(10000, function()
    --     ac.player[1]:send_msg('10秒到啦')
    --     print('移除技能：', u:remove_skill('牛逼的风暴锤') )
    -- end)
end

local function check_item(u)
    local mt = ac.item['风暴之锤']{
        war3_id = 'bspd',
        life = 1000,
        mana = 500,
        attack = 200,
        str = 10,
    }

    function mt:on_add()
        local unit = self.owner
        print('on_add:', self, unit:get_name())
    end

    function mt:on_drop()
        local unit = self.owner
        print()
        -- unit:remove_buff('超生命体')
        print('on_drop:', self, unit:get_name() )
    end
    ac.wait(1500, function()
        ac.point(0, 0):add_item('风暴之锤')
    end)
end

local function check_attribute(u)
    local max_life = u:get_max_life()
    local max_mana = u:get_max_mana()
    print(('%s最大生命：%s，最大魔法:%s'):format(u:get_name(), max_life, max_mana))
    u:add_max_life( max_life)
    u:add_max_mana( max_mana)
    
    local atk = u:get_attack()
    local add_atk = u:get_add_attack()
    print(('%s基础攻击：%s，额外攻击:%s'):format(u:get_name(), atk, add_atk))
    u:add_attack( atk )
    u:add_add_attack( 20 )

    local atk_range = u:get_attack_range()
    local atk_speed = u:get_attack_speed()
    local atk_rate = u:get_attack_rate()
    print(('%s攻击范围：%s，攻速:%s，攻击间隔：%s'):format(u:get_name(), atk_range, atk_speed, atk_rate))
    u:add_attack_range(250)
    -- u:add_attack_speed(200)
    u:add_attack_rate(10)
    print(u:get_attack_rate())

    local def = u:get_defence()
    local move = u:get_move_speed()
    print(('%s防御：%s，移速:%s'):format(u:get_name(), def, move))
    u:add_defence(300)
    u:add_move_speed(500)
    print(('%s防御：%s，移速:%s'):format(u:get_name(), u:get_defence(), u:get_move_speed()))

    -- u:add_move_speed(-1000)
    -- print(('%s防御：%s，移速:%s'):format(u:get_name(), u:get_defence(), u:get_move_speed()))

end

local function check_damage(u)
    u:damage{
        damage = 100,
        magical = true,
        damage_not_repeat = true,
    }
end

local function check_hero()

    local mt = ac.hero['山丘之王']{
        war3_id = 'Hmkg',
    }

    local hero = ac.player[1]:create_hero('山丘之王', ac.point(0, 0))
    print('单位类型：', hero:is_type_hero(), jass.IsUnitType(hero.handle, jass.UNIT_TYPE_HERO), hero:tostring())
    
    -- hero.old_add_add_str = hero.add_add_str
    -- function hero:add_add_str(str)
    --     -- self:old_add_add_str(2*str)
    --     print('hero， add_add_str', str)
    --     local mt = self.__index
    --     mt.add_add_str(self, 2*str)
    -- end

    -- --两种方式都可以，优先选择下面这张吧
    -- hero.old_add_life = hero.add_life
    -- function hero:add_max_life(life)
    --     print('hero， add_max_life', life)
    --     hero:old_add_life(2*life)
    -- end
    -- check_item(hero)
    
    --[[
    hero:add_add_str(100)
    hero:add_add_agi(90)
    hero:add_add_int(80)
    ac.wait(3*1000, function()
        hero:add_add_str(-100)
        hero:add_add_agi(-100)
        hero:add_add_int(-100)
    end)

    ac.wait(8*1000, function()
        hero:add_add_str(-10)
        hero:add_add_agi(-10)
        hero:add_add_int(-10)
    end)
    --]]
    return hero
end

local function check_mover(u, u2)
    ---[[
    local mvr = ac.mover.line{
        source = u,
        -- model = [[Abilities\Spells\Human\MagicSentry\MagicSentryCaster.mdl]],
        model = [[Abilities\Spells\NightElf\SpiritOfVengeance\SpiritOfVengeanceBirthMissile.mdl]],
        -- id = 'hfoo',
        -- mover = u,
		angle = 45,
		distance = 2000,
		speed = 100,
		keep = true,
		skill = true,
    }
    function mvr:on_finish()
        print('运动器到期', self.model)
    end
    --]]
    --[[
    ac.mover.target{
			source = u,
			target = u2,
			mover = u,
			speed = 30,
			angle = u:get_point() / u2:get_point(),
			max_distance = 3000,
			skill = true,
    }
    --]]
end

local function check_dialog()
    local degree_dialog = {

        title = '请选择游戏难度',
    
        buttons = {
            [1] = {
                title = '小白过家家级',
                key = 'a',
                on_click = function(dialog, player)
                    print(player:tostring(), '点击了 小白过家家级 难度')
                    
                end,
            },
            [2] = {
                title = '老鸟各自飞级',
                key = nil,
                on_click = function(dialog, player)
                    print(player:tostring(), '点击了 老鸟各自飞级 难度')
                    
                end,
            },
            [3] = {
                title = '老鸟劝退级',
                key = nil,
                on_click = function(dialog, player)
                    print(player:tostring(), '点击了 老鸟劝退级 难度')
                    
                end,
            },
        },
    
    }
    local dialog = Dialog:new(degree_dialog)
    dialog:show(ac.player[2])
        :show(ac.player[2])
        :set_life(15)
        :set_default_button(dialog.buttons[3])
        :run()
end

local function check_follow()
    local u = ac.player[1]:create_unit('Hmkg', ac.point(0, 0))
    u:follow({
        source = hero,
        model = [[Abilities\Spells\NightElf\SpiritOfVengeance\SpiritOfVengeanceBirthMissile.mdl]],
        distance = 250,
        high = 100,
        skill = true,
        angle_speed = 100,
    })
end

local function check_crit()
    local u = ac.player[1]:create_unit('Obla', ac.point(0, 0))
    u:set_crit()
end

local function test_model()
    -- jass.FogEnable(false)
    -- jass.FogMaskEnable(false)
    -- ac.player[16]:set_alliance(ac.player[1], 6, true)
    -- ac.player[1].hero = hero
    -- hero:set_level(100)
    -- jass.SetHeroLevel(hero.handle, 100, false)
    -- print(ac.player[1]:tostring())
    -- local Player = Router.player
    -- print(Player.self:tostring())
    ac.wait(1000, function()
        ac.player[1]:send_msg('1秒时间到！')
        
        -- local u1 = ac.player[1]:create_unit('Hmkg', ac.point(0, 0))
        -- local u2 = ac.player[1]:create_unit('hfoo', ac.point(800, 0))
        --ac.game:event_notify('游戏-开始')
        -- check_multiboard()
        -- check_point()
        -- check_region()
        check_fogmodifier()
        -- check_buff(u1)
        -- local hero = check_hero()
        -- check_lightning(u1, u2)
        -- check_texttag(u1)
        -- u1:create_illusion(100, 100, 10)
        -- u1:add_sight(2000)
        -- check_heal(u1)
        -- check_selector(u1)
        -- u1:create_illusion(100, 100, 10)
        -- jass.IssueTargetOrderById(u1.handle, 852274, u2.handle)
        -- check_effect(u1)
        -- check_skill(hero)
        -- local point = u1:get_point()
        -- local x, y = point:get()
        -- check_item(u1)
        -- check_damage(u1)
        -- jass.CreateItem(Base.string2id('rat9'), 0, 0)
        -- ac.wait(3500, function()
        --     check_attribute(u1)
        -- end)
        -- check_mover(u1, u2)
        -- check_follow()
        -- check_dialog()
        check_crit()
    end)
end

if not base.release then
    -- test_model()
    ac.player[1]:add_gold(10000)
    ac.wait(1000, function()
        print('选择游戏难度')
        if not Map_game.test then
            Map_game.test = true
            ac.game:event_notify('游戏-选择难度')
        end
    end)
    
end
