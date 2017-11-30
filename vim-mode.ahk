#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; ================ Initialize ================

inVimMode := false

exitVimMode() {
    global inVimMode
    inVimMode := false
    ToolTip
}

; ================ Global Hotkeys ================

; Emergency exit in case something is broken
Pause::
    ExitApp
return

; Disable CapsLock
CapsLock::return

; Enter vim mode
CapsLock & v::
    inVimMode := true
    ToolTip, CapsLockVim
return

; Escape
CapsLock & q::Send {Escape}

; Toggle CapsLock
+CapsLock::
    capsLockState := GetKeyState("CapsLock", "T")
    if (capsLockState) {
        SetCapsLockState, Off
    } else {
        SetCapsLockState, On
    }
return


; ================ Vim Mode Hotkeys ================

#If inVimMode

i::exitVimMode()

; Arrow keys
h::Left
j::Down
k::Up
l::Right
