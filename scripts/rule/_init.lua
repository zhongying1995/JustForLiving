require 'rule.model._init'
require 'rule.round._init'
require 'rule.creep._init'
require 'rule.shop._init'
require 'rule.hero._init'
require 'rule.choose_hero._init'
require 'rule.mission._init'
require 'rule.pick_item'
require 'rule.seed._init'
local Game_start = require 'rule.game_start'

ac.wait(Game_start.prepare_time * 1000, function ()
    Game_start:start_game() 
end)