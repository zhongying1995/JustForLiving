local Boss_round_datas = {}
setmetatable(Boss_round_datas, Boss_round_datas)

local mt = {}
Boss_round_datas.__index = mt


function mt:get_datas_by_index( index )
    return Boss_round_datas[1]
end

mt[1] = {
    unit_id = 'H100',
    msg = '第一关boss来袭，快快逃命！',
    atk = 15,
    life = 56,
    count = 8,
    prepare_time = 20,
    clear_time = 120,
}



return Boss_round_datas