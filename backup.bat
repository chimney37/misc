@echo off

rem
rem Backs up specific folders using robocopy
rem


rem Settings here


:input
echo.
set userkey=
set /p userkey=End (Enter) / Execute Batch1 (o + Enter) / Execute Batch2 (p + Enter) / Execute Batch1,2 (b + Enter)?
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

:routine_batch1
:add /MIR if mirror is intended
echo 'Execute Batch 1'
robocopy z:\ d:\zbackup /Z /E /XJD /XO /XJF /FFT /LOG:"d:\backup1.log" /NP /TEE
exit /b

:routine_batch2
:add /MIR if mirror is intended
echo 'Execute Batch 2'
robocopy d:\temp\pics j:\pics /Z /E /XJD /FFT /XJF /XO /XD "iPod Photo Cache" /LOG:"d:\backup2.log" /NP /TEE
exit /b

rem Quitting the program
:quit
exit