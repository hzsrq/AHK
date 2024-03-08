#NoTrayIcon
#SingleInstance Force

#IfWinActive, ahk_class CabinetWClass
^F::
   ControlGetText, RunPath, ToolbarWindow323, A
   RunPath := SubStr(RunPath, 10)
   isnotauserfolder := ":\"
   IfNotInString, RunPath, %isnotauserfolder%
   {
      RunPath := "%UserProfile%" . "\" . RunPath . "\"
   }
   Run, C:\Program Files\Everything\Everything.exe -p "%RunPath%"
   Return
#IfWinActive
