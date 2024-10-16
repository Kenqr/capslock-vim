#Requires AutoHotkey v2.0


; ================ Initialize ================

inVimMode := false

SetCapsLockState("AlwaysOff")

enterVimMode() {
    global inVimMode
    inVimMode := true
    ToolTip("CapsLockVim")
}

exitVimMode() {
    global inVimMode
    inVimMode := false
    ToolTip()
}

; ================ Global Hotkeys ================

; Emergency exit in case something is broken
Pause::ExitApp()

; Turn off CapsLock
CapsLock::SetCapsLockState("AlwaysOff")

; Turn on CapsLock
CapsLock & Tab::SetCapsLockState("AlwaysOn")

; Enter vim mode
CapsLock & z::enterVimMode()

; Escape
CapsLock & q::Send("{Escape}")

; Page Up, Page Down, Home, End
CapsLock & Up::Send("{PgUp}")
CapsLock & Down::Send("{PgDn}")
CapsLock & Left::Send("{Home}")
CapsLock & Right::Send("{End}")


; ================ Vim Mode Hotkeys ================

#HotIf inVimMode OR GetKeyState("CapsLock", "P")


; ================ Motion ================

; Arrow keys
h::Send("{Left}")
j::Send("{Down}")
k::Send("{Up}")
l::Send("{Right}")

; Beginning/end of line
0::Send("{Home}{Home}")
^::Send("{Home}")
$::Send("{End}")

; Next word
w::
+w::
{
    Send("^{Right}")
}

; Previous word
b::
+b::
{
    Send("^{Left}")
}

; Page Up, Page Down
+h::Send("{PgUp}")
+l::Send("{PgDn}")

; End of file
+G::Send("^{End}")

; Previous line, Next line
-::Send("{Up}{End}{Home}")
+::Send("{Down}{End}{Home}")


; ================ Command ================

; Insert
i::exitVimMode()

; Insert at beginning of line
+i::
{
    Send("{Home}")
    exitVimMode()
}

; Append
a::
{
    Send("{Right}")
    exitVimMode()
}

; Append at end of line
+a::
{
    Send("{End}")
    exitVimMode()
}

; Open below
o::
{
    Send("{End}{Enter}")
    exitVimMode()
}

; Open above
+o::
{
    Send("{Up}{End}{Enter}")
    exitVimMode()
}

; Delete, Backspace
x::Send("{Delete}")
+x::Send("{Backspace}")

; Delete to end of line
+d::Send("+{End}^x")

; Undo
u::Send("^z")

; Copy line
+y::Send("{End}{Home}{Home}+{Down}^c{Up}")
