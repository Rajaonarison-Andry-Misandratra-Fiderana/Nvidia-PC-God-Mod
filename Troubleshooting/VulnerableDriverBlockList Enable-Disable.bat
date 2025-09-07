@echo off
title Vulnerable Driver BlockList Enabled - Disabled
mode con: cols=65 lines=10
color a
echo.
echo --------------------------------------------------------------
echo - 1) Vulnerable Driver BlockList Enabled		     -
echo - 2) Vulnerable Driver BlockList Disabled (Default KernelOS) -
echo --------------------------------------------------------------
set /p vdbl=:
if %vdbl% EQU 1 goto e
if %vdbl% EQU 2 goto d

:e
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Config" /v VulnerableDriverBlocklistEnable /t REG_DWORD /d 1 /f
echo Done, restart your computer.
timeout /t 3 /nobreak
exit

:d
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Config" /v VulnerableDriverBlocklistEnable /t REG_DWORD /d 0 /f
echo Done, restart your computer.
timeout /t 3 /nobreak
exit