Attribute VB_Name = "fxRandom"
Sub random_num(valor As Integer, linha As Integer, coluna As Integer, p As Worksheet)
    'Initialize the random number generator
    '=> Randomize : add this before you call the Rnd function to obtain completely random values
    Randomize
    random_number = Int(valor * Rnd) + 1
    
    p.Cells(linha, coluna) = random_number
    
    Debug.Print random_number
    
End Sub
Public Function Randomico(valor As Integer) As Double
    Randomize
    Randomico = Int(valor * Rnd) + 1
End Function

Sub Main()
Dim p As Worksheet
Set p = ActiveSheet
Call random_num(100, 1, 1, p)
End Sub
