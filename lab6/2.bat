@echo off

set filepath=C:\Windows\file.txt
@REM ECHO: ab57.ru/cmdlist/echo.html
echo "This is just a sample line appended to create a big file..." > %filepath%
@REM TYPE: ab57.ru/cmdlist/type.html
for /L %%i in (1,1,19) do type %filepath% >> %filepath%

:: 1
if exist C:\%ComputerName%\temp (
@REM DEL: ab57.ru/cmdlist/type.html
	del \\%ComputerName%\temp\file.txt
@REM NET: ab57.ru/cmdlist/net.html, /DELETE - stop sharing the resource, /GRANT[permissions]:WHO,WHICH, /unlimited - number of users, accessing the resource
	net share temp /delete /y
@REM RD: ab57.ru/cmdlist/rd.html
	rd C:\%ComputerName%\temp
)
@REM MKDIR
mkdir C:\%ComputerName%\temp
net share temp=C:\%ComputerName%\temp /grant:Everyone,FULL /unlimited /cache:none

:: 3
set /a hour=%time:~0,2%+0
set /a minute=%time:~3,2%+0
if %minute% == 59 (
	set minute=0
	if %hour% == 23 (set hour=0) else (set /a hour=%hour%+1)
) else (set /a minute=%minute%+1)

if %hour% LSS 10 set hour=0%hour%
if %minute% LSS 10 set minute=0%minute%
echo Task will run at %hour%:%minute%

@REM SCHTASKS: ab57.ru/cmdlist/schtasks.html, /query, /create, /end - activity, /tn - task name, /tr - command, script to run, /fo list - output format
schtasks /query /tn copier >NUL 2>&1 && schtasks /delete /tn copier /F >NUL
schtasks /create /tn copier /tr "%CD%\2_copier.bat" /sc once /st %hour%:%minute%

:: 4
:loop
for /f "delims=: tokens=2" %%i in ('schtasks /query /tn copier /v /fo list ^| find "Status:"') do (
	echo %%i|find "Running" >nul || goto loop
)
echo "Task running..."
@REM TIMEOUT: ab57.ru/cmdlist/timeout.html, /T - time to wait
timeout /t 5
schtasks /end /tn copier
timeout /t 2

:: 5
@REM FC: ab57.ru/cmdlist/fc.html
fc %filepath% \\%ComputerName%\temp\file.txt > 2_diff_after_interrupt.txt

:: 6
@REM COPY: ab57.ru/cmdlist/copy.html, /Z - copies networked files in restartable mode
copy /Z %filepath% \\%ComputerName%\temp
timeout /t 2
fc %filepath% \\%ComputerName%\temp\file.txt > 2_diff_after_resume.txt

:: 7
@REM FINDSTR: ab57.ru/cmdlist/findstr.html
findstr /r "^@REM" 2.bat > 2_used_commands_and_params.txt