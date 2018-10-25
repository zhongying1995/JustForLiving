print('hello,yizhong')

require 'filesystem'

if not arg[1] then
	print('please open target file')
	return
end

local dir_path = fs.path(arg[1])

print(arg[1])
print(dir_path)

local root_path = fs.path([[G:\War3\Warcraft3\JustForLiving]])

local function f( dir )
	for path in dir:list_directory()do
		if fs.is_directory(path) then
			f(path)
		else
			local name = path:filename():string()
		end
	end
end

-- f(root_path)

--[[
require 'il8n'
local cm = il8n.conv_method( (2<<16) | string.byte("?", 1) )
function utf8_to_ansi( str )
	return il8n.utf8_to_ansi(str, cm)
end

function ansi_to_utf8( str )
	return il8n.ansi_to_utf8(str, cm)
end

print('我是钟小颖1')
local real_print = print
function print( str )
	local s = utf8_to_ansi(str)
	real_print(s)
end
--]]
print('我是钟小颖2')