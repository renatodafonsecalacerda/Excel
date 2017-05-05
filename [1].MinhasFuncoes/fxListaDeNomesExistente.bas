Attribute VB_Name = "fxListaDeNomesExistente"
Function NamedRangeExists(strName As String, Optional wbName As String) As Boolean
     'Declare variables
    Dim rngTest As Range, i As Long
     
     'Set workbook name if not set in function, as default/activebook
    If wbName = vbNullString Then wbName = ActiveWorkbook.Name
     
    With Workbooks(wbName)
        On Error Resume Next
         
         'Loop through all sheets in workbook.  In VBA, you MUST specify
         ' the worksheet name which the named range is found on.  Using
         ' Named Ranges in worksheet functions DO work across sheets
         ' without explicit reference.
        For i = 1 To .Sheets.Count Step 1
             
             'Try to set our variable as the named range.
            Set rngTest = .Sheets(i).Range(strName)
             
             'If there is no error then the name exists.
            If Err = 0 Then
                 
                 'Set the function to TRUE & exit
                NamedRangeExists = True
                Exit Function
            Else
                 'Clear the error
                Err.Clear
                 
            End If
             
        Next i
         
    End With
     
End Function

Public Function NamedRange(SH As Worksheet, R As Range, Nome As String)
     
    If NamedRangeExists(Nome) = True Then
        ActiveWorkbook.Names(Nome).Delete
    End If
    
    Dim Rng1 As Range
     
     'Change the range of cells (A1:B15) to be the range of cells you want to define
    Set Rng1 = R
    ActiveWorkbook.Names.Add Name:=Nome, RefersTo:=Rng1
     
End Function
Public Function NomeIntervalo(SH As Worksheet, R As Range, Nome As String)
NomeIntervalo = NamedRange(SH, R, Nome)
End Function
Sub Teste()
Call NomeIntervalo(Sheets("CONFIG"), Range("B2:D2"), "unidade")
End Sub

 
 
 
