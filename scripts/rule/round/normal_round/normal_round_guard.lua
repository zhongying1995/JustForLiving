local Round = require 'rule.round.round'
local Creep_datas = require 'rule.round.normal_round.normal_round_datas'
local Map_rects = require 'base.rects'
local Timerdialog = Router.timerdialog
local Player = Router.player
local table_insert = table.insert

local Normal_round_guard = {}
setmetatable(Normal_round_guard, Normal_round_guard)

local mt = {}
Normal_round_guard.__index = mt

Map_game.normal_round_guard = Normal_round_guard

--继承Round
setmetatable(mt, mt)
mt.__index = Round
mt.super = Round

--类型
mt.type = '普通回合'

--附加的类型
mt.additive_type = '防守模式'

--父类型
mt.super_type = mt.super.type

--回合数
mt.index = 0

--最大回合数量，默认36回合
mt._max_round_number = 36

--回合状态，四种状态，创建、准备、开始、结束
mt.state = nil

--计时器窗口
mt.timerdialog = nil

function mt:init()

end

function mt:create()

end

function mt:prepare()

end

function mt:start()

end

function mt:stop()

end


return Normal_round_guard