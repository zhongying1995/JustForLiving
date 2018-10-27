@echo off
echo you can not use chinese in this bat file
echo current path:%~dp0

set currentPath=%~dp0
cd ..

::地图代码路径
set mapCodePath=%cd%
::底层代码路径
set libCodePath=G:\War3\Warcraft3\War3Library
::地图名
set mapName=JustForLiving

cd %~dp0

echo %mapCodePath%

::指定复制文件过去的路径
set targetPath=C:\Users\Administrator\Desktop\%mapName%

::复制地图代码
xcopy %mapCodePath% %targetPath% /s /e

::复制底层代码
xcopy %libCodePath% %targetPath%\scripts\War3Library /s /e

call %currentPath%\w3x2lni\w2l.exe slk %targetPath% %mapCodePath%\%mapName%_slk.w3x

rmdir %targetPath% /s /q

::刷新电脑界面
echo please fresh the path[%targetPath%] manually

pause