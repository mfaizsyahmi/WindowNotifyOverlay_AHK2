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

## Features
- Creates overlays and popup notifications on any window, not just the desktop.
- Layout uses HTML/CSS and can be freely configured.
- Simple and configurable popups using method chaining.
- Supports URL and local file as icons. 
- Select icons from the Visual Studio 2022 Image Library also included and available to use. No external resources needed.
- Supports HTML markup for title and text content.
- CSS stylings for the whole document, the whole popup, or its sub-element.
- Contextual popup themes: info (blue), message (green), warning (yellow), error (red), as well as a default.
- A few popup animations built into the CSS.
- Click and LinkClick event callbacks.

## Known issues
- Currently doesn't support HICON and HBITMAP icons.
- Since the whole overlay is a single Gui window, there can be only one opacity value for the whole overlay.
- Some CSS animations don't work properly.
- The rendered HTML can't have any translucency as it will blend into the trans color and form a halo.
- The HtmlDocument ActiveX control uses the old mshtml library (equivalent to IE~10) so modern web features post-IE aren't supported.

## Class documentation
See [Classes.md](Classes.md) for documentation on classes in WindowNotifyOverlay.ahk.

## License
See [LICENSE.txt](LICENSE.txt) for full text.
