#NoEnv ; recommended for performance and compatibility with future autohotkey releases.
#UseHook
#InstallKeybdHook
#SingleInstance force

SendMode Input

global windowGap := 4

;; deactivate capslock completely
SetCapslockState, AlwaysOff

;; remap capslock to hyper
;; if capslock is toggled, remap it to esc

;; note: must use tidle prefix to fire hotkey once it is pressed
;; not until the hotkey is released
~Capslock::
    ;; must use downtemp to emulate hyper key, you cannot use down in this case 
    ;; according to http://bit.ly/2fLyHHI, downtemp is as same as down except for ctrl/alt/shift/win keys
    ;; in those cases, downtemp tells subsequent sends that the key is not permanently down, and may be 
    ;; released whenever a keystroke calls for it.
    ;; for example, Send {Ctrl Downtemp} followed later by Send {Left} would produce a normal {Left}
    ;; keystroke, not a Ctrl{Left} keystroke
    Send {Ctrl DownTemp}{Shift DownTemp}{Alt DownTemp}{LWin DownTemp}
    KeyWait, Capslock
    Send {Ctrl Up}{Shift Up}{Alt Up}{LWin Up}
    if (A_PriorKey = "Capslock") {
        Send {Esc}
    }
return


~Capslock & Numpad0::
    ;; toggle window decorations
    WinGet, curStyle, Style, a
    if (curStyle & 0xC00000){
        WinSet, Style, -0xC00000,a ; remove the titlebar and border(s) 
    }
    else {
        WinSet, Style, +0xC00000,a ; add the titlebar and border(s) 
    }
return

~Capslock & Numpad4::
    ;; resize window to fill left side of screen
    WinRestore, A
    WinMove, a,, windowGap, windowGap, (A_Screenwidth / 2 - windowGap), (A_Screenheight - windowGap * 2) 
return

~Capslock & Numpad7::
    ;; resize window to fill top left side of screen
    WinRestore, A
    WinMove, a,, windowGap, windowGap, (A_Screenwidth / 2 - windowGap), (A_Screenheight / 2 - windowGap) 
return

~Capslock & Numpad1::
    ;; resize window to fill bottom left side of screen
    WinRestore, A
    WinMove, a,, windowGap, (A_Screenheight / 2 + windowGap), (A_Screenwidth / 2 - windowGap), (A_Screenheight / 2 - windowGap * 2) 
return

~Capslock & Numpad6::
    ;; resize window to fill right side of screen
    WinRestore, A
    WinMove, a,, (A_Screenwidth / 2 + windowGap / 2), windowGap, (A_Screenwidth / 2 - windowGap), (A_Screenheight - windowGap * 2) 
return

~Capslock & Numpad3::
    ;; resize window to fill bottom right side of screen
    WinRestore, A
    WinMove, a,, (A_Screenwidth / 2 + windowGap / 2), (A_Screenheight / 2 + WindowGap), (A_Screenwidth / 2 - windowGap), (A_Screenheight / 2 - windowGap * 2) 
return

~Capslock & Numpad9::
    ;; resize window to fill top right side of screen
    WinRestore, A
    WinMove, a,, (A_Screenwidth / 2 + windowGap / 2), windowGap, (A_Screenwidth / 2 - windowGap), (A_Screenheight / 2 - windowGap) 
return

~Capslock & Numpad5::
    ;; centre window on the screen & resize to a nice viewing size
    ;;    WinGetPos,,, Width, Height, A
    WinRestore, A
    Width := 1400
    Height := 800
    WinMove, A,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2), Width, Height
return

~Capslock & Numpad8::
    ;; Maximize current window
    WinMaximize, A
return

~CapsLock & C::
    ;; Put Chrome in Focus
    SetTitleMatchMode, 2
    WinActivate, Chrome
return

~CapsLock & V::
    ;; Put VSCode in Focus
    SetTitleMatchMode, 2
    WinActivate, Visual Studio Code
return

~CapsLock & Q::
    ;; Put QASP in Focus
    SetTitleMatchMode, 2
    WinActivate, qasp_db
return

~CapsLock & O::
    ;; Put Outlook in Focus
    SetTitleMatchMode, 2
    WinActivate, Microsoft Outlook
return

~Capslock & `::
    SetTitleMatchMode, 2
    WinActivate, ahk_class Console_2_Main
return