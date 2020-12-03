#SingleInstance, force
; Minecraft-Hotkeys by u/Scripter17
; Version 0.1 alpha
; Original concept stolen from https://github.com/monpjc/XAHK
Gui, Add, Text, x10 y10 w50 h20 , Fishing
Gui, Add, Text, x60 y10 w80 h20 , Alt+F

Gui, Add, Text, x10 y30 w50 h20 , Grinding
Gui, Add, Text, x60 y30 w80 h20 , Alt+G

Gui, Add, Text, x10 y50 w50 h20 , Current:
Gui, Add, Text, x60 y50 w80 h20 vCurrentAction, None

Gui, Add, Text, x140 y10 w80 h20 , Set window:
Gui, Add, Text, x220 y10 w90 h20 , Alt+W

Gui, Add, Text, x140 y30 w90 h20 , Current Window:
Gui, Add, Text, x220 y30 w90 h40 vCurrentWindow, None

Gui, Add, Link, x240 y110 w70 h20 , <a href="https://github.com/Scripter17/Minecraft-Hotkeys">Scripter17</a>
Gui, Add, Text, x240 y130 w70 h20 , Version 0.1
Gui, Add, Text, x240 y150 w70 h20 , 2020-12-03
; Generated using SmartGUI Creator 4.0
Gui, Show, h180 w320, Minecraft hotkeys V0.1a
Return
GuiClose:
ExitApp

stopCurrent:=false

!W::
	WinGet, WindowPID, PID, A
	WinGet, WindowName, ProcessName, A
	GuiControl, , CurrentWindow, %WindowName% (%WindowPID%)
return

#If WinActive("ahk_pid " . WindowPID)
	!S::
		stopCurrent:=True
		GuiControl, , CurrentAction, None (Waiting)
	Return
#If

!F::
	GuiControl, , CurrentAction, Fishing
	HotKey, !F, Off
	HotKey, !G, Off
	HotKey, !W, Off
	while (stopCurrent=false){
		ControlClick, , ahk_pid %WindowPID%, , Right, , NAD
		Sleep, 100
		ControlClick, , ahk_pid %WindowPID%, , Right, , NAU
		Sleep, 100
	}
	stopCurrent:=false
	HotKey, !F, On
	HotKey, !G, On
	HotKey, !W, On
	GuiControl, , CurrentAction, None
Return
!G::
	GuiControl, , CurrentAction, Grinding
	HotKey, !F, Off
	HotKey, !G, Off
	HotKey, !W, Off
	while (stopCurrent=false){
		ControlClick, , ahk_pid %WindowPID%, , Left, , NA
		Sleep, 50
		ControlClick, , ahk_pid %WindowPID%, , Right, , NAD
		Sleep, 1620
		ControlClick, , ahk_pid %WindowPID%, , Right, , NAU
		Sleep, 50
	}
	stopCurrent:=false
	HotKey, !F, On
	HotKey, !G, On
	HotKey, !W, On
	GuiControl, , CurrentAction, None
Return