local runtime	= require 'jass.runtime'
local console	= require 'jass.console'

base = {}

--判断是否是发布版本
base.release = not pcall(require, 'lua.currentpath')

--版本号
base.version = '0.01'

--打开控制台
if not base.release then
	console.enable = true
	print('测试版本，开下玩笑吧')
else
	print('发行版本')
end

--重载print,自动转换编码
print = console.write

--将句柄等级设置为0(地图中所有的句柄均使用table封装)
runtime.handle_level = 0

--关闭等待
runtime.sleep = false

function base.error_handle(msg)
	print("---------------------------------------")
	print(tostring(msg) .. "\n")
	print(debug.traceback())
	print("---------------------------------------")
end

--错误汇报
function runtime.error_handle(msg)
	base.error_handle(msg)
end

--测试版本和发布版本的脚本路径
if base.release then
	package.path = package.path .. [[;Poi\]] .. base.version .. [[\?.lua;scripts\?.lua]]
	print('当前版本为 发行版')
else
	package.path = package.path .. [[;G:\War3\Warcraft3\War3Library\?.lua]]
	print('当前版本为 测试版')
end

--初始化本地脚本
require 'main'
