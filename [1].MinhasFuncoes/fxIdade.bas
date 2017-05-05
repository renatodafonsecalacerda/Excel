Attribute VB_Name = "fxIdade"
Function Idade(DoB As Date)
    If DoB = 0 Then
        Idade = "No Birthdate"
    Else
        Select Case Month(Date)
            Case Is < Month(DoB)
                Idade = Year(Date) - Year(DoB) - 1
            Case Is = Month(DoB)
                If Day(Date) >= Day(DoB) Then
                    Idade = Year(Date) - Year(DoB)
                Else
                    Idade = Year(Date) - Year(DoB) - 1
                End If
            Case Is > Month(DoB)
                Idade = Year(Date) - Year(DoB)
        End Select
    End If
End Function
