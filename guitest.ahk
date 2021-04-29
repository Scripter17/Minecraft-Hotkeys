#SingleInstance, force

For slot in [1,2,3,4,5,6,7,8,9]
	For type in [1,2,3]
		Gui, Add, Radio, % "vSwapSlot" . slot . type . " x" . (slot*25+40) . " y" . (type*20+70) . (type=1?" Group":"") . (type=3?" gSetWeapon":" gUnsetWeapon"), % chr(8203)

Gui, Show, h270 w320, Minecraft hotkeys GUITest
Return
GuiClose:
ExitApp

SetWeapon:
	For slot in [1,2,3,4,5,6,7,8,9]
		GuiControl, Disable, SwapSlot%slot%3
return

UnsetWeapon:
	guiSlot:=SubStr(A_GuiControl, -1, 1)
	guiType:=SubStr(A_GuiControl, 0, 1)
	GuiControlGet, guiSlotIsType3, Enabled, SwapSlot%guiSlot%3
	MsgBox %A_GuiControl% %guiSlot% %guiType% %guiSlotIsType3%
	If (guiSlotIsType3=1){
		For slot in [1,2,3,4,5,6,7,8,9]
			GuiControl, Enable, SwapSlot%slot%3
	}
return
