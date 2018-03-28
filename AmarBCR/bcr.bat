cd /d F:\workspace\AmarBCR
@echo off
rem setup classpath
echo set _CP=%%_CP%%;%%1> cp.bat
set _CP=.;.\classes
for %%i in (lib\*.jar) do call cp.bat %%i
set CLASSPATH=%_CP%
del cp.bat
echo %CLASSPATH%

set JAVA_RUN=java
set RUN_OPTION=-Dfile.encoding=GBK
set RUN_CLASS=com.amarsoft.app.datax.bcr.AmarBCR
set ARE_CONFIG_FILE=etc\bcr_are.xml
set TASK=%1%

@echo on
%JAVA_RUN% %RUN_OPTION% -classpath %CLASSPATH% %RUN_CLASS% are=%ARE_CONFIG_FILE% task=%TASK% gui=false

  
