#Persistent			; This keeps the script running permanently.
#SingleInstance		; Only allows one instance of the script to run.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
global toggleMic:=false
global mic_source:=6 ;number gathered from soundanalysis.ahk
Loop { ;Validiates microphone status in case it is changed by another application
	SoundGet, microphone_mute, MASTER, mute, global mic_source
	if microphone_mute = Off
	{
		Menu, Tray, Icon, mic-on.png
		global toggleMic:=true
	}	
	else if microphone_mute = On
	{
		Menu, Tray, Icon, mic-mute.png
		global toggleMic:=false
	}	
	Sleep, 5000	
}

^!;:: ; Speaker switcher
  toggleSpeaker:=!toggleSpeaker ; This toggles the variable between true/false
  if toggleSpeaker
	{ 
	Run, nircmd setdefaultsounddevice "Speakers"
	soundToggleBox("Speakers")
	}
	else
	{
	Run, nircmd setdefaultsounddevice "Headphones"
	soundToggleBox("Headphones")
	}
Return

^!':: ; Mute mic toggle
  if toggleMic
	{
	micMute()
	}
	else if !toggleMic
	{
	micOn()
	}
Return

micMute()
{
	SoundSet, 1, MASTER, mute, global mic_source
	SoundGet, microphone_mute, MASTER, mute, global mic_source
	if microphone_mute = On
	{
		global toggleMic:=false
		micToggleBox("Mic Muted")
		Menu, Tray, Icon, mic-mute.png
	}	
}

micOn()
{
	SoundSet, +1, MASTER, mute, global mic_source
	SoundGet, microphone_mute, MASTER, mute, global mic_source
	if microphone_mute = Off
	{
		global toggleMic:=true
		micToggleBox("Mic On")
		Menu, Tray, Icon, mic-on.png
	}		
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
Return
