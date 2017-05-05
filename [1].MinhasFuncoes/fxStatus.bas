Attribute VB_Name = "fxStatus"
Function fxStatusBar(posINI, posFIM)
    Application.ScreenUpdating = True
    Application.StatusBar = "Executando.. Posição: " & posINI & " de " & posFIM
    Application.ScreenUpdating = False
End Function
Function fxStatusBarModulo(modulo)
    Application.ScreenUpdating = True
    Application.StatusBar = "Executando.. : " & modulo
    Application.ScreenUpdating = False
End Function
Function fxStatusBarModuloPosicao(modulo As String, posINI, posFIM)
    Application.ScreenUpdating = True
    Application.StatusBar = "Executando.. : " & modulo & " Posição: " & posINI & " de " & posFIM
    Application.ScreenUpdating = False
End Function
