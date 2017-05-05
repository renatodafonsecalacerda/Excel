Attribute VB_Name = "fxDebug"
Sub Imprime(Valor As Variant)

On Error GoTo err
    Debug.Print Valor: Exit Sub
err:
    Debug.Print "---[erro]--" & err.Number
End Sub

Function DEBUG_ARRAY(R As Variant)
    For Each A In R
        Debug.Print A
    Next
End Function

Sub Test()
DEBUG_ARRAY (Range("A1:A5").Value)
End Sub
' add references
' Tools >>References >>Microsoft Visual Basic for Applications Extensibility 5.3
Public Function ClearDebug()
    Debug.Print String(65535, vbCr)
End Function
