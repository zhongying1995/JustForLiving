local Player = Router.player
local Rects = require 'base.rects'

local Garden = {}
setmetatable(Garden, Garden)

local mt = {}
Garden.__index = mt

function mt:new( player )
    local o = {}
    setmetatable(o, o)
    o.__index = self

    o.player = player
    player.garden = o
    local id = player.id
    o.garden_rect = Rects['花园'][id]

    o:create_farmer()

    return o
end

--获取花园区域
function mt:get_garden_rect(  )
    return self.garden_rect
end

function mt:create_farmer()
    local player = self.player
    local point = self.garden_rect:get_point()
    self.farmer = player:create_unit(Garden.farmer_name, point)
end

--玩家获取资自己的花园
function Player.__index:get_garden(  )
    return self.garden
end


function Garden:init( farmer_name )
    self.farmer_name = farmer_name
end


return Garden