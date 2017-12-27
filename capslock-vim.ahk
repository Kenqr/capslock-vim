#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; ================ Initialize ================

inVimMode := false

SetCapsLockState, AlwaysOff

enterVimMode() {
    global inVimMode
    inVimMode := true
    ToolTip, CapsLockVim
}

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
CapsLock & z::enterVimMode()

; Escape
CapsLock & q::Send {Escape}


; ================ Vim Mode Hotkeys ================

#If inVimMode OR GetKeyState("CapsLock", "P")


; ================ Motion ================

; Arrow keys
h::Left
j::Down
k::Up
l::Right

; Beginning/end of line
0::Send {Home}{Home}
+6 UP::Send {Home} ; Caret (^)
+4 UP::Send {End} ; Dollar sign ($)

; Next word
w::
+w::
    Send {CtrlDown}{Right}{CtrlUp}
return

; Previous word
b::
+b::
    Send {CtrlDown}{Left}{CtrlUp}
return

; Page Up, Page Down
+h::Send {PgUp}
+l::Send {PgDn}

; End of file
+G::Send {CtrlDown}{End}{CtrlUp}

; Previous line, Next line
-::Send {Up}{End}{Home}
+::Send {Down}{End}{Home}


; ================ Command ================

; Insert
i::
    exitVimMode()
return

; Insert at beginning of line
+i::
    Send {Home}
    exitVimMode()
return

; Append
a::
    Send {Right}
    exitVimMode()
return

; Append at end of line
+a::
    Send {End}
    exitVimMode()
return

; Open below
o::
    Send {End}{Enter}
    exitVimMode()
return

; Open above
+o::
    Send {Up}{End}{Enter}
    exitVimMode()
return

; Delete, Backspace
x::Delete
+x::Backspace

; Delete to end of line
+d::Send {ShiftDown}{End}{ShiftUp}{Delete}

; Undo
u::Send {CtrlDown}z{CtrlUp}

; Copy line
+y::Send {End}{Home}{Home}{ShiftDown}{Down}{ShiftUp}{CtrlDown}c{CtrlUp}{Up}
