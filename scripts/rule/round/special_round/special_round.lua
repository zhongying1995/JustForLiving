local Round = require 'rule.round.round'
local Creep_datas = require 'rule.round.special_round.special_round_datas'
local Map_rects = require 'base.rects'
local Timerdialog = Router.timerdialog
local Player = Router.player

local Special_round = {}
setmetatable(Special_round, Special_round)

local mt = {}
Special_round.__index = mt

--继承Round
setmetatable(mt, mt)
mt.__index = Round
mt.super = Round

--类型
mt.type = '特殊回合'

--父类型
mt.super_type = mt.super.type


function mt:init()

end

function mt:create()

end

function mt:prepare()

end

function mt:start()

end

function mt:finish()

end


return Special_round