@echo off
title Deploy the mods to local mod folder

setlocal enabledelayedexpansion

SET SourceFolder=..\src

SET Sins2ModsFolder=%LocalAppData%\sins2\mods


REM Parameters:
REM /E : Copy subdirectories, including empty ones.
REM /R:0 : Number of retries on failed files (0 means no retries).
REM /W:0 : Wait time between retries (0 seconds).
REM /Y : Suppresses prompting to confirm overwriting of existing destination files (though Robocopy usually doesn't prompt anyway).
REM /XD : exclude directories
REM /PURGE : delete dest files/dirs that no longer exist in source

@REM robocopy "%SourceFolder%" "%DestinationFolder%" /E /R:0 /W:0 /PURGE /XD scenarios

for /d %%m in ("%SourceFolder%\*") do (
    echo.
    echo Processing mod : %%~nxm

    set "currentModFolder=%%m"
    set "currentModScenariosFolder=!currentModFolder!\scenarios"

    set "targetModFolder=%Sins2ModsFolder%\%%~nxm"
    set "targetModScenariosFolder=!targetModFolder!\scenarios"

    echo.
    echo Source: !currentModFolder!
    echo Destination: !targetModFolder!

    robocopy !currentModFolder! !targetModFolder! /E /R:0 /W:0 /PURGE /XD scenarios

    if exist !currentModScenariosFolder! (
        echo Creating target scenarios folder: !targetModScenariosFolder!
        mkdir !targetModScenariosFolder!
    )



    for /d %%s in ("%%m\scenarios\*") do (
        echo.
        echo Processing scenario : %%~nxs

        set "currentScenarioFolder=%%s"
        set "targetScenarioFile=!targetModScenariosFolder!\%%~nxs.scenario"


        echo Source: !currentScenarioFolder!
        echo Destination: !targetScenarioFile!


        rem -c: Create new archive
        rem -f: Specify output filename
        rem -C: Change directory to source (zips contents only)
        tar.exe --format zip -c -f !targetScenarioFile! -C !currentScenarioFolder! *



    )
)