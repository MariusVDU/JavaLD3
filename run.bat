@echo off
REM ============================================
REM Prekiu Management System - Paleidimo Skriptas
REM ============================================

echo.
echo ====================================
echo  Prekiu Valdymo Sistema
echo ====================================
echo.

REM Patikrinti Java
echo [1/4] Tikrinamas Java...
java -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [KLAIDA] Java nerasta! Prasome idiegti Java 21 ar naujesne.
    pause
    exit /b 1
)
echo [OK] Java rasta

REM Patikrinti MySQL
echo.
echo [2/4] Tikrinamas MySQL...
mysql --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ISPEJIMAS] MySQL nerasta PATH. Prasome ivykdyti:
    echo    mysql -u root -p ^< database-schema.sql
    echo.
) else (
    echo [OK] MySQL rastas
)

REM Kompiliuoti projekta
echo.
echo [3/4] Kompiliuojamas projektas...
call mvnw.cmd clean compile -q
if %ERRORLEVEL% NEQ 0 (
    echo [KLAIDA] Kompiliavimas nepavyko!
    pause
    exit /b 1
)
echo [OK] Projektas sukompiliuotas

REM Paleisti aplikacija
echo.
echo [4/4] Paleidziama aplikacija...
echo.
echo ====================================
echo  Aplikacija bus prieinama:
echo  http://localhost:8080/
echo ====================================
echo.
echo Spauskite Ctrl+C, kad sustabdyti aplikacija
echo.

call mvnw.cmd spring-boot:run
