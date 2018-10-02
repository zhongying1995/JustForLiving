local Boss_round_datas = {}
setmetatable(Boss_round_datas, Boss_round_datas)

local mt = {}
Boss_round_datas.__index = mt


function mt:get_datas_by_index( index )
    return Boss_round_datas[1]
end

mt[1] = {
    boss_id = 'H100',
    boss_count = 1,
    henchmans = {
        {
            id = 'hfoo',
            count = 2,
        },
        {
            id = 'hsor',
            count = 2,
        },
    },
    msg = '第一关boss来袭，快快逃命！',
    atk = 15,
    life = 56,
    prepare_time = 20,
    clear_time = 120,
}



return Boss_round_datas