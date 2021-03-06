::@echo off
set PATH_TO_TEMPLATE="__Templates"
set /p "P_NAME=enter your project name:"
setlocal EnableDelayedExpansion
set lastFolder=0
for /d %%d in (*_*) do (
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

::add the keyword you want to replace into the list, and define after how you want to replace it
set LIST=(pnumber pname)
set pnumber=%nextFolder%
set pname=%P_NAME%

for %%G in %LIST% do (
    @for /R "%CD%" %%I in (*.*) do (
        set CURRENT_NAME=%%I
        set NEW_NAME=!CURRENT_NAME:%%G=!%%G!!

        for %%i in ("!CURRENT_NAME!") do (
            set NAME_WITHOUT_PATH=%%~nxi
        )

        if not "!CURRENT_NAME!"=="!NEW_NAME!" do (
            set NEW_NAME_WITHOUT_PATH=!NAME_WITHOUT_PATH:%%G=!%%G!!
            rename "!CURRENT_NAME!" "!NEW_NAME_WITHOUT_PATH!"
        )
    ) 
)





pause



