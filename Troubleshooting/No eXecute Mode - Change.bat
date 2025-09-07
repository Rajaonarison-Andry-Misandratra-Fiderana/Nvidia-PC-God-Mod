@echo off
title No eXecute Mode
mode con: cols=65 lines=10
color a
:home
cls
echo.
echo Select NX Mode.
echo NX Mode to OptIn its recommended for games with AntiCheat.
echo -----------------------------------
echo - 1) OptIn (Windows Default)      -
echo - 2) OptOut                       -
echo - 3) AlwaysOn                     -
echo - 4) AlwaysOff (KernelOS Default) -
echo -----------------------------------
set /p opt=:
if %opt% EQU 1 goto oi
if %opt% EQU 2 goto oo
if %opt% EQU 3 goto aon
if %opt% EQU 4 goto aoff
goto home


:oi
bcdedit /set {current} nx OptIn
echo Done, restart your computer.
timeout /t 3 /nobreak
exit

:oo
bcdedit /set {current} nx OptOut
echo Done, restart your computer.
timeout /t 3 /nobreak
exit

:aon
bcdedit /set {current} nx AlwaysOn
echo Done, restart your computer.
timeout /t 3 /nobreak
exit

:aoff
bcdedit /set {current} nx AlwaysOff
echo Done, restart your computer.
timeout /t 3 /nobreak
exit