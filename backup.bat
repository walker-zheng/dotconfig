set dt=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%

cd %~dp0
md backup
xcopy /i /q *.xml backup/%dt%
