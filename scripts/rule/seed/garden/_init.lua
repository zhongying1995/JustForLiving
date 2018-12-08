local Garden = require 'rule.seed.garden.farmer'
local Garden = require 'rule.seed.garden.garden'

Garden:init('farmer')

for i = 1, ac.cpn do
    local p = ac.player.force[1][i]
    if p:is_player() then
        p.garden = Garden:new(p)
    end
end