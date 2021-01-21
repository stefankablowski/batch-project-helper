::@echo off
setlocal EnableDelayedExpansion
set PATH_TO_TEMPLATE="__Templates"
set "FIXED_LENGTH=4"
set /p "P_NAME=enter your project name:"
set lastFolder=0
for /d %%d in (???_*) do (
    set folder="%%d"
    setlocal EnableDelayedExpansion
    for /f "tokens=1,2 delims=_" %%a in (!folder!) do set folder=%%a
    if not defined folder set folder=0
    if !folder! gtr !lastFolder! set lastFolder=!folder!
)

::remove leading zeroes
for /f "tokens=* delims=0" %%N in ("!lastFolder!") do set "lastFolder=%%N"
if not defined lastFolder set "lastFolder=0"

::calculate new folder number
set /A nextFolder=!lastFolder!+1

set /A endOfLoop=%FIXED_LENGTH%-1
set "COMPARE_NUMBER=100"
for /L %%Y in (1,1,%endOfLoop%) do (
    IF 1!nextFolder! LSS !COMPARE_NUMBER! SET nextFolder=0!nextFolder!
    set /A COMPARE_NUMBER=!COMPARE_NUMBER!*10
)
::add leading zeroes
::IF 1%nextFolder% LSS 1000 SET nextFolder=0%nextFolder%
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


ENDLOCAL


