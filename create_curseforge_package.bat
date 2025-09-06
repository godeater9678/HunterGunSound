@echo off
setlocal enabledelayedexpansion

echo =======================================
echo CurseForge Package Creator
echo =======================================

:: ?? ???? ??
set SOURCE_DIR=%~dp0
set TEMP_DIR=%SOURCE_DIR%temp_curseforge
set ZIP_NAME=HunterGunSound.zip

:: ?? ????? ???? ??
if exist "%TEMP_DIR%" (
    echo Cleaning up existing temp directory...
    rmdir /s /q "%TEMP_DIR%"
)

:: ?? ???? ??
echo Creating temporary directory...
mkdir "%TEMP_DIR%"

:: ?? ??? ?? ??? ?? ????? ??
echo Copying files to temporary directory...
xcopy "%SOURCE_DIR%*" "%TEMP_DIR%\" /E /I /H /Y

:: ???? ??? ??
if exist "%TEMP_DIR%\.idea" (
    echo Removing .idea folder...
    rmdir /s /q "%TEMP_DIR%\.idea"
)

if exist "%TEMP_DIR%\.git" (
    echo Removing .git folder...
    rmdir /s /q "%TEMP_DIR%\.git"
)

if exist "%TEMP_DIR%\temp_curseforge" (
    echo Removing temp folder...
    rmdir /s /q "%TEMP_DIR%\temp_curseforge"
)

:: ???? ??? ??
if exist "%TEMP_DIR%\.gitignore" (
    echo Removing .gitignore file...
    del /q "%TEMP_DIR%\.gitignore"
)

if exist "%TEMP_DIR%\create_curseforge_package.bat" (
    echo Removing batch files...
    del /q "%TEMP_DIR%\create_curseforge_package.bat"
)

if exist "%TEMP_DIR%\create_curseforge_package.ps1" (
    del /q "%TEMP_DIR%\create_curseforge_package.ps1"
)

if exist "%TEMP_DIR%\*.zip" (
    echo Removing existing zip files...
    del /q "%TEMP_DIR%\*.zip"
)

:: ?? zip ??? ??? ??
if exist "%SOURCE_DIR%%ZIP_NAME%" (
    echo Removing existing zip file...
    del /q "%SOURCE_DIR%%ZIP_NAME%"
)

:: PowerShell? ???? ZIP ?? ??
echo Creating ZIP file...
powershell -Command "Compress-Archive -Path '%TEMP_DIR%\*' -DestinationPath '%SOURCE_DIR%%ZIP_NAME%' -Force"

:: ?? ???? ??
echo Cleaning up temporary directory...
rmdir /s /q "%TEMP_DIR%"

echo =======================================
echo Package created successfully!
echo File: %ZIP_NAME%
echo Location: %SOURCE_DIR%
echo =======================================

:: ??? ZIP ?? ?? ??
if exist "%SOURCE_DIR%%ZIP_NAME%" (
    for %%F in ("%SOURCE_DIR%%ZIP_NAME%") do (
        echo File size: %%~zF bytes
        echo Created: %%~tF
    )
    echo.
    echo Ready for CurseForge upload!
) else (
    echo ERROR: ZIP file was not created!
)

echo.
echo Press any key to exit...
pause >nul
