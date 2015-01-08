@ECHO OFF
REM Get all Computers from an OU - Lister les ordinateurs dans une OU precice
dsquery computer "OU=College,DC=STJ,DC=LAN" -o rdn -limit 1000 > machines.txt
REM Remove all quotes - Supprimer les guillemets
for /f "usebackq tokens=*" %%a in ("machines.txt") do echo:%%~a>> machine.txt
REM Loop - Debut de la boucle
for /f %%i in (machine.txt) do (
psshutdown -accepteula -s -t 60 -f -c -m "Attention - Extinction de ce poste dans 60 secondes..." -e u:00:00 \\%%i 1>SDlog.txt 2>&1
)
REM Deletion of computers list - Suppression des liste de postes 
del /f machine.txt
del /f machines.txt
