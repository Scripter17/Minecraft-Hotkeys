; Minecraft-Hotkeys by Github@Scripter17
; Version 0.4.1
; Original concept stolen from https://github.com/monpjc/XAHK
#SingleInstance, force
version:="v0.5.0-pre"
date:="2021-06-01"
; Initialize the GUI
; The 4 AFK hotkeys
; TODO: Maybe a for loop?
; TODO: Contribute to AHK V2's source code to ensure for loops don't suck nearly as much ass in the future
Gui, Add, Link,   x10  y10 w110 h20, AFK <a href="https://www.youtube.com/watch?v=-wKW0OovGK4">Fishing</a>:
Gui, Add, Text,   x120 y10 w30  h20, Alt+F
Gui, Add, Slider, x150 y10 w60  h20 ToolTip Range100-1000 TickInterval225 vFishingInterval

Gui, Add, Text, x10  y30 w110 h20, AFK Mob Grinding:
Gui, Add, Text, x120 y30 w30  h20, Alt+G

Gui, Add, Checkbox, x10 y50 vDoSwapping gSwapToggle, Swap?
For slot in [1,2,3,4,5,6,7,8,9]
	Gui, Add, Text, % "x" . (slot*25+43) .  " y50", % slot
Gui, Add, Text, x10 y70, Slots
For slot in [1,2,3,4,5,6,7,8,9]
	Gui, Add, Checkbox, % "vSwapSlot" . slot . " x" . (slot*25+40) . " y70 disabled", % chr(8203)
Gui, Add, Text, x10 y90, Weapon
For slot in [1,2,3,4,5,6,7,8,9]
	Gui, Add, Radio, % "vWeaponSlot" . slot . " x" . (slot*25+40) . " y90 gSetWeapon disabled", % chr(8203)

Gui, Add, Text, x10  y110 w110 h20, AFK Cobblestone:
Gui, Add, Text, x120 y110 w30  h20, Alt+M

Gui, Add, Text, x10  y130 w110 h20, Quick concrete:
Gui, Add, Text, x120 y130 w30  h20, Alt+C

; Jump flying with an elytra and rocket
Gui, Add, Text, x10  y150 w110 h20, Elytra take off:
Gui, Add, Text, x120 y150 w80  h20, Alt+Space
; Holding MButton and L/RButton spamclicks L/Rbutton
Gui, Add, Checkbox, x10  y170 w110 h20 vMiddleSpam, Autoclick
Gui, Add, Text,     x120 y170 w100 h20, Middle+L/R mouse
Gui, Add, Slider,   x220 y170 w60  h20 vSpamInterval Range100-1000 TickInterval225 ToolTip
;Gui, Add, Text,     x280 y150, ms
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
Gui, Add, Text, x240 y240 w70 h20, %date%
; Generated using SmartGUI Creator 4.0
; https://autohotkey.com/board/topic/738-smartgui-creator
Gui, Show, h270 w320, Minecraft hotkeys %version%
Return
GuiClose:
ExitApp

SetWeapon:
	for slot in [1,2,3,4,5,6,7,8,9]
		GuiControl, Enable, SwapSlot%slot%
	newWeaponSlot:=SubStr(A_GuiControl, 0)
	Gui, Submit, NoHide
	GuiControl, Disable, SwapSlot%newWeaponSlot%
return

SwapToggle:
	Gui, Submit, NoHide
	if (DoSwapping<>0){
		for slot in [1,2,3,4,5,6,7,8,9]
			GuiControl, Enable, SwapSlot%slot%
		for slot in [1,2,3,4,5,6,7,8,9]
			GuiControl, Enable, WeaponSlot%slot%
	} else {
		for slot in [1,2,3,4,5,6,7,8,9]
			GuiControl, Disable, SwapSlot%slot%
		for slot in [1,2,3,4,5,6,7,8,9]
			GuiControl, Disable, WeaponSlot%slot%
	}
return

stopCurrent:=False
isDoigngSomething:=False

; Set the window
; This is disabled while a hotkey is running to ensure the user doesn't accidentally change it when doing other stuff
!W::
	WinGet, WindowPID, PID, A
	WinGetTitle, WindowName, A ; Why isn't this a part of WinGet?
	GuiControl, , CurrentWindow, %WindowName% (%WindowPID%) ; Set the text of the "Current Window" line
Return

; Stop the currently active hotkey
; This only works while the currently selected window is active or if it doesn't exsist anymore
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

#If WinActive("ahk_pid " . WindowPID)
	; Fishing
	!F::
		GuiControl, , CurrentAction, Fishing
		GuiControlGet, FishingInterval
		Suspend, On ; Disable any hotkey that isn't marke with "Suspend, Permit"
		isDoingSomething:=True
		while (stopCurrent<>True){ ; TODO: Figure out why =False doesn't work but <>True does
			ControlClick, , ahk_pid %WindowPID%, , Right, , NAD
			Sleep, 100
			ControlClick, , ahk_pid %WindowPID%, , Right, , NAU
			Sleep, %FishingInterval%
		}
		stopCurrent:=False
		Suspend, Off ; Re-enable the suspended hotkeys
	Return

	; Mob grinding
	!G::
		GuiControl, , CurrentAction, Grinding
		Suspend, On
		Gui, Submit, NoHide
		isDoingSomething:=True
		weaponSlot=:-1
		for slot in [1,2,3,4,5,6,7,8,9]
			if (weaponSlot%slot%){
				weaponSlot:=slot
			}
		GMainLoop:
		while (stopCurrent<>True){
			if (DoSwapping && weaponSlot<>-1){
				SetKeyDelay, 100, 100
				for slot in [1,2,3,4,5,6,7,8,9]
					if (SwapSlot%slot%){
						ControlSend, , %slot%f%weaponSlot%, ahk_pid %WindowPID%]
						Loop 10 {
							Sleep, 162
							if (stopCurrent=True){
								ControlSend, , %slot%f%weaponSlot%, ahk_pid %WindowPID%]
								break, GMainLoop
							}
						}
						ControlClick, , ahk_pid %WindowPID%, , Left, , NA
						ControlSend, , %slot%f%weaponSlot%, ahk_pid %WindowPID%
					}
			} else {
				ControlClick, , ahk_pid %WindowPID%, , Left, , NA
				Sleep, 50
				; Fun fact: It took like 20 minutes to figure out that I forgot the second comma before the NAD/NAU
				ControlClick, , ahk_pid %WindowPID%, , Right, , NAD
				Loop 10 {
					Sleep, 162
					if (stopCurrent=True){
						 ; This is the jankest solution I've ever written, but it lets you stop the key mid-eating
						break, GMainLoop
					}
				}
				Sleep, 50
			}
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
		while (stopCurrent<>True){
			ControlClick, , ahk_pid %WindowPID%, , Left, , NAD
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
		while (stopCurrent<>True){
			Sleep, 50
		}
		ControlClick, , ahk_pid %WindowPID%, , Left, , NAU
		Sleep, 50
		ControlClick, , ahk_pid %WindowPID%, , Right, , NAU
		stopCurrent:=False
		Suspend, Off
	Return

	; Elytra take off
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

	; Autoclicking
	~MButton & LButton::
		Suspend, Permit
		guicontrolget, MiddleSpam
		if (MiddleSpam=1){
			while (getKeyState("LButton", "P")){
				Click
				Sleep % SpamInterval
			}
		}
	Return
	~MButton & RButton::
		Suspend, Permit
		guicontrolget, MiddleSpam
		if (MiddleSpam=1){
			while (getKeyState("RButton", "P")){
				Click, Right
				Sleep % SpamInterval
			}
		}
	Return
#If

!+^#esc::
	; Just trust me on this
	ExitApp
return