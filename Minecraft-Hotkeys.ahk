; Minecraft-Hotkeys by Scripter17
; Version 0.4.1
; Original concept stolen from https://github.com/monpjc/XAHK
#SingleInstance, force
version:="v0.4.1"
; Initialize the GUI
; The 4 AFK hotkeys
; TODO: Maybe a for loop?
Gui, Add, Link,   x10  y10 w110 h20, AFK <a href="https://www.youtube.com/watch?v=-wKW0OovGK4">Fishing</a>:
Gui, Add, Text,   x120 y10 w30  h20, Alt+F
Gui, Add, Slider, x150 y10 w60  h20 ToolTip Range100-1000 TickInterval225 vFishingInterval

Gui, Add, Text, x10  y30 w110 h20, AFK Mob Grinding:
Gui, Add, Text, x120 y30 w30  h20, Alt+G

Gui, Add, Text, x10  y50 w110 h20, AFK Cobblestone:
Gui, Add, Text, x120 y50 w30  h20, Alt+M

Gui, Add, Text, x10  y70 w110 h20, Quick concrete:
Gui, Add, Text, x120 y70 w30  h20, Alt+C

; Jump flying with an elytra and rocket
Gui, Add, Text, x10  y90 w110 h20, Elytra take off:
Gui, Add, Text, x120 y90 w80  h20, Alt+Space
; Holding MButton and L/RButton spamclicks L/Rbutton
Gui, Add, Checkbox, x10  y110 w110 h20 vMiddleSpam, Autoclick (M+L/R)
Gui, Add, Slider,   x120 y110 w60  h20 vSpamInterval Range100-1000 TickInterval225 ToolTip 
; Current action (only applies to the first 4)
Gui, Add, Text, x10  y200 w90 h20, Current action:
Gui, Add, Text, x100 y200 w90 h20 vCurrentAction, None
; Current window data
Gui, Add, Text, x10  y220 w90  h20, Set window:
Gui, Add, Text, x100 y220 w90  h20, Alt+W
Gui, Add, Text, x10  y240 w90  h20, Current Window:
Gui, Add, Text, x100 y240 w100 h30 vCurrentWindow, None
; Credits
Gui, Add, Link, x240 y200 w70 h20, <a href="https://github.com/Scripter17/Minecraft-Hotkeys">Scripter17</a>
Gui, Add, Text, x240 y220 w70 h20, Version %version%
Gui, Add, Text, x240 y240 w70 h20, 2020-12-05
; Generated using SmartGUI Creator 4.0
; https://autohotkey.com/board/topic/738-smartgui-creator
Gui, Show, h270 w320, Minecraft hotkeys %version%
Return
GuiClose:
ExitApp

stopCurrent:=False

; Set the window
; This is disabled while a hotkey is running to ensure the user doesn't accidentally change it when doing other stuff
!W::
	WinGet, WindowPID, PID, A
	WinGetTitle, WindowName, A
	GuiControl, , CurrentWindow, %WindowName% (%WindowPID%)
Return

; Stop the currently active hotkey
; This only works while the currently selected window is active
#If WinActive("ahk_pid " . WindowPID) || !WinExist("ahk_pid" . WindowPID)
	!S::
		Suspend, Permit
		if (isDoingSomething=True){
			stopCurrent:=True
			GuiControl, , CurrentAction, None
			isDoingSomething:=False
		}
	Return
#If

; Fishing
!F::
	GuiControl, , CurrentAction, Fishing
	guicontrolget, FishingInterval
	Suspend, On
	isDoingSomething:=True
	while (stopCurrent=False){
		ControlClick, , ahk_pid %WindowPID%, , Right, , NAD
		Sleep, 100
		ControlClick, , ahk_pid %WindowPID%, , Right, , NAU
		Sleep, %FishingInterval%
	}
	stopCurrent:=False
	; Re-enable the other hotkeys
	Suspend, Off
Return

; Mob grinding
!G::
	GuiControl, , CurrentAction, Grinding
	Suspend, On
	isDoingSomething:=True
	GMainLoop:
	while (stopCurrent=False){
		ControlClick, , ahk_pid %WindowPID%, , Left, , NA
		Sleep, 50
		; Fun fact: It took like 20 minutes to figure out that I forgot the second comma before the NAD/NAU
		ControlClick, , ahk_pid %WindowPID%, , Right, , NAD
		Loop 10 {
			Sleep, 162
			if (stopCurrent=True){
				break, GMainLoop
			}
		}
		Sleep, 50
	}
	ControlClick, , ahk_pid %WindowPID%, , Right, , NAU
	stopCurrent:=False
	Suspend, Off
Return

; Cobblestone generator
!M::
	GuiControl, , CurrentAction, Cobblestone
	Suspend, On
	isDoingSomething:=True
	ControlClick, , ahk_pid %WindowPID%, , Left, , NAD
	while (stopCurrent=False){
		Sleep, 100
	}
	ControlClick, , ahk_pid %WindowPID%, , Left, , NAU
	stopCurrent:=False
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
		Sleep, 100
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

	MButton & LButton::
		Suspend, Permit
		guicontrolget, MiddleSpam
		if (MiddleSpam=1){
			while (getKeyState("MButton", "P") && getKeyState("LButton", "P")){
				Click
				Sleep % SpamInterval
			}
		}
	Return
	MButton & RButton::
		Suspend, Permit
		guicontrolget, MiddleSpam
		if (MiddleSpam=1){
			while (getKeyState("MButton", "P") && getKeyState("RButton", "P")){
				Click, Right
				Sleep % SpamInterval
			}
		}
	Return
#If

; Just trust me on this
!+^#esc::
	ExitApp
return