@echo off


if "%1"=="" ( echo ����ק pcap*_x64.msi �������� && pause && exit ) else echo %1

REM %date:~0,4%-%date:~5,2%-%date:~8,2% 
echo ���������ļ�,�޸���װ��ɻ�ԭ...
set BackupFile=%date:~0,4%-%date:~5,2%-%date:~8,2% %time:~3,2%_%time:~6,2%_machine.prs
copy %ProgramData%\ProxyCap\machine.prs "%BackupFile%"
echo �����ļ���� : %BackupFile%


echo ��ʼ���ע����Ϣ...
reg delete "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Proxy Labs" /f
reg delete "HKEY_LOCAL_MACHINE\Software\WOW6432Node\SB" /f
reg delete "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\pcapsvc" /f
reg delete "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\Tcpip\Parameters\Arp" /f

echo ��װ����%1
echo ��������������������...
cmd /c %1

echo �������� pcapsvc
net stop pcapsvc
taskkill /im pcapui.exe /f
net start pcapsvc
powershell -Command "$Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' ; $Name = 'ProxyCap' ; $result = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop).$Name; & $result"

echo �������,�밴������˳�
pause > nul