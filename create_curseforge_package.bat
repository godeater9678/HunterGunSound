@echo off
echo =======================================
echo CurseForge Package Creator
echo =======================================

:: ?? ?? ?? ??
set TEMP_FOLDER=temp_curseforge_clean
set ADDON_FOLDER=HunterGunSound
set ZIP_FILE=HunterGunSound.zip

:: ?? ??? ??
if exist "%TEMP_FOLDER%" rmdir /s /q "%TEMP_FOLDER%"
if exist "%ZIP_FILE%" del /q "%ZIP_FILE%"

:: ?? ?? ? ??? ?? ??
mkdir "%TEMP_FOLDER%"
mkdir "%TEMP_FOLDER%\%ADDON_FOLDER%"

echo Copying essential addon files only...

:: ??? ?? ???? ?? (HunterGunSound ?? ??)
if exist "HunterGunSound.lua" copy "HunterGunSound.lua" "%TEMP_FOLDER%\%ADDON_FOLDER%\" >nul
if exist "HunterGunSound.toc" copy "HunterGunSound.toc" "%TEMP_FOLDER%\%ADDON_FOLDER%\" >nul
if exist "addon_info.lua" copy "addon_info.lua" "%TEMP_FOLDER%\%ADDON_FOLDER%\" >nul
if exist "README.md" copy "README.md" "%TEMP_FOLDER%\%ADDON_FOLDER%\" >nul
if exist "CURSEFORGE_DESCRIPTION.md" copy "CURSEFORGE_DESCRIPTION.md" "%TEMP_FOLDER%\%ADDON_FOLDER%\" >nul
if exist "SOUND_LICENSES.txt" copy "SOUND_LICENSES.txt" "%TEMP_FOLDER%\%ADDON_FOLDER%\" >nul
if exist "handgun.tga" copy "handgun.tga" "%TEMP_FOLDER%\%ADDON_FOLDER%\" >nul

:: sounds ?? ?? (??? ??? ????)
if exist "sounds" (
    mkdir "%TEMP_FOLDER%\%ADDON_FOLDER%\sounds" >nul 2>&1
    :: backup ??? ?? ?? ???? ??
    for %%f in ("sounds\*.ogg") do (
        echo %%f | find "backup" >nul || copy "%%f" "%TEMP_FOLDER%\%ADDON_FOLDER%\sounds\" >nul
    )
    for %%f in ("sounds\*.OGG") do (
        echo %%f | find "backup" >nul || copy "%%f" "%TEMP_FOLDER%\%ADDON_FOLDER%\sounds\" >nul
    )
    :: _Silence.OGG ??? ??
    if exist "sounds\_Silence.OGG" copy "sounds\_Silence.OGG" "%TEMP_FOLDER%\%ADDON_FOLDER%\sounds\" >nul
)

echo Creating clean ZIP file with HunterGunSound folder structure...

:: PowerShell? ZIP ?? (HunterGunSound ?? ??)
powershell -Command "Compress-Archive -Path '%TEMP_FOLDER%\*' -DestinationPath '%ZIP_FILE%' -Force"

:: ?? ?? ??
rmdir /s /q "%TEMP_FOLDER%"

echo =======================================
echo CurseForge package created successfully!
echo File: %ZIP_FILE%
echo Structure: HunterGunSound\ (folder containing all addon files)
echo =======================================
echo Ready for CurseForge upload!

echo.
echo Press any key to exit...
pause >nul
