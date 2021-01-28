@echo off

:: 1
@REM DRIVERQUERY: ab57.ru/cmdlist/sc.html, /FO format
driverquery /fo table > DRIVERS
@REM SORT: ab57.ru/cmdlist/sort.html, /r - reversed
sort /r DRIVERS > DRIVERS_REVERSED
@REM FINDSTR: ab57.ru/cmdlist/findstr.html
findstr /r "^@REM" 4.bat > 4_used_commands_and_params.txt