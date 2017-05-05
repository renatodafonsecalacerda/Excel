VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "oPessoa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private pNome As String
Private pSobreNome As String
Private pDataNascimento As Date
Private pRG As String

' =================== [PROPRIEDADES] ===================
Public Property Let Nome(Valor As String)
    pNome = Valor
End Property
Public Property Get Nome() As String
    Nome = pNome
End Property

Public Property Let SobreNome(Valor As String)
    pSobreNome = Valor
End Property
Public Property Get SobreNome() As String
    SobreNome = pSobreNome
End Property

Public Property Let DataNascimento(Valor As Date)
    pDataNascimento = Valor
End Property
Public Property Get DataNascimento() As Date
    DataNascimento = pDataNascimento
End Property

Public Property Let RG(Valor As String)
    pRG = Valor
End Property
Public Property Get RG() As String
    RG = pRG
End Property

' =================== [] ===================


