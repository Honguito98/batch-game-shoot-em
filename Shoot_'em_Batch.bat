:    Shoot 'em Batch: An great example of batch capabiliies using Seta:Dsp, Seta:GPU And Chombie[-_-]
:    Copyright (C) 2012-2017  Honguito98
:
:    This program is free software: you can redistribute it and/or modify
:    it under the terms of the GNU General Public License as published by
:    the Free Software Foundation, either version 3 of the License, or
:    (at your option) any later version.
:
:    This program is distributed in the hope that it will be useful,
:    but WITHOUT ANY WARRANTY; without even the implied warranty of
:    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:    GNU General Public License for more details.
:
:    You should have received a copy of the GNU General Public License
:    along with this program.  If not, see README.TXT
@Echo off
	SetLocal EnableExtensions
	Set ANSICON_EXC=nvd3d9wrap.dll;nvd3d9wrapx.dll
	Set "Path=%comspec:~0,-8%;%comspec:~0,-8%\Wbem"
	Cd "%~dp0"
	Set Fn=Core\Fn.dll
	Title Shoot 'em Batch - Remake By Honguito98
	If /i "%1" Neq "LoadANSI" (
		%Fn% Maximize
		%Fn% Enablem
		Call :Flush
		Set "Game=%~0"
		Mode 80,50
		Echo.Shoot 'em Batch started
		For %%a in (
			""
			"Cheking Computer Specs ..."
			" Running On   : %Os%"
			" UserFolder   : %UserName%"
			" Processor    : %Processor_Identifier%"
			" Architecture : %Processor_Architecture%"
			" Cores        : %Number_Of_Processors%"
			" Level        : %Processor_Level%"
			" Revision     : %Processor_Revision%"
			""
		) Do (%Fn% Sleep 10 & Echo.%%~a)
		If "%Number_Of_Processors%" Lss "2" (
			Echo.ERROR -1: Cannot run on single core!
			Pause>Nul & Exit
		)
		If "%Number_Of_Processors%" Equ "2" (
			Echo.WARNING: May be slow on 2.10GHz or less 
		)
		If "%Number_Of_Processors%" Equ "3" (
			Echo.WARNING: May be slow on 2.20GHz or less 
		)
		If "%Number_Of_Processors%" Equ "4" (
			Echo.WARNING: May be slow on 2.40GHz or less 
		)
		If "%Number_Of_Processors%" Geq "5" (
			Echo.Congratulations! The game may be very faster
		)
		Echo.Loading ANSI Controller...
		Call :Stop
		Del "%Tmp%\StopSetaDSP" >Nul
		%Fn% Sleep 800
		Core\Ansi.dll "%~0" LoadANSI 2>Nul
		If Errorlevel 1 (
			Echo.ERROR 1: ANSI Controller Load Failure
			Pause>Nul & Exit
		)
		Exit
	)
	Echo.ANSI Controller Loaded
	Echo.Loading Data Code ...
	:: -> Setting Up Macros <- ::
	Set Xe=^^!
	:: WARNING! DON'T REMOVE THE NEXT TWO BLANK LINES
	Set LF=^


	Set "Mouse="
	Set "Err=^!Errorlevel^!"
	Set "Sprite=For %%. in (0;1) Do If %%. Equ 1 ("
	Set "Effect=For %%. in (0;1) Do If %%. Equ 1 ("
	Set "Tab="

	For /F "Skip=3 Tokens=1,* Delims=:" %%a in ('Find "@0:" "%Game%"') Do (
	Call Set "Sprite=%%Sprite%%%%b[#LineFeed#]"
	)
	For /F "Skip=3 Tokens=1,* Delims=:" %%a in ('Find "@2:" "%Game%"') Do (
	Call Set "Mouse=%%Mouse%%%%b[#LineFeed#]"
	)
	For /F "Skip=3 Tokens=1,* Delims=:" %%a in ('Find "@3:" "%Game%"') Do (
	Call Set "Effect=%%Effect%%%%b[#LineFeed#]"
	)
	For /F "Skip=3 Tokens=1,* Delims=:" %%a in ('Find "@4:" "%Game%"') Do (
	Call Set "Tab=%%Tab%%%%b[#LineFeed#]"
	)
	:: -> End Of Store Data <- ::
	SetLocal EnableDelayedExpansion
	Set ^"Sprite=!Sprite:[#LineFeed#]=^%LF%%LF%!"
	Set ^"Effect=!Effect:[#LineFeed#]=^%LF%%LF%!"
	Set ^"Mouse=!Mouse:[#LineFeed#]=^%LF%%LF%!"
	Set ^"Tab=!Tab:[#LineFeed#]=^%LF%%LF%!"

	Set "Sprite=!Sprite!) Else Set Args="
	Set "Effect=!Effect!) Else Set Args="
	Set "$Tmp=Core\Tmp"
	Rem Set "Dip=<Nul Set/p="
	Set "Dip=Echo;"
	Set/a X=0,Y=0,Z=0,M=0,K=0
	!Fn! Cursor 0
	Rd /s /q !$Tmp! >Nul 2>&1
	Echo.Program data Loaded...
		For /F "Tokens=*" %%g in ('Type Core\Settings.inf') Do Set "%%~g"
		For %%y in (Logo Intro Gear Shoot Help Score Star Like Triangle Circle Cube) Do Call :Seta_GPU %%y
	Echo.Loading Graphics...
	Set/a FramesCircle=198,FramesCube=234,FramesTriangle=172,FramesShoot=13
	For %%_ in (Circle Cube Triangle) Do (
		Set Count=0
		For /L %%a in (0,!SkipLoadFrame!,!Frames%%_!) do (
			Set/a Count+=1
		)
		Set/a Frames%%_=!Count!
	)
	:: For /L %%c in (1,1,13) Do (
	:: 	For /F "Delims=" %%a in ('Type !$Tmp!\Shoot\[%%c]') Do Rem Set "Shoot[%%c]=!Shoot[%%c]!%%~a"
	:: )
	:: 80 Spaces = 10 tab ::
	:: 10x35 Lines        ::
	For /L %%x in (1,1,350) Do Set "Blank=!Blank!	"
	Set "Blank=[1;1H!Blank!"
	:: -> X.X_C = Figure Color  <- ::
	:: -> X.X_O = Figure Object <- ::
	
	Set S.G_C=[1;32m
	Set S.E_C=[1;37m
	Set S.R_C=[1;31m
	Set S.M_C=[1;35m
	Set C.G_C=[1;37m
	Set C.Y_C=[1;33m
	Set T.B_C=[1;36m
	Set H.Y_C=[1;33m
	Set H.R_C=[1;31m
	Set H.Y_O=Shoot
	Set H.R_O=Shoot
	Set S.G_O=Circle
	Set S.E_O=Circle
	Set S.R_O=Circle
	Set S.M_O=Circle
	Set C.G_O=Cube
	Set C.Y_O=Cube
	Set T.B_O=Triangle

	Set/a "Tmp_=(!Random!*43422/10+15)*4"
	Cmd /cexit !Tmp_!
	Echo.Loading Score Table ...
	:: ONLY FOR VIEW GLITCHES:@Echo off
	If Not Exist Core\Score.dat Call :GenScoreList
	Set "Chx=žÃ½¬±ýîóôöûü÷«		®¯¾Ð"
	Set "Header=.datÿshootÿ'emÿscoreÿdataÿ-ÿfileÿformatÿdevelopedÿbyÿhonguito98"
	For /F "Delims=" %%a in ('type Core\Score.dat') Do Set "Tmp_=%%a"
	Set Tmp_=!Tmp_:%Chx:~0,1%=a!&Set Tmp_=!Tmp_:%Chx:~19,1%=t!
	Set Tmp_=!Tmp_:%Chx:~1,1%=b!&Set Tmp_=!Tmp_:%Chx:~20,1%=u!
	Set Tmp_=!Tmp_:%Chx:~3,1%=c!&Set Tmp_=!Tmp_:%Chx:~18,1%=v!
	Set Tmp_=!Tmp_:%Chx:~2,1%=d!&Set Tmp_=!Tmp_:%Chx:~21,1%=w!
	Set Tmp_=!Tmp_:%Chx:~5,1%=e!&Set Tmp_=!Tmp_:%Chx:~24,1%=x!
	Set Tmp_=!Tmp_:%Chx:~6,1%=f!&Set Tmp_=!Tmp_:%Chx:~22,1%=y!
	Set Tmp_=!Tmp_:%Chx:~4,1%=g!&Set Tmp_=!Tmp_:%Chx:~25,1%=z!
	Set Tmp_=!Tmp_:%Chx:~7,1%=h!& Set Tmp_=!Tmp_:%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~23,1%=1!
	Set Tmp_=!Tmp_:%Chx:~9,1%=i!& Set Tmp_=!Tmp_:%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~26,1%=2!
	Set Tmp_=!Tmp_:%Chx:~10,1%=j!&Set Tmp_=!Tmp_:%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~28,1%=3!
	Set Tmp_=!Tmp_:%Chx:~8,1%=k!& Set Tmp_=!Tmp_:%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~27,1%=4!
	Set Tmp_=!Tmp_:%Chx:~12,1%=l!&Set Tmp_=!Tmp_:%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~29,1%=5!
	Set Tmp_=!Tmp_:%Chx:~11,1%=m!&Set Tmp_=!Tmp_:%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~30,1%=6!
	Set Tmp_=!Tmp_:%Chx:~14,1%=n!&Set Tmp_=!Tmp_:%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~32,1%=7!
	Set Tmp_=!Tmp_:%Chx:~13,1%=p!&Set Tmp_=!Tmp_:%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~33,1%=8!
	Set Tmp_=!Tmp_:%Chx:~15,1%=q!&Set Tmp_=!Tmp_:%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~31,1%=9!
	Set Tmp_=!Tmp_:%Chx:~17,1%=r!&Set Tmp_=!Tmp_:%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~34,1%=0!
	Set Tmp_=!Tmp_:%Chx:~16,1%=s!&Set Tmp_=!Tmp_:%Chx:~43,1%= !
	Set Tmp_=!Tmp_:%Chx:~37,1%=[!&Set Tmp_=!Tmp_:%Chx:~35,1%=]!
	Set Tmp_=!Tmp_:%Chx:~38,1%=.!&Set Tmp_=!Tmp_:%Chx:~40,1%=o!
	Set Tmp_=!Tmp_:%Chx:~44,1%=ÿ!
	Set ^"Tmp_=!Tmp_:%Chx:~39,1%=^%LF%%LF%!"
	:: ONLY FOR VIEW GLITCHES: @Echo on
	Set/a Count=0,OkH=0,MaxOk=26
	Del !$Tmp!\TMP1.tmp >Nul 2>&1
	For /F "Delims=" %%z in ("!Tmp_!") Do (
		Set/a Count+=1
		Set _Tmp=%%z
		Echo;%%z>>!$Tmp!\TMP1.tmp
		If /i "!_Tmp:~0,5!" Equ "/size" Set Size=%%z
		If "%%z" Equ "!Header!" (Set Score[!Count!]=[0;30m&Set/a OkH+=1) Else (
		Set "Score[!Count!]=%%~z"
		)
		For %%x in (!Count!) Do (
			Set "Score[%%x]=!Score[%%x]:<:=[1;37m!"
			Set "Score[%%x]=!Score[%%x]:>:=[0;37m!"
			Set "Score[%%x]=!Score[%%x]:+:=[1;30m!"
		)
	)
	Set Tmp_=
	If !OkH! Lss !MaxOk! Call :GenScoreList
	For /F "Tokens=2 Delims=:" %%a in ("!Size!") Do Set Size=%%a
	For %%S in ("!$Tmp!\TMP1.tmp") Do If "!Size!" Neq "%%~zS" Call :GenScoreList
	Set Scount=!Count!
	Del !$Tmp!\TMP1.tmp >Nul 2>&1
	
	Echo.Loading Seta:DSP @ 0x!=Exitcode!
	Core\Dsp.dll --info Core\Stream.arc >Nul 2>&1 || (
		Echo.ERROR 2: Stream.arc not founded in \Core\
		Pause>Nul
		Exit
	)
	%Fn% Sleep 800
	Set "Dsp=!Tmp!\Seta_DSP.bat"
	For %%# in (
	"Shoot 00.000 00.528"
	"Bomb 01.061 01.512"
	"ShootShock1 01.621 02.301"
	"ShootShock2 02.383 03.016"
	"ShootShock3 03.091 03.667"
	"ShootShock4 03.729 04.514"
	"ShootShock5 04.583 05.006"
	"Boom1 05.058 06.318"
	"Boom2 06.388 08.619"
	"Boom3 08.679 10.798"
	"Boom4 10.885 12.646"
	"ToOutAmmo 12.753 12.963"
	"AmmoCharge 13.037 13.579"
	"OutAmmo 13.682 13.780"
	"Bonus 14.403 14.729"
	"Enter 28.891 29.089"

	"MediumLiveM 14.822 16.016"
	"DangerLiveM 16.135 17.733"
	"OutPriAmmoM 17.858 19.251"
	"OutSecAmmoM 19.368 20.760"
	"MediumLiveF 20.883 22.539"
	"DangerLiveF 22.649 24.304"
	"OutPriAmmoF 24.524 26.387"
	"OutSecAmmoF 26.510 28.668"

	"Intro 30.005 34.535 80.569"
	"GamePlay 81.069 96.419 142.447"
	) Do For /F "Tokens=1-4" %%a in ("%%~#") Do (
		Set "%%a=%%b %%c %%d"
	)
	::Set>Tmp.txt
	Cls & %Dip%[1;34m[0K
	Call :Seta_DSP Intro
	For /L %%# in (486,1,625) Do (
		Type "!$Tmp!\Intro\[%%#]"
		!Fn! Locate 0 0
	)
	:MainMenu
	Set Lives_=
	Set MBar1=+-----------+    +--------------+    +------------+    +------+
	Set MBar2=Ý PLAY GAME Ý    Ý INSTRUCTIONS Ý    Ý HIGH SCORE Ý    Ý EXIT Ý
	Set/a CrdBX=8,LngBar=63,Mines=5,Ammunition=300,Lives=20,Score=0,Counter=0,StatusLive=2,X=1,Y=1
	Set/a CrdBXM=CrdBX+LngBar
	For /L %%a in (1,1,!Lives!) Do Set Lives_=!Lives_!Ý
	Set Seta=[1;32mS[1;33me[1;31mt[1;36ma [1;31mEngine[1;34m
	Set MineR=ÝÝÝÝÝ
	Cls
	%Dip%[30;30H[1;33mBatch Version 1.5 [1;34m
	%Dip%[46;08H           Copyright (C) 2005, Original By Jan Ringos
	%Dip%[47;08H        Copyright (C) 2012-2017 Remake By Honguito98
	%Dip%[48;05H                Built on %Seta%, SoX.exe and ZLIB1
	%Dip%[50;08H                     This remake is freeware[1;1H
	!Fn! Sprite 40 37 08 "+---+\n| \0f |\n+---+"
:Menu
For /L %%# in (0,2,378) Do (
Set Err=0
	%== Anim ==%
	If Not !Counter! Geq 63 (
	Set/a Count2=LngBar-Counter,CrdBX2=CrdBX+LngBar-Counter,Count=Counter
	If !Count! Equ 0 Set Count=1
	If !CrdBX2! Equ 71 Set CrdBX2=70
	For /F "Tokens=1-2" %%a in ("!Counter! !Count!") Do (
	%Dip%[1;30m[36;!CrdBX!H!MBar1:~0,%%a!
	%Dip%[37;!CrdBX2!H!MBar2:~-%%b!
	%Dip%[38;!CrdBX!H!MBar1:~0,%%a!
	Set/a Counter+=4
	))

	%== EXec ==%
	%Dip%[1;1H[1;36m
	Type "!$Tmp!\Logo\Logo_%%#.txt"
	%Mouse%
	If !Y! Geq 35 If !Y! Leq 37 (

		If !X! Geq 8 If !X! Leq 19 (
		If !M! Equ 1 Goto :Play
			%Dip%[1;32m[36;8H!MBar1:~0,13![37;8H!MBar2:~0,13![38;8H!MBar1:~0,13!
			Set Err=1
		)
		If !X! Geq 24 If !X! Leq 38 (
		If !M! Equ 1 Goto :Instructions
			%Dip%[1;34m[36;25H!MBar1:~17,16![37;25H!MBar2:~17,16![38;25H!MBar1:~17,16!
			Set Err=1
		)
		If !X! Geq 44 If !X! Leq 57 (
		If !M! Equ 1 Goto :HighScore
			%Dip%[1;37m[36;45H!MBar1:~37,14![37;45H!MBar2:~37,14![38;45H!MBar1:~37,14!
			Set Err=1
		)
		If !X! Geq 62 If !X! Leq 69 (
		If !M! Equ 1 Goto :Exit
			%Dip%[1;31m[36;63H!MBar1:~55,9![37;63H!MBar2:~55,9![38;63H!MBar1:~55,9!
			Set Err=1
		)
	)
	If !X! Geq 37 If !X! Leq 40 If !Y! Geq 40 If !Y! Leq 42 (
	If !M! Equ 1 Goto :Settings
		!Fn! Sprite 40 37 0e "+---+\n| \0f |\n+---+"

		Set Err=1
	)
	If !Counter! Gtr 63 (
	If !Err! Equ 0 (
	%Dip%[1;30m[36;8H!MBar1![37;8H!MBar2![38;8H!MBar1!
	!Fn! Sprite 40 37 08 "+---+\n| \0f |\n+---+"

	Set Err=0
	))

)
	Goto :Menu
:Instructions
	Cls
	%Effect% Enter
	For %%a in (
	"[1;37m[2;26HINSTRUCTIONS[0;37m"
	"[4;26H    Your goal is to destroy the falling objects"
	"[5;26Hbefore they reach the ground and to survive as long"
	"[6;26Has possible. The longer you survive, the more points"
	"[7;26Hyou will get. You will also get extra points for each"
	"[8;26Hobject destroyed."

	"[10;26H    Use your mouse to aim and fire. Primary button"
	"[11;26Hcontrols the Machine Guns, secondary is Mine Emitor."
	"[12;26HAmmunition informations are shown in the aiming box"
	"[13;26Hand in lower corners of the screen."


	"[16;26H[1;37mHEALTH[0;37m"
	"[17;26H"
	"[18;26H    When an object manages to get to the bottom grid"
	"[19;26Hit will explode decreasing your health. Bonuses and"
	"[20;26Hammo crates do not explode. Your health will increase"
	"[21;26Hevery time you destroy green diamond."
	"[22;26H    Watch your health bellow score indicator."
	
	"[28;3H[1;37mOBJECTS:[1;37m"

	"[30;8HBox & Sphere[0;37m - Easy to destroy (25 pts)."
	"[31;8H[1;30m                 Cause heavy damage."
	"[32;8H[1;35mSmall Sphere[0;37m - Easy to destroy (50 pts)."
	"[33;8H[1;30m                 Cause heavy damage."
	"[34;8H[1;32mArmor[0;37m        - Easy to destroy (200 pts)."
	"[35;8H[1;30m                 Cause heavy damage."
	"[36;8H[1;36mBonus[0;37m        - Easy to destroy (2000 pts)."
	"[37;8H[1;30m                 Cause heavy damage."
	"[38;8H[1;31mMine[0;37m         - Easy to destroy (1000 pts). Cause heavy damage."
	"[39;8H[1;30m                 Detonation destroys nearby objects and collects ammo."
	"[40;8H[1;33mAmmo[0;37m         - Easy to destroy (1000 pts). Cause heavy damage."
	"[41;8H[1;30m                 Carries 80 bullets, may contain extra mine."
	"[1;30m"
	"[45;69H+------+"
	"[46;69HÝ BACK Ý"
	"[47;69H+------+"
	) Do %Dip%%%~a
	:Instructions_
	For /L %%a in (1,2,110) Do (
	%Dip%[1;1H[1;32m
	Type !$Tmp!\Help\[%%a]
	%Mouse%
	If !K! Equ 27 Goto :MainMenu
	If !Y! Geq 44 If !Y! Leq 46 If !X! Geq 68 If !X! Leq 75 (
	If !M! Equ 1 (
		%Effect% Enter
		Goto :MainMenu
	)
		%Dip%[1;31m[45;69H+------+
		%Dip%[46;69HÝ BACK Ý
		%Dip%[47;69H+------+
		Call
	)
	If !Errorlevel! Equ 0 (
		%Dip%[1;30m[45;69H+------+
		%Dip%[46;69HÝ BACK Ý
		%Dip%[47;69H+------+
		Call 
	)
	)
	Goto :Instructions_

:HighScore
	Cls & %Effect% Enter
	::set>tmp.txt
	Set Tmp_=
	For /L %%a in (1,1,37) Do Set "Tmp_=!Tmp_! "
	For %%a in (
	"[1;25H[1;37m          HALL OF FAME"
	""
	"[3;25H[1;30m        The best players"
	""
	"[1;30m"
	"[44;41H+------+"
	"[45;41HÝ BACK Ý"
	"[46;41H+------+"
	""
	"[1;30m"
	"[17;70H+---+[21;70H+---+"
	"[18;70HÝ  Ý[22;70HÝ  Ý"
	"[19;70H+---+[23;70H+---+"
	) Do %Dip%%%~a
	Set/a Vmin=1,Vmax=34
	Call :ScL
	:HighScore_
	For /L %%a in (1,2,105) Do (
	%Dip%[1;1H[1;32m
	Type !$Tmp!\Like\[%%a]
	%Mouse%
	If !K! Equ 27 Goto :MainMenu
	If !Y! Geq 43 If !Y! Leq 45 If !X! Geq 40 If !X! Leq 46 (
		If !M! Equ 1 (
			%Effect% Enter
			Goto :MainMenu
		)
		%Dip%[1;31m[44;41H+------+
		%Dip%[45;41HÝ BACK Ý
		%Dip%[46;41H+------+
		Call
	)
	If !X! Geq 69 If !X! Leq 74 (
		If !Y! Geq 16 If !Y! Leq 18 (
			If !M! Equ 1 Call :ScL -
			Set M=0
			%Dip%[1;33m
			%Dip%[17;70H+---+
			%Dip%[18;70HÝ  Ý
			%Dip%[19;70H+---+
			Call
		)
		If !Y! Geq 20 If !Y! Leq 22 (
			If !M! Equ 1 Call :ScL +
			Set M=0
			%Dip%[1;33m
			%Dip%[21;70H+---+
			%Dip%[22;70HÝ  Ý
			%Dip%[23;70H+---+
			Call
		)
	)
	If !Errorlevel! Equ 0 (
		%Dip%[1;30m[44;41H+------+
		%Dip%[45;41HÝ BACK Ý
		%Dip%[46;41H+------+
		%Dip%[17;70H+---+[21;70H+---+
		%Dip%[18;70HÝ  Ý[22;70HÝ  Ý
		%Dip%[19;70H+---+[23;70H+---+
		Call 
	)
)
	Goto :HighScore_
:ScL [+/-]
	If "%1" Equ "+" If !Vmax! Lss !SCount! Set/a Vmin+=2,Vmax+=2
	If "%1" Equ "-" If !Vmin! Gtr 1 Set/a Vmin-=2,Vmax-=2
	Set Count=7
	For /L %%# in (!Vmin!,1,!Vmax!) Do (
		%Dip%[!Count!;25H[0;30m!Tmp_![!Count!;25H!Score[%%#]!
		Set/a Count+=1
	)
	Goto :Eof
	
:Settings
	Cls
	%Effect% Enter
	:Sett
	For %%a in (
	"[01;51H[1;31mSETTINGS:"
	"[04;46H[1;36m+---------------------------------+"
	"[05;46H[1;36mÝ Frame Skip:[0;37m      ÃÄÄÄÄÄÅÄÄÄÄ´   [1;36mÝ"
	"[06;46H[1;36m+---------------------------------+"
	"[09;46H[1;33m+---------------------------------+"
	"[10;46H[1;33mÝ Game Speed:    [0;37m  ÃÄÄÄÄÄÅÄÄÄÄ´   [1;33mÝ"
	"[11;46H[1;33m+---------------------------------+"
	"[14;46H[1;32m+---------------------------------+"
	"[15;46H[1;32mÝ Voices:[0;37m     ( ) Male ( ) Female[1;32m Ý"
	"[16;46H[1;32m+---------------------------------+"
	

	"[27;03H[1;37mFRAME SKIP:"
	""
	"[29;03H[0;37mSet amount of frames to skip, eg:"
	"[30;03H[0;37mfor need more speed in game..."
	""
	"[32;03H[1;37mGAME SPEED:"
	"[34;03H[0;37mSet amount of gameplay speed."
	"[35;03H[0;37mAdjust it if you have problems."
	""
	"[37;03H[1;37mVOICES:"
	"[38;03H[0;37mSet type of voice."
	"[39;03H[0;37mSome peoples need change this because the voice sound"
	"[40;03H[0;37mis baffling."
	""
	"[05;78H[0;37m!FrameSkip!"
	"[10;77H!GameSpeed!"
	"[45;65H[1;30m+------+"
	"[46;65H[1;30mÝ BACK Ý"
	"[47;65H[1;30m+------+"
	) Do %Dip%%%~a
	Set/a BarxFS=65,BarxAc=64
	For /L %%s in (1,1,!FrameSkip!) Do Set/a BarxFS+=1
	For /L %%s in (0x9FFF,-0xFFF,!GameSpeed!) Do Set/a BarxAc+=1
	%Dip%[0;37m[05;!BarxFS!HÛ[10;!BarxAc!HÛ
	If /i !Gnr! Equ M %Dip%[0;37m[15;61H*
	If /i !Gnr! Equ F %Dip%[0;37m[15;70H*
	:Settings_
For /L %%# in (1,1,3) Do (
	%Dip%[1;1H[1;30m
	Type !$Tmp!\Gear\[%%#]
	%Mouse%
	If !X! Geq 65 If !X! Leq 74 If !M! Equ 1 (
		If !Y! Equ 4 (
			Set/a FrameSkip=0,M=0
			For /L %%a in (65,1,!X!) Do Set/a FrameSkip+=1
			Goto :Sett
		)
		If !Y! Equ 9 (
			Set/a GameSpeed=0x9FFF,M=0
			For /L %%a in (65,1,!X!) Do Set/a GameSpeed-=0xFFF
			Goto :Sett
		)
	)
	If !Y! Equ 14 (
		If !M! Equ 1 (
		Set M=0
		If !X! Equ 60 Set Gnr=M
		If !X! Equ 69 Set Gnr=F
		Goto :Sett
		)
	)
	If !K! Equ 27 (Goto :Settings_Apply)
	If !Y! Geq 45 If !Y! Leq 47 If !X! Geq 65 If !X! Leq 73 (
	If !M! Equ 1 Goto :Settings_Apply_
		%Dip%[1;31m[45;65H+------+
		%Dip%[46;65HÝ BACK Ý
		%Dip%[47;65H+------+
		Call
	)
	If !Errorlevel! Equ 0 (
		%Dip%[1;30m[45;65H+------+
		%Dip%[46;65HÝ BACK Ý
		%Dip%[47;65H+------+
		Call 
	)
)
	Goto :Settings_
:Settings_Apply_
%Effect% Enter
:Settings_Apply
(
	Echo.;Settings Info Used By Shoot 'em Batch
	Echo.;Warning!: Don't Modify here the FrameSkip and GameSpeed data
	Echo.FrameSkip=!FrameSkip!
	Echo.GameSpeed=!GameSpeed!
	Echo.SkipLoadFrame=!SkipLoadFrame!
	Echo.Gnr=!Gnr!
	)>"Core\Settings.inf"
	Set M=0
	Goto :MainMenu

:Exit
	%Effect% Enter
	%Dip%[0;37m
	Cls & Echo.Stoping Seta:DSP...
	Call :Stop
	Echo.Unloading variables...
	Rd /s /q !$Tmp! >Nul 2>&1
	Echo.Closing game...
	!Fn! Sleep 300
	Exit/b 0
:HallOfFame
	Cls
	!Fn! Cursor 100
	For %%a in (
	"[10;24H[1;37m^^^!^^^!^^^! YOU ARE IN HALL OF FAME ^^^!^^^!^^^!"
	"[16;34H>>>          <<<"
	"[16;38H!Score!"
	"[0;37m"
	"[23;24HAdd your nickname to High scores table."
	"[24;17HYou can provide short message to all, if you want to."
	"[1;30m"
	"[26;21HDo not forget to synchronize your score list^!"
	"[1;30m"
	"[41;38H+------+"
	"[42;38HÝ  OK  Ý"
	"[43;38H+------+"
	) Do %Dip%%%~a
	::         Y  X
	Set Camp1=30;32
	Set Camp2=34;32
	Set Camp3=35;33
	Set CurPos=!Camp1!
	Set Nickname=
	Set Message1=
	Set Message2=
	Set C=
	Set CCoun=1
	Call :Hall_
	:HallOfFame_
	For /L %%# in (1,2,111) Do (
	%Dip%[1;1H[1;33m & Set KeyChar=& Set KeyCode=
	Type !$Tmp!\Star\[%%#]
	%Dip%[!CurPos!H[!CurPos!H[!CurPos!H
	%Mouse%
	rem If Defined KeyChar Set "KeyChar=!KeyChar:~1,1!"
	For %%a in (13 8 92 124 37 38 33 34 42 43 47 94 60 62 58 91 93) Do If !KeyCode! Equ %%a Set "KeyChar="
	If !KeyCode! Equ 32 Set "KeyChar=ÿ"
	If !KeyCode! Equ 13 (
		If !CCount! Geq 3 Set CCount=0
		Set/a CCount+=1
		For %%p in (!CCount!) Do Set "CurPos=!Camp%%p!"
	)
	If "!CurPos!" Equ "30;32" (
		If Defined KeyChar (Set "NickName=!NickName!!KeyChar!"&Set "NickName=!NickName:~0,17!")
		If !KeyCode! Equ 8 If Defined NickName Set "NickName=!NickName:~0,-1!"
		Call :Hall_
	)
	If "!CurPos!" Equ "34;32" (
		If Defined KeyChar (Set "Message1=!Message1!!KeyChar!"&Set "Message1=!Message1:~0,33!")
		If !KeyCode! Equ 8 If Defined Message1 Set "Message1=!Message1:~0,-1!"
		Call :Hall_
	)
	If "!CurPos!" Equ "35;33" (
		If Defined KeyChar (Set "Message2=!Message2!!KeyChar!"&Set "Message2=!Message2:~0,33!")
		If !KeyCode! Equ 8 If Defined Message2 Set "Message2=!Message2:~0,-1!"
		Call :Hall_
	)
	If !Y! Geq 40 If !Y! Leq 42 If !X! Geq 37 If !X! Leq 45 (
		If !M! Equ 1 Goto :SetScore
		%Dip%[1;32m[41;38H+------+
		%Dip%[42;38HÝ  OK  Ý
		%Dip%[43;38H+------+
		Call 
	)
	If !Errorlevel! Equ 1 (
		%Dip%[1;30m[41;38H+------+
		%Dip%[42;38HÝ  OK  Ý
		%Dip%[43;38H+------+
		Call
	)
	Set C=&Set K=0&Set Chr=
)
	Goto :HallOfFame_
:Hall_
	For %%a in (
	"[1;36m"
	"[29;20H          +-------------------+"
	"[30;20HNickname: Ý                   Ý"
	"[31;20H          +-------------------+"
	""
	"[33;20H          +-------------------------------------+"
	"[34;20H Message: Ý                                   < Ý"
	"[35;20H          Ý >                                   Ý"
	"[36;20H          +-------------------------------------+"
	"[1;37m[30;32H!Nickname![34;33H!Message1![35;33H!Message2!"
	) Do %Dip%%%~a
	Goto :Eof
:SetScore
	!Fn! Cursor 0
	<Nul Set/p=[38;19H[1;31mLOADING .
	Set/a Ln1=0,Ln2=0,Ln3=0
	For /L %%a in (2,1,102) Do (
		If !Place! Equ %%a (
			Set/a Ln1=%%a,Ln2=%%a+1,Ln3=%%a+2
			Set Score[!Ln1!]=[1;37m!Place_!.ÿÿ!NickName!ÿ[!Score!]
			Set Score[!Ln2!]=[0;37mÿÿÿÿÿÿ!Message1!
			Set Score[!Ln3!]=[1;30mÿÿÿÿÿÿÿÿ!Message2!
		)
	)
	<Nul Set/p=.
	For /L %%b in (3,1,102) Do (
		If "!Score[%%b]!" Equ "[0;30m" (Set Tmp_=!Header!) Else (
			For /F "Tokens=1* Delims=m" %%x in ("!Score[%%b]!") Do (
				If /i "%%x" Equ "[1;37" Set "Tmp_=<:%%y"
				If /i "%%x" Equ "[0;37" Set "Tmp_=>:%%y"
				If /i "%%x" Equ "[1;30" Set "Tmp_=+:%%y"
			)
		)
	Echo;!Tmp_!>>!$Tmp!\$core.tmp
	)
	<Nul Set/p=.
	For %%S in (!$Tmp!\$core.tmp) Do Set "Size=%%~zS"
	Call :GetLg Size
	Set/a Size=Size+Count+63+6+4
	:: sum size+sizeofstring+headersize+sizeofstringsize+twoCRLFs
	:: Header Size: 63 bytes
	For %%t in (
	"!Header!"
	"/size:!Size!"
	) Do Echo;%%~t>>!$Tmp!\Header.bin
	Copy /b /y !$Tmp!\Header.bin + !$Tmp!\$core.tmp !$Tmp!\TMP$.tmp>Nul 2>&1
	Del !$Tmp!\Header.bin >Nul 2>&1
	Del !$Tmp!\$core.tmp >Nul 2>&1
	<Nul Set/p=.
	For /F "Delims=" %%y in ('Type !$Tmp!\TMP$.tmp') Do (
	Set "Tmp_=%%y"
	Set Tmp_=!Tmp_:a=%Chx:~0,1%!&Set Tmp_=!Tmp_:t=%Chx:~19,1%!
	Set Tmp_=!Tmp_:b=%Chx:~1,1%!&Set Tmp_=!Tmp_:u=%Chx:~20,1%!
	Set Tmp_=!Tmp_:c=%Chx:~3,1%!&Set Tmp_=!Tmp_:v=%Chx:~18,1%!
	Set Tmp_=!Tmp_:d=%Chx:~2,1%!&Set Tmp_=!Tmp_:w=%Chx:~21,1%!
	Set Tmp_=!Tmp_:e=%Chx:~5,1%!&Set Tmp_=!Tmp_:x=%Chx:~24,1%!
	Set Tmp_=!Tmp_:f=%Chx:~6,1%!&Set Tmp_=!Tmp_:y=%Chx:~22,1%!
	Set Tmp_=!Tmp_:g=%Chx:~4,1%!&Set Tmp_=!Tmp_:z=%Chx:~25,1%!
	Set Tmp_=!Tmp_:h=%Chx:~7,1%!& Set Tmp_=!Tmp_:1=%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~23,1%!
	Set Tmp_=!Tmp_:i=%Chx:~9,1%!& Set Tmp_=!Tmp_:2=%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~26,1%!
	Set Tmp_=!Tmp_:j=%Chx:~10,1%!&Set Tmp_=!Tmp_:3=%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~28,1%!
	Set Tmp_=!Tmp_:k=%Chx:~8,1%!& Set Tmp_=!Tmp_:4=%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~27,1%!
	Set Tmp_=!Tmp_:l=%Chx:~12,1%!&Set Tmp_=!Tmp_:5=%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~29,1%!
	Set Tmp_=!Tmp_:m=%Chx:~11,1%!&Set Tmp_=!Tmp_:6=%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~30,1%!
	Set Tmp_=!Tmp_:n=%Chx:~14,1%!&Set Tmp_=!Tmp_:7=%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~32,1%!
	Set Tmp_=!Tmp_:p=%Chx:~13,1%!&Set Tmp_=!Tmp_:8=%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~33,1%!
	Set Tmp_=!Tmp_:q=%Chx:~15,1%!&Set Tmp_=!Tmp_:9=%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~31,1%!
	Set Tmp_=!Tmp_:r=%Chx:~17,1%!&Set Tmp_=!Tmp_:0=%Chx:~41,1%%Chx:~36,1%%Chx:~42,1%%Chx:~34,1%!
	Set Tmp_=!Tmp_:s=%Chx:~16,1%!&Set Tmp_=!Tmp_: =%Chx:~43,1%!
	Set Tmp_=!Tmp_:[=%Chx:~37,1%!&Set Tmp_=!Tmp_:]=%Chx:~35,1%!
	Set Tmp_=!Tmp_:.=%Chx:~38,1%!&Set Tmp_=!Tmp_:o=%Chx:~40,1%!
	Set Tmp_=!Tmp_:ÿ=%Chx:~44,1%!
	<Nul Set/p=!Tmp_!!Chx:~39,1!>>!$Tmp!\Score.tmp
	)
	<Nul Set/p=.
	Del !$Tmp!\TMP$.tmp >Nul 2>&1
	Move /y !$Tmp!\Score.tmp Core\Score.dat
	<Nul Set/p=.
	Goto :YourScore
:GetLg
	Set Tmp_=!%~1!
	Set Count=0
	:GetLg_
	Set/a Count+=1
	Set Tmp_=!Tmp_:~1!
	If Defined Tmp_ Goto :GetLg_
	Goto :Eof

:YourScore
	Cls & %Effect% Enter
	If !Score! Geq 250000 Set Slogan=[20;22HUnbelievable^! How did you do that???
	If !Score! Lss 150000 Set Slogan=[20;29HWow. Can you join to the army?
	If !Score! Lss 75000 Set Slogan=[20;25HOnly few get stay in hall of fame.
	If !Score! Lss 55000 Set Slogan=[20;18HI am sure you are able to get more points.
	If !Score! Lss 35000 Set Slogan=[20;18HTrainer monkey is able to get more points.
	If !Score! Lss 15000 Set Slogan=[20;29HYou wanted to loose, don't you?
	%Dip%[0;37m!Slogan!
	Set/a "FAc=(BHit*100)/BFired,MAc=(MHit*100)/MFired,ArmorCol=(ObjTotalArmor*1000)/ObjHitArmor"
	For %%a in (
	"[1;1H[1;37m"
	"[19;34H>>>          <<<"
	""
	"[21;35HGame Statics" "[0;37m"
	"[23;12H Bullets hit/fired:                Objects destroyed:            "
	"[1;30m"
	"[24;12H     Fire accuracy:    %%"
	"[0;37m"
	"[25;12H                                             Spheres:          "
	"[26;12HMines hit/released:                            Boxes:          "
	"[1;30m"
	"[27;12H     Mine accuracy:    %%                       [0;37mMines:          "
	""
	"[29;12HTime points gained:                   Armor diamonds:          "
	"[30;12H      Bonus points:                          Bonuses:          "
	"[31;12H                                          Ammo packs:          "
	"[32;12H   Armor collected:     %%"
	""
	"[1;30m"
	"[35;37H+------+"
	"[36;37HÝ  OK  Ý"
	"[37;37H+------+"
	""
	"[1;1H[0;37m"
	"[19;38H!Score!"
	"[23;32H!BHit! / !BFired![23;66H!ObjHit! / !ObjTotal!"
	"[24;32H[1;30m!FAc![0;37m"
	"[25;66H!ObjHitSp! / !ObjTotalSp![26;66H!ObjHitSp! / !ObjTotalSp!"
	"[26;32H!MHit! / !MFired!"
	"[27;32H[1;30m!MAc![0;37m[27;66H!ObjHitMine! / !ObjTotalMine!"
	"[29;32H!TimePoints![29;66H!ObjHitArmor! / !ObjTotalArmor!"
	"[30;32H!BonusPoints![30;66H!ObjHitBonus! / !ObjTotalBonus!"
	"[31;66H!ObjHitAmmo! / !ObjTotalAmmo!"
	"[32;32H!ArmorCol!"
	) Do %Dip%%%~a
	:YS_
	For /L %%# in (1,2,377) Do (
		%Dip%[1;1H[1;34m
		Type !$Tmp!\Score\[%%#]
		%Mouse%

		If !Y! Geq 34 If !Y! Leq 36 If !X! Geq 36 If !X! Leq 44 (
			If !M! Equ 1 Goto :HighScore
			%Dip%[1;32m
			%Dip%[35;37H+------+
			%Dip%[36;37HÝ  OK  Ý
			%Dip%[37;37H+------+
			Call
		)
		If !Errorlevel! Equ 0 (
			%Dip%[1;30m
			%Dip%[35;37H+------+
			%Dip%[36;37HÝ  OK  Ý
			%Dip%[37;37H+------+
			Call 
		)
	)
	Goto :YS_


	

:Play
	Cls
	Call :Stop
	%Effect% Enter
	Type Core\Background.bga
	For %%a in (C.Y C.G S.G S.R S.M S.E T.B H.Y H.R) Do Set %%a_Cr=
	Set/a M=0,MaxPosSp=36,SpeedGen=50,Score=0,NextSprite=0,Clock=0
	Set/a BHit=0,BFired=0,BAc=0,MHit=0,MFired=0,MAc=0,ObjTotal=0,ObjHit=0,ObjHitSp=0,ObjTotalSp=0
	Set/a ObjHitMine=0,ObjTotalMine=0,ObjHitArmor=0,ObjTotalArmor=0,ObjTotalBonus=0,ObjHitBonus=0
	Set/a ObjTotalAmmo=0,ObjHitAmmo=0,Timepoints=0,Bonuspoints=0,ArmorCol=0
	Set Destroy=No
	Set Refresh=No
	Set Ef=None
	Set Tp=0
	Set/a Rnd=!Random!%%8
	If !Rnd! Equ 0 Set Tip=Also your mines will explode if you hit them.
	If !Rnd! Equ 1 Set Tip=The longer you survive the more points you'll get.
	If !Rnd! Equ 2 Set Tip=Conserve your ammo in the beginning of the game.
	If !Rnd! Equ 3 Set Tip=Later in game, focus to diamonds and bonuses only.
	If !Rnd! Equ 4 Set Tip=Try to catch the objects as soon as they appear.
	If !Rnd! Equ 5 Set Tip=Collect ammo first before detonating nearby mines.
	If !Rnd! Equ 6 Set Tip=Try to collect bonuses first before detonating mines.
	If !Rnd! Equ 7 Set Tip=Ladies, switch to male narrator in settings menu.
	Call :Seta_DSP GamePlay
	!Fn! Cursor 0
	Set List=;
	%Tab%
	:Play_Loop
	:: -> Main Loop <- ::
	
	FOR /L %%! IN (1,1,500) DO (

	If "!Lives_!" Equ "ÝÝÝÝÝÝÝÝÝÝ" (
		Set StatusLive=2
		Set Adv3=Yes
	)
	If "!Lives_!" Equ "ÝÝÝÝÝÝÝÝÝ" (
		Set StatusLive=3
		If "!Adv3!" Equ "Yes" (Set Adv3=No&%Effect% MediumLive!Gnr!)
	)
	If "!Lives_!" Equ "ÝÝÝÝÝ" (
		Set StatusLive=3
		Set Adv4=Yes
	)
	If "!Lives_!" Equ "ÝÝÝÝ" (
		Set StatusLive=1
		If "!Adv4!" Equ "Yes" (Set Adv4=No&%Effect% DangerLive!Gnr!)
	)
	If Not Defined Lives_ Goto :GameOver
	
	%Mouse%
	If !KeyCode! Equ 27 Goto :Reset
	If !M! Equ 1 (
		If !Ammunition! Neq 0 (
			For %%_ in (80 60 40 20) Do If !Ammunition! Equ %%_ %Effect% ToOutAmmo
			Set/a X+=1,Y+=1,BFired+=1
			Set "H.Y_Cr=!H.Y_Cr!!X!.!Y!,"
			Set/a Ammunition-=4
			Set Adv2=Yes
			%Effect% Shoot
		) Else (
		If "!Adv2!" Equ "Yes" (Set Adv2=No&%Effect% OutPriAmmo!Gnr!)
		%Effect% OutAmmo
		)
	)
	If !M! Equ 2 (
		If !Mines! Neq 0 (
			If "!MineR!" Equ "ÝÝÝÝÝ" (
				Set/a X+=1,Y+=1,Mines-=1,MFired+=1
				Set "H.R_Cr=!H.R_Cr!!X!.!Y!,"
				Set MineR=
				Set Adv=Yes
				%Effect% Bomb
			)
		) Else (
		If "!Adv!" Equ "Yes" (Set Adv=No&%Effect% OutSecAmmo!Gnr!)
		)
	)
	REM Set M=0
	set/a NextSprite+=1,Score+=2,Clock+=1,TimePoints+=5,Tp+=1
	If !Tp! Equ 1  %Dip%[0;37m[15;15HTip: [1;37m!Tip!
	If !Tp! Equ 35 %Dip%[0;37m[15;15HTip: [0;37m!Tip!
	If !Tp! Equ 37 %Dip%[1;30m[15;15HTip: [1;30m!Tip!
	If !Tp! Equ 39 %Dip%[0;30m[15;15HTip: [0;30m!Tip!
	
	If !Tp! Equ 1  %Dip%[1;37m[10;32H^^!^^!^^! GET READY ^^!^^!^^!
	If !Tp! Equ 25 %Dip%[0;37m[10;32H^^!^^!^^! GET READY ^^!^^!^^!
	If !Tp! Equ 27 %Dip%[1;30m[10;32H^^!^^!^^! GET READY ^^!^^!^^!
	If !Tp! Equ 29 %Dip%[0;30m[10;32H^^!^^!^^! GET READY ^^!^^!^^!
	For %%t in (
	50 100 150 200 250 300 350
	400 450 500 550 600 650 700 750
	800 850 900 1200 1300 1400 1500
	) Do If !Clock! Equ %%t Set/a SpeedGen-=2
	If Defined H.Y_Cr Set/a H.Y_F+=2
	If Defined H.R_Cr Set/a H.R_F+=1
	If "!MineR!" Neq "ÝÝÝÝÝ" Set/a M.C+=1
	If !M.C! Geq 10 (Set MineR=!MineR!Ý&Set M.C=0)
	If !NextSprite! Geq !SpeedGen! (
		Set/a Rnd=!Random!%%20,_X=!Random!*50/32768,_Y=1
		If !Rnd! Equ 0 Set C.Y_Cr=!C.Y_Cr!!_X!.!_Y!,&Set/a ObjTotalAmmo+=1
		If !Rnd! Equ 1 Set C.Y_Cr=!C.Y_Cr!!_X!.!_Y!,&Set/a ObjTotalAmmo+=1
		If !Rnd! Equ 2 Set C.G_Cr=!C.G_Cr!!_X!.!_Y!,&Set/a ObjTotalSp+=1
		If !Rnd! Equ 3 Set C.G_Cr=!C.G_Cr!!_X!.!_Y!,&Set/a ObjTotalSp+=1
		If !Rnd! Equ 4 Set C.G_Cr=!C.G_Cr!!_X!.!_Y!,&Set/a ObjTotalSp+=1
		If !Rnd! Equ 5 Set C.G_Cr=!C.G_Cr!!_X!.!_Y!,&Set/a ObjTotalSp+=1
		If !Rnd! Equ 6 Set C.G_Cr=!C.G_Cr!!_X!.!_Y!,&Set/a ObjTotalSp+=1
		If !Rnd! Equ 7 Set S.G_Cr=!S.G_Cr!!_X!.!_Y!,&Set/a ObjTotalArmor+=1
		If !Rnd! Equ 8 Set S.E_Cr=!S.E_Cr!!_X!.!_Y!,&Set/a ObjTotalSp+=1
		If !Rnd! Equ 9 Set S.E_Cr=!S.E_Cr!!_X!.!_Y!,&Set/a ObjTotalSp+=1
		If !Rnd! Equ 10 Set S.E_Cr=!S.E_Cr!!_X!.!_Y!,&Set/a ObjTotalSp+=1
		If !Rnd! Equ 11 Set S.E_Cr=!S.E_Cr!!_X!.!_Y!,&Set/a ObjTotalSp+=1
		If !Rnd! Equ 12 Set S.E_Cr=!S.E_Cr!!_X!.!_Y!,&Set/a ObjTotalSp+=1
		If !Rnd! Equ 13 Set S.R_Cr=!S.R_Cr!!_X!.!_Y!,&Set/a ObjTotalMine+=1
		If !Rnd! Equ 14 Set S.M_Cr=!S.M_Cr!!_X!.!_Y!,&Set/a ObjTotalSp+=1
		If !Rnd! Equ 15 Set T.B_Cr=!T.B_Cr!!_X!.!_Y!,&Set/a ObjTotalBonus+=1
		If !Rnd! Equ 16 Set T.B_Cr=!T.B_Cr!!_X!.!_Y!,&Set/a ObjTotalBonus+=1
		If !Rnd! Equ 17 Set T.B_Cr=!T.B_Cr!!_X!.!_Y!,&Set/a ObjTotalBonus+=1
		If !Rnd! Equ 18 Set T.B_Cr=!T.B_Cr!!_X!.!_Y!,&Set/a ObjTotalBonus+=1
		If !Rnd! Equ 19 Set T.B_Cr=!T.B_Cr!!_X!.!_Y!,&Set/a ObjTotalBonus+=1
		Set/a NextSprite=0,ObjTotal+=1
	)
	For %%a in (C.Y;C.G;S.G;S.R;S.M;S.E;T.B;H.Y;H.R) Do (
		If Defined %%a_Cr (
			Set "List=!List:%%a;=!%%a;"
		)
	)
	
For %%a in (!List!) Do (
	 For %%c in (!%%a_Cr!) Do (
		For /F "Tokens=1-2 Delims=." %%d in ("%%c") Do (
			Set/a X=%%d,Y=%%e
			For /F "Tokens=1-2" %%p in ("!%%a_F! !%%a_O!") Do (
				For /F "Delims=" %%t in (Core\Tmp\%%q\%%q_%%p.txt) Do Echo;!%%a_C!%%t[1;1H
				Set/a _Y=%%e+1
				If %%a Neq H.Y (
					If %%a Neq H.R (
						Set/a %%a_F+=!FrameSkip!
				)	)
				For %%f in (!%%a_O!) Do (
					If !%%a_F! Geq !Frames%%f! (
						Set %%a_F=0
						If %%a_Cr Equ H.Y_Cr (
							Set %%a_F=13
							If %%e Geq 33 Set Refresh=Yes
							Set "List=!List:%%a;=!"
							Set %%a_Cr=
							For %%k in (C.Y C.G S.G S.R S.M S.E T.B) Do (
								For %%w in (!%%k_Cr!) Do (
									For /F "Tokens=1-2 Delims=." %%x in ("%%w") Do (
										Set/a _X=%%x+17,_Y=%%y+15,__X=%%d+9,__Y=%%e+6
										If !__X! Geq %%x If %%d Leq !_X! If !__Y! Geq %%y If %%e Leq !_Y! (
										rem If %%d Geq %%x If !__X! Leq !_X! If %%e Geq %%y If !__Y! Leq !_Y! (
											%Dip%[1;1H[0;30m!Blank!
											Type Core\Background.bga
											Set %%k_Cr=!%%k_Cr:%%x.%%y,=!
											Set "List=!List:%%k;=!"
											Set Ef=Obj
											If %%k Equ T.B Set Ef=Bonus
											If %%k Equ S.G Set Ef=Armor
											If %%k Equ S.M Set Ef=Small
											If %%k Equ S.R Set Ef=Bomb
											If %%k Equ C.Y Set Ef=Ammo
						)	)	)	)	)
						If %%a_Cr Equ H.R_Cr (
							Set %%a_F=13
							If %%e Geq 33 Set Refresh=Yes
								Set/a Ammunition+=80
								For %%k in (C.Y C.G S.G S.R S.M S.E T.B H.Y H.R) Do Set %%k_Cr=
								Set "List=;"
								Set Ef=Bomb
								%Dip%[1;1H[0;30m!Blank!
								Type Core\Background.bga
					)	)	)
				If %%a_Cr Neq H.Y_Cr If %%a_Cr Neq H.R_Cr (
					If !_Y! Geq !MaxPosSp! (Set %%a_Cr=!%%a_Cr:%%c,=!&Set Destroy=Yes&Set "List=!List:%%a;=!") Else (
						For %%t in (!_Y!) Do Set %%a_Cr=!%%a_Cr:%%c,=%%d.%%t,!
)	)	)		)	)

	
		If /i "!Destroy!" Equ "Yes" (
			Set Destroy=No
			%Effect% Boom1
			Rem !Fn! Sprite 36 0 !BackGround!
			Type Core\Background.bga
			Set "Lives_=!Lives_:~1!"
		)
		If /i "!Refresh!" Equ "Yes" (
			Set Refresh=No
			Rem !Fn! Sprite 36 0 !BackGround!
			Type Core\Background.bga
		)
		If /i "!Ef!" Equ "Obj" (
			Set Ef=None
			Set/a Rnd=!Random!%%4+1,Score+=25,BHit+=1,ObjHit+=1,ObjHitSp+=1
			%Effect% ShootShock!Rnd!
			%Effect% Boom4
		)
		If /i "!Ef!" Equ "Bomb" (
			Set Ef=None
			Set/a Score+=1000,MHit+=1,ObjHit+=1,ObjHitMine+=1,MFired+=1
			%Effect% ShootShock
			%Effect% Boom2
			For %%a in (C.Y C.G S.G S.R S.M S.E T.B H.Y H.R) Do Set %%a_Cr=
			%Dip%[0;30m!Blank!
			Rem !Fn! Sprite 36 0 !BackGround!
			Type Core\Background.bga
		)
		If /i "!Ef!" Equ "Small" (
			Set Ef=None
			Set/a Score+=50,BHit+=1,ObjHit+=1,ObjHitSp+=1
			%Effect% ShootShock
			%Effect% Boom1
		)
		If /i "!Ef!" Equ "Bonus" (
			Set Ef=None
			Set/a Rnd=!Random!%%8
			If !Rnd! Equ 6 Set/a Mines+=1
			Set/a Score+=2000,BHit+=1,ObjHit+=1,ObjHitBonus+=1,BonusPoints+=2000
			%Effect% Bonus
		)
		If /i "!Ef!" Equ "Armor" (
			Set Ef=None
			Set/a Score+=200,BHit+=1,ObjHit+=1,ObjHitArmor+=1
			If "!Lives_!" Neq "ÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ" Set Lives_=!Lives_!Ý
			%Effect% Bonus
		)
		If /i "!Ef!" Equ "Ammo" (
			Set Ef=None
			Set/a Score+=1000,Ammunition+=80,BHit+=1,ObjHit+=1,ObjHitAmmo+=1
			%Effect% AmmoCharge
		)
	)
	If !H.Y_F! Geq 13 Set H.Y_F=0
	If !H.R_F! Geq 13 Set H.R_F=0
	%Tab%
	Set M=0
)
	Goto :Play_Loop
:Reset
	Cls & Call :Stop
	Call :Seta_DSP Intro
	Goto :MainMenu
:GameOver
	Cls & Call :Stop
	Call :Seta_DSP Intro
	Set Place_=0
	For /L %%a in (1,1,4) Do %Effect% Boom%%a
	For /L %%# in (3,4,99) Do (
		For /F "Tokens=3 Delims=[]" %%a in ("!Score[%%#]!") Do (
			Set/a Place_+=1
			If !Score! Geq %%a (Set Place=%%#&Goto :HallOfFame)
		)
	)
	Goto :YourScore
	
:Seta_DSP
	For /F "Tokens=1-3" %%a In ("!%~1!") Do Set I=%%a& Set N=%%b& Set F=%%c
(
	Echo;@Echo Off
	Echo;SetLocal EnableExtensions
	Echo;Rem Title Seta:DSP
	Echo;Set I=!I!
	Echo;Set N=!N!
	Echo;Set F=!F!
	Echo;Echo;Seta:DSP - Developed By Honguito98
	Echo;Echo;Debug info: sound offset:
	Echo;Echo;Init = !I!  Loop = !N!  EndLoop = !F!
	Echo;For /F "Tokens=1-6 Delims=." %%%%a in ("%%I%%.%%N%%.%%F%%"^) Do (
	Echo;	Set _I=%%%%a%%%%b
	Echo;	Set _N=%%%%c%%%%d
	Echo;	Set _F=%%%%e%%%%f
	Echo;^)
	Echo;Set/a "S1=%%_N%%-%%_I%%,S2=(%%_F%%-%%_N%%)*5"
	Echo;Echo;Times To Repeat: 5 [%%S2%%]
	Echo;Start "" /B Cmd /C "Core\Dsp.dll Core\Stream.arc -d trim %%I%% =%%N%%"
	Echo;Core\Fn.dll Sleep %%S1%%
	Echo;If Exist "%%Tmp%%\StopSetaDSP" (Del "%%Tmp%%\StopSetaDSP" ^& Exit^)
	Echo;:Loop
	Echo;Start "" /B Cmd /C Core\Dsp.dll Core\Stream.arc -d trim %%N%% =%%F%% repeat 4
	Echo;Core\Fn.dll Sleep %%S2%%
	Echo;If Exist "%%Tmp%%\StopSetaDSP" (Del "%%Tmp%%\StopSetaDSP" ^& Exit^)
	Echo;Goto :Loop
	)>"!Dsp!"
	(Start "" /B Cmd /c "!Dsp!") >Nul 2>&1
	Goto :Eof
:Seta_GPU
	For %%R in ("Core\%~1.r3d") Do (
	Md "!$Tmp!\%%~nR"
	Copy /y "Core\%~1.r3d" "!$Tmp!\%%~nR\$Tmp.exe" >Nul 2>&1
	Pushd "!Cd!"
	Cd "!$Tmp!\%%~nR"
	$Tmp.exe >Nul 2>&1
	Del $Tmp.exe >Nul 2>&1
	Popd
	)
	Goto :Eof
:Stop
	Echo;>"%Tmp%\StopSetaDSP"
	Taskkill /f /im Dsp.dll            >Nul 2>&1
	Taskkill /f /im Fn.dll            >Nul 2>&1
	Goto :Eof
:Flush
	For /f "Tokens=1 Delims==" %%a in ('Set') Do (
	If /i "%%a" Neq "Comspec" (
	If /i "%%a" Neq "Tmp" (
	If /i "%%a" Neq "Userprofile" (
	IF /i "%%a" Neq "SystemRoot" (
	IF /i "%%a" Neq "Game" (
	IF /i "%%a" Neq "Gpu" (
	Set "%%a="))))))
	)
	Set "Path=%comspec:~0,-8%;%SystemRoot%;%Comspec:~0,-8%\Wbem"
	Goto :Eof

	:: -> Notes <- ::
	::C.Y = YellowCube   ::
	::C.G = GrayCube     ::
	::S.G = GreenSphere  ::
	::S.E = GraySphere   ::
	::S.R = RedSphere    ::
	::S.M = MagentaSphere::
	::T.B = BlueTriangle ::
	:: Charset For Frames: SRWUPYCVCMNLB;:." "
	:: -> Macros Area <- ::

:: -> Mouse <- :: V=%Y% W=%X% X=%M% Y=%K% Z=%C%

@2:!Fn! Inputhit > inputkey.txt
@2:For /L %%_ in (0x00,0x01,!GameSpeed!) Do Rem
@2:For /F "Tokens=1-5" %%A in (inputkey.txt) Do (
@2:	Set "KeyChar="  & Set M=0
@2:	If %%A Equ -2 (
@2:		Set StatusW=Not Present
@2:	) Else Set StatusW=Focused
@2:	If %%A Geq 0 Set Y=%%A
@2:	If %%B Geq 0 Set X=%%B
@2:	If %%C Geq 0 If %%C Leq 5 Set M=%%C
@2:	If %%C Geq 10000  Set/a Ct+=1
@2:	If %%C Leq -10000 Set/a Ct-=1 
@2:	If "%%E" Neq "" Set "KeyChar=%%E"
@2: Set KeyCode=%%D
@2:)
@2:


:: -> Effect <- ::
@3:For /F "Tokens=1" %%a in ("!Args!") Do (
@3: For /F "Tokens=1-2" %%b in ("!%%a!") Do (
@3: (Start "" /B Cmd /C "Core\Dsp.dll Core\Stream.arc -d -q trim %%b =%%c") >Nul 2>&1
@3:))

:: -> Tab <- ::
@4:For %%a in (
@4:"[36;01H[0;30m                                                  "
@4:"[1;36m"
@4:"[45;3H+-------+[45;36H+--------+[45;65H+------------+"
@4:"[46;3HÝ Mines Ý[46;36HÝ        Ý[46;65HÝ Ammunition Ý"
@4:"[47;3HÝ       Ý[47;30H+-----+--------+-----+[47;65HÝ            Ý"
@4:"[48;3HÝ       Ý[48;30HÝ                    Ý[48;65HÝ            Ý"
@4:"[49;3H+-------+[49;30H+--------------------+[49;65H+------------+"
@4:"[1;34m[47;7H!Mines![46;37H!Score![47;70H!Ammunition![48;5H!MineR!"
@4:"[48;67HÝÝÝÝÝÝÝÝÝÝ[1;3!StatusLive!m[48;31H!Lives_!"
@4:) Do Echo;%%~a

:GenScoreList
	Del Core\Score.dat >Nul 2>&1
	set "Start="
	set "End="
	For /F "Tokens=1 Delims=:" %%a in ('Findstr /N /B "</*Score:Data>" "%Game%"') Do (
		If Not Defined Start (
			set Start=%%a
		) Else (
			Set End=%%a
		)
	)
	Set/a Count=!Start!
	For /F "Skip=%Start% Delims=" %%a in ('Type "%Game%"') do   (
		Set/a Count+=1
		If "!Count!" Geq "!End!" Goto :Eof
		<Nul Set/p=%%a>>Core\Score.dat
	)
	Goto :Eof
		For /F "Skip=3 Tokens=1* Delims=|" %%a in ('Find "NEW" !Game!') Do <Nul Set/p=%%b>>Core\Score.dat

:: DON'T MODIFY THIS AREA!
<Score:Data>
®Ð¾¾Ð
'Ð¾ÐÐ-ÐÐ¾Ð¾ÐžÐ¾¾
	ö	ü¯/¬:	ý	±	÷	ü¯<:	Ã®ÐÐÐ¾Ð		î	
ó	÷	÷	÷	÷«¯>:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	±®ÐÐÐ¾Ð		î	÷	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	î®ÐÐÐ¾Ð		±	ó	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	ý®ÐÐÐ¾Ð		±	÷	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	ó®ÐÐÐ¾Ð		Ã	ó	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	ô®ÐÐÐ¾Ð		Ã	÷	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	û®ÐÐÐ¾Ð		ö	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	ü®ÐÐÐ¾Ð		ü	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	ö®ÐÐÐ¾Ð		û	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	Ã	÷®ÐÐ¾Ð		ô	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	Ã	Ã®ÐÐ¾Ð		ó	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	Ã	±®ÐÐ¾Ð		ý	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	Ã	î®ÐÐ¾Ð		î	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	Ã	ý®ÐÐ¾Ð		±	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	Ã	ó®ÐÐ¾Ð		Ã	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	Ã	ô®ÐÐ¾Ð		Ã	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	Ã	û®ÐÐ¾Ð		Ã	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	Ã	ü®ÐÐ¾Ð		Ã	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	Ã	ö®ÐÐ¾Ð		Ã	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	±	÷®ÐÐ¾Ð		Ã	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	±	Ã®ÐÐ¾Ð		Ã	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	±	±®ÐÐ¾Ð		Ã	÷	÷	÷	÷«¯>:ÐÐÐÐÐÐ
žÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	±	î®ÐÐ¾Ð		Ã	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	±	ý®ÐÐ¾Ð		Ã	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯<
:	±	ó®ÐÐ¾Ð		Ã	÷	÷	÷	÷«¯>
:ÐÐÐÐÐÐžÐ¾ÐÐž¾ÐÐ®¯+
:ÐÐÐÐÐÐÐÐÐÐÐž¾Ð¾®¯®Ð¾¾Ð'Ð¾Ð
Ð-ÐÐ¾Ð¾ÐžÐ¾¾	ö	ü¯
</Score:Data>