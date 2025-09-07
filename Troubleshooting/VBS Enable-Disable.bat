@echo off
title Virtualization-Based Security
mode con: cols=55 lines=10
color a
echo.
echo --------------------------------------
echo - 1) VBS Enabled		     -
echo - 2) VBS Disabled (KernelOS Default) -
echo --------------------------------------
set /p opt=:
if %opt% EQU 1 goto e
if %opt% EQU 2 goto d

:e
bcdedit /set hypervisorlaunchtype auto
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 1 /f
echo Done, restart your computer.
timeout /t 3 /nobreak
exit

:d
bcdedit /set hypervisorlaunchtype off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f
echo Done, restart your computer.
timeout /t 3 /nobreak
exit