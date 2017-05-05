Attribute VB_Name = "modSheetProcedures"
Option Explicit
Private Const ciMaxLenSheetName As Integer = 31

Private Function SheetNameIllegalCharacters() As Variant
    SheetNameIllegalCharacters = Array("/", "\", "[", "]", "*", "?", ":")
End Function

Public Function IsValidSheetName(strSheetName As String) As Boolean
    IsValidSheetName = False
    If Len(strSheetName) = 0 Then Exit Function
    If Len(strSheetName) > ciMaxLenSheetName Then Exit Function

    Dim varSheetNameIllegalCharacters As Variant: varSheetNameIllegalCharacters = SheetNameIllegalCharacters
    
    Dim i As Integer
    For i = LBound(varSheetNameIllegalCharacters) To UBound(varSheetNameIllegalCharacters)
        If InStr(strSheetName, (varSheetNameIllegalCharacters(i))) > 0 Then Exit Function
    Next i

    IsValidSheetName = True
End Function

Public Function SheetExists(strSheetName As String, Optional wbWorkbook As Workbook) As Boolean
    SheetExists = True
    On Error GoTo HandleError
    Set wbWorkbook = WorkbookOptionalNothingTakeActive(wbWorkbook)
    Dim obj As Object
    Set obj = wbWorkbook.Sheets(strSheetName)
    Exit Function
HandleError:
    SheetExists = False
End Function

Private Function WorkbookOptionalNothingTakeActive(Optional wbWorkbook As Workbook) As Workbook
        If wbWorkbook Is Nothing Then
            Set WorkbookOptionalNothingTakeActive = ActiveWorkbook
        Else
            WorkbookOptionalNothingTakeActive = wbWorkbook
        End If
End Function


