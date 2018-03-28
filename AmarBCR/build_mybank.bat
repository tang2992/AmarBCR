@echo off
rem setup classpath
echo set _CP=%%_CP%%;%%1> cp.bat
set _CP=.;.\classes
for %%i in (lib\*.jar) do call cp.bat %%i
set CLASSPATH=%_CP%
del cp.bat

set COMPILER=javac
set COMPILE_OPTION=-encoding GBK -sourcepath .\src -d classes -target 1.4 -source 1.4 -classpath %CLASSPATH%
@echo on
%COMPILER% %COMPILE_OPTION% src\mybank\*

  