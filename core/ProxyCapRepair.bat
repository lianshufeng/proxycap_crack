@echo off


if "%1"=="" ( echo 请拖拽 pcap*_x64.msi 到本程序 && pause && exit ) else echo %1

REM %date:~0,4%-%date:~5,2%-%date:~8,2% 
echo 备份配置文件,修复安装后可还原...
set BackupFile=%date:~0,4%-%date:~5,2%-%date:~8,2% %time:~3,2%_%time:~6,2%_machine.prs
copy %ProgramData%\ProxyCap\machine.prs "%BackupFile%"
echo 备份文件完成 : %BackupFile%


echo 开始清除注册信息...
reg delete "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Proxy Labs" /f
reg delete "HKEY_LOCAL_MACHINE\Software\WOW6432Node\SB" /f
reg delete "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\pcapsvc" /f
reg delete "HKEY_LOCAL_MACHINE\System\ControlSet001\Services\Tcpip\Parameters\Arp" /f

echo 安装包：%1
echo 复程序后，无需重启计算机...
cmd /c %1

echo 重启服务 pcapsvc
net stop pcapsvc
taskkill /im pcapui.exe /f
net start pcapsvc
powershell -Command "$Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' ; $Name = 'ProxyCap' ; $result = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop).$Name; & $result"

echo 操作完成,请按任意键退出
pause > nul