@echo off
set old_dir=%CD%
:: 1
@REM mkdir 
mkdir C:\LAB6
@REM VER: ab57.ru/cmdlist/ver.html
ver > C:\LAB6\ver
@REM SYSTEMINFO: ab57.ru/cmdlist/systeminfo.html
systeminfo > systeminfo.log
@REM FINDSTR: ab57.ru/cmdlist/findstr.html, /C:"string to search"
findstr /C:"Physical Memory:" systeminfo.log > C:\LAB6\physical_memory
echo list disk > diskpart
@REM DISKPART: ab57.ru/cmdlist/diskpart.html, /S:"script"
diskpart /s diskpart > C:\LAB6\disks
@REM DEL: ab57.ru/cmdlist/del.html
del systeminfo.log diskpart

:: 2
mkdir C:\TEST
copy /y C:\LAB6 C:\TEST
cd C:\TEST

:: 3
@REM DIR: ab57.ru/cmdlist/dir.html, /b - only filenames
dir /b > list_of_files

:: 4
type list_of_files | findstr /V "list_of_files" > files_to_delete
for /f %%i in (files_to_delete) do ( del %%i )
del files_to_delete

:: 5
cd %old_dir%
findstr /R "^@REM" 1.bat > 1_used_commands_and_params.txt