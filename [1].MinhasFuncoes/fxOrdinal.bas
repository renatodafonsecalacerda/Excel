Attribute VB_Name = "fxOrdinal"
Function Ordinal(ByRef lngCardinal As Long) As String
    ' Chris Rae's VBA Code Archive - http://chrisrae.com/vba
    ' Code by Will Rickards, 15/01/2004
Dim lngTemp1 As Long
Dim lngTemp2 As Long

   ' last two digits
   lngTemp2 = lngCardinal Mod 100
   ' last digit
   lngTemp1 = lngTemp2 Mod 10
   
   If lngTemp2 >= 11 And lngTemp2 <= 13 Then
      Ordinal = lngCardinal & "th"
   ElseIf lngTemp1 >= 4 Or lngTemp1 = 0 Then
      Ordinal = lngCardinal & "th"
   Else
      Ordinal = lngCardinal & Array("st", "nd", "rd")(lngTemp1 - 1)
   End If
End Function
