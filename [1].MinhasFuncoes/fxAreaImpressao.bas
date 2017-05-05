Attribute VB_Name = "fxAreaImpressao"
Sub AreaImpressao(p As Worksheet, range As String)
    p.range(range).Select
    p.PageSetup.PrintArea = range
End Sub

    
