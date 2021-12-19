@echo off

:======================================================================================================================================================
:Thanks to s1ave77 - Original Author of Digital License Generation without KMS or predecessor install/upgrade
:Thanks to rpo for the Great and Continued help in improving this script.
:======================================================================================================================================================

::===========================================================================
fsutil dirty query %systemdrive%  >nul 2>&1 || (
echo ==== ERROR ====
echo This script require administrator privileges.
echo To do so, right click on this script and select 'Run as administrator'
echo.
echo Press any key to exit...
pause >nul
exit
)
::===========================================================================

color 1F
mode con cols=98 lines=30
title W10 Digital License Activation Script v7.0
setlocal EnableExtensions EnableDelayedExpansion
pushd "%~dp0"
cd /d "%~dp0"

:======================================================================================================================================================
:MAINMENU
cls
mode con cols=98 lines=30
FOR /F "TOKENS=2 DELIMS==" %%A IN ('"WMIC PATH SoftwareLicensingProduct WHERE (Name LIKE 'Windows%%' AND PartialProductKey is not NULL) GET LicenseFamily /VALUE"') DO IF NOT ERRORLEVEL 1 SET "osedition=%%A"
IF NOT DEFINED osedition (
cls
FOR /F "TOKENS=3 DELIMS=: " %%A IN ('DISM /English /Online /Get-CurrentEdition 2^>nul ^| FIND /I "Current Edition :"') DO SET "osedition=%%A"
echo        ==================================================================================
echo            No Product Key Found, Incorrect Windows Edition May Be Detected, If that's 
echo                   the Case then Use  "Change the windows 10 Edition" Option.
echo        ==================================================================================
echo.
pause
) 
cls   
echo.      
echo.                 
echo.                     _________________________________________________________
echo.                    ^|                                                         ^|
Echo.                    ^|   [1] Read Me                                           ^|
Echo.                    ^|                                                         ^|
Echo.                    ^|   [2] Activate Windows 10 with Digital License          ^|  
Echo.                    ^|                                                         ^|
Echo.                    ^|   [3] Check Windows Activation Status                   ^|
Echo.                    ^|                   _______________                       ^|
echo.                    ^|                                                         ^| 
Echo.                    ^|   [4] Insert The Product Key                            ^|
Echo.                    ^|                                                         ^|
Echo.                    ^|   [5] Change the windows 10 Edition                     ^|
Echo.                    ^|                                                         ^|
Echo.                    ^|   [6] Extract $OEM$ Folder To Desktop                   ^|
Echo.                    ^|                   _______________                       ^|
echo.                    ^|                                                         ^|  
Echo.                    ^|   [7] Check For Script Updates                          ^|
Echo.                    ^|                                                         ^|
Echo.                    ^|   [8] Exit                                              ^|
Echo.                    ^|_________________________________________________________^|
ECHO.            
choice /C:12345678 /N /M ".                    Enter Your Choice [1,2,3,4,5,6,7,8] : "
if errorlevel 8 goto:Exit
if errorlevel 7 goto:CheckForUpdates
if errorlevel 6 goto:Extract
if errorlevel 5 goto:EditionChange
if errorlevel 4 goto:InsertProductKey
if errorlevel 3 goto:Check
if errorlevel 2 goto:HWIDActivate
if errorlevel 1 goto:ReadMe

:======================================================================================================================================================
:ReadMe
cls
mode con cols=98 lines=130

call :create_file  %0 "%TEMP%\ReadMe.txt" "REM ReadMe Start" "REM ReadMe End"
goto :TempReadMe
REM ReadMe Start
 ===============================================================================================
 
 # About:                                                                                      
                                                                                               
 - W10 Digital License Activation Script                                                       
   Activate the Windows 10 permanently with digital License.                                                                                
                                                                                               
 ===============================================================================================
 
 # Remarks:                                                                                    
                                                                                               
 - This script does not install any files in your system.                                      
                                                                                               
 - For Successful Instant Activation,The Windows Update Service and Internet Must be Enabled.  
   If you are running it anyway then system will auto-activate later when you enable the       
   Windows update service and Internet.                                                        
                                                                                               
 - Use of VPN, and privacy, anti spy tools, privacy-based hosts and firewall's rules           
   may cause (due to blocking of some MS servers) problems in successful Activation.           
                                                                                               
 - You may see an Error about 'Blocked key' or other errors in activation process. 
   Note that reasons behind these errors are either above mentioned reasons or corrupt 
   system files or rarely MS server problem.   
   'Blocked key' error appears because system couldn't contact MS servers for activation,  
   This script activation process actually doesn't use any Blocked Keys.
                                                                                               
 - In same hardware, after activation, if user reinstall the same windows edition then         
   'Retail (Consumer)' version of Windows 10 will auto activate at first online contact, but                                                                                              
   in case of 'VL (Business)' version of Windows 10, User will have to insert that windows     
   edition product key to activate the system. You can insert the product key manually           
   or you can use tool's option "Insert Product key".It saves the Activation process.   
                                                                                               
 ===============================================================================================
 
 # Windows 10 Preactivate:                                                                     
                                                                                               
 - To preactivate the system during installation,Do the following things.                      
   Use option No. 6 in script and extract the $OEM$ Folder to Desktop. Now copy this $OEM$     
   Folder to "sources" folder in the installation media.                                       
   The directory will appear like this. iso/usb: \sources\$OEM$\                               
   Now use this iso/usb to install Windows 10 and it'll auto activate at first online contact. 
                                                                                               
 ===============================================================================================

 # Fix Tip:
 
  If you having activation errors, try to rebuild licensing Tokens.dat as suggested:
  https://support.microsoft.com/en-us/help/2736303

  launch command prompt as admin and execute these commands respectively:
  net stop sppsvc
  ren %windir%\System32\spp\store\2.0\tokens.dat tokens.bar
  net start sppsvc
  cscript %windir%\system32\slmgr.vbs /rilc

  then restart the system twice,
  afterwards, run the script to activate.
																						   
 ===============================================================================================
 
 # Supported Windows 10 Editions:                                                              
                                                                                               
 Core (Home) and (N)                                                                           
 CoreSingleLanguage and (N)                                                                    
 Professional and (N)                                                                          
 ProfessionalEducation and (N)                                                                 
 ProfessionalWorkstation and (N)                                                               
 Education and (N)                                                                             
 Enterprise and (N)                                                                            
 EnterpriseS (LTSB) 2016 and (N)                                                               
                                                                                               
 (This activator does not support Windows 10 1507 version)                                     
                                                                                               
 ===============================================================================================
 
 # Credits:                                                                                    
                                                                                               
 s1ave77       - Original Author of Digital License Generation without KMS or predecessor      
                 install/upgrade                                                               
                                                                                               
 mephistooo2   - Repacking s1ave77's earlier cmd version in 'KMS-Digital-Activation_Suite'     
                                                                                               
 WindowsAddict - Repacking mephistooo2's Repack to make a clean, separate, and improved        
                 W10 Digital License Activation Script                                         
                                                                                               
 rpo           - Providing Great support in correction and improvements in this script               
                                                                                               
 ===============================================================================================
 
 # Homepages:                                                                                   
	
 W10 Digital License Activation Script __ W10 LTSB 2015 Digital License Activation Script 
 https://www.nsaneforums.com/topic/316668-w10-digital-license-activation-script/  
 
 Online KMS Activation Script
 https://www.nsaneforums.com/topic/318518-online-kms-activation-script/
 
 Digital + KMS Preactivation Script
 https://www.nsaneforums.com/topic/318518-online-kms-activation-script-v40/?page=3&tab=comments#comment-1358422    
 
 ===============================================================================================
 
REM ReadMe End

:TempReadMe
type "%temp%\ReadMe.txt"
echo.
echo.
echo Press any key to continue...
pause >nul
del /f /q "%temp%\ReadMe.txt"
goto:MAINMENU

:======================================================================================================================================================
:HWIDActivate
cls
echo    ==========================================================================================
echo     Note: For Successful Activation, The Windows Update Service and Internet Must be Enabled.
echo    ==========================================================================================
echo.
choice /C:GC /N /M "[C] Continue To Activation [G] Go Back : "
        if %errorlevel%==1 Goto:MainMenu
		cls
::===========================================================
CLS
wmic path SoftwareLicensingProduct where (LicenseStatus='1' and GracePeriodRemaining='0' and PartialProductKey is not NULL) get Name 2>nul | findstr /i "Windows" 1>nul && (
echo.
echo ==================================================================
echo Checking: Windows 10 %osedition% is Permanently Activated.
echo Activation is not required.
echo ==================================================================
echo.
echo.
choice /C:AG /N /M "[A] I still want to Activate [G] Go Back : "
if errorlevel 2 goto:MainMenu
if errorlevel 1 Goto:continue
)
::===========================================================
:continue
cls
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
echo      =======================================================================================
echo                   Windows 10 %osedition% Digital License Activation
echo      =======================================================================================
echo.

cd /d "%~dp0"
set "gatherosstate=bin\gatherosstate.exe"

echo Installing Default product key for Windows 10 %osedition% ...
cscript /nologo %windir%\system32\slmgr.vbs -ipk %key%

echo Creating registry entries...
reg add "HKLM\SYSTEM\Tokens" /v "Channel" /t REG_SZ /d "Retail" /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Kernel-ProductInfo" /t REG_DWORD /d %sku% /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Security-SPP-GenuineLocalStatus" /t REG_DWORD /d 1 /f

echo Creating GenuineTicket.XML file for Windows 10 %osedition% ...
start /wait "" "%gatherosstate%"
timeout /t 3 >nul 2>&1

echo GenuineTicket.XML file is installing for Windows 10 %osedition% ...
clipup -v -o -altto bin\
cscript /nologo %windir%\system32\slmgr.vbs -ato

echo Deleting registry entries...
reg delete "HKLM\SYSTEM\Tokens" /f
del /f "%temp%\editions"

echo:
echo Press any key to continue...
pause >nul
goto:MainMenu

:======================================================================================================================================================
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

:======================================================================================================================================================
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

:======================================================================================================================================================
:EditionChange
cls
echo ========================================================================================
echo Note: This script can not change 'Core'(Home) to 'Non-Core' Editions.
echo       To do that, Insert 'Pro' Edition Default Product Key VK7JG-NPHTM-C97JM-9MPGT-3V66T
echo       Manually in settings Activation Page, offline.
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
		echo =====================================================================
        echo Changing the Edition to Windows 10 !osedition! edition
        cscript /nologo %windir%\system32\slmgr.vbs -ipk !key!
		echo =====================================================================
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
	
:======================================================================================================================================================
:Extract
cls
mode con cols=98 lines=30
echo     ==================================================================================
echo       Note: This Option Will Create $OEM$ Folder of This Activator on Your Desktop,   
echo             Which You Can Use to Create Preactivated Windows Install. 
echo             For More Info Use ReadMe.
echo     ==================================================================================
echo.
choice /C:GC /N /M "[C] Create $OEM$ Folder [G] Go Back : "
        if %errorlevel%==1 Goto:MainMenu
		cls
echo WScript.Echo WScript.CreateObject^("WScript.Shell"^).SpecialFolders^("Desktop"^) >"%temp%\desktop.vbs"
for /f "tokens=* delims=" %%a in ('cscript //nologo "%temp%\desktop.vbs"') do (set DESKTOPDIR=%%a&del "%temp%\desktop.vbs">nul)
cd /d "%desktopdir%"
IF EXIST $OEM$ (
echo.
echo.
echo               ================================================
echo                 Error - $OEM$ folder was not created because 
echo                      $OEM$ Folder already exists on Desktop.
echo               ================================================
echo. 
echo Press any key to continue...
pause >nul
goto:MAINMENU

) ELSE (
md $OEM$\$$\Setup\Scripts\BIN
cd /d "%~dp0"
copy BIN\gatherosstate.exe "%desktopdir%\$OEM$\$$\Setup\Scripts\BIN"
copy BIN\slc.dll "%desktopdir%\$OEM$\$$\Setup\Scripts\BIN"
)
cd /d "%desktopdir%\$OEM$\$$\Setup\Scripts\"

call :create_file  %0 "%desktopdir%\$OEM$\$$\Setup\Scripts\SetupComplete.cmd" "REM SetupComplete Start" "REM SetupComplete End"
goto :SetupCompleteCreated

REM SetupComplete Start
@Echo off 
pushd "%~dp0"
cd /d "%~dp0"
::===========================================================================
call:key
FOR /F "TOKENS=2 DELIMS==" %%A IN ('"WMIC PATH SoftwareLicensingProduct WHERE (Name LIKE 'Windows%%' AND PartialProductKey is not NULL) GET LicenseFamily /VALUE"') DO IF NOT ERRORLEVEL 1 SET "osedition=%%A"
for /f "tokens=1-4 usebackq" %%a in ("%temp%\editions") do (if ^[%%a^]==^[%osedition%^] (
    set edition=%%a
    set key=%%b
    set sku=%%c
    set editionId=%%d
    goto :parseAndPatch))
echo %osedition% Digital License Activation is Not Supported.
del /f "%temp%\editions"
exit
::===========================================================================
:parseAndPatch
cd /d "%~dp0"
set "gatherosstate=bin\gatherosstate.exe"
cscript /nologo %windir%\system32\slmgr.vbs -ipk %key%
reg add "HKLM\SYSTEM\Tokens" /v "Channel" /t REG_SZ /d "Retail" /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Kernel-ProductInfo" /t REG_DWORD /d %sku% /f
reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Security-SPP-GenuineLocalStatus" /t REG_DWORD /d 1 /f
start /wait "" "%gatherosstate%"
timeout /t 3 >nul 2>&1
clipup -v -o -altto bin\
cscript /nologo %windir%\system32\slmgr.vbs -ato
reg delete "HKLM\SYSTEM\Tokens" /f
del /f "%temp%\editions"
cd %~dp0
rmdir /s /q "%windir%\setup\scripts" >nul 2>&1
exit
::===========================================================================
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
) > "%temp%\editions" &exit /b
::===========================================================================
REM SetupComplete End
:SetupCompleteCreated
cls
echo.
echo.
echo ====================================================
echo $OEM$ folder is successfully created on the Desktop.
echo ====================================================
echo Press any key to continue...
pause >nul
goto:MAINMENU

:======================================================================================================================================================
:CheckForUpdates
start https://www.nsaneforums.com/topic/316668-w10-digital-license-activation-script/
goto:MAINMENU

:======================================================================================================================================================
:Exit
cls
echo.
echo.
echo.
echo.                        ===========================================
echo.                                                                   
echo.                                Thanks to s1ave77 and rpo
echo.                                                                    
echo.                        ===========================================
echo.
echo.
echo Press any key to Exit.
pause > nul
exit

:======================================================================================================================================================
:create_file
(
echo Set objFso = CreateObject^("Scripting.FileSystemObject"^)
echo Set InputFile = objFso.OpenTextFile^("%~1"^)
echo Set OutputFile = objFso.CreateTextFile^("%~2", True^)
echo trigger = False
echo Do Until InputFile.AtEndOfStream
echo line=InputFile.ReadLine
echo If trigger=True Then If line="%~4" Then Exit Do Else OutputFile.WriteLine line
echo If line="%~3" Then trigger=True
echo Loop
echo InputFile.Close
echo OutputFile.close
)>"%temp%\create_file.txt"&cmd /u /c type "%temp%\create_file.txt">"%temp%\create_file.vbs"
"%temp%\create_file.vbs"&del /q "%temp%\create_file.*"&exit /b
:======================================================================================================================================================