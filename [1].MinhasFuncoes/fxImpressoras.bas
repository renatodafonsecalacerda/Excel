Attribute VB_Name = "fxImpressoras"
Option Explicit
 
Const PRINTER_ENUM_CONNECTIONS = &H4
Const PRINTER_ENUM_LOCAL = &H2
 
Private Declare Function EnumPrinters Lib "winspool.drv" Alias "EnumPrintersA" _
                                      (ByVal flags As Long, ByVal name As String, ByVal Level As Long, _
                                       pPrinterEnum As Long, ByVal cdBuf As Long, pcbNeeded As Long, _
                                       pcReturned As Long) As Long
 
Private Declare Function PtrToStr Lib "kernel32" Alias "lstrcpyA" _
                                  (ByVal RetVal As String, ByVal Ptr As Long) As Long
 
Private Declare Function StrLen Lib "kernel32" Alias "lstrlenA" _
                                (ByVal Ptr As Long) As Long
 
 
Public Function ListPrinters() As Variant
 
    Dim bSuccess As Boolean
    Dim iBufferRequired As Long
    Dim iBufferSize As Long
    Dim iBuffer() As Long
    Dim iEntries As Long
    Dim iIndex As Long
    Dim strPrinterName As String
    Dim iDummy As Long
    Dim iDriverBuffer() As Long
    Dim StrPrinters() As String
 
    iBufferSize = 3072
 
    ReDim iBuffer((iBufferSize \ 4) - 1) As Long
 
    'A função EnumPrinters retornará falso casa a fila de impressão estiver muito cheia
    bSuccess = EnumPrinters(PRINTER_ENUM_CONNECTIONS Or _
                            PRINTER_ENUM_LOCAL, vbNullString, _
                            1, iBuffer(0), iBufferSize, iBufferRequired, iEntries)
 
    If Not bSuccess Then
        If iBufferRequired > iBufferSize Then
            iBufferSize = iBufferRequired
            Debug.Print "iBuffer too small. Trying again with "; _
                        iBufferSize & " bytes."
            ReDim iBuffer(iBufferSize \ 4) As Long
        End If
 
        'Tentar chamar a função novamente
        bSuccess = EnumPrinters(PRINTER_ENUM_CONNECTIONS Or _
                                PRINTER_ENUM_LOCAL, vbNullString, _
                                1, iBuffer(0), iBufferSize, iBufferRequired, iEntries)
    End If
 
    If Not bSuccess Then
        'Mostra mensagem em caso de erro na chamada da EnumPrinters
        MsgBox "Error enumerating printers."
        Exit Function
    Else
        'Caso EnumPrinters retorne True, preenche o array com as impressoras
        ReDim StrPrinters(iEntries - 1)
        For iIndex = 0 To iEntries - 1
            'Pega o nome da impressora
            strPrinterName = Space$(StrLen(iBuffer(iIndex * 4 + 2)))
            iDummy = PtrToStr(strPrinterName, iBuffer(iIndex * 4 + 2))
            StrPrinters(iIndex) = strPrinterName
        Next iIndex
    End If
 
    ListPrinters = StrPrinters
 
End Function
 
Public Function IsBounded(vArray As Variant) As Boolean
    'Se a variável passada é um array, retorna True, do contrário, False
    On Error Resume Next
    IsBounded = IsNumeric(UBound(vArray))
End Function

