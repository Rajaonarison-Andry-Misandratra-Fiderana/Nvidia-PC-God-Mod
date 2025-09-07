@echo off
title Code Integrity Enabled - Disabled
mode con: cols=50 lines=10
color a
echo.
echo ---------------------------------------
echo - 1) HVCI Enabled		      -
echo - 2) HVCI Disabled (KernelOS Default) -
echo ---------------------------------------
set /p opt=:
if %opt% EQU 1 goto e
if %opt% EQU 2 goto d

:e
bcdedit /set hypervisorlaunchtype auto
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 1 /f
echo Done, restart your computer.
timeout /t 3 /nobreak
exit

:d
bcdedit /set hypervisorlaunchtype off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f
echo Done, restart your computer.
timeout /t 3 /nobreak
exit