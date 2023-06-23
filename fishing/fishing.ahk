#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxThreadsPerHotkey 2
; =======================================================================================
; Start fishing then press F11, only tested at 16:9, 16:10, and 4:3 standard resolutions
; =======================================================================================
Widths := [1280, 1366, 1440, 1600, 1680, 1920, 2560]
Menu, Tray, Icon, script_icon_off.png
F11::
Toggle := !Toggle
LoopCount = 0
WaitCount = 0
If Toggle {
    Menu, Tray, Icon, script_icon_on.png
    SoundPlay, *48
} Else {
    Menu, Tray, Icon, script_icon_off.png
    SoundPlay, *16
}
Loop,
{
    If !Toggle {
        Filename =
        Break
    }
    hwnd := WinActive("ahk_exe destiny2.exe")
    If Not hwnd {
        Filename =
        Continue
    }
    if (!Filename) {
        GetClientSize(hwnd, Width, Height)
        Closest = 2560
        OldDist = 2560
        For idx, w in Widths {
            NewDist := Abs(w - Width)
            Closest := NewDist < OldDist ? w : Closest
            OldDist := NewDist < OldDist ? NewDist : OldDist
        }
        Filename = E.%Closest%.png
        BoxX := (Width/2) + (-85*Width/2560)
        BoxY := (Height/2) + (265*Height/1440)
        TopLeftX := BoxX - 25
        TopLeftY := BoxY - 25
        BotRightX := BoxX + 25
        BotRightY := BoxY + 25
    }

    LoopCount++

    CoordMode, Pixel, Client
    ImageSearch, FoundX, FoundY, TopLeftX, TopLeftY, BotRightX, BotRightY, %Filename%

    if (ErrorLevel == 0 || WaitCount >= 12) {
        WaitCount = 0
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
    if (LoopCount >= 100) {
        WaitCount++
        ; SoundPlay, *48
        LoopCount = 0
        Send {d Down}
        sleep 12
        Send {d Up}
        sleep 12
        Send {a Down}
        sleep 12
        Send {a Up}
        sleep 14
    } else {
        sleep 50
    }
} 
return


GetClientSize(hwnd, ByRef w, ByRef h)
{
    VarSetCapacity(rc, 16)
    DllCall("GetClientRect", "uint", hwnd, "uint", &rc)
    w := NumGet(rc, 8, "int")
    h := NumGet(rc, 12, "int")
}

; -------------------------------------------------------------------------
; Left Ctl + Esc = Kill AHK script. Will need to be reactivated.
; -------------------------------------------------------------------------

LCtrl & Esc::ExitApp

LCtrl & F5::Reload
