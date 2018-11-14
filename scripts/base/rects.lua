local Rect = Router.rect

local Map_rects = {}

Map_rects['进攻怪物出生点-生存'] = {
    Rect.j_rect('BirthPoint_1'),
    Rect.j_rect('BirthPoint_2'),
    Rect.j_rect('BirthPoint_3'),
    Rect.j_rect('BirthPoint_4'),
    Rect.j_rect('BirthPoint_5'),
}

Map_rects['进攻怪物出生点-防守'] = {
    Rect.j_rect('BirthPoint_6'),
    Rect.j_rect('BirthPoint_7'),
}

Map_rects['战斗区域'] = Rect.j_rect('Battlefield')


Map_rects['海区域'] = {
    Rect.j_rect('Sea_0'),
    Rect.j_rect('Sea_1'),
    Rect.j_rect('Sea_2'),
    Rect.j_rect('Sea_3'),
    Rect.j_rect('Sea_4'),
    Rect.j_rect('Sea_5'),
    Rect.j_rect('Sea_6'),
    Rect.j_rect('Sea_7'),
    Rect.j_rect('Sea_8'),
    Rect.j_rect('Sea_9'),
    Rect.j_rect('Sea_10'),
    Rect.j_rect('Sea_11'),
    Rect.j_rect('Sea_12'),
    Rect.j_rect('Sea_13'),
    Rect.j_rect('Sea_14'),
    Rect.j_rect('Sea_15'),
    Rect.j_rect('Sea_16'),
    Rect.j_rect('Sea_17'),
    Rect.j_rect('Sea_18'),
    Rect.j_rect('Sea_19'),
    Rect.j_rect('Sea_20'),
    Rect.j_rect('Sea_21'),
    Rect.j_rect('Sea_22'),
    Rect.j_rect('Sea_23'),
    Rect.j_rect('Sea_24'),
    Rect.j_rect('Sea_25'),
    Rect.j_rect('Sea_26'),
    Rect.j_rect('Sea_27'),
    Rect.j_rect('Sea_28'),
    Rect.j_rect('Sea_29'),
    Rect.j_rect('Sea_30'),
    Rect.j_rect('Sea_31'),
    Rect.j_rect('Sea_32'),
    Rect.j_rect('Sea_33'),
    Rect.j_rect('Sea_34'),
    Rect.j_rect('Sea_35'),
    Rect.j_rect('Sea_36'),
    Rect.j_rect('Sea_37'),
    Rect.j_rect('Sea_38'),
    Rect.j_rect('Sea_39'),
    Rect.j_rect('Sea_40'),
    Rect.j_rect('Sea_41'),
    Rect.j_rect('Sea_42'),
    Rect.j_rect('Sea_43'),
    Rect.j_rect('Sea_44'),
    Rect.j_rect('Sea_45'),
}

Map_rects['默认视野'] = Rect.j_rect('DefaultFog')


Map_rects['选英雄区域'] = Rect.j_rect('ChooseHero')

Map_rects['青蛙区域'] = {
    Rect.j_rect('Creep_frog_01'),
    Rect.j_rect('Creep_frog_02'),
    Rect.j_rect('Creep_frog_03'),
    Rect.j_rect('Creep_frog_04'),
}

return Map_rects