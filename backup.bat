@echo off

rem
rem Backs up specific folders using robocopy
rem


rem Settings here
set Sourcedrive=z
set Destdrive=e
set ExcludeDirs="LXUSER-PC2" "WindowsImageBackup" "OneDrive" "trashbox"
set ExcludeFiles="MediaID.bin"

rem exclusion for source directories
set "DataVar=\iphone_bak,\mai_iphone_bak"
set "dir_list=\iphone_bak \mai_iphone_bak"

setlocal EnableDelayedExpansion
for %%s in (%dir_list%) do (
  set "ExcludeSources=%Sourcedrive%:%%s !ExcludeSources!"
)

rem Batch routines
set "Batch1=mirror backup from a drive to a backup drive"
set "Batch2=unused...may be useful for future batch process"

echo %%Batch1%% %Batch1%
echo %%Batch2%% %Batch2%

:input
echo.
set userkey=
set /p userkey=End (Enter) / Execute %%Batch1%% (o + Enter) / Execute %%Batch2%% (p + Enter) / Execute All (b + Enter)?
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
robocopy %Sourcedrive%:\ %Destdrive%:\zbackup /Z /E /XJD /XO /XJF /XD %ExcludeDirs% /XF %ExcludeFiles% /XD %ExcludeSources% /FFT /LOG:"%Destdrive%:\backup.log" /NP /TEE
exit /b

:routine_batch2 (unused)
:add /MIR if mirror is intended
echo 'Execute Batch 2'
echo 'This is unused...'
exit /b

rem Quitting the program
:quit
exit