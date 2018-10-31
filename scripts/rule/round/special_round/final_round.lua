local Round = require 'rule.round.round'
local Boss_datas = require 'rule.round.boss_round.boss_round_datas'
local Map_rects = require 'base.rects'
local Timerdialog = Router.timerdialog
local Player = Router.player

local Final_round = {}
setmetatable(Final_round, Final_round)

local mt = {}
Final_round.__index = mt

--继承Round
setmetatable(mt, mt)
mt.__index = Round
mt.super = Round

--类型
mt.type = '最终回合'

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


return Final_round