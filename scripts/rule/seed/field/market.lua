local Rects = require 'base.rects'

local Market = {}


function Market:init(  )
    local rect = Rects['神树']
    self.rect = rect
    self.market = ac.player[16]:create_unit('神种之树', rect:get_point(), 180)
end



return Market