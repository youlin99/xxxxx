@echo off
rem -----------------------------------------------------------------------
rem (C) COPYRIGHT International Business Machines Corp. 2013
rem All Rights Reserved
rem
rem US Government Users Restricted Rights - Use, duplication or
rem disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
rem
rem NAME: wplistener
rem
rem FUNCTION: Start the NoSQL wire listener for DB2
rem
rem -----------------------------------------------------------------------

setlocal

set LOGPATH=

set NOSQLPROPERTYPATH=

set MYCLASSPATH=

@REM Any dependent script blocks is specified on top
goto startScript

:_readOption
if "%~1" == "" goto _End_readOption else (
    if "-logPath" == "%~1" (
	    if "%~2"=="" (
rem            echo ERROR: -logPath parameter has been specified but no path value has been specified.
            exit /b 1
	    ) else (
            set LOGPATH="%~2"
            )
    ) else ( 
            if "-noSQLPropertyPath" == "%~1" (
	        if "%~2"=="" (
rem             echo ERROR: -noSQLPropertyPath parameter has been specified but no path value has been specified.
                exit /b 1
	        ) else (
                set NOSQLPROPERTYPATH="%~2"
                )
            )
    )
)
shift
goto _readOption
:_End_readOption
exit /b 0

:_stripDblQuotes
if not defined %1 exit /b 0

setlocal ENABLEDELAYEDEXPANSION

@REM Must quote path first or NLS system cannot parse file path
set FIRSTCHAR=^!%1:~0,1!
if not [^%FIRSTCHAR%] == [^"] (
    set %1="!%1!"
)
   
for /f "useback tokens=*" %%A in ('!%1!') do (
endlocal
    set %1=%%~A
)
exit /b 0

:_setupJavaExe
@REM JAVA_EXE is set as a quoted path
if exist "%JAVA_HOME%\bin\java.exe" (
    set JAVA_EXE="%JAVA_HOME%\bin\java"
    exit /b 0 
) 

if exist "%JAVA_HOME%\jre\bin\java" (
    set JAVA_EXE="%JAVA_HOME%\jre\bin\java"
    exit /b 0 
)
exit /b 1

:startScript
@REM *** Official start script ***
call :_readOption %*

@REM Specify the log path directory if trace is enabled. 
@REM If the directory name has spaces, the path must be enclosed by double quotes.
SET CUR_DIR="%cd%"
cd /d "%~dp0.."
SET JSONDIR=%cd%

call :_stripDblQuotes JAVA_HOME
call :_stripDblQuotes JSONDIR

if not defined JAVA_HOME (
    set JAVA_HOME=%JSONDIR%\..\java\jdk
)

if not exist "%JAVA_HOME%" (
    echo ERROR: "%JAVA_HOME%" does not exist. JAVA_HOME is not set correctly.
    exit /B 1
)

call :_setupJavaExe
if not defined JAVA_EXE (
    echo ERROR: java.exe file cannot be found under bin or jre\bin directory of "%JAVA_HOME%".
    exit /B 1
)

call :_stripDblQuotes LOGPATH
if not defined LOGPATH (
    set LOGPATH=%JSONDIR%\logs
)

if "%LOGPATH:~-1%"=="\" set LOGPATH=%LOGPATH:~0,-1%
if not exist "%LOGPATH%" mkdir "%LOGPATH%"

if not exist "%LOGPATH%" (
    echo ERROR: "%LOGPATH%" does not exist. LOGPATH is not set correctly.
    exit /B 1
)


if "%NOSQLPROPERTYPATH%"=="" (
    set MYCLASSPATH="%JSONDIR%\lib\db2NoSQLWireListener.jar";"%JSONDIR%\lib\nosqljson.jar";"%JSONDIR%\lib\js.jar";"%JSONDIR%\..\java\db2jcc.jar";"%JSONDIR%\..\java\db2jcc4.jar"
) else (
    set MYCLASSPATH=%NOSQLPROPERTYPATH%;"%JSONDIR%\lib\db2NoSQLWireListener.jar";"%JSONDIR%\lib\nosqljson.jar";"%JSONDIR%\lib\js.jar";"%JSONDIR%\..\java\db2jcc.jar";"%JSONDIR%\..\java\db2jcc4.jar"
) 

set TRACEOPT=-Dcom.ibm.ejs.ras.lite.traceFileName="%LOGPATH%\trace.log"

if "%1" == "-register" (
  %JAVA_EXE% -classpath "%JSONDIR%\lib\db2NoSQLWireListener.jar";"%JSONDIR%\lib\nosqljson.jar" com.ibm.nosql.wireListener.auth.ConfigTool %*
) else (
  %JAVA_EXE% %TRACEOPT% -classpath %MYCLASSPATH% com.ibm.nosql.db2wire.server.DB2Listener %*
)

cd /d %CUR_DIR%
endlocal
