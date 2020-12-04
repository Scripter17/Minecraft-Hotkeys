#SingleInstance, force
; Minecraft-Hotkeys by Scripter17
; Version 0.3.1
; Original concept stolen from https://github.com/monpjc/XAHK
version=v0.3.1
; Initialize the GUI
Gui, Add, Text, x10 y10 w70 h20, Fishing:
Gui, Add, Text, x80 y10 w80 h20, Alt+F
Gui, Add, Text, x10 y30 w70 h20, Grinding:
Gui, Add, Text, x80 y30 w80 h20, Alt+G
Gui, Add, Text, x10 y50 w70 h20, Cobblestone:
Gui, Add, Text, x80 y50 w80 h20, Alt+M
Gui, Add, Text, x10 y70 w70 h20, Concrete:
Gui, Add, Text, x80 y70 w80 h20, Alt+C
Gui, Add, Text, x10 y90 w70 h20, Take off:
Gui, Add, Text, x80 y90 w80 h20, Alt+Space
Gui, Add, Text, x10 y110 w70 h20, Current:
Gui, Add, Text, x80 y110 w80 h20 vCurrentAction, None
Gui, Add, Text, x150 y10 w90 h20, Set window:
Gui, Add, Text, x240 y10 w90 h20, Alt+W
Gui, Add, Text, x150 y30 w90 h20, Current Window:
Gui, Add, Text, x240 y30 w90 h60 vCurrentWindow, None
Gui, Add, Link, x240 y110 w70 h20, <a href="https://github.com/Scripter17/Minecraft-Hotkeys">Scripter17</a>
Gui, Add, Text, x240 y130 w70 h20, Version %version%
Gui, Add, Text, x240 y150 w70 h20, 2020-12-03
; Generated using SmartGUI Creator 4.0
; https://autohotkey.com/board/topic/738-smartgui-creator
Gui, Show, h180 w320, Minecraft hotkeys %version%
Return
GuiClose:
ExitApp

stopCurrent:=false

; Set the window
; This is disabled while a hotkey is running to ensure the user doesn't accidentally change it when doing other stuff
!W::
	WinGet, WindowPID, PID, A
	WinGetTitle, WindowName, A
	GuiControl, , CurrentWindow, %WindowName% (%WindowPID%)
return

; Stop the currently active hotkey
; This only works while the currently selected window is active
#If WinActive("ahk_pid " . WindowPID) || !WinExist("ahk_pid" . WindowPID)
	!S::
		Suspend, Permit
		if (isDoingSomething=true){
			stopCurrent:=True
			GuiControl, , CurrentAction, None
			isDoingSomething:=false
		}
	Return
#If

; Fishing
!F::
	GuiControl, , CurrentAction, Fishing
	; Disable the other hotkeys
	Suspend, On
	isDoingSomething:=true
	while (stopCurrent=false){
		ControlClick, , ahk_pid %WindowPID%, , Right, , NAD
		Sleep, 100
		ControlClick, , ahk_pid %WindowPID%, , Right, , NAU
		Sleep, 100
	}
	stopCurrent:=false
	; Re-enable the other hotkeys
	Suspend, Off
Return

; Mob grinding
!G::
	GuiControl, , CurrentAction, Grinding
	Suspend, On
	isDoingSomething:=true
	GMainLoop:
	while (stopCurrent=false){
		ControlClick, , ahk_pid %WindowPID%, , Left, , NA
		Sleep, 50
		; Fun fact: It took like 20 minutes to figure out that I forgot the second comma before the NAD/NAU
		ControlClick, , ahk_pid %WindowPID%, , Right, , NAD
		Loop 10 {
			Sleep, 162
			if (stopCurrent=true){
				break, GMainLoop
			}
		}
		Sleep, 50
	}
	ControlClick, , ahk_pid %WindowPID%, , Right, , NAU
	stopCurrent:=false
	Suspend, Off
Return

; Cobblestone generator
!M::
	GuiControl, , CurrentAction, Cobblestone
	Suspend, On
	isDoingSomething:=true
	ControlClick, , ahk_pid %WindowPID%, , Left, , NAD
	while (stopCurrent=false){
		Sleep, 100
	}
	ControlClick, , ahk_pid %WindowPID%, , Left, , NAU
	stopCurrent:=false
	Suspend, Off
Return

; Concrete
; I don't intend to use this, I just want to do everything XAHK does and more
!C::
	GuiControl, , CurrentAction, Concrete
	Suspend, On
	isDoingSomething:=True
	ControlClick, , ahk_pid %WindowPID%, , Right, , NAD
	Sleep, 50
	ControlClick, , ahk_pid %WindowPID%, , Left, , NAD
	while (stopCurrent=False){
		sleep, 100
	}
	ControlClick, , ahk_pid %WindowPID%, , Right, , NAU
	Sleep, 50
	ControlClick, , ahk_pid %WindowPID%, , Left, , NAU
	stopCurrent:=False
	Suspend, Off
Return

#If WinActive("ahk_pid " . WindowPID)
	!Space::
		Suspend, Permit
		; Why exactly I need to do it like this is anyone's guess
		Send {Space down}
		Sleep 75
		Send {Space up}
		Sleep 200
		Send {Space down}
		Sleep 75
		Send {Space up}
		Sleep 50
		Click, Right
	Return
#If
