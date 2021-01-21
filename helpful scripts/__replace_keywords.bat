setlocal ENABLEDELAYEDEXPANSION
@for /R "%CD%" %%I in (*.*) do (
    set CURRENT_NAME=%%I
    set NEW_NAME=!CURRENT_NAME:pnumber=peter!

    for %%i in ("!CURRENT_NAME!") do (
        set NAME_WITHOUT_PATH=%%~nxi
    )

    if not "!CURRENT_NAME!"=="!NEW_NAME!" do (
        set NEW_NAME_WITHOUT_PATH=!NAME_WITHOUT_PATH:pnumber=peter!
        rename "!CURRENT_NAME!" "!NEW_NAME_WITHOUT_PATH!"
    )
) 