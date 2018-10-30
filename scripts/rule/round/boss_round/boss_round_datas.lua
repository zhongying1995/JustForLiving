local Boss_round_datas = {}
setmetatable(Boss_round_datas, Boss_round_datas)

local mt = {}
Boss_round_datas.__index = mt


function mt:get_datas_by_index( index )
    return Boss_round_datas[1]
end

mt[1] = {
    boss_name = 'Boss进攻怪-第1波',
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
    boss_name = 'Boss进攻怪-第2波',
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
    boss_name = 'Boss进攻怪-第3波',
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
    boss_name = 'Boss进攻怪-第4波',
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
    boss_name = 'Boss进攻怪-第5波',
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
    boss_name = 'Boss进攻怪-第6波',
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