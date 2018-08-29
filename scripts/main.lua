local std_print = print

function print(...)
	std_print(('[%.3f]'):format(os.clock()), ...)
end

local function main()
	print 'hello loli!'
	print ('package.path = ', package.path)
	print('hello 一中')
end

main()
