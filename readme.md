# Output switcher and microphone mute script with hotkeys

Uses Nircmd to switch output between multiple sources (headphones or speakers).

Provide hotkey to mute/unmute microphone.

Mute microphone and speakers when Windows is locked.

## Microphone Controls

Use [Soundcard Anaylsis](https://autohotkey.com/docs/commands/SoundSet.htm#Ex) from AHK to identify the device number.

Modify the SoundSet and SoundGet commands to use your device ID number. 

## Output switching with Nircmd

Download [Nircmd](http://www.nirsoft.net/utils/nircmd.zip) and place nircmd.exe in C:\Windows\System32\ folder. 

The device names used are the ones set in the Windows "Sounds" settings. 

