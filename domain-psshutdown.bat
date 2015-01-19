@echo Script d'extinction + log avec timestamp

Rem Create FileName with datatime 
:: this is Regional settings dependent so tweak this according your current settings
echo %DATE% %Time%
for /f "tokens=1-8 delims=::./ " %%A in ('echo %DATE% %TIME%') do set  FileDateTime=%%C-%%B-%%A
echo FileDateTime IS %FileDateTime%
@echo  sd-%filedatetime%_shutdown.txt
echo Extinction des Postes > sd-%FileDateTime%-shutdown.txt

REM Get all Computers from an OU
dsquery computer "OU=College,DC=STJ,DC=LAN" -o rdn -limit 1000 > machines.txt
REM Remove all quotes
for /f "usebackq tokens=*" %%a in ("machines.txt") do echo:%%~a>> machine.txt
REM Loop
for /f %%i in (machine.txt) do (
psshutdown -accepteula -s -t 60 -f -c -m "Attention - Extinction de ce poste dans 60 secondes..." -e u:00:00 \\%%i 1>>sd-%FileDateTime%-shutdown.txt 2>&1
)
del /f machine.txt
del /f machines.txt
