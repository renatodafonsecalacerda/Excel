Attribute VB_Name = "fxExtractEmailAddress"
Function ExtractEmailAddress(s As String) As String
    Dim AtSignLocation As Long
    Dim i As Long
    Dim TempStr As String
    Const CharList As String = "[A-Za-z0-9._-]"
    
    'Get location of the @
    AtSignLocation = InStr(s, "@")
    If AtSignLocation = 0 Then
        ExtractEmailAddress = "" 'not found
    Else
        TempStr = ""
        'Get 1st half of email address
        For i = AtSignLocation - 1 To 1 Step -1
            If Mid(s, i, 1) Like CharList Then
                TempStr = Mid(s, i, 1) & TempStr
            Else
                Exit For
            End If
        Next i
        If TempStr = "" Then Exit Function
        'get 2nd half
        TempStr = TempStr & "@"
        For i = AtSignLocation + 1 To Len(s)
            If Mid(s, i, 1) Like CharList Then
                TempStr = TempStr & Mid(s, i, 1)
            Else
                Exit For
            End If
        Next i
    End If
    'Remove trailing period if it exists
    If Right(TempStr, 1) = "." Then TempStr = _
       Left(TempStr, Len(TempStr) - 1)
    ExtractEmailAddress = TempStr
End Function

