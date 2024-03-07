#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Force

$^f::OpenEverythingInExplorerWithCurrentPath()

OpenEverythingInCurrentPath()
{
    explorerGetPath(hwnd := 0)
    {
        Static explorer := 'CabinetWClass', winTitle := 'ahk_class' explorer
        winClass := WinGetClass(hWnd := WinActive('A'))
        Switch 
        {
            Case winClass ~= 'Progman|WorkerW': Return A_Desktop
            Case winClass  = explorer:
            hWnd ?    explorerHwnd := WinExist(winTitle ' ahk_id' hwnd)
                : ((!explorerHwnd := WinActive(winTitle)) && explorerHwnd := WinExist(winTitle))
            If explorerHwnd
            For window in ComObject('Shell.Application').Windows
            Try If window && window.hwnd && window.hwnd = explorerHwnd
            Return window.Document.Folder.Self.Path
        }
    }
    Run("`"C:\Program Files\Everything\Everything.exe`"" . " -p " . explorerGetPath())
}

OpenEverythingInExplorerWithCurrentPath()
{
    ; 检查当前激活的窗口是否为 explorer (文件资源管理器)
    if WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass") or WinActive("ahk_class WorkerW")
    {
        OpenEverythingInCurrentPath()
    }
    else
    {
        ; 如果不是文件资源管理器，发送原本的 Ctrl+F 组合键
        Send "^f"
    }
}