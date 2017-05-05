Attribute VB_Name = "fxUltimoDiaDoMes"
Public Function vUltimo_dia_mes(vAno As Integer, vMes As Integer, Optional vDia As Integer = 1) As Integer
Dim vArray_Ultimo_Dia_Meses As Variant

 vArray_Ultimo_Dia_Meses = Array(0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)

 If vMes = 2 Then
    If IsDate("29/2/" & vAno) Then
       vUltimo_dia_mes = 29
    Else
       vUltimo_dia_mes = 28
    End If
 Else
    vUltimo_dia_mes = vArray_Ultimo_Dia_Meses(vMes)
 End If
 
End Function
