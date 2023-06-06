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
LoopCount = 0
If Toggle
    SoundPlay, *48
Else
    SoundPlay, *16
Loop,
{
    If !Toggle {
        Break
    }
    If Not WinActive("ahk_exe destiny2.exe") {
        Continue
    }
    LoopCount++
    ImageSearch, FoundX, FoundY, 1170, 960, 1210, 1010, E.png

    if (ErrorLevel == 0) {
        ; SoundPlay, *48
        Send {e down}
        sleep 200
        Send {e up}
        sleep 2000
        Send {LCtrl down}
        sleep 100
        Send {LCtrl up}
        Click R D
        sleep 100
        Click R U
        sleep 100
        Send {e down}
        sleep 2000
        Send {e up}
    }
    if (LoopCount > 100) {
        ; SoundPlay, *48
        LoopCount = 0
        Send {d Down}
        sleep 12
        Send {d Up}
        sleep 12
        Send {a Down}
        sleep 12
        Send {a Up}
        sleep 12
    } else {
        sleep 50
    }
} 
return

; -------------------------------------------------------------------------
; Left Ctl + Esc = Kill AHK script. Will need to be reactivated.
; -------------------------------------------------------------------------

LCtrl & Esc::ExitApp

LCtrl & F5::Reload
