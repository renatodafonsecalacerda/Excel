Attribute VB_Name = "fxMySplit"
'Origem: http://guiadoexcel.com.br/funcao-excel-para-dividir-celula-em-colunas-diferentes
'=mySplit($A$1;";";COL()-1)
Public Function mySplit(ByVal lTexto As String, ByVal lEncontrar As String, ByVal lPosicao As Integer) As String
    Application.Volatile
 
    Dim lVariant() As String
 
    lVariant = Split(lTexto, lEncontrar)
 
    If UBound(lVariant) >= lPosicao - 1 Then
        mySplit = lVariant(lPosicao - 1)
    End If
 
End Function
