Attribute VB_Name = "fxHorasPM"
Sub testeFunction()
For x = 1 To 24
Cells(x, 5) = HorasPM(Val(x))
Next
End Sub
Public Function HorasPM(valor As Integer) As String
Dim Manha, Tarde, Noite
Manha = " da Manhã"
Tarde = " da Tarde"
Noite = " da Noite"
    Select Case (valor)
        Case 1
            HorasPM = "Uma Hora" + Manha
        Case 2
            HorasPM = "Duas Horas" + Manha
        Case 3
            HorasPM = "Três Horas" + Manha
        Case 4
            HorasPM = "Quatro Horas" + Manha
        Case 5
            HorasPM = "Cinco Horas" + Manha
        Case 6
            HorasPM = "Seis Horas" + Manha
        Case 7
            HorasPM = "Sete Horas"
        Case 8
            HorasPM = "Oito Horas"
        Case 9
            HorasPM = "Nove Horas"
        Case 10
            HorasPM = "Dez Horas"
        Case 11
            HorasPM = "Onze Horas"
        Case 12
            HorasPM = "Meio Dia"
        Case 13
            HorasPM = "Uma Hora" + Tarde
        Case 14
            HorasPM = "Duas Horas" + Tarde
        Case 15
            HorasPM = "Três Horas" + Tarde
        Case 16
            HorasPM = "Quatro Horas" + Tarde
        Case 17
            HorasPM = "Cinco Horas" + Tarde
        Case 18
            HorasPM = "Seis Horas" + Tarde
        Case 19
            HorasPM = "Sete Horas" + Noite
        Case 20
            HorasPM = "Oito Horas" + Noite
        Case 21
            HorasPM = "Nove Horas" + Noite
        Case 22
            HorasPM = "Dez Horas" + Noite
        Case 23
            HorasPM = "Onze Horas" + Noite
        Case 24
            HorasPM = "Meia Noite"
    End Select
End Function
