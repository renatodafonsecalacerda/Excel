Attribute VB_Name = "fxFormula2Data"
Sub Formula2Data(rangeinterval As Range, placetopaste As Range)
Attribute Formula2Data.VB_ProcData.VB_Invoke_Func = " \n14"
    rangeinterval.Select
    Selection.Copy
    placetopaste.Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
End Sub
Sub testemain()
Call Formula2Data(Range("b2:j6"), Range("b2"))
End Sub
