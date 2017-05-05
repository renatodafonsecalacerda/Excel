Attribute VB_Name = "FileSystem"
' version 3.0
'
' GetFiles - gets the list of all files from 1.strFolder into a table starting at
'       2.strAddress. only files with 3.maskAllowAttributes (optional - default 0)
'       are listed. Files with 4.maskStopAttributes (optional - default 0) set are
'       are NOT listed.



' wrapper function for GetFiles
Function GetFilesWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments & Chr(10) & 0 & Chr(10) & 0, Chr(10))
    GetFiles arrArguments(0), arrArguments(1), arrArguments(2), arrArguments(3)
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Function



Sub GetFiles(strFolder, strAddress, maskAllowAttributes, maskStopAttributes)
On Error GoTo Error_Handler

    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set Folder = objFSO.GetFolder(strFolder)
    Set Files = Folder.Files
    
    allowAttributes = GetDecimalFromBinary(maskAllowAttributes)
    stopAttributes = GetDecimalFromBinary(maskStopAttributes)
    
    Set cellCurrent = ExcelBricks.fGetRange(strAddress)
    For Each file In Files
        If (allowAttributes And file.Attributes) = allowAttributes And _
           (stopAttributes And file.Attributes) = 0 Then
            cellCurrent.Value = file.Name
            Set cellCurrent = cellCurrent.Offset(1, 0)
        End If
    Next

Error_Handler:
    If Err.Number <> 0 Then
        strErrDescription = Err.Description
        lngErrNumber = Err.Number
    End If
    
    On Error Resume Next
    Set Folder = Nothing
    Set Files = Nothing
    Set cellCurrent = Nothing
    Set objFSO = Nothing
    On Error GoTo 0

    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub

Function GetDecimalFromBinary(strBinary)
    GetDecimalFromBinary = 0
    For i = 1 To Len(strBinary)
        GetDecimalFromBinary = GetDecimalFromBinary + (CDbl(Mid(strBinary, Len(strBinary) - i + 1, 1)) * (2 ^ (i - 1)))
    Next
End Function
