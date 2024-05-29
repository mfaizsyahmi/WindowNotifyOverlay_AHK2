#Requires AutoHotkey v2.0
#SingleInstance
#INCLUDE ..\
#INCLUDE WindowNotifyOverlay.ahk
; #INCLUDE AutoXYWH_hashed.ahk ; v2 version of this library is broken
#MaxThreads 69

Main := Gui(" +Resize")
Main.AddText("xm ym w300 0x200", "Static Control")
Main.AddEdit("xm y+10 w300", "Edit Control")
Main.AddEdit("xm y+10 w300", "Edit Control + UpDown")
Main.AddUpDown()
Main.AddEdit("xm y+10 w300 r3", "Multi-Line Edit Control")
Main.AddDropDownList("xm y+10 w300 Choose1", ["DDL Control", "DDL 2", "DDL 3"])
Main.AddComboBox("xm y+10 w300 Choose1", ["CB Control", "CB 2", "CB 3"])
Main.AddCheckBox("xm y+10 w300", "CheckBox")
SGW := SysGet(SM_CXMENUCHECK := 71)
SGH := SysGet(SM_CYMENUCHECK := 72)
Main.AddCheckBox("xm y+10 Checked h" SGH " w" SGW)
Main.AddText("x+1 yp 0x200 h" SGH, "Fake Checkbox")
Main.AddCheckBox("xm y+10 w300 Check3 CheckedGray", "CheckBox CheckedGray")
Main.AddButton("xm y+10 w300", "Button")
.OnEvent("Click", (*) => MainOverlay.popupSimple("Time is " FormatTime(A_Now, "HH:mm:ss"),,"I"))
;.OnEvent("Click", (*) => InWindowNotify(Main,String(A_TickCount),"TITLE","ii alignBL d30"))
Main.AddRadio("xm y+10 w300 Group Checked", "DarkMode") ;.OnEvent("Click", ToggleTheme)
Main.AddRadio("xm y+10 w300", "LightMode") ; .OnEvent("Click", ToggleTheme)


mtab := Main.AddTab3("x+10 ym vTab",["List","CSS","Test","Create"])
mtab.UseTab(1)
	LV := Main.AddListView("w300 r10", ["LV 1", "LV 2", "LV 3"])
	loop 11
		LV.Add("", A_Index, A_Index, A_Index)
	LB_Entries := Array()
	; loop 11
	; 	LB_Entries.Push("LB " A_Index)
	global lb := Main.AddListBox("xp y+10 w300 r10", LB_Entries)

Main.OnEvent("Close", (*) => ExitApp())
Main.OnEvent("Size", Main_Size)

MainOverlay := WindowNotifyOverlay(Main)
MainOverlay.opacity := 240
; desktopHwnd := WinGetId("ahk_class Progman")
; yyy := WindowNotifyOverlay(desktopHwnd)

pad := [MainOverlay.Popup("padding1",,,,"TL").Show(),MainOverlay.Popup("padding2",,,,"TL").Show()]
test := MainOverlay.Popup("HTML:TEST and a <a href='#asdf'>link</a>","TITLE","InformationOutline",,"TL")
	.SetFont("italic","cursive","title")
	.Show()
	.OnEvent("LinkClick", (inst,e,el,*)=> MsgBox("link clicked!`n" el.href))
	.OnEvent("Click", (inst,e,el,*)=> MsgBox("clicked!`n" el.id))
	;.OnEvent("ContextMenu", (inst,e,el,*)=> MsgBox("Context menu?`n" el.id))

mtab.UseTab(2)
	global csspad
	main.SetFont(,"Fira Code")
	(csspad := Main.AddEdit("w300 r18 -wrap +hscroll +wantTab multi vCSS",))
	.OnEvent("Change",CSS_Edit)
	main.SetFont()
	Main.AddButton("y+m vbtnCssPad", "Open in new window").OnEvent("Click",(*)=>CssGui.Show())

global CssGui := Gui("+Resize","CSS Pad")
CssGui.MarginX := CssGui.MarginY := 0
CssGui.SetFont(,"Fira Code")
CssGui.AddEdit("w640 r25 -wrap +hscroll +wantTab cC0C0C0 Background202020 vCSS",)
.OnEvent("Change",CSS_Edit)
CssGui.OnEvent("Size",CssGui_Size)
CssGui_Size(cssGui, *) {
	cssGui.GetClientPos(,,&W,&H)
	cssGui["CSS"].Move(,,W,H)
}

global cssEdit_semaphore := false
CSS_Edit(ctrl,*) {
	global MainOverlay, cssEdit_semaphore
	if cssEdit_semaphore
		return
	cssEdit_semaphore := True

	if ctrl = csspad
		CssGui["CSS"].Value := ctrl.value
	else if ctrl = CssGui["CSS"]
		csspad.Value := ctrl.value
	MainOverlay.CSS := ctrl.Value

	cssEdit_semaphore := false
}
CssGui["CSS"].Value := csspad.Value := WindowNotifyOverlay.DEFAULT_CSS

mtab.UseTab(3)

	main.marginx := main.marginy := 4
	main.SetFont("underline s8","Fira Code")
	main.AddText("w150 section","Class")
	main.AddText("x+m w150 vlblText","Text")
	main.SetFont("norm","Fira Code")

	;main.AddText("xs y+4 w150","popupSlot")
	CtrlBind(main.AddEdit("xs y+m w300 vpopupSlotClass"), test.SubElement["popupSlot"],"className")
	; main.AddEdit("xs yp w100 vpopupSlot")

	;main.AddText("xs y+m w150","popup")
	CtrlBind(main.AddEdit("xs y+m w300 vpopupClass"), test.SubElement["popup"],"className")
	; main.AddEdit("x+4 yp w100 vPopup")

	;main.AddText("xs y+m w150","side")
	CtrlBind(main.AddEdit("xs y+m w150 vsideClass"), test.SubElement["side"],"className")
	CtrlBind(main.AddEdit("x+m yp w150 r3 vsideHtml"), test.SubElement["side"],"innerHtml")

	;main.AddText("xs y+m w150","title")
	CtrlBind(main.AddEdit("xs y+m w150 vtitleClass"), test.SubElement["title"],"className")
	CtrlBind(main.AddEdit("x+m yp w150 vtitleHtml"), test.SubElement["title"],"innerHtml")

	;main.AddText("xs y+m w150","content")
	CtrlBind(main.AddEdit("xs y+m w150 vcontentClass"), test.SubElement["content"],"className")
	CtrlBind(main.AddEdit("x+m yp w150 vcontentHtml"), test.SubElement["content"],"innerHtml")

	main.AddText("xs y+m w150","Style")
	main.AddEdit("x+m yp w150 readOnly vpopupID", test.ID)
	CtrlBind(main.AddEdit("xs y+m w300 r5 -wrap +hscroll +vscroll vStyleText"),
		test.SubElement["styleEl"],"innerText")

	CtrlBind(main.AddDDL("xs y+m -sort vPos",StrSplit("tl tc tr bl bc br",A_Space)),
		test,"pos")

	main.SetFont()

mtab.UseTab(4)

createTabGui()
createTabGui() {
	global main, MainOverlay
	static svgList := []
	for k in MainOverlay.__Static.SvgIconMap
		svgList.Push(k)
	static themeList := StrSplit("info|message|warning|error|default","|")
	static posList := ["tl","tc","tr","bl","bc","br"]

	main.marginx := main.marginy := 8
	main.AddText("section w40", "Title")
	main.AddEdit("x+5 w200 vnewTitle", )
	main.AddCheckBox("x+5 w50 yp+4 vnewTitleHTML", "HTML")

	main.AddText("xs w40", "Text")
	main.AddEdit("x+5 w200 vnewText r3", "Hello!")
	main.AddCheckBox("x+5 w50 yp+4 vnewTextHTML", "HTML")

	main.AddText("xs w40", "Icon")
	main.AddComboBox("x+5 w200 vnewIcon", svgList)
	main.AddCheckBox("x+5 w50 yp+4 vnewIconRnd", "Rnd")

	main.AddText("xs w40", "Theme")
	main.AddComboBox("x+5 w200 vnewTheme", ["",themeList*])
	main.AddCheckBox("x+5 w50 yp+4 vnewThemeRnd", "Rnd")

	main.AddText("xs w40", "Position")
	main.AddRadio("x+5 w60 vnewPos", "TL")
	main.AddRadio("x+5 w60", "TC")
	main.AddRadio("x+5 w60", "TR")
	main.AddRadio("xs+45 y+m w60 checked", "BL")
	main.AddRadio("x+5 w60", "BC")
	main.AddRadio("x+5 w60", "BR")
	main.AddCheckBox("xs+250 yp-21 w50 vnewPosRnd","Rnd")

	main.AddText("xs w40", "Show ")
	main.AddComboBox("x+5 w200 vnewShowAnim", ["",
		"in-slide-t", "in-slide-b", "in-slide-l", "in-slide-r",
		"in-roll-h" , "in-roll-v" ,
		"in-roll-t" , "in-roll-b" , "in-roll-l" , "in-roll-r" ,
		"in-zoom"   ])
	main.AddEdit("x+5 w50 vnewShowDur number",300)

	main.AddText("xs w40", "Hold")
	main.AddEdit("x+210 w50 vnewDur number",3000)
	main.AddCheckbox("xp-50 yp w50 vnewStay","Stay")

	main.AddText("xs w40", "Hide ")
	main.AddComboBox("x+5 w200 vnewHideAnim", ["",
		"out-slide-t", "out-slide-b", "out-slide-l", "out-slide-r",
		"out-roll-h" , "out-roll-v" ,
		"out-roll-t" , "out-roll-b" , "out-roll-l" , "out-roll-r" ,
		"out-zoom"   ])
	main.AddEdit("x+5 w50 vnewHideDur",300)

	main.AddText("xs w40", "Events")
	main.AddCheckbox("x+5 w100 vnewClickEvent","Click event")
	main.AddCheckbox("x+0 wp vnewLinkClickEvent","LinkClick event")

	(btnSimple  := main.AddButton("xs+45","Add Simple"))
	.OnEvent("Click", newPopup)
	(btnAdvance := main.AddButton("x+5","Add-vanced"))
	.OnEvent("Click", newPopup)

	newPopup(ctrl,*) {
		local myPopup
		props := main.submit(0)
		Sleep -1
		title := (props.newTitleHTML ? "HTML:" : "") props.newTitle
		text  := (props.newTextHTML  ? "HTML:" : "") props.newText
		icon  := props.newIconRnd ? svgList[Random(1,svgList.length)] : props.newIcon
		theme := props.newThemeRnd ? themeList[Random(1,themeList.length)] : props.newTheme
		pos   := props.newPosRnd ? posList[Random(1,posList.length)] : posList[props.newPos]

		if ctrl=btnSimple
			MainOverlay.popupSimple(text,title,icon,theme,pos)
		else {
			myPopup := MainOverlay.Popup(text,title,icon,theme,pos)
			if props.newClickEvent
				myPopup.OnEvent("Click",clickEvent.Bind("Click"))
			if props.newLinkClickEvent
				myPopup.OnEvent("LinkClick",clickEvent.Bind("LinkClick"))
			myPopup.Show(props.newShowAnim,props.newShowDur)
			If !props.newStay
				myPopup.After(props.newDur,
					(p)=>p.Hide(props.newHideAnim,props.newHideDur)
				)
		}
		clickEvent(which,instance,event,element,*) {
			data := (which = "linkclick") ? element.href : element.id
			If MsgBox(which " event dispatched.`ndata: " data "`nKeep the popup?",
			,"YN") = "no"
				instance.Remove()
		}
	}
}

mtab.UseTab()

opacitySlider_Change(ctrl,*) {
	MainOverlay.opacity := ctrl.Value
	ctrl.gui["opacityText"].Value := ctrl.Value
}

Main.AddSlider("xm y356 w250 range0-255 AltSubmit TickInterval16 ToolTip", MainOverlay.opacity)
	.OnEvent("Change",opacitySlider_Change)
Main.AddText("x+0 yp hp w50 right 0x200 vopacityText", MainOverlay.opacity)

global TabDlgHwnd
getTabDlgHwnd(mtab, &TabDlgHwnd)
getTabDlgHwnd(tabCtrl, &targetHwnd) {
	local nextIsTarget := false, cbPtr
	EnumCb(hwnd,*) {
		if nextIsTarget {
			targetHwnd := hwnd
			CallbackFree(cbPtr)
			return false
		}
		else if hwnd == tabCtrl.hwnd
			nextIsTarget := True
		return true
	}
	cbPtr := CallbackCreate(EnumCb)
	DllCall("EnumChildWindows", "Ptr", tabCtrl.Gui.hwnd, "Ptr", cbPtr, "Ptr", 0)
}

Main.Show("AutoSize")
mTab.Value := 3

Main_Size(main, minmax, *) {
	critical
	global mtab, TabDlgHwnd
	;static WM_SETREDRAW := 0xB
	;SendMessage(WM_SETREDRAW, false, 0, TabDlgHwnd) ; disable redraw
	If minmax = -1
		return ; do nothing for minimized window

	;AutoXYWH("wh", mtab)
	;AutoXYWH("twh", csspad)
	Main.GetClientPos(,,&winW,&winH)
	main["Tab"].GetPos(&oTabX,&oTabY)
	main["Tab"].Move(,, winW-oTabX-8, winH-oTabY-8)

	; dpi-agnostic resizing
	WinGetClientPos(&winX,&winY,,, main)
	WinGetClientPos(&tabX,&tabY,&tabW,&tabH, TabDlgHwnd)
	ControlMove(,, tabW-16, tabH-40, main["CSS"])
	ControlMove(, tabY+tabH-winY-28,,, main["btnCssPad"])

	static testTabResizeBound := testTabResize.bind(main,TabDlgHwnd)
	If mTab.Value = 3
		testTabResizeBound()
	Else ; defer if not on Test tab
		SetTimer testTabResizeBound, -100, -1
	testTabResize(main,TabDlgHwnd) {
		main["Tab"].Opt("-Redraw")
		WinGetClientPos(&winX,,,,main)
		WinGetClientPos(&tabX,,&tabW,&tabH,TabDlgHwnd)
		;ControlGetPos(&tabBaseX,,,,main["sideClass"])
		xHalf := tabX-winX + (tabW/2 + 2) ; * 96 // A_ScreenDPI
		wFull := (tabW - 8  ) ; * 96 // A_ScreenDPI
		wHalf := (tabW/2 - 6) ; * 96 // A_ScreenDPI

		for ctrl in [main["sideClass"],main["titleClass"],main["contentClass"]]
			ControlMove(,,wHalf,,ctrl)
		for ctrl in [main["popupSlotClass"], main["popupClass"],main["StyleText"]]
			ControlMove(,,wFull,,ctrl)
		for ctrl in [main["lblText"], main["sideHtml"], main["titleHtml"], main["contentHtml"], main["popupID"]]
			ControlMove(xHalf,,wHalf,,ctrl, TabDlgHwnd)

		main["Tab"].Opt("+Redraw")
		main["Tab"].Redraw()
	}
	;DllCall("RedrawWindow","Ptr",TabDlgHwnd,"Ptr",0,"Ptr",0,"UInt",RDW_INVALIDATE := 0x1, "Uint")
	;SendMessage(WM_SETREDRAW, True, 0, TabDlgHwnd) ; enable redraw
}

CtrlBind(Ctrl, obj, prop) {
	static focusGettingValue
	OnFocus()
	ctrl.OnEvent("Focus", OnFocus)
	ctrl.OnEvent("Change", OnChange)
	OnFocus(*) {
		focusGettingValue := true

		If ctrl.Type ~= "Edit|DDL"
			ctrl.Text := obj.%prop%
		Else
			ctrl.Value := obj.%prop%
		focusGettingValue := false
	}
	OnChange(*) {
		If focusGettingValue
			return
		If ctrl.Type ~= "Edit|DDL"
			obj.%prop% := StrReplace(ctrl.Text,"`n","`r`n")
		Else
			obj.%prop% := ctrl.Value
	}
}

#HotIf WinActive(Main) || WinActive(CssGui)
F9::Reload()
#HotIf
