local Region = Rount.region
local Map_rects = require 'base.rects'

local Map_Regions = {}

temp_region = Region:new()
for _, rect in pairs(Map_rects['海区域']) do
    temp_region = temp_region + rect
end

Map_Regions['海区域'] = temp_region

return Map_Regions