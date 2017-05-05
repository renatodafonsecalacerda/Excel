Attribute VB_Name = "fxAbaExiste"
Public Function AbaExiste(plan As Worksheet) As Boolean
    AbaExiste = IIf(Not plan Is Nothing, True, False)
End Function
