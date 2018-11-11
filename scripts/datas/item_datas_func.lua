--生存物品相关数据的算法

--装备性物品，8个等级 + 烂木级


--贝塞尔公式
--  最小值
--  最大值
--  相对位置i[0-1]
--  前半部分曲度因子
--  后半部分度曲因子
local function bezier_formula(min, max, i, factor1, factor2)
	if not i or i<0 then
		print('你他妈的传个小于0的i进来什么意思')
		return
	end
	if i > 1 then
		print('你他妈的传个大于1的i进来什么意思')
		return
	end
	local p0 = min
	local p3 = max
	local p1 = (max-min)/factor1
	local p2 = (max-min)/factor2
	return p0*(1-i)^3 + 3*p1*i*(1-i)^2 + 3*p2*i^2*(1-i) + p3*i^3
end


--武器攻击力
--剑，弓，镰，杖，铃
local types = {
    --最小值，最大值
    --剑
    {128, 10240},
    --弓
    {138, 11264},
    --镰
    {148, 12312},
    --杖
    {112, 9068},
    --铃
    {96, 8000},
}
}
for type_i = 1, #types do
	for i = 1, 8 do
		math.ceil(bezier_formula(types[type_i][1], types[type_i][2], (i-1)/7, 5, 2))
	end
end

--武器属性：
--剑，弓，镰，杖，铃
local types = {
    --最小值，最大值
    {30, 5000},
    {35, 5500},
    {30, 6000},
    {25, 4000},
    {20, 4500},
}
for type_i = 1, #types do
	for i = 1, 8 do
		math.ceil(bezier_formula(types[type_i][1], types[type_i][2], (i-1)/7, 6, 2))
	end
end


--魂珠属性、脱战生命回复：
local types = {
    --属性，脱战生命回复
    {30, 6666},
    {5, 333},
}
for i = 1, 8 do
	local attr = math.ceil(bezier_formula(types[1][1], types[1][2], (i-1)/7, 9, 3))
	local life = math.ceil(bezier_formula(types[2][1], types[2][2], (i-1)/7, 6, 1.6))
end

