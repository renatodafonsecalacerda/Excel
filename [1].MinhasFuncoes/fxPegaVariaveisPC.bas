Attribute VB_Name = "fxPegaVariaveisPC"
Function getPCName() As String
    getPCName = Environ$("computername")
End Function

Function getUserName() As String
    getUserName = Environ$("username")
End Function

