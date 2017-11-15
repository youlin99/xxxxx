@ECHO OFF
SETLOCAL

SET RDF_BIN=%~dp0

SET RDF_JAR="file:///%RDF_BIN%../lib/db2rdf.jar"

SET UDF_CALL=CALL sqlj.install_jar('%RDF_JAR%','DB2RDFJAR') 

set db2clp=1

db2 connect to %1 user %2

db2 %UDF_CALL%

ENDLOCAL
