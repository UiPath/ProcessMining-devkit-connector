@ECHO OFF
SET directory=%~dp0
SET scriptPath=%directory%extractor.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%scriptPath%'";
PAUSE