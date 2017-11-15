@setlocal enableextensions enabledelayedexpansion
@echo off 

REM @copyright(external)
REM Licensed Materials - Property of IBM
REM (c) Copyright IBM Corp. 2013.   All Rights Reserved.

REM US Government Users Restricted Rights
REM Use, duplication or disclosure restricted by GSA ADP Schedule
REM Contract with IBM Corporation.

REM IBM grants you ("Licensee") a non-exclusive, royalty free, license to use,
REM copy and redistribute the Non-Sample Header file software in source and binary code form,
REM provided that i) this copyright notice, license and disclaimer  appear on all copies of
REM the software; and ii) Licensee does not utilize the software in a manner
REM which is disparaging to IBM.


REM This software is provided "AS IS."  IBM and its Suppliers and Licensors expressly disclaim all warranties, whether  EXPRESS OR IMPLIED,
REM INCLUDING ANY IMPLIED WARRANTY OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR WARRANTY OF  NON-INFRINGEMENT.  IBM AND ITS SUPPLIERS AND  LICENSORS SHALL NOT BE LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE THAT RESULT FROM USE OR DISTRIBUTION OF THE SOFTWARE OR THE COMBINATION OF THE SOFTWARE WITH ANY OTHER CODE.  IN NO EVENT WILL IBM OR ITS SUPPLIERS  AND LICENSORS BE LIABLE FOR ANY LOST REVENUE, PROFIT OR DATA, OR FOR DIRECT, INDIRECT, SPECIAL, CONSEQUENTIAL, INCIDENTAL OR PUNITIVE DAMAGES, HOWEVER CAUSED AND REGARDLESS OF THE THEORY OF LIABILITY, ARISING OUT OF THE USE OF OR INABILITY TO USE SOFTWARE, EVEN IF IBM HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

REM @endCopyright

SET USER=
SET HOSTNAME=localhost
SET PORT=50000
SET DB=
SET PASSWORD=
SET SETUP=
SET URL=

echo JSON Command Shell Setup and Launcher.
echo This batch script assumes your JRE is 1.5 and higher. 1.6 will mask your password.
echo db2nosql.bat is launched with several options.
echo ************************************************************************
echo EACH OPTION DELIMITED BY ONE WHITESPACE. DO NOT ADD EXTRA WHITESPACES.
echo ************************************************************************

SET ARGV=.%*
CALL :PARSE_ARGV
IF ERRORLEVEL 1 (
  ECHO Cannot parse arguments
  ENDLOCAL
  EXIT /B 1
)

 
CALL :GETARGS 1 !ARGC! ARGS
 

FOR /L %%I IN (1,1,!ARGC!) DO (
  CALL :GETARG %%I ARGI
  set /a next=%%I+1
  
  CALL :GETARG !NEXT! ARGN
  
  if "!ARGI!"=="-help" (
     
      goto :help
  )

  if "!ARGI!"=="-user" (
    
    if NOT "!user!"=="" (
      echo Please enter only one -user.
      EXIT /B 0    
    )
    
    if !ARGN! NEQ [] ( 
       SET USER=!ARGN!
 
    )

  )
  if "!ARGI!"=="-hostname" (
  
    if NOT "!HOSTNAME!"=="localhost" (
       echo Please enter only one -hostname.
       EXIT /B 0       
    )

    if !ARGN! NEQ [] ( 
       SET HOSTNAME=!ARGN!
 
    )

  )
    if "!ARGI!"=="-hostName" (
  
    if NOT "!HOSTNAME!"=="localhost" (
       echo Please enter only one -hostname.
       EXIT /B 0       
    )

    if !ARGN! NEQ [] ( 
       SET HOSTNAME=!ARGN!
 
    )

  )
  if "!ARGI!"=="-port" (

     if NOT "!PORT!"=="50000" (
       echo Please enter only one -port.
       EXIT /B 0    
     )
     
    if !ARGN! NEQ [] ( 
       SET PORT=!ARGN!
 
    )

  )

  if "!ARGI!"=="-db" (

    if NOT "!DB!"=="" (
       echo Please enter only one -db.
       EXIT /B 0    
     )
     
    if !ARGN! NEQ [] ( 
       SET DB=!ARGN!
 
    )
    
   
  )

 if "!ARGI!"=="-setup" (

     if NOT "!SETUP!"=="" (
       echo Please enter only one -setup.
       EXIT /B 0    
     )
     
    if !ARGN! NEQ [] ( 
       SET SETUP=!ARGN!
 
    )

  )

 if "!ARGI!"=="-password" (

     if NOT "!PASSWORD!"=="" (
       echo Please enter only one -password.
       EXIT /B 0    
     )
     
    if !ARGN! NEQ [] ( 
       SET PASSWORD=!ARGN!
 
    )

  )

 if "!ARGI!"=="-url" (

    if NOT "!URL!"=="" (
       echo Please enter only one -url.
       EXIT /B 0    
    )
     
    if !ARGN! NEQ [] ( 
       SET URL=!ARGN!
 
    )

  )

)


if "%DB%"=="" (
   if "%URL%"=="" (
    set /p DB=Enter DB:
   )
)



if "%DB%"=="" (
   if "%URL%"=="" (
   goto :error
   )
)
 

if "%SETUP%" EQU "enable" goto setup
if "%SETUP%" EQU "disable"  goto remove
if "%SETUP%" EQU "migrate"  goto migrate

goto shell


:setup

  IF NOT "%URL%"=="" (
     IF "%PASSWORD%"=="" (
       goto autherror
     )
     IF "%USER%"=="" (
       goto autherror
     )
     
     java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url %URL%  --user %USER% --password %PASSWORD% --enable true
    
     goto :end
  )

  IF "%PASSWORD%"=="" (
         IF "%USER%"=="" (
           java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url jdbc:db2:%DB% --enable true
         ) ELSE (
           java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url jdbc:db2://%HOSTNAME%:%PORT%/%DB%  --user %USER% --enable true
	 )
  ) ELSE (
    java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url jdbc:db2://%HOSTNAME%:%PORT%/%DB%  --user %USER% --password %PASSWORD% --enable true
  )
goto end


:remove
 
  IF NOT "%URL%"=="" (
     IF "%PASSWORD%"=="" (
       goto autherror
     )
     IF "%USER%"=="" (
       goto autherror
     )
     
     java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url "%URL%"  --user %USER% --password %PASSWORD% --disable true
    
     goto end
  )  


  IF "%PASSWORD%"=="" (
         IF "%USER%"=="" (
           java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url jdbc:db2:%DB% --disable true
         ) ELSE (
           java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url jdbc:db2://%HOSTNAME%:%PORT%/%DB%  --user %USER% --disable true
	 )
  ) ELSE (
    java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url jdbc:db2://%HOSTNAME%:%PORT%/%DB%  --user %USER% --password %PASSWORD% --disable true
  )
goto end

:migrate

  IF NOT "%URL%"=="" (
     IF "%PASSWORD%"=="" (
       goto autherror
     )
     IF "%USER%"=="" (
       goto autherror
     )
     
     java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url %URL%  --user %USER% --password %PASSWORD% --migrate true
    
     goto :end
  )

  IF "%PASSWORD%"=="" (
         IF "%USER%"=="" (
           java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url jdbc:db2:%DB% --migrate true
         ) ELSE (
           java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url jdbc:db2://%HOSTNAME%:%PORT%/%DB%  --user %USER% --migrate true
	 )
  ) ELSE (
    java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url jdbc:db2://%HOSTNAME%:%PORT%/%DB%  --user %USER% --password %PASSWORD% --migrate true
  )
goto end

:shell

  IF NOT "%URL%"=="" (
     IF "%PASSWORD%"=="" (
       goto autherror
     )
     IF "%USER%"=="" (
       goto autherror
     )
     
     java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url %URL%  --user %USER% --password %PASSWORD%
    
     goto end
  ) 
  
  IF "%PASSWORD%"=="" (
         IF "%USER%"=="" (
           java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url jdbc:db2:%DB%
         ) ELSE (
           java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url jdbc:db2://%HOSTNAME%:%PORT%/%DB%  --user %USER%
	 )
  ) ELSE (
    java.exe -cp "..\..\tools\jline-0.9.93.jar;..\lib\nosqljson.jar;..\lib\js.jar;..\lib\mongo-2.8.0.jar;%CLASSPATH%" com.ibm.nosql.json.cmd.NoSqlCmdLine  --url jdbc:db2://%HOSTNAME%:%PORT%/%DB%  --user %USER% --password %PASSWORD%
  )
  
goto end

ENDLOCAL
EXIT /B 0




:GETARG
  SET %2=!ARG%1!
  SET %2_=!ARG%1_!
  SET %2Q=!ARG%1Q!
  EXIT /B 0

:GETARGS
  SET %3=
  FOR /L %%I IN (%1,1,%2) DO (
    IF %%I == %1 (
      SET %3=!ARG%%I!
    ) ELSE (
      SET %3=!%3! !ARG%%I!
    )
  )
  EXIT /B 0

:PARSE_ARGV
  SET PARSE_ARGV_ARG=[]
  SET PARSE_ARGV_END=FALSE
  SET PARSE_ARGV_INSIDE_QUOTES=FALSE
  SET /A ARGC = 0
  SET /A PARSE_ARGV_INDEX=1
  :PARSE_ARGV_LOOP
  CALL :PARSE_ARGV_CHAR !PARSE_ARGV_INDEX! "%%ARGV:~!PARSE_ARGV_INDEX!,1%%"
  IF ERRORLEVEL 1 (
    EXIT /B 1
  )
  IF !PARSE_ARGV_END! == TRUE (
    EXIT /B 0
  )
  SET /A PARSE_ARGV_INDEX=!PARSE_ARGV_INDEX! + 1
  GOTO :PARSE_ARGV_LOOP

  :PARSE_ARGV_CHAR
    IF ^%~2 == ^" (
      SET PARSE_ARGV_END=FALSE
      SET PARSE_ARGV_ARG=.%PARSE_ARGV_ARG:~1,-1%%~2.
      IF !PARSE_ARGV_INSIDE_QUOTES! == TRUE (
        SET PARSE_ARGV_INSIDE_QUOTES=FALSE
      ) ELSE (
        SET PARSE_ARGV_INSIDE_QUOTES=TRUE
      )
      EXIT /B 0
    )
    IF %2 == "" (
      IF !PARSE_ARGV_INSIDE_QUOTES! == TRUE (
        EXIT /B 1
      )
      SET PARSE_ARGV_END=TRUE
    ) ELSE IF NOT "%~2!PARSE_ARGV_INSIDE_QUOTES!" == " FALSE" (
      SET PARSE_ARGV_ARG=[%PARSE_ARGV_ARG:~1,-1%%~2]
      EXIT /B 0
    )
    IF NOT !PARSE_ARGV_INDEX! == 1 (
      SET /A ARGC = !ARGC! + 1
      SET ARG!ARGC!=%PARSE_ARGV_ARG:~1,-1%
      IF ^%PARSE_ARGV_ARG:~1,1% == ^" (
        SET ARG!ARGC!_=%PARSE_ARGV_ARG:~2,-2%
        SET ARG!ARGC!Q=%PARSE_ARGV_ARG:~1,-1%
      ) ELSE (
        SET ARG!ARGC!_=%PARSE_ARGV_ARG:~1,-1%
        SET ARG!ARGC!Q="%PARSE_ARGV_ARG:~1,-1%"
      )
      SET PARSE_ARGV_ARG=[]
      SET PARSE_ARGV_INSIDE_QUOTES=FALSE
    )
    EXIT /B 0

:error
echo **************************************************
echo URL and DB cannot both be empty
echo **************************************************
goto :help

:autherror
echo **************************************************
echo -user and -password must be provided when -url is used
echo **************************************************
goto :help

:doubleerror
echo **************************************************
echo Please provide only one instance of each -<option>
echo **************************************************
goto :help


:help
echo db2nosql.bat is used with the following options:
echo -help will print out help
echo -user username , if not provided, we will use a Type 2 JDBC connection (uses OS username/password)
echo -hostname host URL, if not provided, default is localhost
echo -port  port for db, if not provided, default 50000
echo -db database Name, if not provided,  command line will prompt
echo -password password for db and user, if not provided, command line will prompt
echo -setup enable/disable/migrate, enable creates artifacts, disable removes them, migrate migrates artifacts from previous releases (against DB2 LUW only)
echo -url <T4 JDBC URL>, full jdbc url with options. If using -url, -db, -port, and -hostname will be ignored
echo Example: db2nosql.bat -user bob -hostName bob.bobhome.com -port 23023 -db bobdb -setup enable -password mypassword
echo Example: db2nosql.bat -user bob -url jdbc:db2://bob.bobhome.com:50000/mydb:traceLevel=ALL;traceFile=C:/jcctrace.txt; -setup enable -password mypassword


 
:end
