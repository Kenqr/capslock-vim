#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; ================ Initialize ================

inVimMode := false

SetCapsLockState, AlwaysOff

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
CapsLock::SetCapsLockState, AlwaysOff

; Turn on CapsLock
CapsLock & Tab::SetCapsLockState, AlwaysOn

; Enter vim mode
CapsLock & v::
    inVimMode := true
    ToolTip, CapsLockVim
return

; Escape
CapsLock & q::Send {Escape}


; ================ Vim Mode Hotkeys ================

#If inVimMode OR GetKeyState("CapsLock", "P")

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

; Ctrl+Right
w::
+w::
    Send {CtrlDown}{Right}{CtrlUp}
return

; Ctrl+Left
b::
+b::
    Send {CtrlDown}{Left}{CtrlUp}
return
