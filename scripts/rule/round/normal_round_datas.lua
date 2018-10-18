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
    count = 80,
    prepare_time = 100,
    clear_time = 100,
}

mt[2] = {
    unit_id = 'h101',
    msg = '',
    count = 90,
    prepare_time = 30,
    clear_time = 90,
}

mt[3] = {
    unit_id = 'h102',
    msg = '',
    count = 75,
    prepare_time = 30,
    clear_time = 100,
}

mt[4] = {
    unit_id = 'h103',
    msg = '',
    count = 75,
    prepare_time = 30,
    clear_time = 100,
}

mt[5] = {
    unit_id = 'h104',
    msg = '',
    count = 90,
    prepare_time = 20,
    clear_time = 100,
}

mt[6] = {
    unit_id = 'h105',
    msg = '',
    count = 120,
    prepare_time = 20,
    clear_time = 120,
}

mt[7] = {
    unit_id = 'h106',
    msg = '',
    count = 80,
    prepare_time = 40,
    clear_time = 100,
}

mt[8] = {
    unit_id = 'h107',
    msg = '',
    count = 80,
    prepare_time = 30,
    clear_time = 100,
}

mt[9] = {
    unit_id = 'h108',
    msg = '',
    count = 90,
    prepare_time = 20,
    clear_time = 100,
}

mt[10] = {
    unit_id = 'h109',
    msg = '',
    count = 100,
    prepare_time = 20,
    clear_time = 100,
}

mt[11] = {
    unit_id = 'h10A',
    msg = '',
    count = 100,
    prepare_time = 20,
    clear_time = 100,
}

mt[12] = {
    unit_id = 'h10B',
    msg = '',
    count = 120,
    prepare_time = 20,
    clear_time = 90,
}

mt[13] = {
    unit_id = 'h10C',
    msg = '',
    count = 120,
    prepare_time = 25,
    clear_time = 100,
}

mt[14] = {
    unit_id = 'h10D',
    msg = '',
    count = 120,
    prepare_time = 25,
    clear_time = 90,
}

mt[15] = {
    unit_id = 'h10E',
    msg = '',
    count = 120,
    prepare_time = 20,
    clear_time = 90,
}

mt[16] = {
    unit_id = 'h10F',
    msg = '',
    count = 120,
    prepare_time = 20,
    clear_time = 100,
}

mt[17] = {
    unit_id = 'h10G',
    msg = '',
    count = 130,
    prepare_time = 20,
    clear_time = 100,
}

mt[18] = {
    unit_id = 'h10H',
    msg = '',
    count = 140,
    prepare_time = 30,
    clear_time = 80,
}

mt[19] = {
    unit_id = 'h10I',
    msg = '',
    count = 140,
    prepare_time = 15,
    clear_time = 90,
}

mt[20] = {
    unit_id = 'h10J',
    msg = '',
    count = 120,
    prepare_time = 15,
    clear_time = 90,
}

mt[21] = {
    unit_id = 'h10K',
    msg = '',
    count = 120,
    prepare_time = 15,
    clear_time = 90,
}

mt[22] = {
    unit_id = 'h10L',
    msg = '',
    count = 120,
    prepare_time = 15,
    clear_time = 80,
}

mt[23] = {
    unit_id = 'h10M',
    msg = '',
    count = 130,
    prepare_time = 15,
    clear_time = 80,
}

mt[24] = {
    unit_id = 'h10N',
    msg = '',
    count = 130,
    prepare_time = 10,
    clear_time = 80,
}

mt[25] = {
    unit_id = 'h10O',
    msg = '',
    count = 100,
    prepare_time = 15,
    clear_time = 90,
}

mt[26] = {
    unit_id = 'h10P',
    msg = '',
    count = 100,
    prepare_time = 15,
    clear_time = 100,
}

mt[27] = {
    unit_id = 'h10Q',
    msg = '',
    count = 130,
    prepare_time = 12,
    clear_time = 90,
}

mt[28] = {
    unit_id = 'h10R',
    msg = '',
    count = 130,
    prepare_time = 12,
    clear_time = 80,
}

mt[29] = {
    unit_id = 'h10S',
    msg = '',
    count = 130,
    prepare_time = 10,
    clear_time = 80,
}

mt[30] = {
    unit_id = 'h10T',
    msg = '',
    count = 120,
    prepare_time = 10,
    clear_time = 80,
}

mt[31] = {
    unit_id = 'h10U',
    msg = '',
    count = 150,
    prepare_time = 10,
    clear_time = 70,
}

mt[32] = {
    unit_id = 'h10V',
    msg = '',
    count = 150,
    prepare_time = 10,
    clear_time = 60,
}

mt[33] = {
    unit_id = 'h10W',
    msg = '',
    count = 150,
    prepare_time = 10,
    clear_time = 50,
}

mt[34] = {
    unit_id = 'h10X',
    msg = '',
    count = 160,
    prepare_time = 10,
    clear_time = 50,
}

mt[35] = {
    unit_id = 'h10Y',
    msg = '',
    count = 170,
    prepare_time = 10,
    clear_time = 50,
}

mt[36] = {
    unit_id = 'h10Z',
    msg = '第36波来袭！真的能活下去吗？',
    count = 180,
    prepare_time = 20,
    clear_time = 60,
}



return Normal_round_datas