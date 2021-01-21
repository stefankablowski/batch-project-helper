for /f "tokens=1 delims=_" %%a in ("hallo_peter") do (
    set "folder=%%a"
    pause
)