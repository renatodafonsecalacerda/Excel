Attribute VB_Name = "Memory"
' version 3.0
'
' sShowMemory - shows the memory used by excel in the status bar. Waits if
'   strPauseFlag (optional) is present. Displays for 500ms and exits otherwise.



' Performance monitor functions for Visual Basic from PDH.DLL
' from http://support.microsoft.com/kb/319998
Declare Function PdhVbOpenQuery Lib "pdh.dll" _
    (ByRef QueryHandle As Long) As Long
Declare Function PdhCloseQuery Lib "pdh.dll" _
    (ByVal QueryHandle As Long) As Long
Declare Function PdhVbAddCounter Lib "pdh.dll" _
    (ByVal QueryHandle As Long, ByVal CounterPath As String, _
    ByRef CounterHandle As Long) As Long
Declare Function PdhRemoveCounter Lib "pdh.dll" _
    (ByVal CounterHandle As Long) As Long
Declare Function PdhCollectQueryData Lib "pdh.dll" _
    (ByVal QueryHandle As Long) As Long
Declare Function PdhVbGetDoubleCounterValue Lib "pdh.dll" _
    (ByVal CounterHandle As Long, ByRef CounterStatus As Long) As Double
Declare Function PdhVbIsGoodStatus Lib "pdh.dll" _
    (ByVal StatusValue As Long) As Long
Declare Function PdhVbGetOneCounterPath Lib "pdh.dll" _
    (ByVal PathString As String, ByVal PathLength As Long, _
    ByVal DetailLevel As Long, ByVal CaptionString As String) As Long
Declare Function PdhVbCreateCounterPathList Lib "pdh.dll" _
    (ByVal DetailLevel As Long, ByVal CaptionString As String) As Long
Declare Function PdhVbGetCounterPathFromList Lib "pdh.dll" _
    (ByVal Index As Long, ByVal Buffer As String, _
    ByVal BufferLength As Long) As Long
Declare Function PdhVbGetCounterPathElements Lib "pdh.dll" _
    (ByVal PathString As String, ByVal MachineName As String, _
    ByVal ObjectName As String, ByVal InstanceName As String, _
    ByVal ParentInstance As String, ByVal CounterName As String, _
    ByVal BufferSize As Long) As Long

' to calculate increment
Dim dblPrivateBytes



' sShowIndicator wrapper
Sub sShowMemoryWrapper(strArguments)
On Error GoTo Error_Handler

    arrArguments = Split(strArguments, Chr(10))
    If strArguments = "" Then
        sShowMemory
    Else
        sShowMemory (arrArguments(0))
    End If
    
Error_Handler:
    ExcelBricks.lngGlobalErrNumber = Err.Number
    ExcelBricks.strGlobalErrDescription = Err.Description
End Sub



' shows memory and memory indicator for the excel process
Sub sShowMemory(Optional strPauseFlag)
On Error GoTo Error_Handler
    
    ' initialize PDH query object and counter
    PdhVbOpenQuery hPDHQuery
    strCounterPath = "\\" & Environ$("computername") & "\Process(Excel)\Private Bytes"
    PdhVbAddCounter hPDHQuery, strCounterPath, hPDHCounter
    
    ' gather data, get counter value and process data
    PdhCollectQueryData hPDHQuery
    dblOldPrivateBytes = dblPrivateBytes
    dblPrivateBytes = CDbl(PdhVbGetDoubleCounterValue(hPDHCounter, lngCounterStatus))
    dblPrivateMB = Round(dblPrivateBytes / 1000000, 3)
    dblChangeKB = Round((dblPrivateBytes - dblOldPrivateBytes) / 1000, 3)
      
      
    ' to show in status bar
    strText = "Memory used : " & dblPrivateMB
    
    strText = strText & " MB "
    If dblOldPrivateBytes > 0 Then
        If dblChangeKB > 0 Then
            strText = strText & ", Change : +" & dblChangeKB & " KB"
        ElseIf dblChangeKB < 0 Then
            strText = strText & ", Change : -" & Abs(dblChangeKB) & " KB"
        Else
            strText = strText & ", Change : " & dblChangeKB & " KB"
        End If
    End If
    
    
    Application.ScreenUpdating = True       ' to avoid flicker
    Application.StatusBar = strText         ' show in status bar
    
    ' wait, otherwise we'll miss the message
    If IsMissing(strPauseFlag) Then
        ExcelBricks.Sleep (500)
    Else
        MsgBox "Memory displayed in status bar. Press OK to continue", vbOKOnly
    End If

Error_Handler:
    If Err.Number <> 0 Then
        lngErrNumber = Err.Number
        strErrDescription = Err.Description
    End If
    
    On Error Resume Next
    PdhRemoveCounter (hPDHCounter)
    PdhCloseQuery (hPDHQuery)
    Application.ScreenUpdating = False
    Application.StatusBar = False
    On Error GoTo 0

    If lngErrNumber <> 0 Then Err.Raise lngErrNumber, , strErrDescription
End Sub
