@echo off
set Sandboxie_Start=%ProgramFiles%\Sandboxie-Plus\Start.exe
set Sandbox_Box=%HomeDrive%\Sandbox\%UserName%\DefaultBox
set proxycap_file=pcap536_x64.msi

echo Build Proxycap Registration.reg
echo please wait ...

:: get Registration
"%Sandboxie_Start%" /terminate
"%Sandboxie_Start%" /wait delete_sandbox
"%Sandboxie_Start%" /wait "%proxycap_file%" /qn
"%Sandboxie_Start%" /wait "reg" "export" "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\WOW6432Node\Proxy Labs\ProxyCap\Registration" "c:/Registration.reg"

:: decode
type "%Sandbox_Box%\drive\C\Registration.reg" > Registration.reg

:: replace WOW6432Node bug
powershell -Command "(gc Registration.reg) -replace 'WOW6432Node\\WOW6432Node', 'WOW6432Node' | Out-File -encoding ASCII Registration.reg"


