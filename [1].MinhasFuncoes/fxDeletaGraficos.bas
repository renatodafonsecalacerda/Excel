Attribute VB_Name = "fxDeletaGraficos"

Function DeletarGraficos(p As Worksheet)
    Dim WSD As Worksheet
    Set WSD = p
    WSD.ChartObjects.Delete
End Function
