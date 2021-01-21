::@echo off
set PATH_TO_TEMPLATE="__Templates"
set /p "P_NAME=enter your project name:"
setlocal EnableDelayedExpansion
set lastFolder=0
for /d %%d in (???_*) do (
   set folder=%%d
   set folder=!folder:"!folder:~3!"=!
   echo !folder!
   if not defined folder set folder=0
   if !folder! gtr !lastFolder! set lastFolder=!folder!
)
set /A nextFolder=lastFolder+1
IF 1%nextFolder% LSS 100 SET nextFolder=0%nextFolder%
IF 1%nextFolder% LSS 1000 SET nextFolder=0%nextFolder%
set DESTINATION_PATH="%CD%\%nextFolder%_%P_NAME%"
ROBOCOPY %PATH_TO_TEMPLATE% %DESTINATION_PATH% /E

@for /R "%DESTINATION_PATH%" %%I in (*.*) do (
    set CURRENT_NAME=%%I
    set NEW_NAME=!CURRENT_NAME:pnumber=%nextFolder%!

    for %%i in ("!CURRENT_NAME!") do (
        set NAME_WITHOUT_PATH=%%~nxi
    )

    if not "!CURRENT_NAME!"=="!NEW_NAME!" (
        set NEW_NAME_WITHOUT_PATH=!NAME_WITHOUT_PATH:pnumber=%nextFolder%!
        rename "!CURRENT_NAME!" "!NEW_NAME_WITHOUT_PATH!"
    )
)


