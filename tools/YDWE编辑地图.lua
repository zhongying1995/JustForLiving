require 'filesystem'
local registry = require 'registry'
local ydwe = require 'tools.ydwe'
local process = require 'process'
if not ydwe then
    return
end

local root = fs.path(arg[1])
if not fs.exists(root / 'JustForLiving.w3x') then
    print('地图不存在', root / 'JustForLiving.w3x')
    return
end
local command = (registry.open [[HKEY_CURRENT_USER\SOFTWARE\Classes\YDWEMap\shell\open\command]])['']
command = command:gsub("%%1", (root / 'JustForLiving.w3x'):string())
print(command)
local p = process()
if p:create(nil, command, nil) then
    p:close()
end

