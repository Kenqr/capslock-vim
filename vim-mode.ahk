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

; Turn off CapsLock
CapsLock::SetCapsLockState, Off

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

; Arrow keys
CapsLock & h::
    Send {Left}
return

CapsLock & j::
    Send {Down}
return

CapsLock & k::
    Send {Up}
return

CapsLock & l::
    Send {Right}
return

; Delete
CapsLock & x::
    Send {Delete}
return

; Home
CapsLock & 0::
    Send {Home}
return

; End
CapsLock & a::
    Send {End}
return

; ================ Vim Mode Hotkeys ================

#If inVimMode

i::exitVimMode()

; Arrow keys
h::Left
j::Down
k::Up
l::Right

; Delete, Backspace
x::Delete
X::Backspace

; Home, End
0::Home
+6 UP::Send {Home} ; Caret (^)
+4 UP::Send {End} ; Dollar sign ($)
