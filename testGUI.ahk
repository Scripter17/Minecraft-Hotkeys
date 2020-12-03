#SingleInstance, force

Gui, New, , Minecraft QOL hotkeys
Gui, Add, Text, x12 y9 w160 h20, Minecraft QOL/AFK hotkeys
Gui, Add, Radio, x12 y39 w80 h20 gFishing, Fishing
Gui, Add, Radio, x12 y59 w80 h20 gGrinding, Grinding
Gui, Add, Radio, x12 y79 w80 h20 gFighting, Fighting
Gui, Add, Text, x92 y39 w80 h20, Alt+F
Gui, Add, Text, x92 y59 w80 h20, Alt+G
Gui, Add, Text, x92 y79 w80 h20, Alt+K
Gui, Add, Text, x242 y109 w70 h20, u/Scripter17
Gui, Add, Text, x242 y129 w70 h20, Alpha 0.1
Gui, Add, Text, x242 y149 w70 h20, 2020-12-03
; Generated using SmartGUI Creator 4.0
Gui, Show, h180 w320, Minecraft QOL hotkeys
Return
GuiClose:
ExitApp
Fishing:
HotKey !f, On
HotKey !g, Off
HotKey !k, Off
return
Grinding:
HotKey !f, Off
HotKey !g, On
HotKey !k, Off
return
Fighting:
HotKey !f, Off
HotKey !g, Off
HotKey !k, On
return
!f::
MsgBox, f
Return
!g::
MsgBox, g
Return
!k::
MsgBox, k
Return
HotKey !f, Off
HotKey !g, Off
HotKey !k, Off
