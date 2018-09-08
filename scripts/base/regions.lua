local Region = Rount.region
local Map_Rects = require 'base.rects'

local Map_Regions = {}

temp_region = Region:new()
for _, rect in pairs(Map_Rects['海区域']) do
    temp_region = temp_region + rect
end

Map_Regions['海区域'] = temp_region

return Map_Regions