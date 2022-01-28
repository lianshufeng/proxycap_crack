@echo off
cd /d %~dp0

echo backup proxycap config to c:\proxycap_backup
mkdir c:\proxycap_backup
copy %PROGRAMDATA%\proxycap\machine.prs c:\proxycap_backup\machine.prs /y 

echo clean Registration
reg delete "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Proxy Labs" /f
reg delete "HKEY_LOCAL_MACHINE\Software\WOW6432Node\SB" /f
reg delete "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\pcapsvc" /f
reg delete "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\Tcpip\Parameters\Arp" /f

echo please Repair and input any key continue start proxycap service
pause > nul


net start pcapsvc
powershell -Command "$Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' ; $Name = 'ProxyCap' ; $result = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop).$Name; & $result"


echo finish
pause > nul
