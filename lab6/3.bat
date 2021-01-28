@echo off

:: 1
@REM SC: ab57.ru/cmdlist/sc.html, query - query service state, stop - stop service, start - start service
sc query > 3_services_initial.txt

:: 2.1
sc stop dnscache

:: 2.2
@REM TIMEOUT: ab57.ru/cmdlist/timeout.html, /T - time to wait
timeout /t 5
sc query > 3_services.txt

:: 2.3
@REM FC: ab57.ru/cmdlist/fc.html
fc "3_services_initial.txt" "3_services.txt" > 3_services_diff.txt

:: 2.4
sc start dnscache
@REM FINDSTR: ab57.ru/cmdlist/findstr.html
findstr /r "^@REM" 3.bat > 3_used_commands_and_params.txt
