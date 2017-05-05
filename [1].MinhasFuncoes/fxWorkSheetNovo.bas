Attribute VB_Name = "fxWorkSheetNovo"
Private Sub GenerateNewWorksheet()
    Dim ActSheet As Worksheet
    Dim NewSheet As Worksheet
 
    ' Prevents screen refreshing.
    Application.ScreenUpdating = False

    Set ActSheet = ActiveSheet
    Set NewSheet = ThisWorkbook.Sheets().Add()
 
    NewSheet.Move After:=Sheets(ThisWorkbook.Sheets().Count)
 
    ActSheet.Select

     ' Enables screen refreshing.
    Application.ScreenUpdating = True
End Sub
