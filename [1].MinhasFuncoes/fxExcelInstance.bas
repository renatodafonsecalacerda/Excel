Attribute VB_Name = "fxExcelInstance"
Sub ExcelInstance()
Dim ExcelApplication As Object
   Dim TimeoutTime As Long

   On Error Resume Next
   Set ExcelApplication = GetObject(, "Excel.Application")
   On Error GoTo 0

   If ExcelApplication Is Nothing Then
       Shell "Excel.exe"

       Let TimeoutTime = Timer + 5

       On Error Resume Next

       Do
           DoEvents
           Err.Reset
           Set ExcelApplication = GetObject(, "Excel.Application")
       Loop Until Not ExcelApplication Is Nothing Or Timer > TimeoutTime

       On Error GoTo 0
   End If

   If ExcelApplication Is Nothing Then
       MsgBox "Unable to launch Excel."
   Else
       ' Do something with the Excel instance...
   End If
End Sub
