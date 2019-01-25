#Persistent			; This keeps the script running permanently.
#SingleInstance		; Only allows one instance of the script to run.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir C:\scripts\Speaker-Control  ; Ensures a consistent starting directory.

^!;:: ; Speaker switcher
  toggleSpeaker:=!toggleSpeaker ; This toggles the variable between true/false
  if toggleSpeaker
	{
	Run, C:\scripts\Speaker-Control\nircmd.exe setdefaultsounddevice "Speakers"
	soundToggleBox("Speakers")
	}
	else
	{
	Run, C:\scripts\Speaker-Control\nircmd.exe setdefaultsounddevice "Headphones"
	soundToggleBox("Headphones")
	}
Return

^!':: ; Mute mic toggle
  toggleMic:=!toggleMic ; This toggles the variable between true/false
  if toggleMic
	{
	micMute()
	}
	else
	{
	micOn()
	}
Return

micMute()
{
	Run, C:\scripts\Speaker-Control\nircmd.exe mutesysvolume 1 "Mic"
	micToggleBox("Mic Muted")
	Menu, Tray, Icon, mic-mute.png
}

micOn()
{
	Run, C:\scripts\Speaker-Control\nircmd.exe mutesysvolume 0 "Mic"
	micToggleBox("Mic On")
	Menu, Tray, Icon, mic-on.png
}

; Display sound toggle GUI
soundToggleBox(Device)
{
	IfWinExist, soundToggleWin
	{
		Gui, destroy
	}
	Gui, +ToolWindow -Caption +0x400000 +alwaysontop
	Gui, Add, text, x35 y8, Default sound: %Device%
	SysGet, screenx, 0
	SysGet, screeny, 1
	xpos:=screenx-275
	ypos:=screeny-100
	Gui, Show, NoActivate x%xpos% y%ypos% h30 w200, soundToggleWin
	SetTimer,soundToggleClose, 2000
}
soundToggleClose:
    SetTimer,soundToggleClose, off
    Gui, destroy
Return

; Display mic toggle GUI
micToggleBox(Device)
{
	IfWinExist, micToggleWin
	{
		Gui, destroy
	}
	Gui, +ToolWindow -Caption +0x400000 +alwaysontop
	Gui, Add, text, x35 y8, %Device%
	SysGet, screenx, 0
	SysGet, screeny, 1
	xpos:=screenx-275
	ypos:=screeny-100
	Gui, Show, NoActivate x%xpos% y%ypos% h30 w120, micToggleWin
	SetTimer,micToggleClose, 2000
}
micToggleClose:
    SetTimer,micToggleClose, off
    Gui, destroy
Return

~#l:: ; Mute on screen lock

SoundSet, 1,,Mute
micMute()

WinWait, A

SoundSet, 0,,Mute

return
