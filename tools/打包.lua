print('hello,yizhong')

require 'filesystem'

if not arg[1] then
	print('please open target file')
	return
end


local dir_path = fs.path(arg[1])

print(arg[1])
print(dir_path)

if fs.is_directory(dir_path) then
	print(dir_path, 'is directory')
else
	print(dir_path, 'is a file')
end
