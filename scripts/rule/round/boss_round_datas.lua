local Boss_round_datas = {}
setmetatable(Boss_round_datas, Boss_round_datas)

local mt = {}
Boss_round_datas.__index = mt


function mt:get_datas_by_index( index )
    return Boss_round_datas[1]
end

mt[1] = {
    boss_id = 'H101',
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
    prepare_time = 20,
    clear_time = 120,
}

mt[2] = {
    boss_id = 'H102',
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
    msg = '第二关boss来袭，快快逃命！',
    prepare_time = 20,
    clear_time = 120,
}

mt[3] = {
    boss_id = 'H103',
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
    msg = '第三关boss来袭，快快逃命！',
    prepare_time = 20,
    clear_time = 120,
}

mt[4] = {
    boss_id = 'H104',
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
    msg = '第四关boss来袭，快快逃命！',
    prepare_time = 20,
    clear_time = 120,
}

mt[5] = {
    boss_id = 'H105',
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
    msg = '第五关boss来袭，快快逃命！',
    prepare_time = 20,
    clear_time = 120,
}

mt[6] = {
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
    msg = '第六关boss来袭，快快逃命！',
    prepare_time = 20,
    clear_time = 120,
}



return Boss_round_datas