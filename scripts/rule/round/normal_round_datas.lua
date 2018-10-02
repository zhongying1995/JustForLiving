local Normal_round_datas = {}
setmetatable(Normal_round_datas, Normal_round_datas)

local mt = {}
Normal_round_datas.__index = mt


function mt:get_datas_by_index( index )
    return Normal_round_datas[1]
end

mt[1] = {
    unit_id = 'h100',
    msg = '正宗阳澄湖大闸蟹来袭，不要争不要抢，人人有份人人有份！',
    atk = 15,
    life = 56,
    count = 30,
    prepare_time = 10,
    clear_time = 100,
}



return Normal_round_datas