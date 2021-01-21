@echo off


# nachricht
```
echo hi

```
# press any key
```
pause
```

# clear screen
```
cls
```

# go to end (exit script)
```
goto end
```

# somewhere else:
```
:end
```

# ask for variable
```
set /p MYVAR=Message?
```

# calculate math formula
```
set /a RESULT=%MYVAR%
```
# use variable
```
%MYVAR%
```

# if statement
```
if %RESULT%==5 
(MYEXPR)
// greater
if %num% GTR 5
// less
if %num% LSS 5

```

# for Loop
```
// iterate through numbers (start increment stop)

set /p code=Text:
for /L %%N in (1 1 26) do (
echo %%N

)

// iterate through string
for /F %%C in ("!chars:%%N,1!") do (
    // get the  
)

```

# string comparison
```
if "%Status%" =="Problem"
```

# modify strings
```
//replace a with b
set "string=!string:a=b!"
```

# start programm
```
start PATH_TO_APPLICATION
```

# start program and wait
```
call PATH_TO_APPLICATION
```

# save to text file
```
echo hi > test.txt
```

# add to text file
```
echo hi >> test.txt
```

# user prompt
```
echo -option1 (option1_text)
echo -option2 (option2_text)
echo.
set /p OPTION= What do you choose?
goto %OPTION%

:option1
// option one code goes here
:option2
// option two code goes here
```

# read from text document
```
for /f "Delims=" %%a in (test.txt) do (
    set TEXT=%%a
)

if %MYVAR%==%TEXT% MYEXPR
```

# test for file
if EXIST test1.txt () else () else if

# create ifle
echo. > test.txt

# copy files
```
copy C:\path\source C:\path\destination
```

# better copy (folders)
```
xcopy PATH PATH
```

# force copy
```
xcopy /y PATH PATH
robocopy
```

# delete file
```
del PATH
```

# rename file
```
move /y %CD%FILE1.TXT %CD%File123.TXT
```

# STANDARD VARIABLES
```
%USERNAME% is current User
%CD% is the current directory where the program is running
```

# create variable
```
set MYVAR=content
```

# variables between files, parameters
```
call Receive.bat myMessage myMessage2 ...
//in receive.bat
echo %1
echo %2
echo %3
...
```

# to exe
```
https://f2ko.de/programme/bat-to-exe-converter/?pid=b2e

https://battoexeconverter.com/
```

# delayed Expansion
```
setlocal enableDelayedExpansion
set Status=Problem
if "%Status%"=="Problem" (
    set Status=No Problem
    // use most recend version of variable
    echo !Status!
)
```

# popup window
msg "%username%" Some message to display

# substring
:

# snake
%1 is the first argument form the invoking command line. If the passed argument has quotes around it, %1 includes the quotes. Where as, %~1 provides the argument value with quotes removed.

# split string by delimiters
for /F "tokens=1,3 delims=. " %%a in ("%string%") do (
   echo %%a
   echo %%b
)

option 2:
set i=1
set "x=monotonous"
set "x!i!=%x:o=" & set /A i+=1 & set "x!i!=%"
set x

setlocal ENABLEDELAYEDEXPANSION

# split string
for /f %%s in ('set') do (
   set tmp=%%s
   echo !tmp:~-3!
)

# storage
    if not "!CURRENT_NAME!"=="!NEW_NAME!" do (
        rename "!CURRENT_NAME!" "!NEW_NAME!"
    )

rename "!CURRENT_NAME!" "!NEW_NAME!"

# look for filename recursively
@echo off
setlocal ENABLEDELAYEDEXPANSION
for /R %%d in (.) do (
   for /f "usebackq" %%i in (`dir /b %%d ^| findstr /i %1`) do (
      echo Processing %%i
   )
)
endlocal

# extract filename from path
@ECHO OFF
SETLOCAL
set file=C:\Users\l72rugschiri\Desktop\fs.cfg
FOR %%i IN ("%file%") DO (
ECHO filedrive=%%~di
ECHO filepath=%%~pi
ECHO filename=%%~ni
ECHO fileextension=%%~xi
)