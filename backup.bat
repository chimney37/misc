@echo off

rem
rem Backs up specific folders using robocopy
rem


rem Settings here

set backupSourceDrive=z:
set backupDestinationDrive=c:
set backupDir=\various_bak
set backupExcludesDir="LXUSER-PC2" "WindowsImageBackup" "OneDrive" "trashbox" "iphone_bak" "mai_iphone_bak" "Pictures" "playmemories"
set backupExcludesFiles="2010To2014.rar"

:input
echo.
set userkey=
set /p userkey=End (Enter) / Execute Backup Batch (o + Enter) ?
if not '%userkey%'=='' set userkey=%userkey:~0,1%
if '%userkey%'=='o' goto first
if '%userkey%'=='p' goto second
if '%userkey%'=='b' goto both
goto quit

:first
call :routine_batch1
pause
goto quit

:second
call :routine_batch2
pause
goto quit

:both
call :routine_batch1
call :routine_batch2
pause
goto quit

:routine_batch1 (backs up external drive content to internal drive)
:add /MIR if mirror is intended
echo 'Execute Batch 1'
robocopy %backupSourceDrive%%backupDir% %backupDestinationDrive%%backupDir% /Z /E /XJD /XO /XJF /XD %backupExcludesDir% /XF %backupExcludesFiles% /FFT /LOG:"%backupSourceDrive%backup1.log" /NP /TEE
exit /b

:routine_batch2 (unused)
:add /MIR if mirror is intended
echo 'Execute Batch 2'
rem robocopy d:\temp\pics j:\pics /Z /E /XJD /FFT /XJF /XO /XD "iPod Photo Cache" /LOG:"d:\backup2.log" /NP /TEE
exit /b

rem Quitting the program
:quit
exit