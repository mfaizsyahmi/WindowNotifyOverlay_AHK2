This page documents the classes in WindowNotifyOverlay.ahk.

## `WindowNotifyOverlay` Class
Creates and manages HTML-based overlays over windows, and popups on top.

### Nested classes
#### `HtmlDocEvents`
Event sink for the HTMLDocument on the overlay Gui.

#### `MapWith extends Map`
Extends the `Map` class to allow multiple calls to the same Map in the same static initialization call.

#### `Popup`
[WindowNotifyOverlay.Popup class](#windownotifyoverlaypopup-class)


### Static Class Properties
#### `COLOR_MAP`
Name: Hex RGB value.

#### `DEFAULT_CSS`
Used to instantiate WindowNotifyOverlay's HTML's stylesheet.

#### `DOC_TEMPLATE`
Used to instantiate WindowNotifyOverlay's HTML layout. 

Uses AHK's `Format()`. Arguments:

1. CSS

#### `instances`
`Array()` holding instances of WindowNotifyOverlay.

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

#### `PopupThemeAssocMap`
IconName: Theme. This is blank by default. `#Include WindowNotifyOverlay_icons.ahk` to populate it with some icons from VS2022 Icon Library. See [Icons.md](Icons.md) for the association map values it adds.

#### `SvgIconMap`
IconName: Svg markup. This is blank by default. `#Include WindowNotifyOverlay_icons.ahk` to populate it with some icons from VS2022 Icon Library. See [Icons.md](Icons.md) for the icons it contains.

### Static Class Methods
#### `__New`
```ahk
__New() -> class
```
Binds the static `WM_SIZE` message listener below.

#### `_Static_WM_SIZE`
```ahk
_Static_WM_SIZE(...)
```
Static `WM_SIZE` message handler. Loops over the `instance`s and resizes their windows when their window is resized.

### Constructor/destructor
#### `__New`
```ahk
__New(GuiObjOrHwnd) -> instance
```

- `GuiObjOrHwnd`
– An AHK `Gui` instance or a window hwnd.

#### `__Delete`
```ahk
__Delete()
```

### Instance Properties
#### `CSS`
Gets/sets the main stylesheet CSS of the overlay's `Doc`.

#### `Doc`
Gets a reference of the overlay's `HtmlDocument`.

#### `HtmlEvents`
Instance of `WindowNotifyOverlay.HtmlDocEvents` bound to the instance's `Doc`.

#### `Opacity`
Gets/sets the opacity of the overlay.

#### `parentHwnd`
`HWND` of the parent.

#### `PopupHtmlTemplate`
Gets/sets the HTML used to create the popup. Copied from `WindowNotifyOverlay.POPUP_HTML_TEMPLATE` and same AHK `Format()` arguments apply.

#### `Popups`
A `Map` where the key is a unique id, value is `WindowNotifyOverlay.Popup` instance.

DO NOT add or remove items directly. Instead use the `Popup()` method to add,
and call the individual popup's `Remove()` method to remove.

#### `StackOrder`
Gets/sets the stacking order of popups:

- `0`: Popups placed at the start of the stack.
- `1`: Popups placed at the end of the stack.

Start of the stack are nearest to the vertical edge of the window, and vice versa.

#### `TransColor`
Gets/sets transparent colour of the overlay. The `Doc`'s background colour will automatically be updated. Defaults to lime (`#00FF00`). 

Change this if your stylesheet is clashing with the default colour or producing too obvious of a halo around things.

#### `Wnd`
Gets a reference of `Doc`'s `parentWindow`.

### Instance Methods
#### `Clear`
```ahk
Clear(pos?)
```

Clears the popups from the given position, or everywhere.

#### `Popup`
```ahk
Popup(text,title:="",icon:="",theme:="",pos:="") -> WindowNotifyOverlay.popup
```

Creates a popup and returns a `WindowNotifyOverlay.Popup` instance.

- `text` 
– Text of the popup. To use HTML markup prepend with `HTML:`.
- `title` 
– [optional] Title of the popup. To use HTML markup prepend with `HTML:`.
- `icon`
– [optiona] Icon to display. Enter a local path, a URL, whitespace, a HTML markup prepend with `HTML:`, or a named value.

  Omitting the argument, or passing an empty string, removes the side slot where icons are displayed. To keep it open, use whitespace e.g. `A_Space`.

  Named values are the keys of `WindowNotifyOverlay.SvgIconMap`. This is blank by default unless `WindowNotifyOverlay_icons.ahk` is also `#Include`d. See [Icons.md](Icons.md) for a list of icons added.

- `theme`
– [optional] A theme to apply. If omitted or left blank, fill infer from `icon` if it contains a word from the above table, otherwise defaults to `default`. 

  Value inference is read from `WindowNotifyOverlay.PopupThemeAssocMap` which is blank by default unless `WindowNotifyOverlay_icons.ahk` is also `#Include`d.

  Values:

  |   |   |   |   |   |   |
  |---|---|---|---|---|---|
  | **Value**        | `default`  | `info` | `message` | `warning` | `error` |
  | **Color scheme** | monochrome | blue   | green     | yellow    | red     |

- `Pos`
– [optional] Where to place the popup. Values: 

  |   |   |   |
  |---|---|---|
  |`tl` (top left)   |`tc` (top center)   |`tr` (top right)   |
  |`bl` (bottom left)|`bc` (bottom center)|`br` (bottom right)|

#### `PopupSimple`
```ahk
PopupSimple(text,title:="",icon:="",theme:="",pos:="") -> unset
```

Creates a simple popup. Displays for 5 seconds.

See the `Popup()` method above for the arguments.

This method doesn't return any value.

## `WindowNotifyOverlay.Popup` Class
Default popup class for `WindowNotifyOverlay`.
This class is designed to be chainable. Good ol' jQuery paradigm.

All popups should only be instantiated from `WindowNotifyOverlay` instance's `Popup()` method.

### Static Class Properties
#### `autoAnimMap`
`Map` for default animation names for each popup position (sans `in-` and `out-` prefixes).

#### `DefaultTitle`, `DefaultIcon`, `DefaultTheme`, `DefaultPos`
Default values to fill if corresponding values are left blank when calling `PopupSimple()` or `Popup()`.

- `DefaultPos` defaults to `bl` (bottom left)

#### `qsMap`
`Map` where the keys are the valid sub-element components of the popup, and the value CSS selector to select it.

|   |   |   |   |   |   |   |
|---|---|---|---|---|---|---|
| **Key**         | `popupSlot`     | `popup`   | `side`    | `title` | `content` | `styleEl`
| **Sub-element** | popup container | the popup | side icon | title   | text      | popup stylesheet

### Constructor/destructor
#### `__New`
```ahk
__New(owner,ID,rest*) -> instance
```

- `owner`
– `WindowNotifyOverlay` instance creating this popup.
- `ID`
– Unique ID used by the creating `WindowNotifyOverlay` instance to identify both the `Popup` instance and the popup inserted in its HTML.
- `rest*`
– Same arguments as `WindowNotifyOverlay.Popup()`.

Use `WindowNotifyOverlay.Popup()` instead of calling the constructor directly.

#### `__Delete`
```ahk
__Delete()
```
This also calls `Remove()`

### Instance Properties
#### `ContentHTML`, `ContentText`, `SideHTML`, `SideText`, `TitleHTML`, `TitleText`
Gets or sets the HTML/text of the content/side/title sub-elements. 
Shortcut to `this.subElement[name].inner%type%`.

#### `CSS`
Gets/sets the stylesheet CSS that is part of the popup.

Note: This doesn't use the Shadow DOM, so all selectors must start with an id selector targeting the `ID` of the popup.

Several methods e.g. `SetItemStyle()` provide a managed way to populate this stylesheet, 
automatically filling in the selectors for you.

#### `EventMap`
The `Map` holding the callable event handlers assigned to this popup.

DO NOT assign keyvalues to this Map directly. Use the `OnEvent` method.

#### `ID`
ID of this popup.

#### `owner`
The `WindowNotifyOverlay` instance that manages this popup.

#### `popupEl`
Gets reference to the main popup HTMLElement.

#### `Pos`
Gets/sets the position of this popup. Values are same as `WindowNotifyOverlay.Popup()`'s `pos` argument.

You can set this repeatedly, and the popup will move to the given positions.

Where the popup would be placed in the stack is dictated by the owner `WindowNotifyOverlay`'s `StackOrder` property.

#### `SubElement[key]`
Gets reference to a sub-element of the popup, which is an HTMLElement. Valid key names are the keys of the static `qsMap`.

### Instance Methods
All the following methods except `Remove()` returns the popup instance so you can chain multiple methods in a single call.

#### `After`
```ahk
After(wait, callback) -> self
```

Runs a callback function for the popup instance after set time using a timer.  
This is better than using `Wait()` as it doesn't block the thread.

#### `Hide`
```ahk
Hide(animationClass := "", deleteAfter := 300) -> self
```

Hides the popup. Optionally can set animation class to apply while doing so.

- `animationClass` – [optional] animation class name. 
If `auto` will use the value in `autoAnimMap`.
- `deleteAfter` – [optional] wait before automatically calling `Remove()`. 
Set to a value below 0 to disable this.

#### `InsertAt`
```ahk
InsertAt(pos) -> self
```

Inserts the popup at `pos`. Chaining method equivalent to `Pos` property.

#### `OnEvent`
```ahk
OnEvent(name, callable, AddRemove:=1) -> self
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

`AddRemove` has the same meaning as the same argument in AHKv2's [`OnEvent()`](https://www.autohotkey.com/docs/v2/lib/GuiOnEvent.htm).

#### `Remove`
```ahk
Remove()
```

Immediately removes the popup in the overlay, and in the owner `WindowNotifyOverlay`'s list of popups.

This method does not return the popup instance.

#### `SetAnimationDuration`
```ahk
SetAnimationDuration(ms) -> self
```

Adds CSS declaration to the attached style element to override the animation duration set in the owner `WindowNotifyOverlay`'s stylesheet.

#### `SetCSS`
```ahk
SetCSS(css) -> self
```

Sets CSS for the style element attached to the popup. 
This will override the style element's content. 
Chaining method alternative to the `CSS` property.

#### `SetFont`
```ahk
SetFont(options?, name?, target:="popup") -> self
```

Sets font options for the whole popup or a sub-element. 
Uses similar syntax to AHKv2's [Gui.SetFont](https://www.autohotkey.com/docs/v2/lib/Gui.htm#SetFont|Gui.SetFont).

- `options` additional values supported:
– `overline`
- `options` values not supported:
– `Q` (quality)
- `name` can take multiple font names, or font family names, separated with commas. Directly corresponds to CSS `font-family` property.
    - e.g. ```Fira Mono,Consolas,Courier New,monospace```
- `target` takes the name of a sub-element to set font settings to. Defaults to `popup`.

#### `SetIconSize`
```ahk
SetIconSize(w?,h?) -> self
```

Sets image size. If both values omitted, does nothing. Otherwise the omitted values will be set to `auto`. Values are in CSS units, or in `px` if omitted.

#### `SetItemStyle`
```ahk
SetItemStyle(target:="popup", styleStr?) -> self
```

Writes a CSS selector for the target sub-element and passes the given style declarations.

NOTE: successive calls with the same sub-element results in duplicate selectors for the sub-element. CSS order of precedence applies. Declarations not overridden will remain in effect.

#### `SetTextAlign`
```ahk
SetTextAlign(textAlign:="l", target:="popup") -> self
```

Sets text alignment.

- `textAlign`
– `l` (left), `c` (center), `r` (right)
- `target` takes the name of a sub-element to set font settings to. Defaults to `popup`.

#### `Show`
```ahk
Show(animationClass := "", wait := 300) -> self
```

Shows (or unhides) the popup. Optionally can set animation class to apply while doing so.

- `animationClass` – [optional] animation class name. If `auto` will use the value in `autoAnimMap`.
- `wait` – [optional] wait before returning.
  WARNING: this is blocking, because AHK is not multithreaded.

#### `Wait`
```ahk
Wait(duration:=5000) -> self
```

Waits for set time before continuing execution.  
WARNING: this is blocking (because AHK is not multithreaded). 
Use `After()` instead.

---
