@ECHO OFF
SET directory=%~dp0
SET scriptPath=%directory%extraction.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%scriptPath%'";
::Uncomment the following line to debug the extraction script
::PAUSE