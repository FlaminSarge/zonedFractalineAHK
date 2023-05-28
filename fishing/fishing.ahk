#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxThreadsPerHotkey 2
; =======================================================================================
; Start fishing then press F11, only tested at 1440p resolution with E as interact
; =======================================================================================
F11::
Toggle := !Toggle
SoundPlay, *48
Loop,
{
    If !Toggle
        break

    ImageSearch, FoundX, FoundY, 1170, 960, 1210, 1010, E.png

    if (ErrorLevel == 0) {
        ; SoundPlay, *48
        Send {e down}
        sleep 200
        Send {e up}
        sleep 2000
        Send {e down}
        sleep 2000
        Send {e up}
    }

    sleep, 50 
} 
return

; -------------------------------------------------------------------------
; Left Ctl + Esc = Kill AHK script. Will need to be reactivated.
; -------------------------------------------------------------------------

LCtrl & Esc::ExitApp

Ctrl & Esc::ExitApp
