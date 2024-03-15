#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Force

$^f::OpenEverythingInExplorerWithCurrentPath()

OpenEverythingInCurrentPath()
{
    explorerGetPath(hwnd := 0)
    {
        Static explorer := 'CabinetWClass', winTitle := 'ahk_class' explorer ;设置文件资源管理器的类名和窗口标题的通用部分
        winClass := WinGetClass(hWnd := WinActive('A')) ;获取当前激活窗口的类名
        Switch ;根据当前窗口的类名，判断并获取相应的路径
        {
            Case winClass ~= 'Progman|WorkerW': Return A_Desktop ;如果是桌面或桌面的工作区，则返回桌面路径
            Case winClass ~= 'Shell_TrayW': Return '::{20D04FE0-3AEA-1069-A2D8-08002B30309D}' ; 如果是任务栏，则返回这台电脑的Shell路径
            Case winClass  = explorer: ;如果窗口是文件资源管理器，则获取其路径
            hWnd ?    explorerHwnd := WinExist(winTitle ' ahk_id' hwnd) ;尝试获取指定或当前激活的文件资源管理器窗口的句柄
                : ((!explorerHwnd := WinActive(winTitle)) && explorerHwnd := WinExist(winTitle))
            If explorerHwnd ;如果找到窗口句柄，使用COM对象遍历所有窗口，寻找匹配的窗口并获取其路径
            For window in ComObject('Shell.Application').Windows
            Try If window && window.hwnd && window.hwnd = explorerHwnd
            Return window.Document.Folder.Self.Path
        }
    }
    Run("`"C:\Program Files\Everything\Everything.exe`"" . " -p " . explorerGetPath()) ;使用获取到的路径作为参数，运行Everything并指定该路径
}

OpenEverythingInExplorerWithCurrentPath()
{
    ; 检查当前激活的窗口是否为 explorer (文件资源管理器)
    if WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass") or WinActive("ahk_class WorkerW") or WinActive("ahk_Class Progman") or WinActive("ahk_Class Shell_TrayWnd")
    {
        OpenEverythingInCurrentPath()
    }
    else
    {
        ; 如果不是文件资源管理器，发送原本的 Ctrl+F 组合键
        Send "^f"
    }
}