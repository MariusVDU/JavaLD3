@echo off
REM ============================================
REM Student Management System - Build Script
REM ============================================

echo.
echo ====================================
echo  WAR Failo Kurimas
echo ====================================
echo.

REM Isvalyti sena build
echo [1/3] Valomas target aplankas...
if exist target (
    rmdir /s /q target
)
echo [OK] Target aplankas isvalytas

REM Kompiliuoti projekta
echo.
echo [2/3] Kompiliuojamas projektas...
call mvnw.cmd clean package -DskipTests
if %ERRORLEVEL% NEQ 0 (
    echo [KLAIDA] Kompiliavimas nepavyko!
    pause
    exit /b 1
)
echo [OK] Projektas sukompiliuotas

REM Patikrinti WAR faila
echo.
echo [3/3] Tikrinamas WAR failas...
if exist "target\rest-service-0.0.1-SNAPSHOT.war" (
    echo [OK] WAR failas sukurtas sekmingai!
    echo.
    echo ====================================
    echo  WAR Failas:
    echo  target\rest-service-0.0.1-SNAPSHOT.war
    echo ====================================
    echo.
    echo Dabar galite:
    echo  1. Nukopijuoti i Tomcat webapps:
    echo     copy target\rest-service-0.0.1-SNAPSHOT.war C:\apache-tomcat-10.1\webapps\students.war
    echo.
    echo  2. Arba paleisti su embedded Tomcat:
    echo     mvnw.cmd spring-boot:run
    echo.
) else (
    echo [KLAIDA] WAR failas nerastas!
)

pause
