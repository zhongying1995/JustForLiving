local Final_round_datas = {}
setmetatable(Final_round_datas, Final_round_datas)

local mt = {}
Final_round_datas.__index = mt

--获得该波次的单位数据
function mt:get_datas(  )
    return Final_round_datas[1]
end


mt[1] = {
    boss_datas = {
        {
            boss = {
                name = '最终Boss-1号',
            },
        },
        {
            boss = {
                name = '最终Boss-2号',
            },
        },
    },
    msg = '|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r|cffff0000[WARNING!!]|r',
    count = 80,
    prepare_time = 40,
    clear_time = 120,
}


return Final_round_datas