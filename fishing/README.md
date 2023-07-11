# Info
Requires latest AutoHotKey v1 (not v2).
Fishing script was only tested for any 16:9, 16:10, or 4:3 resolution that's in the game's "Windowed" resolution list from 1280x720 to 2560x1440 (you can run one of those resolutions fullscreen as long as it is in the list for Windowed). It _may_ work for ultrawide but most likely will not. It will probably not work for Brightness 1.
The script has its own AutoHotKey taskbar icon of `E` instead of the AHK default.

# Usage
1. Download `fishing.ahk` and all png files to the same folder.
2. Right click `fishing.ahk` + 'Run as Administrator'.
3. Open Destiny 2, and bind `Interact` to `E` and remove any other `Interact` binds.
4. Select a supported resolution for the script in Video settings (see above). If Brightness is 1, set it to 2 or higher (4 is ideal).
5. Travel to Fishing Pond, begin fishing, then press `F11`. You will hear a Windows 'info' noise and the taskbar icon will turn blue.
   - If the script was unable to determine your window size, it will show an error and disable the fishing loop. You may have to restart the game/script in this case.
6. Fish without needing to pay attention. You _should_ get movement inputs to prevent you from being sent to orbit.
   - If you do not find any fish for a full minute, the script will assume you were interrupted in some way and will attempt to start fishing again.
7. When done fishing, press `F11` again to stop the fishing loop. You will hear a Windows 'asterisk' noise and the taskbar icon will turn grey/black.
   - `LeftCtrl+Esc` will cause the script to fully exit.
   - `LeftCtrl+F5` will cause the script to reload itself, in case something went wrong.
