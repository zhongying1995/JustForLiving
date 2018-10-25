@echo off

echo 当前盘符和路径：%~dp0 

::call %~dp0w3x2lni\build\luabuild\lua.exe test.lua %~1

xcopy G:\War3\Warcraft3\JustForLiving C:\Users\Administrator\Desktop\JustForLiving /s /e

xcopy G:\War3\Warcraft3\War3Library C:\Users\Administrator\Desktop\JustForLiving\scripts\War3Library /s /e

pause