@echo off
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  cmd /u /c echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0""", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
color 1F
title W10 Digital License Activation Script 5
setlocal enabledelayedexpansion
setlocal EnableExtensions
pushd "%~dp0"
cd /d "%~dp0"
::===========================================================
:MAINMENU
cls
FOR /F "TOKENS=2 DELIMS==" %%A IN ('"WMIC PATH SoftwareLicensingProduct WHERE (Name LIKE 'Windows%%' AND PartialProductKey is not NULL) GET LicenseFamily /VALUE"') DO IF NOT ERRORLEVEL 1 SET "osedition=%%A"
IF NOT DEFINED osedition (
cls
FOR /F "TOKENS=3 DELIMS=: " %%A IN ('DISM /English /Online /Get-CurrentEdition 2^>nul ^| FIND /I "Current Edition :"') DO SET "osedition=%%A"
echo        ====================================================================================================
echo            No Product Key Found, Incorrect Windows Edition May Be Detected, If that's the Case then Use 
echo                                   "Change the windows 10 Edition" Option.
echo        ====================================================================================================
echo.
pause
)
for /f "tokens=2 delims==" %%a IN ('"wmic Path Win32_OperatingSystem Get Version /format:LIST"')do (set Version=%%a) >nul 2>&1
cls
echo.                              _________________________________________________________
echo.
echo                                 Windows 10 %osedition% %Version%                      
echo.                              _________________________________________________________
echo.                             ^|                                                         ^|
Echo.                             ^|   [1] Activate Windows 10 with Digital License          ^|
Echo.                             ^|                                                         ^|
Echo.                             ^|   [2] Check Windows Activation Status                   ^|  
Echo.                             ^|                                                         ^|
Echo.                             ^|   [3] -Read Me-                                         ^|
Echo.                             ^|                                                         ^|    
echo.                             ^|                 + Advance Options +                     ^|
echo.                             ^|                                                         ^|
Echo.                             ^|   [4] Insert The Product Key                            ^|
Echo.                             ^|                                                         ^|
Echo.                             ^|   [5] Change the windows 10 Edition                     ^|
Echo.                             ^|                                                         ^|
Echo.                             ^|   [6] Extract $OEM$ Folder To Desktop                   ^|
Echo.                             ^|                   _______________                       ^|
echo.                             ^|                                                         ^|  
Echo.                             ^|   [7] Check For Script Updates                          ^|
Echo.                             ^|                                                         ^|
Echo.                             ^|   [8] Exit                                              ^|
Echo.                             ^|_________________________________________________________^|
ECHO.
choice /C:12345678 /N /M ".                            Enter Your Choice [1,2,3,4,5,6,7,8] : "
if errorlevel 8 goto:Exit
if errorlevel 7 goto:CheckForUpdates
if errorlevel 6 goto:Extract
if errorlevel 5 goto:EditionChange
if errorlevel 4 goto:InsertProductKey
if errorlevel 3 goto:ReadMe
if errorlevel 2 goto:Check
if errorlevel 1 goto:HWIDActivate
::===========================================================
:key
rem              Edition                          Key              SKU EditionId
(
echo Cloud                          V3WVW-N2PV2-CGWC3-34QGF-VMJ2C 178 X21-32983
echo CloudN                         NH9J3-68WK7-6FB93-4K3DF-DJ4F6 179 X21-32987
echo Core                           YTMG3-N6DKC-DKB77-7M9GH-8HVX7 101 X19-98868
echo CoreCountrySpecific            N2434-X9D7W-8PF6X-8DV9T-8TYMD  99 X19-99652
echo CoreN                          4CPRK-NM3K3-X6XXQ-RXX86-WXCHW  98 X19-98877
echo CoreSingleLanguage             BT79Q-G7N6G-PGBYW-4YWX6-6F4BT 100 X19-99661
echo Education                      YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY 121 X19-98886
echo EducationN                     84NGF-MHBT6-FXBX8-QWJK7-DRR8H 122 X19-98892
echo Enterprise                     XGVPP-NMH47-7TTHJ-W3FW7-8HV2C   4 X19-99683
echo EnterpriseN                    3V6Q6-NQXCX-V8YXR-9QCYV-QPFCT  27 X19-98746
echo EnterpriseS                    NK96Y-D9CD8-W44CQ-R8YTK-DYJWX 125 X21-05035
echo EnterpriseSN                   2DBW3-N2PJG-MVHW3-G7TDK-9HKR4 126 X21-04921
echo Professional                   VK7JG-NPHTM-C97JM-9MPGT-3V66T  48 X19-98841
echo ProfessionalEducation          8PTT6-RNW4C-6V7J2-C2D3X-MHBPB 164 X21-04955
echo ProfessionalEducationN         GJTYN-HDMQY-FRR76-HVGC7-QPF8P 165 X21-04956
echo ProfessionalN                  2B87N-8KFHP-DKV6R-Y2C8J-PKCKT  49 X19-98859
echo ProfessionalWorkstation        DXG7C-N36C4-C4HTG-X4T3X-2YV77 161 X21-43626
echo ProfessionalWorkstationN       WYPNQ-8C467-V2W6J-TX4WX-WT2RQ 162 X21-43644
echo ServerRdsh                     NJCF7-PW8QT-3324D-688JX-2YV66 175 X21-41295
) > "%temp%\editions"
goto:eof
::===========================================================
:HWIDActivate
CLS
wmic path SoftwareLicensingProduct where (LicenseStatus='1' and GracePeriodRemaining='0' and PartialProductKey is not NULL) get Name 2>nul | findstr /i "Windows" 1>nul && (
echo.
echo ==================================================================
echo Checking: Windows 10 %osedition% is Permanently Activated.
echo Activation is not required.
echo ==================================================================
echo.
echo Press any key to continue...
pause >nul
goto:MainMenu
)
::===========================================================
cls
echo Windows 10 %osedition% Digital License Activation
call:key
for /f "tokens=1-4 usebackq" %%a in ("%temp%\editions") do (if ^[%%a^]==^[%osedition%^] (
    set edition=%%a
    set key=%%b
    set sku=%%c
    set editionId=%%d
    goto:parseAndPatch))
echo:
echo %osedition% Digital License Activation is Not Supported.
echo:
echo Press any key to continue...
del /f "%temp%\editions"
pause >nul
goto:MainMenu
::===========================================================
:parseAndPatch
cls
echo              =================================================================================================
echo                                 Windows 10 %osedition% Digital License Activation
echo              +++ Note - For Successful Activation, The Windows Update Service and Internet Must be Enabled +++
echo              =================================================================================================
echo.
echo Installing Default product key for Windows 10 %osedition% ...
cscript /nologo %windir%\system32\slmgr.vbs -ipk %key%
wmic path SoftwareLicensingProduct where (LicenseStatus='1' and GracePeriodRemaining='0' and PartialProductKey is not NULL) get Name 2>nul | findstr /i "Windows" 1>nul && (
echo.
echo ==================================================================
echo Checking: Windows 10 %osedition% is Permanently Activated.
echo Activation is not required.
echo ==================================================================
echo.
echo Press any key to continue...
del /f "%temp%\editions"
pause >nul
goto:MainMenu
)
::===========================================================
cd /d "%~dp0"
set "gatherosstate=bin\gatherosstate.exe"
echo Creating registry entries...
reg add "HKLM\SYSTEM\Tokens" /v "Channel" /t REG_SZ /d "Retail" /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Kernel-ProductInfo" /t REG_DWORD /d %sku% /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Security-SPP-GenuineLocalStatus" /t REG_DWORD /d 1 /f
echo Creating GenuineTicket.XML file for Windows 10 %osedition% ...
start /wait "" "%gatherosstate%"
timeout /t 3 >nul 2>&1
echo GenuineTicket.XML file is installing for Windows 10 %osedition% ...
clipup -v -o -altto bin\
echo ===================================================================================
cscript /nologo %windir%\system32\slmgr.vbs -ato
echo ===================================================================================
echo Deleting registry entries...
reg delete "HKLM\SYSTEM\Tokens" /f
del /f "%temp%\editions"
echo:
echo Press any key to continue...
pause >nul
goto:MainMenu
::===========================================================
:Check
CLS
echo ======================================================================
echo.
cscript //nologo %systemroot%\System32\slmgr.vbs /dli
cscript //nologo %systemroot%\System32\slmgr.vbs /xpr
echo.
echo ======================================================================
echo.
echo Press any key to continue...
pause >nul
goto:MainMenu
::===========================================================
:ReadMe
CLS
cd /d "%~dp0"
type ReadMe.txt
echo.
echo.
echo Press any key to continue...
pause >nul
goto:MAINMENU
::===========================================================
:InsertProductKey
CLS
echo:
call:key
for /f "tokens=1-4 usebackq" %%a in ("%temp%\editions") do (if ^[%%a^]==^[%osedition%^] (
    set edition=%%a
    set key=%%b
    set sku=%%c
    set editionId=%%d
    goto :Insertkey))
echo %osedition% Digital License Activation is Not Supported.
echo Press any key to continue...
del /f "%temp%\editions"
pause >nul
goto:MainMenu
:Insertkey
CLS
echo:
echo =============================================================
echo Installing the Product key for Windows 10 %osedition%
echo =============================================================
echo:
cscript /nologo %windir%\system32\slmgr.vbs -ipk %key%
echo:
echo Press any key to continue...
del /f "%temp%\editions"
pause >nul
goto:MAINMENU
::===========================================================
:EditionChange
cls
echo ========================================================================================
echo Note: This script can not change 'Core'(Home) to 'Non-Core' Editions.
echo       To do that, Insert 'Pro' Edition Default Product Key VK7JG-NPHTM-C97JM-9MPGT-3V66T
echo       Manually in settings Activation Page.
echo.
echo ========================================================================================
echo You can change your Current Edition to one of the following :
echo ========================================================================================
echo.
for /f "tokens=4" %%a in ('dism /online /english /Get-TargetEditions ^| findstr /i /c:"Target Edition : "') do echo %%a
echo.
choice /C:GC /N /M "[C] Continue [G] Go Back : "
        if %errorlevel%==1 Goto:MainMenu
Echo.
for /f "tokens=4" %%a in ('dism /online /english /Get-TargetEditions ^| findstr /i /c:"Target Edition : "') do (
    set osedition=%%a
    choice /C:NY /N /M "Do you want to change to the %%a edition? [Y,N] : "
    if errorlevel 2 (
	call:key
        for /f "tokens=1-4 usebackq" %%a in ("%temp%\editions") do (if ^[%%a^]==^[!osedition!^] (
        set edition=%%a
        set key=%%b
		cls
		echo.
		echo.
		echo ====================================================================================================
        echo Changing the !key! key for Windows 10 !osedition! edition
        cscript /nologo %windir%\system32\slmgr.vbs -ipk !key!
		echo ====================================================================================================
		echo. 
		echo Press any key to continue...
		del /f "%temp%\editions"
        pause >nul
        goto :MainMenu))
    echo Digital License Activation is Not Supported.
    echo Press any key to continue...
	del /f "%temp%\editions"
    pause >nul
    goto:MainMenu))
	goto:MainMenu
::===========================================================
:Extract
cls
cd /d "%userprofile%\desktop\"
IF EXIST $OEM$ (
echo.
echo.
echo ===============================================
echo $OEM$ folder already exists on Desktop.
echo ===============================================
echo. 
echo Press any key to continue...
pause >nul
goto:MAINMENU
) ELSE (
md $OEM$\$$\Setup\Scripts\BIN
cd /d "%~dp0"
copy BIN\gatherosstate.exe "%userprofile%\desktop\$OEM$\$$\Setup\Scripts\BIN"
copy BIN\slc.dll "%userprofile%\desktop\$OEM$\$$\Setup\Scripts\BIN"
)
cd /d "%userprofile%\desktop\$OEM$\$$\Setup\Scripts\"
(
echo @Echo off 
echo pushd "%%~dp0"
echo cd /d "%%~dp0"
echo ::===========================================================================
echo rem              Edition                          Key              SKU EditionId
echo ^(
echo echo Cloud                          V3WVW-N2PV2-CGWC3-34QGF-VMJ2C 178 X21-32983
echo echo CloudN                         NH9J3-68WK7-6FB93-4K3DF-DJ4F6 179 X21-32987
echo echo Core                           YTMG3-N6DKC-DKB77-7M9GH-8HVX7 101 X19-98868
echo echo CoreCountrySpecific            N2434-X9D7W-8PF6X-8DV9T-8TYMD  99 X19-99652
echo echo CoreN                          4CPRK-NM3K3-X6XXQ-RXX86-WXCHW  98 X19-98877
echo echo CoreSingleLanguage             BT79Q-G7N6G-PGBYW-4YWX6-6F4BT 100 X19-99661
echo echo Education                      YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY 121 X19-98886
echo echo EducationN                     84NGF-MHBT6-FXBX8-QWJK7-DRR8H 122 X19-98892
echo echo Enterprise                     XGVPP-NMH47-7TTHJ-W3FW7-8HV2C   4 X19-99683
echo echo EnterpriseN                    3V6Q6-NQXCX-V8YXR-9QCYV-QPFCT  27 X19-98746
echo echo EnterpriseS                    NK96Y-D9CD8-W44CQ-R8YTK-DYJWX 125 X21-05035
echo echo EnterpriseSN                   2DBW3-N2PJG-MVHW3-G7TDK-9HKR4 126 X21-04921
echo echo Professional                   VK7JG-NPHTM-C97JM-9MPGT-3V66T  48 X19-98841
echo echo ProfessionalEducation          8PTT6-RNW4C-6V7J2-C2D3X-MHBPB 164 X21-04955
echo echo ProfessionalEducationN         GJTYN-HDMQY-FRR76-HVGC7-QPF8P 165 X21-04956
echo echo ProfessionalN                  2B87N-8KFHP-DKV6R-Y2C8J-PKCKT  49 X19-98859
echo echo ProfessionalWorkstation        DXG7C-N36C4-C4HTG-X4T3X-2YV77 161 X21-43626
echo echo ProfessionalWorkstationN       WYPNQ-8C467-V2W6J-TX4WX-WT2RQ 162 X21-43644
echo echo ServerRdsh                     NJCF7-PW8QT-3324D-688JX-2YV66 175 X21-41295
echo ^) ^> "%%temp%%\editions"
echo ::===========================================================================
echo FOR /F "TOKENS=2 DELIMS==" %%%%A IN ^('"WMIC PATH SoftwareLicensingProduct WHERE (Name LIKE 'Windows%%%%' AND PartialProductKey is not NULL) GET LicenseFamily /VALUE"'^) DO IF NOT ERRORLEVEL 1 SET "osedition=%%%%A"
echo for /f "tokens=1-4 usebackq" %%%%a in ^("%%temp%%\editions"^) do ^(if ^^[%%%%a^^]==^^[%%osedition%%^^] ^(
echo     set edition=%%%%a
echo     set key=%%%%b
echo     set sku=%%%%c
echo     set editionId=%%%%d
echo     goto :parseAndPatch^)^)
echo echo %%osedition%% Digital License Activation is Not Supported.
echo del /f "%%temp%%\editions"
echo exit
echo ::===========================================================================
echo :parseAndPatch
echo cd /d "%%~dp0"
echo set "gatherosstate=bin\gatherosstate.exe"
echo cscript /nologo %%windir%%\system32\slmgr.vbs -ipk %%key%%
echo reg add "HKLM\SYSTEM\Tokens" /v "Channel" /t REG_SZ /d "Retail" /f
echo reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Kernel-ProductInfo" /t REG_DWORD /d %%sku%% /f
echo reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Security-SPP-GenuineLocalStatus" /t REG_DWORD /d 1 /f
echo start /wait "" "%%gatherosstate%%"
echo timeout /t 3 ^>nul 2^>^&1
echo clipup -v -o -altto bin\
echo cscript /nologo %%windir%%\system32\slmgr.vbs -ato
echo reg delete "HKLM\SYSTEM\Tokens" /f
echo del /f "%%temp%%\editions"
echo cd %%~dp0
echo rmdir /s /q "%%windir%%\setup\scripts" ^>nul 2^>^&1
echo exit
echo ::===========================================================================
)^> SetupComplete.cmd
cls
echo.
echo.
echo ====================================================
echo $OEM$ folder is successfully created on the Desktop.
echo ====================================================
echo Press any key to continue...
pause >nul
goto:MAINMENU
::===========================================================
:CheckForUpdates
start https://www.nsaneforums.com/topic/316668-w10-digital-license-activation-script/
goto:MAINMENU
::===========================================================
:Exit
exit
::===========================================================