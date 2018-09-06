
--生成进攻单位的算法，该算法由sumbline生成

--[=[

	local str = [[
	[%id%]
	_parent = "hfoo"
	-- 图标 - 游戏界面
	Art = "ReplaceableTextures\\CommandButtons\\BTNSpinyCrab.blp"
	-- 生命最大值
	HP = %life%
	-- 名字
	Name = "进攻怪物 Lv%lv%"
	-- 提示工具 - 基础
	Tip = "进攻怪物 Lv%lv%"
	-- 提示工具 - 扩展
	Ubertip = "进攻怪物 Lv%lv%"
	-- 普通
	abilList = ""
	-- 攻击 1 - 攻击间隔
	cool1 = %atk_spd%
	-- 护甲类型
	defType = "normal"
	-- 攻击 1 - 基础伤害
	dmgplus1 = %atk%
	-- 模型文件
	file = "units\\critters\\SpiderCrab\\SpiderCrab.mdl"
	-- 占用人口
	fused = 0
	-- 生命回复
	regenHP = %life_rec%
	-- 视野范围(白天)
	sight = 1000
	-- 基础速度
	spd = %mov%
	-- 使用科技
	upgrades = ""
	]]

	local function caculate_attack( a, i )
		a = a * 6 / 5 + i * 3
		return math.floor(a)
	end
	local base_attack = 10

	--生命
	local function caculate_life( a, i )
		a = a * 7 / 6 + i * 10
		return math.floor(a)
	end
	local base_life = 40

	--防御
	local function caculate_defence( a, i )
		a = (a+1) * 7 / 8 +  math.floor(math.max(0, i - 5))
		return math.ceil(a)
	end
	local base_def = 1

	--攻速
	local function caculate_attack_speed( a, i )
		a = a  - math.max(0, (i%3 - 1)) * 0.1
		return a
	end
	local base_speed = 1.8

	local function caculate_move( a, i )
		a = a + i / 3
		return math.floor(a)
	end
	local base_move = 250

	--
	local function caculate_recovery( a, i )
		a = (a + i / 3) * 10/9
		return math.ceil(a)
	end
	local base_rec = 0

	require 'id2string'
	local base_i_1 = 1748054063
	local base_i_2 = 1748054070
	local strs = {}
	for lv = 1, 36 do
		if lv < 10 then
			base_i = base_i_1
		else 
			base_i = base_i_2
		end

		local id = base.id2string(base_i + lv)
		base_attack = caculate_attack(base_attack, lv)
		base_life = caculate_life(base_life, lv)
		base_def = caculate_defence(base_def, lv)
		base_speed = caculate_attack_speed(base_speed, lv)
		base_move = caculate_move(base_move, lv)
		base_rec = caculate_recovery(base_rec, lv)

		-- print(base_attack)
		local s = str:gsub('%%id%%', id)
		local s = s:gsub('%%atk%%', base_attack)
		local s = s:gsub('%%lv%%', lv)
		local s = s:gsub('%%life%%', base_life)
		local s = s:gsub('%%def%%', base_def)
		local s = s:gsub('%%atk_spd%%', base_speed)
		local s = s:gsub('%%mov%%', base_move)
		local s = s:gsub('%%life_rec%%', base_rec)
		
		table.insert(strs, s)
	end
	local s = table.concat(strs, '\n')
	-- print(s)
	local file = io.open('data.lua', 'w')
	io.output(file)
	io.write(s)
	io.close()


--]=]