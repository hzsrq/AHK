#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Force

#^i::Run("rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,4") ;Quick Access Internet Options
#^n::Run("ncpa.cpl") ;Quick Access Network Connections