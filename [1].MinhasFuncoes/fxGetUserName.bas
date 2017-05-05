Attribute VB_Name = "fxGetUserName"
' By Chris Rae, 14/6/99, 3/9/00.
Option Explicit
' This is used by GetUserName() to find the current user's
' name from the API
Declare Function Get_User_Name Lib "advapi32.dll" Alias _
                 "GetUserNameA" (ByVal lpBuffer As String, _
                 nSize As Long) As Long
Function GetUserName() As String
    Dim lpBuff As String * 25
 
    Get_User_Name lpBuff, 25
    GetUserName = Left(lpBuff, InStr(lpBuff, Chr(0)) - 1)
End Function

