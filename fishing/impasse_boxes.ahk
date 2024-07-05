#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxThreadsPerHotkey 2
; =======================================================================================
; Fly to Pale Heart, wait to load in, then press F11. F11 again to stop.
; Only tested at 16:9 standard resolutions
; 30 Mobility, no lightweight weapons/other movement buffs/exotics
; Needs all the PNGs in fishing folder to work
; =======================================================================================
Widths := [1280, 1366, 1440, 1600, 1680, 1920, 2560]
Menu, Tray, Icon, script_icon_off.png
JIGGLE := False
RECAST := True
CROUCH := False
F11::
Toggle := !Toggle
LoopCount = 0
NeedMap := True
If Toggle {
    Menu, Tray, Icon, script_icon_on.png
    SoundPlay, *64
} Else {
    Menu, Tray, Icon, script_icon_off.png
    SoundPlay, *48
}
Loop,
{
    If !Toggle {
        Filename =
        Send {A up}
        Send {S up}
        Break
    }
    hwnd := WinActive("ahk_exe destiny2.exe")
    If Not hwnd {
        Filename =
        Continue
    }
    if (!Filename) {
        GetClientSize(hwnd, Width, Height)

        if (Width == 0 && Height == 0) {
            SoundPlay, *16
            MsgBox, Could not fetch current window size, you may have to restart the game/script
            Toggle := False
            Menu, Tray, Icon, script_icon_off.png
            Continue
        }

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
        Move1X := (235 * Width/2560)
        Move1Y := (-500 * Height/1440)
        Move2X := 0
        Move2Y := 74
    }

    LoopCount++

    if (NeedMap) {
        Send {f3 down}
        sleep 100
        Send {f3 up}
        sleep 100
        MouseMove, Move1X, Move1Y, 5, R
        sleep 500
        MouseMove, Move2X, Move2Y, 5, R
        sleep 1000
        Click d
        sleep 2000
        Click u
        Loop 35,
        {
            sleep 1000
            If !Toggle {
                Filename =
                Break
            }
        }
        If !Toggle {
            Filename =
            Break
        }
        Send {A down}
        Sleep 1800
        Send {S down}
        NeedMap := False
    }

    CoordMode, Pixel, Client
    ImageSearch, FoundX, FoundY, TopLeftX, TopLeftY, BotRightX, BotRightY, *24 %Filename%

    if (ErrorLevel == 0 || LoopCount >= 260) {
        LoopCount = 0
        ; SoundPlay, *48
        Send {A up}
        Send {S up}
        sleep 200
        if (ErrorLevel == 0) {
            Send {e down}
            sleep 2000
            Send {e up}
            sleep 2000
        }
        if (CROUCH) {
            Send {LCtrl down}
            sleep 50
            Send {LCtrl up}
            Click R D
            sleep 50
            Click R U
            sleep 50
        } else {
            sleep 150
        }
        if (RECAST) {
            NeedMap := True
        }
    }
    if (JIGGLE && Mod(LoopCount, 100) == 0) {
        ; SoundPlay, *48
        Send {d Down}
        sleep 12
        Send {d Up}
        sleep 13
        Send {a Down}
        sleep 12
        Send {a Up}
        sleep 13
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
