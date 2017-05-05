Attribute VB_Name = "fxGetComputerName"
Private Declare Function GetComputerName Lib "kernel32" Alias _
   "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long
  
Function apicGetComputerName() As String
    'Call to apiGetUserName returns current user.
  Dim lngResponse As Long
  Dim strUserName As String * 32
    lngResponse = GetComputerName(strUserName, 32)
  apicGetComputerName = Left(strUserName, InStr(strUserName, Chr$(0)) - 1)
End Function

