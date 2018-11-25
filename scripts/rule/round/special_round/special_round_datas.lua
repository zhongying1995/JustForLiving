local Special_round_datas = {}
setmetatable(Special_round_datas, Special_round_datas)

local mt = {}
Special_round_datas.__index = mt

--获得该波次的单位数据
function mt:get_datas_by_index( index )
    return Special_round_datas[index]
end

function mt:get_type_datas( type )
    return Special_round_datas[type]
end

mt[1] = {
    name = '特殊进攻怪-50闪避',
    msg = '|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r',
    count = 80,
    prepare_time = 40,
}
mt['50闪避'] = mt[1]


mt[2] = {
    name = '特殊进攻怪-狙击',
    msg = '|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r',
    count = 80,
    prepare_time = 40,
}
mt['狙击'] = mt[2]

mt[3] = {
    name = '特殊进攻怪-隐身',
    msg = '|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r',
    count = 80,
    prepare_time = 40,
}
mt['隐身'] = mt[3]

mt[4] = {
    name = '特殊进攻怪-物免',
    msg = '|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r',
    count = 80,
    prepare_time = 40,
}
mt['物免'] = mt[4]

mt[5] = {
    name = '特殊进攻怪-拆基地',
    msg = '|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r',
    count = 80,
    prepare_time = 40,
}
mt['拆基地'] = mt[5]

mt[6] = {
    name = '特殊进攻怪-魔免',
    msg = '|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r',
    count = 80,
    prepare_time = 40,
}
mt['魔免'] = mt[6]

mt[7] = {
    name = '特殊进攻怪-无敌',
    msg = '|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r',
    count = 80,
    prepare_time = 40,
}
mt['无敌'] = mt[7]



return Special_round_datas