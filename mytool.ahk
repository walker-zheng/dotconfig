#NoTrayIcon

; 隐藏 开始按钮/任务栏/托盘
WinHide ahk_class Button   
WinHide ahk_class Shell_TrayWnd
WinShow ahk_class NotifyIconOverflowWindow
WinHide ahk_class NotifyIconOverflowWindow

; 窗口置顶
#Q::  
	Winset, Alwaysontop, Toggle, A
return

; 任务栏隐藏
#c::
if taskbarToggle := !taskbarToggle
{   
    WinHide ahk_class Button   
	WinHide ahk_class Shell_TrayWnd
}
else
{   
    WinShow ahk_class Button   
    WinShow ahk_class Shell_TrayWnd
}
return

; 托盘显示
#v::
if trayToggle := !trayToggle
{   
    WinShow ahk_class NotifyIconOverflowWindow
}
else
{   
    WinHide ahk_class Shell_TrayWnd
    WinHide ahk_class NotifyIconOverflowWindow
}
return

~LAlt & z::AltTabMenu