local std_print = print

function print(...)
	std_print(('[%.3f]'):format(os.clock()), ...)
end


local function main()
	print 'hello loli!'
	print ('package.path = ', package.path)
	print('hello 一中11231233')
	require("War3Library._init")

	print('加载地图应用代码')
	require 'base._init'
	require 'skill._init'
	require 'unit._init'
	require 'item._init'
	require 'rule._init'

	require 'test'
	ac.game:event '玩家-按下esc'(function(trg, player)
		print('马上reload test')
		reload('test')
	end)
end

main()
