@echo off

echo ^<html^> > index.html

echo ^<pre^>>> index.html
type Registration.reg >> index.html
echo ;; save to Registration.reg and import regedit >> index.html
echo ^</pre^>>> index.html


echo ^</html^> >> index.html