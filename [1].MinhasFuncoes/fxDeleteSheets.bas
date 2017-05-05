Attribute VB_Name = "fxDeleteSheets"
Function DeleteSheets(ByVal dontdelete As String)
    Application.DisplayAlerts = False
    For Each e In Worksheets
        If e.Name <> dontdelete Then
            e.Delete
        End If
    Next
    Application.DisplayAlerts = True
End Function
