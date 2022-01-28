@echo off

cd /d C:\inetpub\wwwroot
cmd /c call core.bat
timeout /t 10
cmd /c call update.bat