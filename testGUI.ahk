#SingleInstance, force

Gui, Add, Text, x12 y9 w160 h20 , Minecraft QOL/AFK hotkeys
Gui, Add, Text, x52 y39 w80 h20 , Alt+F
Gui, Add, Text, x52 y59 w80 h20 , Alt+G
Gui, Add, Text, x52 y79 w80 h20 , Alt+K
Gui, Add, Text, x242 y109 w70 h20 , u/Scripter17
Gui, Add, Text, x242 y129 w70 h20 , Alpha 0.1
Gui, Add, Text, x242 y149 w70 h20 , 2020-12-03
Gui, Add, Text, x2 y39 w50 h20 , Fishing
Gui, Add, Text, x2 y59 w50 h20 , Grinding
Gui, Add, Text, x2 y79 w50 h20 , Fighting
Gui, Add, Text, x142 y39 w80 h20 , Set window:
Gui, Add, Text, x222 y39 w90 h20 , Alt+W
Gui, Add, Text, x142 y59 w90 h20 , Current Window:
Gui, Add, Text, x222 y59 w90 h40 vCurrentWindow, None
; Generated using SmartGUI Creator 4.0
Gui, Show, x328 y132 h184 w324, New GUI Window
Return

GuiClose:
ExitApp

!W::
WinGet, WindowPID, PID, A
WinGet, WindowName, ProcessName, A
GuiControl, , CurrentWindow, %WindowName%
return