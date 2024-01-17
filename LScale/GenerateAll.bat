echo off

cls
echo *************               *************
echo *************  L S C A L E  *************
echo *************               *************
echo .

	Rem Bepaal de actieve program files directory, deze verschilt op Windows 64 machines
	
	if "%ProgramFiles(x86)%"=="" (
		Echo LSCALE requires an x64 platform
		GoTo End
	) 
	Rem Verwerk de meegegeven parameter die bepaalt welke exe gebruikt moet worden
	Set GeoDmsRunPath="%ProgramFiles%\ObjectVision\GeoDms%1%\GeoDmsRun.exe"
	if "%1"=="" Set GeoDmsRunPath="%ProgramFiles%\ObjectVision\GeoDms7130\GeoDmsRun.exe"
	IF "%1" == "D64" Set GeoDmsRunPath="C:\dev\GeoDms\bin\Debug\x64\GeoDmsRun.exe"
	IF "%1" == "R64" Set GeoDmsRunPath="C:\dev\GeoDms\bin\Release\x64\GeoDmsRun.exe"

	Rem zet directories op basis van inhoud config.ini / default waarden
	Rem Lees de LocalDataDir uit de registry en zet de waarde als environment variable
	:: delims is a TAB followed by a space
	SET ProjDir=%CD%
	ECHO ProjDir=%ProjDir%
	
	FOR /F "tokens=2* delims=	 " %%A IN ('REG QUERY "HKCU\Software\ObjectVision\DMS" /v LocalDataDir') DO SET LocalDataDir=%%B
	ECHO LocalDataDir=%LocalDataDir%
	

	for /f "delims==" %%F in ("%ProjDir%") do set ProjName=%%~nF
	echo ProjName=%ProjName%

	SET LocalDataProjDir=%LocalDataDir%\%ProjName%
	echo LocalDataProjDir=%LocalDataProjDir%
	If EXIST "%LocalDataProjDir%" rename "%LocalDataProjDir%" "old_%ProjName%_%date:/=-%_%time::=-%"

	Set ResultsDir=%ProjDir%\results
	Set LogFileDir=%ResultsDir%\log

	If EXIST "%ResultsDir%" rename "%ResultsDir%" "old_results_%date:/=-%_%time::=-%"
	md "%ResultsDir%"
	If NOT EXIST "%LogFileDir%" md "%LogFileDir%"

	Set LogFileName=temp.txt
	Set LogFilePath=%LogFileDir%\%LogFileName%
	Set GeoDmsLogFilePath=%LogFileDir%\GeoDmsTemp.txt
	
	If EXIST "%LogFilePath%" del "%LogFilePath%"
	If EXIST "%GeoDmsLogFilePath%" del "%GeoDmsLogFilePath%"

	Echo Start Logging > %LogFilePath%

	Set GeoDmdRunCmdBase=%GeoDmsRunPath% /L%GeoDmsLogFilePath%

	Set RegrResult=OK
	
	echo %GeoDmdRunCmdBase% cfg/stam.dms /GenerateFiles
	%GeoDmdRunCmdBase% cfg/stam.dms /GenerateFiles

	if not errorlevel 1 (Echo *** %1 OK ) Else (
		Set RegrResult=FAILED
 		Echo !!! %1 FAILED
		Echo !!! %1 FAILED >> %LogFilePath%
		type %GeoDmsLogFilePath% >> %LogFilePath%
	)

	Echo End Logging >> %LogFilePath%
	SET LogFileFinalName=v%1_%RegrResult%_%date:/=-%_%time::=-%.txt
	RENAME "%LogFilePath%" "%LogFileFinalName%"
	Echo Log Information written to "%LogFileDir%\%LogFileFinalName%"
	
	IF not %RegrResult% == OK (
		"%ProgramFiles(86)%\Crimson Editor\cedt.exe" "%LogFileDir%\%LogFileFinalName%"
	)

: End
echo .
echo Einde.
pause