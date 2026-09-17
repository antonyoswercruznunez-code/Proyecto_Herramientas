@echo off
setlocal
cd /d "%~dp0"
title Mundo Pet - Sistema V42 Corregido

echo ==============================================
echo       MUNDO PET - INICIAR SISTEMA
echo ==============================================

where node >nul 2>&1
if errorlevel 1 (
  echo ERROR: Node.js no esta instalado o no esta en PATH.
  pause
  exit /b 1
)

if not exist ".env" (
  echo ERROR: Falta el archivo .env en esta carpeta.
  echo Copia tu .env anterior aqui y vuelve a ejecutar.
  pause
  exit /b 1
)

powershell -NoProfile -Command "if (Test-NetConnection 127.0.0.1 -Port 3306 -InformationLevel Quiet) { exit 0 } else { exit 1 }"
if errorlevel 1 (
  echo ERROR: MySQL no esta encendido en el puerto 3306.
  echo Abre XAMPP y presiona Start en MySQL.
  if exist "C:\xampp\xampp-control.exe" start "" "C:\xampp\xampp-control.exe"
  pause
  exit /b 1
)

node -e "for(const m of ['dotenv','nodemailer','express','mysql2','helmet','multer','sharp','bcrypt']){require(m)}; console.log('Dependencias OK')"
if errorlevel 1 (
  echo ERROR: Las dependencias incluidas no se pudieron cargar.
  pause
  exit /b 1
)

echo.
echo Iniciando sistema en http://localhost:3000/login
echo Para detenerlo presiona Ctrl+C.
echo.
node app.js
pause
