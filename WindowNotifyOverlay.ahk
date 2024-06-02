/**
 * WindowNotifyOverlay.ahk
 * @namespace WindowNotifyOverlay
 * @file window overlay and notification popups using HTML
 * @version 1.0.0
 * @author mfaizsyahmi <https://github.com/mfaizsyahmi>
 * @copyright (c) mfaizsyahmi 2024
 *
 * @summary
 * 	Creates a window overlay based on HTML/CSS, which is then used to display
 * 	notifications within the window's client area.
 *  Works on both AHK Gui window and other windows, including the desktop.
 *  The Popup class implements method chaining, like good old jQuery.
 *
 * @example
 * 	1) Creating an overlay
 *		myGui := Gui()
 *		myOverlay := WindowNotifyOverlay(myGui)
 * 	OR
 *		otherWinHWND := WinGetID("A")
 *		otherOverlay := WindowNotifyOverlay(otherWinHWND)
 *
 * 	2) Create a simple popup
 *		myOverlay.PopupSimple("Hello!")
 *
 * 	3) Create and manage a popup through method chaining
 *		(myPopup := myOverlay("Hello world!","Announcement"))
 *		.InsertAt("tl") 	; places popup at top left corner of myGui
 *		.Show("in-slide-l")	; shows popup with animation sliding from left
 *		.After(5000, (p)=>p.Hide("out-zoom"))
 *							; hides popup with zoom out animation 5s after the call
 */

/** @license
 *  The MIT License (MIT)
 *
 * Copyright © 2024 mfaizsyahmi
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the “Software”), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 *
 *
 * This script includes resources from Visual Studio 2022 Image Library, the
 * inclusion of which is dictated by the Visual Studio 2022 Image Library EULA:
 *		 https://download.microsoft.com/download/0/6/0/0607D8EA-9BB7-440B-A36A-A24EB8C9C67E/Visual%20Studio%202022%20Image%20Library%20EULA.rtf
 *
 */

#Requires AutoHotkey v2.0

/**
 * WindowNotifyOverlay Class
 * 	Creates and manages HTML-based overlays over windows, and popups on top
 *
 * Nested classes:
 *	MapWith extends Map
 *	HtmlDocEvents
 *	Popup
 *
 * Static Class Properties:
 *	instances			: Array[WindowNotifyOverlay]
 *	DEFAULT_CSS			: str
 *	DOC_TEMPLATE		: str
 *	POPUP_HTML_TEMPLATE	: str
 *	COLOR_MAP			: Object[str,str]
 *	SvgIconMap			: WindowNotifyOverlay.MapWith[str,str]
 *	PopupThemeAssocMap	: WindowNotifyOverlay.MapWith[str,str]
 *
 * Static Class Methods:
 *	__New()	-> Class
 *	_Static_WM_SIZE(...)
 *
 * Constructor:
 *	__New(GuiObjOrHwnd) -> instance
 *
 * Instance Properties:
 *	__Static			: (Class prototype) - to get to the static props
 *	parentHwnd			: HWND
 *	popups				: Map[id,WindowNotifyOverlay.Popup]
 *	HtmlEvents			: WindowNotifyOverlay.HtmlDocEvents
 *	CSS					: Get -> str, Set(str)
 *	PopupHtmlTemplate	: Get -> str, Set(str)
 *	TransColor			: Get -> str, Set(str)
 *	Opacity				: Get -> int, Set(int)
 *	Doc					: Get -> HTMLDocument
 *	Wnd					: Get -> HTMLWindow
 *	StackOrder			: Get -> int, Set(int)
 *
 * Instance Methods:
 *	PopupSimple(...)
 *	Popup(...) -> WindowNotifyOverlay.Popup
 *	__Delete()
 */
Class WindowNotifyOverlay {
	/** Holds instances of this class
	 * the [also] static wm_size handler uses this to find overlay windows to handle
	 */
	static instances := []

	/** prepares the static class object
	 * @private
	 * @static
	 * @constructor
	 */
	static __New(*) {
		; makes instances' __static property point to class
		this.prototype.__Static := this
		; binds a static WM_Size handler
		OnMessage(WM_SIZE := 0x0005, ObjBindMethod(this,"_Static_WM_SIZE"))
	}

	/**
	 * adds a With method to Map, which calls a callable with itself as argument
	 * this allows further keyvalues to be set after the fact whose value refer to
	 * earlier items, without a second statement (which can't be done on class static)
	 */
	Class MapWith extends Map {
		/**
		 * @callback MapWithWithCB
		 * @param {MapWith} this - the MapWith instance
		 */
		/**
		 * @param {MapWithWithCB} callable
		 * @return this
		 */
		With(callable) {
			callable(this)
			return this
		}
	}

	/** Default CSS used to instantiate instances' html styles */
	static DEFAULT_CSS := "
	(
	html, body {
		/* must be the same colour as the trans color of the overlay */
		/* DO NOT REMOVE these markers or TransColor setting will break! */
		/*BGMARKER*/
		background-color: lime !important;
		/*BGMARKER*/
		font-family: Segoe UI;
		font-size: 10pt;
		margin: 0;
	}

	body {position: relative}
	.popup-container {position:absolute; width:50%}
	.popup-container[id*='t'] {top:0}
	.popup-container[id*='b'] {bottom:0}
	.popup-container[id*='l'] {text-align: left; left: 0}
	.popup-container[id*='c'] {text-align: center; left: 25%}
	.popup-container[id*='r'] {text-align: right; right:0}
	.popup-container[id*='t'] .popup {margin-top: 8px}
	.popup-container[id*='b'] .popup {margin-bottom: 8px}

	.popup-slot {position: relative}
	.popup {
		cursor: default;
		display: inline-block;
		background: #f0f0f0;
		border: 1px solid #505050;
		border-radius: 0px;
		text-align: left;
		margin: 0 8px;
		clear: both;
	}
	.popup .row {display:table-row;}
	.popup .side {display:table-cell; width:20px; text-align:center;
				  font-family: Noto Sans Emoji, Segoe UI Emoji, sans-serif;
				  padding:2px; margin-right:6px }
	.popup .side:empty {display:none}
	.popup .side img {width:16px;height:16px;}
	.popup .side img.s18 {width:18px;height:18px;}
	.popup .main {display:table-cell;padding: 2px 6px;vertical-align:top;}
	.popup .title {font-weight: 700;}

	/* text alignment */
	.ta-l {text-align:left} .ta-c {text-align:center} .ta-r {text-align:right}

	/* popup type styles */
	.popup-default        {color: #000000; background: #f0f0f0; border-color: #a0a0a0}
	                                 .side, .popup-default .side {background: #bababa}

	.popup-message        {color: #000000; background: #b3e6b3; border-color: #339933}
	.popup-message .title {color: #277327}  .popup-message .side {background: #40bf40}

	.popup-info           {color: #000000; background: #d0ecf9; border-color: #1BA1E2}
	.popup-info .title    {color: #1581b4}     .popup-info .side {background: #47b4e9}

	.popup-warning        {color: #000000; background: #fff5cc; border-color: #FFCC00}
	.popup-warning .title {color: #332900}  .popup-warning .side {background: #ffd633}

	.popup-error          {color: #000000; background: #ffb9b2; border-color: #E51400}
	.popup-error .title   {color: #b31000}    .popup-error .side {background: #ff2d19}

	/* transitions */
	.in-slide-t         {animation: slide-t  0.3s ease-out forwards}
	.in-slide-b         {animation: slide-b  0.3s ease-out forwards}
	.out-slide-t        {animation: slide-t  0.3s ease-in reverse both}
	.out-slide-b        {animation: slide-b  0.3s ease-in reverse both}
	.in-slide-l  .popup {animation: slide-l  0.3s ease-out forwards}
	.in-slide-r  .popup {animation: slide-r  0.3s ease-out forwards}
	.out-slide-l .popup {animation: slide-lr 0.3s ease-out forwards}
	.out-slide-r .popup {animation: slide-rr 0.3s ease-out forwards}

	.in-roll-h  .popup  {animation: roll-h   0.3s ease-out forwards}
	.in-roll-v  .popup  {animation: roll-v   0.3s ease-out forwards}
	.out-roll-h .popup  {animation: roll-h   0.3s ease-in reverse forwards}
	.out-roll-v .popup  {animation: roll-v   0.3s ease-in reverse forwards}
	.in-roll-t  .popup  {animation: roll-t   0.3s ease-out forwards}
	.in-roll-b  .popup  {animation: roll-b   0.3s ease-out forwards}
	.in-roll-l  .popup  {animation: roll-l   0.3s ease-out forwards}
	.in-roll-r  .popup  {animation: roll-r   0.3s ease-out forwards}
	.out-roll-t .popup  {animation: roll-t   0.3s ease-in reverse forwards}
	.out-roll-b .popup  {animation: roll-b   0.3s ease-in reverse forwards}
	.out-roll-l .popup  {animation: roll-l   0.3s ease-in reverse forwards}
	.out-roll-r .popup  {animation: roll-r   0.3s ease-in reverse forwards}

	.in-zoom    .popup  {animation: zoom     0.3s ease-out forwards}
	.out-zoom   .popup  {animation: zoom     0.3s ease-in reverse forwards}

	/* animation keyframes */
	@keyframes slide-t { 0% {top:-100%} 100% {top:0} }
	@keyframes slide-b { 0% {top: 100%} 100% {top:0} }
	@keyframes slide-l { 0% {transform:translate(-110%,0)} 100% {transform:none} }
	@keyframes slide-r { 0% {transform:translate( 110%,0)} 100% {transform:none} }
	@keyframes slide-lr{ 0% {transform:none} 100% {transform:translate(-110%,0)} }
	@keyframes slide-rr{ 0% {transform:none} 100% {transform:translate( 110%,0)} }

	@keyframes roll-h  { 0% {transform:scalex(0)} 100% {transform:none} }
	@keyframes roll-v  { 0% {transform:scaley(0)} 100% {transform:none} }
	@keyframes roll-t  { 0% {transform:scale(1,0) translate(0,-50%)} 100% {transform:none} }
	@keyframes roll-b  { 0% {transform:scale(1,0) translate(0, 50%)} 100% {transform:none} }
	@keyframes roll-l  { 0% {transform:scale(0,1) translate(-50%)} 100% {transform:none} }
	@keyframes roll-r  { 0% {transform:scale(0,1) translate( 50%)} 100% {transform:none} }

	@keyframes zoom    { 0% {transform:scale(0)}  100% {transform:none} }

	.invis {visibility:hidden} .hidden {display:none}
	)"

	/** HTML template for the mshtml overlay. Uses AutoHotkey Format().
	 * {1} CSS
	 */
	static DOC_TEMPLATE := "
	(
	<meta http-equiv='X-UA-Compatible' content='IE=edge'>
	<style>{1}</style>
	<body>
		<div class='popup-container' id='_tl'></div>
		<div class='popup-container' id='_tr'></div>
		<div class='popup-container' id='_tc'></div>
		<div class='popup-container' id='_bl'></div>
		<div class='popup-container' id='_br'></div>
		<div class='popup-container' id='_bc'></div>
	</body>
	)"

	/** HTML template for the Popup. Uses AutoHotkey Format().
	 * {1} ID (prefixed A_TickCount)
	 * {2} slot class
	 * {3} popup class
	 * {4} content
	 * {5} title
	 * {6} side content (icons). collapsed when empty. to keep it open use A_Space
	 * {7} custom style
	 */
	static POPUP_HTML_TEMPLATE := "
	(
	<!--1: ID (prefixed A_TickCount)
		2: slot class
		3: popup class
		4: content
		5: title
		6: side content (icons). collapsed when empty. to keep it open use A_Space
		7: custom style -->
	<div class='popup-slot hidden {2}' id='{1}'>
		<div class='popup {3}'>
			<div class='row'>
				<div class='side'>{6}</div>
				<div class='main'>
					<div class='title'>{5}</div>
					<div class='content'>{4}</div>
				</div>
			</div>
		</div>
		<style>{7}</style>
	</div>
	)"

	/** Maps HTML colour names to their Hex values
	 * @type {Object}
	 * @enum {string}
	 */
	Static COLOR_MAP := {
		Black	: "000000", Silver	: "C0C0C0", Gray	: "808080", White	: "FFFFFF",
		Maroon	: "800000", Red		: "FF0000", Purple	: "800080", Fuchsia	: "FF00FF",
		Green	: "008000", Lime	: "00FF00", Olive	: "808000", Yellow	: "FFFF00",
		Navy	: "000080", Blue	: "0000FF", Teal	: "008080", Aqua	: "00FFFF",
		DEFAULT : "000000"}

	/** Stores the SVG icons. Includes aliases. Case insensitive.
	 * NOTE: MOVED TO WindowNotifyOverlay_icons.ahk
	 * @type {WindowNotifyOverlay.MapWith}
	 * @enum {string}
	 */
	static SvgIconMap := this.MapWith()
	.With((self) => self.CaseSense := 0)

	/** Associates icon names (and their aliases) to a theme name. Case insensitive.
	 * NOTE: MOVED TO WindowNotifyOverlay_icons.ahk
	 * @type {WindowNotifyOverlay.MapWith}
	 */
	Static PopupThemeAssocMap := this.MapWith()
	.With((self) => self.CaseSense := 0)

	/** @typedef {integer} HWND handle to a window */
	/** @typedef {(HWND|Gui)} GuiOrHWND */

	/** Creates a WindowNotifyOverlay instance, which creates a transparent Gui
	 *  covering the client area of the given Gui/window
	 * @constructor
	 * @param {GuiOrHWND} GuiObjOrHwnd
	 *
	 * @throws {ValueError} GuiOrHWND not a Gui object nor a window hwnd
	 *
	 * @returns {WindowNotifyOverlay} new instance
	 */
	__New(GuiObjOrHwnd, overlayGuiOpt:="") {
		DHW := A_DetectHiddenWindows
		DetectHiddenWindows 1
		; get hwnd and client size right away
		If GuiObjOrHwnd is Gui {
			/** @member {HWND} parent window's handle */
			this.parentHwnd := GuiObjOrHwnd.Hwnd
			GuiObjOrHwnd.GetClientPos(,,&pW,&pH)
			; GuiObjOrHwnd.OnEvent("Size", ObjBindMethod(this,"_OnSize"))

		} else if WinExist(GuiObjOrHwnd) {
			/** @member {HWND} parent window's handle */
			this.parentHwnd := GuiObjOrHwnd
			WinGetClientPos(,,&pW,&pH, GuiObjOrHwnd)

		; 0 -> becomes its own fullscreen window with no parent
		} else if GuiObjOrHwnd=0 {
			this.parentHwnd := 0
			WinGetPos(,,,&taskbarH, "ahk_class Shell_TrayWnd")
			pW := A_ScreenWidth, pH := A_ScreenHeight - taskbarH

		} else throw ValueError("GuiObjOrHwnd is neither a Gui object or a window hwnd", -1)

		; register instance to static instance list
		this.__Static.instances.Push(this)

		/** @member {Gui} the overlay Gui window, child of the given window */
		this.overlayGui := overGui := Gui("-Caption "
			. (this.parentHwnd
				? "+Parent" this.parentHwnd
				; standalone gui is automatically on top (& no taskbar button)
				: "+AlwaysOnTop ToolWindow"))
		this.overlayGui.opt(overlayGuiOpt)
		overGui.BackColor := "00ff00"
		overGui.MarginX := overGui.MarginY := 0

		;EXE_NAME := A_IsCompiled ? A_ScriptName : StrSplit(A_AhkPath, "\").Pop()
		;KEY_FBE := "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BROWSER_EMULATION"
		;fbe := RegRead(KEY_FBE,EXE_NAME,""), RegWrite(0, "REG_DWORD", KEY_FBE, EXE_NAME)
		/** @member {HtmlDocument} */
		this._htmldoc := htmldoc := overGui.Add("ActiveX", "vhtml x0 y0 w" pW " h" pH,
				"mshtml:").Value
		;(fbe="") ? RegDelete(KEY_FBE,EXE_NAME) : RegWrite(fbe, "REG_DWORD", KEY_FBE, EXE_NAME)

		; <!DOCTYPE html><meta charset='utf-8'>
		htmldoc.Write(Format(this.__Static.DOC_TEMPLATE, this.__Static.DEFAULT_CSS))

		this._popuptpl := this.__Static.POPUP_HTML_TEMPLATE
		this._popups := Map()

		WinSetTransColor "00FF00", "ahk_id " overGui.Hwnd
		WinMoveTop "ahk_id " overGui.Hwnd
		overGui.Show("x0 y0 w" pw " h" pH)
		;overGui.Opt("-Caption")
		overGui.Move(,,pw,ph)

		DetectHiddenWindows DHW

		/** @member {WindowNotifyOverlay.HtmlDocEvents} event sink for this.htmldoc */
		this.HtmlEvents := this.__Static.HtmlDocEvents(this)
		ComObjConnect(this._htmldoc, this.HtmlEvents)
	}

	__Delete() {
		this.wnd.close()
		this.overGui.Destroy()
		for i, item in this.__Static.Instances
			if item = this
				return this.__Static.Instances.RemoveAt(i)
	}

	/** prototype class for the event sink for HtmlDocument instances */
	Class HtmlDocEvents {
		/**
		 * @constructor
		 * @param {WindowNotifyOverlay} parent
		 */
		__New(parent) {
			this.parent := parent
		}

		/**
		 * @private
		 * @param {HtmlDocument} doc - the HtmlDocument that initiated the event
		 * @param {HTMLElementEvent} [&event] - the event object
		 * @param {HTMLElement} [&element] - the event's target element
		 * @param {HTMLElement} [&popupEl] - the popup element containing/being the target
		 * @param {HTMLElement} [&popupSlotEl] - the popup slot element containing/being the target
		 * @param {HTMLElement} [&popupContainerEl] - the container element containing the target
		 * @param {WindowNotifyOverlay.Popup} [&popupInstance] - the instance handling the popup
		 */
		_getCommonProps(doc, &event, &element,
		&popupEl?, &popupSlotEl?, &popupContainerEl?, &popupInstance?) {
			event := doc.parentWindow.event
			outerEl := element := event.target
			while (outerEl.tagName != "body") {
				(outerEl.classList.contains("popup")) ? popupEl := outerEl : 0
				(outerEl.classList.contains("popup-slot")) ? popupSlotEl := outerEl : 0
				(outerEl.classList.contains("popup-container")) ? popupContainerEl := outerEl : 0
				outerEl := outerEl.parentNode
			}
			popupInstance := (popupSlotEl.id)
				? this.parent._popups[popupSlotEl.id] : 0
		}

		_dispatchEvents(eventList, args*) {
			for event in eventList
				event(args*)
		}

		/** the click event handler of the parent HtmlDocument
		 * @param {HtmlDocument} doc - event sinks get passed the parent object
		 *		by default as the last argument. The HtmlDocument doesn't seem
		 *		to pass any arguments (in particular, the event object) so it is
		 *		the only argument. Event objects are instead retrieved as a
		 *		property of the document's parentWindow object. This is an
		 *		ancient DOM spec used by this version of HtmlDocument (mshtml).
		 */
		onclick(doc,*) {
			this._getCommonProps(doc,&e,&el,,&popupSlot,,&popupInst)
			if popupInst {
				; dispatch events to popup instances. parameters passed:
				; 1: instance whose event is being dispatched
				; 2: js event
				; 3: element involved (anchor for link, otherwise popupSlot)
				; 4: [for link] link's href
				if StrCompare(el.tagName,"A")==0 && popupInst.EventMap.has("LinkClick")
					this._dispatchEvents(popupInst.EventMap["LinkClick"],
						popupInst, e, el, el.href)
				else if popupInst.EventMap.has("Click")
					this._dispatchEvents(popupInst.EventMap["Click"],
						popupInst, e, popupSlot)
				else ; dismiss with prejudice
					popupInst.Remove()
			}
		}

		/** the context menu event handler of the parent HtmlDocument
		 * @param {HtmlDocument} doc - @see {@link this.onclick}
		 */
		onContextMenu(doc,*) {
			this._getCommonProps(doc,&e,&el,,&popupSlot,,&popupInst)
			; disables context menu everywhere but in links
			if el.tagName != "A" {
				e.preventDefault()
				if popupInst.EventMap.has("Click")
					this._dispatchEvents(popupInst.EventMap["Click"],
						popupInst, e, popupSlot)
			}
			; doc.parentWindow.event.returnValue := false
		}
	}

	/**
	 * receives callback of WM_SIZE message
	 * this is made static so that only one is needed
	 */
	static _Static_WM_SIZE(wParam, lParam, msg, hwnd) {
		If wParam = 1 ; minimized
			Return
		; this should run on a new thread and doesn't go anywhere so should be fine
		DetectHiddenWindows 1
		WinGetClientPos(,,&width,&height, "ahk_id " hwnd)
		for inst in this.instances
			if (hwnd = inst.parentHwnd) {
				inst.overlayGui.Move(,,width, height)
				inst.overlayGui["html"].Move(,,width, height)
				Return
			}
	}

	; INSTANCE PROPERTIES ------------------------------------------------------
	/** GETTER
	 * @property
	 * @returns {string} CSS of the HtmlDoc's main style element
	 */
	/** SETTER
	 * @property
	 * @param {string} value - CSS string to write to the HtmlDoc's main style element
	 */
	CSS[*] {
		get => this._htmldoc.GetElementsByTagName("style").item(0).innerText
		set => this._htmldoc.GetElementsByTagName("style").item(0).innerText := value
	}

	/** GETTER
	 * @property
	 * @returns {string} HTML string of the popup template
	 */
	/** SETTER
	 * @property
	 * @param {string} value - HTML string to set as the popup's template
	 */
	PopupHtmlTemplate[*] {
		get => this._popuptpl
		set => this._popuptpl := value
	}

	_csscolor(val) {
		if val ~= "i)^[0-9a-f]+$"
			return "#" val
		else if this.__Static.COLOR_MAP.HasProp(val)
			return this.__Static.COLOR_MAP.%val%
		else
			return val
	}
	/** GETTER
	 * @property
	 * @returns {string} Colour name or RGB HEX value of the transparency
	 */
	/** SETTER
	 * @property
	 * @param {string} value - Colour name or RGB HEX value of the transparency
	 */
	TransColor[*] {
		get => this.hasProp("_transColor") ? this._transColor : this.overlayGui.BackColor
		set {
			valfix := this._csscolor(value)
			this.overlayGui.BackColor := this._transColor := Value
			;this.css := RegExReplace(this.css, "(\/\*BGMARKER\*\/)(.*)\1",
			;"$1background-color: #" valfix " !important;$1")
			this.Doc.documentElement.style.backgroundColor := valfix " !important"
			this.Doc.body.style.backgroundColor := valfix " !important"
			Try WinSetTransColor Value " " this.opacity, this.overlayGui
		}
	}

	/** GETTER
	 * @property
	 * @returns {integer} Opacity value (0-255)
	 */
	/** SETTER
	 * @property
	 * @param {integer} value - Opacity value (0-255)
	 */
	Opacity[*] {
		get => this.hasProp("_opacity") ? this._opacity : 255
		set {
			this._opacity := value
			WinSetTransColor this.TransColor " " value, this.overlayGui
		}
	}

	/** GETTER
	 * @property
	 * @readonly
	 * @returns {HtmlDocument} instance's HtmlDocument object
	 */
	Doc => this._htmldoc
	/** GETTER
	 * @property
	 * @readonly
	 * @returns {ComObject} instance's HtmlDocument's window object
	 */
	Wnd => this._htmldoc.parentWindow

	/** GETTER
	 * @property
	 * @returns {integer} 0: at beginning of stack, 1: at end of stack
	 */
	/** SETTER
	 * @property
	 * @param {integer} value - 0: at beginning of stack, 1: at end of stack
	 */
	StackOrder[*] {
		; 0: at beginning of stack
		; 1: at end of stack
		; (reversed for popups positioned at the bottom)
		get => this.hasProp("_stackorder") ? this._stackorder : 1
		set => this._stackorder := value
	}

	/**
	 * Exposes the internal popup Map
	 * DO NOT add or remove items directly. Instead use the Popup() method to add,
	 * and call the individual popup's Remove() method to remove.
	 * @property
	 * @readonly
	 * @type {Map}
	 */
	Popups[id?] => IsSet(id) ? this._popups.get(id, 0) : this._popups

	_container[pos] => this._htmldoc.GetElementById("_" StrLower(pos))
	_insertAt(pos, el) {
		adjacency := (pos ~= "i)t" && this.StackOrder) || (pos ~= "i)b" && !this.StackOrder)
			? "beforeEnd" : "afterBegin"
		this._container[StrLower(pos)].insertAdjacentElement(adjacency, el)
	}
	_encUrl(path) => this.wnd.EncodeUri(path)
	_popupId(id) => id

	; POPUP METHODS ------------------------------------------------------------
	/**
	 * A one-call popup that runs on autopilot
	 * @param {array} args - @see {@link WindowNotifyOverlay.Popup.__New}
	 */
	PopupSimple(args*) {
		static animMap := this.__Static.Popup.autoAnimMap
		popupFn(args*) {
			(myPopup := this.Popup(args*))
			.Show("in-" animMap[myPopup.Pos])
			.After(5000,(p)=>p.Hide("out-" animMap[myPopup.Pos]))
		}
		SetTimer popupFn.Bind(args*), -1
	}
	/**
	 * creates a popup, and you chain all the settings and events
	 * @param {array} args - @see {@link WindowNotifyOverlay.Popup.__New}
	 * @return {WindowNotifyOverlay.Popup} popup instance
	 */
	Popup(args*) {
		ID := Format("POPUP_{:x}_{:02x}", A_TickCount, Random(0,0xffff))
		newPopupObj := this.__Static.Popup(this,ID,args*)
		this._popups[ID] := newPopupObj
		return newPopupObj
	}

	/**
	 * Clears popups in position, or all of them
	 */
	Clear(pos?) {
		itemsToRemove := []
		For id, popupInst in this.Popups
			if IsSet(pos) && popupInst.Pos != pos
				Continue
			Else
				itemsToRemove.Push(popupInst)
		For popupInst in itemsToRemove
			popupInst.Remove()
	}

	/**
	 * WindowNotifyOverlay.Popup
	 *	Default popup class for WindowNotifyOverlay
	 *	This class is designed to be chainable. good ol' jquery paradigm.
	 *	All popups should only be instantiated from WindowNotifyOverlay
	 *	instance's .Popup() method
	 *
	 * Static Class Properties:
	 *	qsMap		: Map[str,str]
	 *	autoAnimMap	: Map[str,str]
	 *  DefaultTitle: String
	 *  DefaultIcon	: String
	 *  DefaultTheme: String
	 *  DefaultPos	: String
	 *
	 * Constructor:
	 *	__New(owner,ID,text,title:="",icon:="",theme:="",pos:="") -> instance
	 *
	 * Instance Properties:
	 *	__Static	: (Class prototype) - to get to the static props
	 *	popupEl		: HTMLElement
	 *	SubElement	: Get[key] -> HTMLElement
	 *	CSS			: Get -> str, Set[str]
	 *	EventMap	: Get -> Map[str,callable]
	 *	Pos			: Get -> str, Set[str]
	 *
	 * Instance Methods:
	 *	SetCSS(css) -> self
	 *	SetAnimationDuration(ms) -> self
	 *	SetItemStyle(target:="popup", styleStr?) -> self
	 *	SetFont(options?, name?, target:="popup") -> self
	 *	SetTextAlign(textAlign:="l", target:="popup") -> self
	 *	SetIconSize(w?, h?) -> self
	 *	OnEvent(name, callable) -> self
	 *	InsertAt(pos) -> self
	 *	Show(animationClass := "", wait := 300) -> self
	 *	After(wait, callback) -> self
	 *	Wait(duration:=5000) -> self
	 *	Hide(animationClass := "", deleteAfter := 300) -> self
	 *	Remove()
	 */
	Class Popup {
		; makes instances' __static property point to class
		static __New(*) => this.prototype.__Static := this
		/**
		 * maps sub-element names and their corresponding querySelector selector
		 * @type {Map}
		 * @enum {string}
		 */
		static qsMap := Map(
			"popupSlot",".popup-slot",  "popup",".popup",
			"side",".side",  "title",".title",  "content",".content",  "styleEl","style"
		)
		/**
		 * maps per-position default animation
		 * @type {Map}
		 * @enum {string}
		 */
		static autoAnimMap := Map( ; per-position default animation
			"tl","slide-l",  "tc","slide-t",  "tr","slide-r",
			"bl","slide-l",  "bc","slide-b",  "br","slide-r" )

		; Set these values to make popups use them by default
		static DefaultTitle := ""
		static DefaultIcon := ""
		static DefaultTheme := "" ; will infer from icon first before loading this
		static DefaultPos := "bl"

		/**
		 * Popup constructor
		 * @constructor
		 * @param {WindowNotifyOverlay} owner - an instance of WindowNotifyOverlay
		 * @param {string} ID - identify both the dom and the popup instance in
		 * 		WindowNotifyOverlay's list
		 * @param {string} text - text to display. prefix with "HTML:" to pass HTML string
		 * @param {string} [title] - title to display. prefix with "HTML:" to pass HTML string
		 * @param {string|path} [icon] - path to image or name matching a key of SvgIconMap.
		 *		prefix with "HTML:" to pass HTML string. If 0-length string, will
		 *		collapse the side panel. Use whitespace to keep open.
		 * @param {string} [theme] - one of the following:
		 * 		- "info" (blue)
		 * 		- "message" (green)
		 * 		- "warning" (yellow)
		 * 		- "error" (red)
		 *		- "default"
		 * 		if blank, will try to infer from icon, defaulting to "default"
		 * @param {string} [pos] - where to place the popup. one of <tl|tc|tr|bl|bc|br>
		 *
		 * @returns {WindowNotifyOverlay.Popup} instance
		 */
		__New(owner,ID,text,title:="",icon:="",theme:="",pos:="") {
			this.owner := owner, this.ID := ID

			; set defaults if set in static class
			; EXCLUDES theme to let it infer from icon first before loading the default!
			For name in ["Title", "Icon", "Pos"]
				If !StrLen(%name%) && StrLen(this.__Static.Default%name%)
					%name% := this.__Static.Default%name%
			/*
			If !StrLen(title) && StrLen(this.__Static.DefaultTitle)
				title := this.__Static.DefaultTitle
			If !StrLen(icon) && StrLen(this.__Static.DefaultIcon)
				icon := this.__Static.DefaultIcon
			If !StrLen(theme) && StrLen(this.__Static.DefaultTheme)
				theme := this.__Static.DefaultTheme
			If !StrLen(pos) && StrLen(this.__Static.DefaultPos)
				pos := this.__Static.DefaultPos
			*/

			; icon to side content
			If icon ~="i)^html:"
				sideHtml := RegExReplace(icon,"i)^html:")
			Else If FileExist(icon)
				sideHtml := '<img src="file://' owner._encUrl(StrReplace(icon,"\","/")) '">'
			Else If icon ~= "i)^https?://|^data:image/"
				sideHtml := '<img src="' icon '">' ; "
			Else If owner.__Static.SvgIconMap.Has(icon)
				sideHtml := Format('<img src="data:image/svg+xml;base64,{}" class="{}">',
					owner.wnd.btoa(owner.__Static.SvgIconMap[icon]),
					icon ~= "18$" ? "s18" : "")
			Else If icon ~= "^\s+$"
				sideHtml := A_Space
			Else
				sideHtml := ""

			; theme to popup-theme class
			If trim(theme) ~= "i)^(info|message|warning|error|default)$"
				popupThemeClass := "popup-" trim(theme)
			Else If !StrLen(theme) && owner.__Static.PopupThemeAssocMap.Has(icon)
				popupThemeClass := "popup-" owner.__Static.PopupThemeAssocMap[icon]
			Else If !StrLen(theme) && StrLen(this.__Static.DefaultTheme)
				popupThemeClass := "popup-" this.__Static.DefaultTheme
			Else
				popupThemeClass := "popup-default"

			tempContainer := owner.doc.createElement("div")
			; sanitize both text and title (unless they have HTML: at the start)
			sanitize(str) {
				tempContainer.InnerText := str
				return tempContainer.InnerHTML
			}
			text := (text~="i)^html:") ? RegExReplace(text,"i)^html:") : sanitize(text)
			title := (title~="i)^html:") ? RegExReplace(title,"i)^html:") : sanitize(title)

			; create the dom structure inside the tempContainer
			tempContainer.innerHtml := Format(owner.PopupHtmlTemplate,
				ID, "", popupThemeClass, text, title, sideHtml, "")
			; the tempContainer must be inserted into the document body...
			owner.doc.body.insertBefore(tempContainer)
			; ...for this to work
			/**
			 * @property
			 * @type {HTMLElement}
			 */
			this.popupEl := owner.doc.GetElementById(ID)

			/**
			 * Instantiate the event map. Case-insensitive.
			 * Default click event removes it.
			 * @private
			 * @property
			 * @type {Map}
			 */
			this._eventMap := Map(), this._eventMap.CaseSense := 0
			;this._eventMap["click"] := (*) => this.Remove()

			; place the popup in one of the positions
			(pos) ? this.InsertAt(pos) : this.InsertAt("bl")
		}

		/**
		 * @property
		 * @param {string} key - name of sub-element
		 *
		 * @throws {ValueError} Unknown sub-element name key
		 *
		 * @returns {HTMLElement} sub-element
		 */
		SubElement[key] {
			get {
				If !this.__Static.qsMap.Has(key)
					Throw ValueError("Unknown sub-element name: " key, -1)
				Return (key = "popupSlot")
					? this.popupEl : this.popupEl.querySelector(this.__Static.qsMap[key])
			}
		}

		ContentText[*] {
			get => this.SubElement["content"].innerText
			set => this.SubElement["content"].innerText := value
		}
		ContentHTML[*] {
			get => this.SubElement["content"].innerHTML
			set => this.SubElement["content"].innerHTML := value
		}
		TitleText[*] {
			get => this.SubElement["title"].innerText
			set => this.SubElement["title"].innerText := value
		}
		TitleHTML[*] {
			get => this.SubElement["title"].innerHTML
			set => this.SubElement["title"].innerHTML := value
		}
		SideText[*] {
			get => this.SubElement["side"].innerText
			set => this.SubElement["side"].innerText := value
		}
		SideHTML[*] {
			get => this.SubElement["side"].innerHTML
			set => this.SubElement["side"].innerHTML := value
		}

		/** GETTER
		 * @property
		 * @returns {string} CSS inside the popup's style element
		 */
		/** SETTER
		 * @property
		 * @param {string} value - CSS string to write to the popup's style element
		 */
		CSS[*] {
			get => this.SubElement["styleEl"].innerText
			set => this.SubElement["styleEl"].innerText := value
		}

		/**
		 * @method
		 * @param {string} value - CSS string to write to the popup's style element
		 *
		 * @returns {WindowNotifyOverlay.Popup} self
		 */
		SetCSS(css) { ; chainable variant
			this.CSS := css
			return this
		}

		/**
		 * Writes an overriding animation-duration property to the popup's css
		 * @method
		 * @param {integer} ms - time in milliseconds
		 *
		 * @returns {WindowNotifyOverlay.Popup} self
		 */
		SetAnimationDuration(ms) {
			this.CSS .= Format("#{1}, #{1} .popup {{}animation-duration: {2}s{} !important}",
				this.ID, ms/1000)
			return this
		}

		/**
		 * Writes a CSS selector for the target sub-element and passes the given
		 * style declarations.
		 * NOTE: successive calls with the same sub-element results in duplicate
		 * selectors for the sub-element. CSS order of precedence applies.
		 * Declarations not overridden will remain in effect.
		 *
		 * @method
		 * @param {string} [target] - sub-element name
		 * @param {string} [styleStr] - css style declarations
		 *
		 * @returns {WindowNotifyOverlay.Popup} self
		 */
		SetItemStyle(target:="popup", styleStr?) {
			if IsSet(styleStr) {
				(!this.__Static.qsMap.Has(target)) ? target := "popup" : 0
				this.CSS .= Trim(Format("#{1} {2} {{}{3}{}} ",
					this.ID, this.__Static.qsMap[target], styleStr))
			}
			return this
		}

		/**
		 * Sets font options for the whole popup or a sub-element.
		 * Uses similar syntax to AHKv2's Gui.SetFont
		 * @see {@link https://www.autohotkey.com/docs/v2/lib/Gui.htm#SetFont|Gui.SetFont}
		 *
		 * @method
		 * @param {string} [options] - list of options. See link.
		 * 		Additional options:
		 *		- overline
		 * 		Unsupported options:
		 *		- Q (quality)
		 * @param {string} [name] - a font name, or list of names or families
		 * 		separated by comma.
		 *		Directly corresponds to CSS font-family property.
		 * @param {string} [target] - sub-element name to apply style to.
		 * 		Defaults to the whole popup.
		 *
		 * @returns {WindowNotifyOverlay.Popup} self
		 */
		SetFont(options?, name?, target:="popup") {
			static optRe := "ix)"
				. "\b(?P<word>norm|bold|italic|strike|underline|overline)\b"
				. "|\bs(?P<s>\d+)\b | \bc(?P<c>\w+)\b | \bw(?P<w>\d+)\b"
			static opt2CssMap := Map(
				"s", (v)=>"font-size:" v "pt;",
				"c", (v)=>"color:" (v~="i)[0-9a-f]{3,6}"?"#" v: v) ";",
				"w", (v)=>"font-weight:" v ";",
				"word", (v)=> {
					norm:		"font-style:normal;font-weight:normal;"
								. "text-decoration:none;",
					italic:		"font-style:italic;",
					bold:		"font-weight:bold;",
					strike:		"text-decoration:line-through;",
					underline:	"text-decoration:underline;",
					overline:	"text-decoration:overline;",
				}.%StrLower(v)%,
			)

			optMap := Map(), pos:= 1
			If IsSet(options)
				While (RegExMatch(options, optRe, &m, pos)) {
					pos := m.pos + m.len
					loop m.Count
						if m[A_Index]
							optMap[m.Name[A_Index]] := m[A_Index]
				}

			cssProps := ""
			(isSet(name)) ? cssProps .= "font-family:" name ";" : 0
			for k, v in optMap
				(opt2CssMap.Has(k)) ? cssProps .= opt2CssMap[k](v) : 0

			return this.SetItemStyle(target, cssProps)
		}

		/**
		 * Sets text alignment for the whole popup or a sub-element.
		 *
		 * @method
		 * @param {string} [textAlign] - one of <l|c|r>.
		 * @param {string} [target] - sub-element name to apply style to.
		 * 		Defaults to the whole popup.
		 *
		 * @throws {ValueError} Unknown textAlign value
		 *
		 * @returns {WindowNotifyOverlay.Popup} self
		 */
		SetTextAlign(textAlign:="l", target:="popup") {
			if !(textAlign ~= "i)l|c|r")
				Throw ValueError("Unknown value given. Must be <L|C|R>.", -1)
			this.SubElement[target].className := RegExReplace(this.popupEl.className, "i)ta-\w")
				. " ta-" StrLower(textAlign)
			return this
		}

		/**
		 * Sets size of the side image
		 *
		 * @param {string} [w] - width in CSS units (or px if omitted)
		 * @param {string} [h] - height in CSS units (or px if omitted)
		 *
		 * @returns {WindowNotifyOverlay.Popup} self
		 */
		SetIconSize(w?,h?) {
			if !IsSet(w) && !IsSet(h)
				return

			w := IsSet(w) ? w : "auto"
			h := IsSet(h) ? h : "auto"
			css := "width:" w (w~="[\w%]+$" ? "" : "px") ";"
				.  "height:" h (h~="[\w%]+$" ? "" : "px") ";"

			this.CSS .= Trim(Format("#{1} .side img {{}{2}{}} ", this.ID, css))
			return this
		}

		/** GETTER
		 * Values MUST be callable
		 * Use OnEvent as the proper way to add event callbacks
		 * @property
		 * @returns {Map} event map
		 */
		EventMap => this._eventMap
		/*
		Events[name] {
			get => this._eventMap.Has(name) ? this._eventMap[name] : (*)=>0
			set {
				If !(value.HasMethod())
					Throw Error("Value not callable", -1)
				this._eventMap[name] := value
			}
		}
		*/

		/** @typedef {string} URL */
		/**
		 * @callback PopupClickEvent
		 * @param {WindowNotifyOverlay.Popup} popupInst - the popup instance
		 * @param {HTMLElementEvent} event - the event object
		 * @param {HTMLElement} popupSlotEl - the popup slot element containing/being the target
		 */
		/**
		 * @callback PopupLinkClickEvent
		 * @param {WindowNotifyOverlay.Popup} popupInst - the popup instance
		 * @param {HTMLElementEvent} event - the event object
		 * @param {HTMLElement} linkEl - the link element clicked
		 * @param {URI} href - the href property of the link element
		 */
		/** @typedef {PopupClickEvent|PopupLinkClickEvent} PopupEvent */

		/**
		 * Proper way to register callback for events.
		 *
		 * @method
		 * @param {string} name - event name
		 * @param {PopupEvent} callable - event callback
		 * @param {integer} AddRemove where to place the callback
		 *
		 * @throws {ValueError} callable not a callable
		 *
		 * @returns {WindowNotifyOverlay.Popup} self
		 */
		OnEvent(name, callable, AddRemove:=1) {
			If !callable.HasMethod()
				Throw ValueError("Value not callable", -1)

			If !this.EventMap.Has(name)
				this.EventMap[name] := []

			If AddRemove = -1
				this.EventMap[name].InsertAt(1,callable)
			Else If AddRemove = 1
				this.EventMap[name].Push(callable)
			Else If AddRemove = 0
				For i, item in this.EventMap[name]
					If item = callable {
						this.EventMap[name].RemoveAt(i)
						Break
					}

			return this
		}

		/** GETTER
		 * @property
		 * @returns {string} string identifying popup's position in the overlay
		 */
		/** SETTER
		 * @property
		 * @param {string} value - string identifying popup's position in the overlay
		 */
		Pos {
			get => this._pos
			set => this.InsertAt(value)
		}

		/**
		 * Inserts the popup in the position given. Can be called multiple times
		 * to move to different positions.
		 *
		 * @method
		 * @param {string} pos - string identifying popup's position in the overlay
		 *
		 * @throws {ValueError} Unknown pos value
		 *
		 * @returns {WindowNotifyOverlay.Popup} self
		 */
		InsertAt(pos) {
			If !(pos ~="i)[tb][lcr]")
				Throw ValueError("Unknown position given. Must be <tl|tc|tr|bl|bc|br>.", -1)
			this.owner._insertAt(StrLower(pos), this.popupEl)
			this._pos := StrLower(pos)
			return this
		}

		/**
		 * Shows (or unhides) the popup. Optionally can set animation class to
		 * apply while doing so.
		 *
		 * @method
		 * @param {string} [animationClass] - animation class name.
		 * @param {integer} [wait=300] - wait before returning.
		 *		WARNING: this is blocking (because AHK is not multithreaded)
		 *
		 * @returns {WindowNotifyOverlay.Popup} self
		 */
		Show(animationClass := "", wait := 300) {
			If animationClass = "auto" {
				this.SubElement["popupSlot"].classList
				.add("in-" this.__Static.autoAnimMap[this.pos])
			}
			Else if StrLen(Trim(animationClass)) {
				this.SubElement["popupSlot"].classList.add(animationClass)
				this._preferredHideAnim := RegExReplace(animationClass,"i)in-","out-")
			}
			this.SubElement["popupSlot"].classList.remove("hidden")
			if wait >= 0 {
				Sleep -1
				Sleep wait
			}
			return this
		}

		/**
		 * @callback PopupAfterCB
		 * @param {WindowNotifyOverlay.Popup} this - the popup instance
		 */
		/**
		 * Runs a callback function for the popup instance after set time using
		 * a timer. This is better than using Wait() as it doesn't block the thread.
		 *
		 * @method
		 * @param {integer} wait - how long to wait after this method call
		 * @param {PopupAfterCB} callback
		 *		WARNING: this is blocking (because AHK is not multithreaded)
		 *
		 * @returns {WindowNotifyOverlay.Popup} self
		 */
		After(wait, callback) {
			If !callback.HasMethod()
				Throw Error("Value not callable", -1)
			SetTimer callback.bind(this), wait>0 ? -wait : wait
		}

		/**
		 * Waits for set time before continuing execution.
		 * WARNING: this is blocking (because AHK is not multithreaded).
		 * Use After() instead.
		 *
		 * @method
		 * @param {integer} duration - how long to wait
		 *
		 * @returns {WindowNotifyOverlay.Popup} self
		 */
		Wait(duration:=5000) {
			Sleep -1
			Sleep duration
			return this
		}

		/**
		 * Hides the popup. Optionally can set animation class to apply while doing so.
		 *
		 * @method
		 * @param {string} [animationClass] - animation class name.
		 * @param {integer} [deleteAfter=300] - wait before removing the popup
		 *		WARNING: this is blocking (because AHK is not multithreaded)
		 *
		 * @returns {WindowNotifyOverlay.Popup} self
		 */
		Hide(animationClass := "", deleteAfter := 300) {
			popupEl := this.SubElement["popupSlot"]
			popupEl.className := RegExReplace(popupEl.className, "i)in-[\w-]\b")

			If animationClass = "auto"
				animationClass := "out-" this.__Static.autoAnimMap[this.pos]
			Else If !StrLen(Trim(animationClass))
				animationClass := (this.HasProp("_preferredHideAnim"))
					? this._preferredHideAnim
					: "hidden"

			boundAsync := ((c)=>popupEl.classList.add(c))
				.Bind(Trim(animationClass))
			SetTimer boundAsync, -1

			if deleteAfter >= 0
				SetTimer ObjBindMethod(this,"Remove"), -deleteAfter
			return this
		}

		/**
		 * Removes the popup elements. Also try to remove all references to itself.
		 * @method
		 */
		Remove() {
			If !this.HasProp("_DELETED")
				Try this.popupEl.outerHtml := ""
			Try
				this.owner._popups.Delete(this.owner._popupId(this.ID))
			this._DELETED := 1
		}

		/**
		 * When all references are released, attempts to remove popup elements.
		 * @method
		 */
		__Delete() {
			this.Remove()
		}
	}

}

; The SVG icon set is in this separate file.
; To include them on every import of this library everywhere it's used,
;   uncomment the following #Include line.
; To exclude them, comment out the following #Include line.
; Alternatively, include the following #include line yourself below the #include
;   directive to this library, in scripts where and when you want to use them.
;
; #Include WindowNotifyOverlay_icons.ahk
