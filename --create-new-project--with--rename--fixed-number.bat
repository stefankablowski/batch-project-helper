::@echo off
setlocal EnableDelayedExpansion
set PATH_TO_TEMPLATE="__Templates"
set "FIXED_LENGTH=4"
set /p "P_NAME=enter your project name:"
:: lowest project number to start with
set lastFolder=0
:: loop through all directories in current folder
for /d %%d in (*_*) do (
    set folder="%%d"
    :: split current folder in two parts 001_myfolder -> 001, myfolder
    for /f "tokens=1,2 delims=_" %%a in (!folder!) do set folder=%%a

    ::remove leading zeroes
    for /f "tokens=* delims=0" %%M in ("!folder!") do set "folder=%%M"
    if not defined folder set folder=0

    ::check if folder number is numeric
    SET "var="&for /f "delims=0123456789" %%i in ("!folder!") do set var=%%i
    if not defined var (
        if !folder! gtr !lastFolder! set lastFolder=!folder!
    )

)

::calculate new folder number
set /A nextFolder=!lastFolder!+1

::add leading zeroes to folder number
set /A endOfLoop=%FIXED_LENGTH%-1
set "COMPARE_NUMBER=100"
for /L %%Y in (1,1,%endOfLoop%) do (
    IF 1!nextFolder! LSS !COMPARE_NUMBER! SET nextFolder=0!nextFolder!
    set /A COMPARE_NUMBER=!COMPARE_NUMBER!*10
)

::build project path
set DESTINATION_PATH="%CD%\%nextFolder%_%P_NAME%"

::copy files from template folder
ROBOCOPY %PATH_TO_TEMPLATE% %DESTINATION_PATH% /E

echo %DESTINATION_PATH%
pause
::recursively search through project directory and replace keywords
@for /R %DESTINATION_PATH% %%I in (*.*) do (
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

@for /R %DESTINATION_PATH% %%I in (*.*) do (
    set CURRENT_NAME=%%I
    set NEW_NAME=!CURRENT_NAME:pname=%P_NAME%!

    for %%i in ("!CURRENT_NAME!") do (
        set NAME_WITHOUT_PATH=%%~nxi
    )

    if not "!CURRENT_NAME!"=="!NEW_NAME!" (
        set NEW_NAME_WITHOUT_PATH=!NAME_WITHOUT_PATH:pname=%P_NAME%!
        rename "!CURRENT_NAME!" "!NEW_NAME_WITHOUT_PATH!"
    )
)


ENDLOCAL


