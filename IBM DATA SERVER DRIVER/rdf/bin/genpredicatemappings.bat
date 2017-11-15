@ECHO OFF
SETLOCAL

SET RDF_BIN=%~dp0

call "%RDF_BIN%"\\setUp.bat

java com.ibm.rdf.store.cmd.GeneratePredicateMappings %*

ENDLOCAL