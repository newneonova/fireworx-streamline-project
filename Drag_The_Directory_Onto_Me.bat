::::::::::::::::::::::::::::::::::::::::::::
:: Elevate.cmd - Version 4
:: Automatically check & get admin rights
:: see "https://stackoverflow.com/a/12264592/1016343" for description
::::::::::::::::::::::::::::::::::::::::::::
 @echo off
 
   SET commandline=%*
   
      SET _string=###%commandline%###
   SET _string=%_string:"###=%
   SET _string=%_string:###"=%
   SET _string=%_string:###=%
   
   SET _string = %_string%\
   SET _string = "%_string%"
    :: store it to file
    echo %_string%\> "__temp__.txt"

 CLS
 ECHO.
 ECHO =============================
 ECHO Running Admin shell
 ECHO =============================

:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~0"
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO.
  ECHO **************************************
  ECHO Invoking UAC for Privilege Escalation
  ECHO **************************************

  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"

  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

 ::::::::::::::::::::::::::::
 ::START
 ::::::::::::::::::::::::::::
 REM Run shell as admin (example) - put here code as you like


@echo off

set /p dirProcess=<__temp__.txt

echo path is %dirProcess%

del __temp__.txt

      SET _string=###%dirProcess%###
   SET _string=%_string:"###=%
   SET _string=%_string:###"=%
   SET _string=%_string:###=%
  
   
   SET _string = %_string%\
   SET _string = "%_string%"
   echo 'dir /b /a-d "%_string%*" '

FOR /f "delims=" %%a IN (
 'dir /b /a-d "%_string%*" '
 ) DO (
 setlocal enableDelayedExpansion
 echo %%a
set "_srcp=%%a"
  echo _srcp is !_srcp!
  set "_newp=!_srcp:.000=!"
  if not !_newp!==!_srcp! (
  call set dataFileName=!_newp!
  goto :escapeMe

  )



 ECHO ------------------
)

:escapeMe




echo  the directory is  %dirProcess%
echo  the data file name is %dataFileName%


type "%~dp0\ScriptFiles\ScriptProcessingFiles\configPre.txt" > out.txt
echo  '%dirProcess%'; >> out.txt

type "%~dp0\ScriptFiles\ScriptProcessingFiles\configMid.txt" >> out.txt
echo  '%dataFileName%'; >> out.txt

type "%~dp0\ScriptFiles\ScriptProcessingFiles\configPost.txt" >> out.txt

echo Opening matlab and running fireworx, please wait until matlab closes. The results should be in your file directory.

matlab -nosplash -r "run '%~dp0\ScriptFiles\doTheFireworx.m'"

pause