# WindowNotifyOverlay.ahk
Window overlay and notification popups using HTML.

Creates a window overlay using HTML/CSS, which is then used to display notifications within the window's client area. Works on both AHK Gui window and other windows, including the desktop. The Popup class implements method chaining, like good old jQuery.

## Example
1) Creating an overlay
```ahk2
myGui := Gui()
myOverlay := WindowNotifyOverlay(myGui)
```
OR
```ahk2
otherWinHWND := WinGetID("A")
otherOverlay := WindowNotifyOverlay(otherWinHWND)
```

2) Create a simple popup
```ahk2
myOverlay.PopupSimple("Hello!")
```

3) Create and manage a popup through method chaining
```ahk2
(myPopup := myOverlay("Hello world!","Announcement"))
.InsertAt("tl")     ; places popup at top left corner of myGui
.Show("in-slide-l") ; shows popup with animation sliding from left
.After(5000, (p)=>p.Hide("out-zoom"))
                    ; hides popup with zoom out animation 5s after the call
```

A sandbox example is available in [Example/GuiWithOverlay.ahk](Example/GuiWithOverlay.ahk).

## `WindowNotifyOverlay` Class
Creates and manages HTML-based overlays over windows, and popups on top.

### Nested classes
#### `MapWith extends Map`
Extends the `Map` class to allow multiple calls to the same Map in the same static initialization scope.

#### `HtmlDocEvents`
Event sink for the HTMLDocument on the overlay Gui.

#### `Popup`
[WindowNotifyOverlay.Popup class](#windownotifyoverlaypopup-class)


### Static Class Properties
#### `instances`
`Array()` holding instances of WindowNotifyOverlay.

#### `DEFAULT_CSS`
Used to instantiate WindowNotifyOverlay's HTML's stylesheet.

#### `DOC_TEMPLATE`
Used to instantiate WindowNotifyOverlay's HTML layout. 

Uses AHK's `Format()`. Arguments:

1. CSS

#### `POPUP_HTML_TEMPLATE`
Used to instantiate WindowNotifyOverlay's popup markup.

Uses AHK's `Format()`. Arguments:

1. ID (prefixed `A_TickCount`)
2. slot class
3. popup class
4. content
5. title
6. side content (icons). collapsed when empty. to keep it open use `A_Space`
7. custom style


#### `COLOR_MAP`
Name: Hex RGB value.

#### `SvgIconMap`
IconName: Svg markup (From VS2022 Icon Library).

#### `PopupThemeAssocMap`
IconName: Theme.


### Static Class Methods
    __New() -> class
Binds the static `WM_SIZE` message listener below.

    _Static_WM_SIZE(...) 
Static `WM_SIZE` message handler. Loops over the `instance`s and resizes their windows when their window is resized.

### Constructor/destructor
```
__New(GuiObjOrHwnd) -> instance
```
- `GuiObjOrHwnd`
– An AHK `Gui` instance or a window hwnd.

```
__Delete()
```

### Instance Properties
#### `__Static`
The Class prototype, - to get to the static props.

#### `parentHwnd`
`HWND` of the parent.

#### `popups`
A `Map` where the key is a unique id, value is WindowNotifyOverlay.Popup instance.

#### `HtmlEvents`
Instance of `WindowNotifyOverlay.HtmlDocEvents` bound to the instance's `Doc`.

#### `CSS`
Gets/sets the main stylesheet CSS of the overlay's `Doc`.

#### `PopupHtmlTemplate`
Gets/sets the HTML used to create the popup. Copied from `WindowNotifyOverlay.POPUP_HTML_TEMPLATE` and same AHK `Format()` arguments apply.

#### `TransColor`
Gets/sets transparent colour of the overlay. The `Doc`'s background colour will automatically be updated. Defaults to lime (`#00FF00`). 

Change this if your stylesheet is clashing with the default colour.

#### `Opacity`
Gets/sets the opacity of the overlay.

#### `Doc`
Gets a reference of the overlay's `HtmlDocument`.

#### `Wnd`
Gets a reference of `Doc`'s `parentWindow`.

#### `StackOrder`
Gets/sets the stacking order of popups:

- `0`: Popups placed at the start of the stack.
- `1`: Popups placed at the end of the stack.

Start of the stack are nearest to the vertical edge of the window, and vice versa.

### Instance Methods
```
PopupSimple(text,title:="",icon:="",theme:="",pos:="") -> unset
```
Creates a simple popup. Displays for 5 seconds.

See the `Popup()` method below for the arguments.

```
Popup(text,title:="",icon:="",theme:="",pos:="") -> WindowNotifyOverlay.popup
```
Creates a popup and returns a `WindowNotifyOverlay.Popup` instance.

- `text` 
– Text of the popup. To use HTML markup prepend with `HTML:`.
- `title` 
– [optional] Title of the popup. To use HTML markup prepend with `HTML:`.
- `icon`
– [optiona] Icon to display. Enter a local path, a URL, whitespace, or a named value.

    - Omitting the argument, or passing an empty string, removes the side slot where icons are displayed. To keep it open, use whitespace e.g. `A_Space`.
    - A list of named values are in the Name and Abbr. columns below:

| Name			| Abbr.	| Mock	| Theme		|
|---------------|-------|-------|-----------|
| `Alert`		| `!`	| <!>	| error		|
| `Error`		| `E`	| (X)	| error		|
| `Excluded`	| `-`	| (-)	| error		|
| `Help`		| `?`	| (?)	| info		|
| `Information`	| `I`	| (i)	| info		|
| `Invalid`		| `Inv`	| (!)	| warning	|
| `No`			| `NO`	| (\\)	| error		|
| `OK`			| `OK`	| (/)	| message	|
| `Paused`		| `PP`	|		| info		|
| `Required`	| `*`	| (*)	| warning	|
| `Running`		| `PR`	|		| message	|
| `Stopped`		| `PS`	|		| error		|
| `Warning`		| `W`	| /!\\	| warning	|

- `theme`
– [optional] A theme to apply. Any of the words in the above table, or `default`. 
    - If omitted or left blank, fill infer from `icon` if it contains a word from the above table, otherwise defaults to `default`.

- `pos`
– [optional] Where to place the popup. Values are: 

|   |   |   |
|---|---|---|
|`tl` (top left)   |`tc` (top center)   |`tr` (top right)   |
|`bl` (bottom left)|`bc` (bottom center)|`br` (bottom right)|

## `WindowNotifyOverlay.Popup` Class
Default popup class for `WindowNotifyOverlay`.
This class is designed to be chainable. Good ol' jQuery paradigm.

All popups should only be instantiated from `WindowNotifyOverlay` instance's `Popup()` method.

### Static Class Properties
#### `qsMap`
`Map` where the keys are the valid sub-element components of the popup, and the value CSS selector to select it.

#### `autoAnimMap`
`Map` for default animation names for each popup position (sans `in-` and `out-` prefixes).

### Constructor/destructor
```
__New(owner,ID,rest*) -> instance
```
- `owner`
– `WindowNotifyOverlay` instance creating this popup
- `ID`
– Unique ID used by the creating `WindowNotifyOverlay` instance to identify both the `Popup` instance and the popup inserted in its HTML.
- `rest*`
– Same arguments as `WindowNotifyOverlay.Popup()`.

```
__Delete()
```

### Instance Properties
#### `__Static`
The Class prototype, - to get to the static props.

#### `owner`
The `WindowNotifyOverlay` instance that manages this popup.

#### `ID`
ID of this popup.

#### `popupEl`
Gets reference to the main popup HtmlElement.

#### `SubElement[key]`
Gets reference to a sub-element of the popup. Valid key names are the keys of the static `qsMap`.

#### `CSS`
Gets/sets the stylesheet CSS that is part of the popup.

Note: This doesn't use the Shadow DOM, so all selectors must start with an id selector targeting the `ID` of the popup.

#### `EventMap`
The `Map` holding the callable event handlers assigned to this popup.

DO NOT assign keyvalues to this Map directly. Use the `OnEvent` method.

#### `Pos`
Gets/sets the position of this popup. Values are same as `WindowNotifyOverlay.Popup()`'s `pos` argument.

You can set this repeatedly, and the popup will move to the given positions.

Where the popup would be placed in the stack is dictated by the owner `WindowNotifyOverlay`'s `StackOrder` property.

### Instance Methods
All the following methods except `Remove()` returns the popup instance so you can chain multiple methods in a single call.

```
SetCSS(css) -> self
```
Sets CSS for the style element attached to the popup. Chaining method alternative to the `CSS` property.

```
SetAnimationDuration(ms) -> self
```
Adds CSS declaration to the attached style element to override the animation duration set in the owner `WindowNotifyOverlay`'s stylesheet.

```
SetItemStyle(target:="popup", styleStr?) -> self
```
Writes a CSS selector for the target sub-element and passes the given style declarations.

NOTE: successive calls with the same sub-element results in duplicate selectors for the sub-element. CSS order of precedence applies. Declarations not overridden will remain in effect.

```
SetFont(options?, name?, target:="popup") -> self
```
Sets font options for the whole popup or a sub-element. 
Uses similar syntax to AHKv2's [Gui.SetFont](https://www.autohotkey.com/docs/v2/lib/Gui.htm#SetFont|Gui.SetFont)

- `options` additional values supported:
– `overline`
- `options` values not supported:
– `Q` (quality)
- `name` can take multiple font names, or font family names, separated with commas. Directly corresponds to CSS `font-family` property.
- `target` takes the name of a sub-element to set font settings to. Defaults to `popup`.

```
SetTextAlign(textAlign:="l", target:="popup") -> self
```
Sets text alignment.

- `textAlign`
– `l` (left), `c` (center), `r` (right)
- `target` takes the name of a sub-element to set font settings to. Defaults to `popup`.

```
OnEvent(name, callable) -> self
```
Sets event callback. Valid event names and arguments passed are as follows:

- `Click` event arguments:
    1. `popupInst` – the popup instance.
	2. `event` – The HTMLEvent object.
	3. `popupSlotEl` – The popup slot sub-element containing/being the event target.
	
- `LinkClick` event arguments:
    1. `popupInst` – the popup instance.
	2. `event` – The HTMLEvent object.
	3. `linkEl` – The link element being clicked.
    4. `href` – the link's `href`.

```
InsertAt(pos) -> self
```
Inserts the popup at `pos`. Chaining method equivalent to `Pos` property.

```
Show(animationClass := "", wait := 300) -> self
```
Shows (or unhides) the popup. Optionally can set animation class to apply while doing so.

- `animationClass` – [optional] animation class name.
- `wait` – [optional] wait before returning.
  WARNING: this is blocking, because AHK is not multithreaded.

```
After(wait, callback) -> self
```
Runs a callback function for the popup instance after set time using a timer.  
This is better than using `Wait()` as it doesn't block the thread.

```
Wait(duration:=5000) -> self
```
Waits for set time before continuing execution.  
WARNING: this is blocking (because AHK is not multithreaded). 
Use After() instead.

```
Hide(animationClass := "", deleteAfter := 300) -> self
```
Hides the popup. Optionally can set animation class to apply while doing so.

```
Remove()
```
Immediately removes the popup in the overlay, and in the owner `WindowNotifyOverlay`'s list of popups.

This method does not return the popup instance.

---
## License
The MIT License (MIT)

See [LICENSE.txt](LICENSE.txt) for full text.
