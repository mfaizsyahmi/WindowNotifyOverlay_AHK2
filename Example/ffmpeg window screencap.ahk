#Requires AutoHotkey v2.0
#Warn Unreachable, Off
#SingleInstance
#Include ..\WindowNotifyOverlay.ahk

; if PATH env var has path pointing to ffmpeg bin folder then only name is needed
; otherwise the full path is required
Global FFMPEG := "ffmpeg.exe"
Global FRAMERATE := 30
Global FFMPEG_ARGS := "-f gdigrab -framerate {} -offset_x {} -offset_y {} -video_size {}x{} "
	. '-i desktop "{}"' ; framerate, x, y, w, h, outpath
Global OUTPUT_PATH_FMT := "D:\Snap\Capture_{}.mkv"
Global OUTPUT_TIMESTAMP_FMT := "yyyy-MM-dd_HH-mm-ss" ; timestamp format
Global COUNTDOWN_SECONDS := 5
Global ENDRECORD_HKEY := ["AppsKey & End", "AppsKey+End"]
Global PASSTHROUGH_HKEY := "AppsKey"
Global FFMPEG_PID

; value 0 creates an overlay without parent, sized to the desktop client area
deskOverlay := WindowNotifyOverlay(0)
;deskOverlay.overlayGui.Opt("+AlwaysOnTop ToolWindow")
deskOverlay.__Static.Popup.DefaultTheme := "info"
deskOverlay.__Static.Popup.DefaultPos := "br"
deskOverlay.overlayGui.OnEvent("Close", (*)=>ExitApp())

nullFn := (*) => 0

global popupTpl := {
	countdown: "Recording in {} seconds...<br><i>Do not move the window</i>",
	recording: "Click here or press {} to end<br><i>Do not move the window</i>",
}
global popups := {
	countdown: deskOverlay.Popup(
		"HTML:" Format(popupTpl.countdown, 5),
		"Select window to record",
		"HTML:🎬")
		.OnEvent("Click", nullFn) ; prevent clicks from dismissing
		.Show(,0),
	recording: deskOverlay.Popup(
		"HTML:" Format(popupTpl.recording, ENDRECORD_HKEY[2]),
		"Recording",
		"HTML:🔴"),
	stopping: deskOverlay.Popup(
		"Stopping ffmpeg...",,
		"HTML:⏹")
}

SetTimer Countdown, 1000
SetTimer StartRecord, COUNTDOWN_SECONDS * -1000

Countdown() {
	global
	static timer := COUNTDOWN_SECONDS
	--timer
	popups.countdown.ContentHtml := Format(popupTpl.countdown, timer)
	If (timer <=0) {
		popups.countdown.Remove()
		SetTimer , 0
	}
}

StartRecord() {
	targetHwnd := WinGetId("A")

	SoundBeep 1046
	If PASSTHROUGH_HKEY
		HotKey PASSTHROUGH_HKEY, Send.Bind("{" PASSTHROUGH_HKEY "}")

	; get pos of active window
	WinGetPos(&winX,&winY,&winW,&winH,targetHwnd)
	outPath := Format(OUTPUT_PATH_FMT, FormatTime(,OUTPUT_TIMESTAMP_FMT))
	cmdargs := Format(FFMPEG_ARGS, FRAMERATE, winX, winY, winW, winH, outPath)
	Run FFMPEG " " cmdargs,,"HIDE",&FFMPEG_PID

	HotKey ENDRECORD_HKEY[1], (*)=>EndRecord(FFMPEG_PID)

	popups.recording
	.OnEvent("Click", (*)=>EndRecord(FFMPEG_PID))
	.Show(,0)

	WinActivate targetHwnd

	OnExit EndRecord.Bind(FFMPEG_PID), -1
}

EndRecord(FFMPEG_PID,*) {
	SoundBeep
	popups.recording.Remove()

	If !ProcessExist(FFMPEG_PID)
		Return

	DetectHiddenWindows(true) ; IMPORTANT
	winTitle := Format("ahk_class ConsoleWindowClass ahk_pid {1}", FFMPEG_PID)
	if !WinExist(winTitle) {
		FFMPEG_PID := ProcessExist()
		winTitle := Format("ahk_class ConsoleWindowClass ahk_pid {1}", FFMPEG_PID)
	}
	try {
		ControlSend("q", Control?, winTitle) ; Attempt a graceful shutdown of FFmpeg.
	}
	catch TargetError
		ProcessClose(FFMPEG_PID) ; Graceful shutdown failed, terminate the process.

	SplitPath OUTPUT_PATH_FMT, , &outDir
	Run "*open " outDir

	ExitApp

}
