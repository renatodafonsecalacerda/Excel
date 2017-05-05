Attribute VB_Name = "fxProtegeTodasasPlanilhas"
'Função que protege todas as planilhas de um arquivo
Sub lsProtegerTodasAsPlanilhas()
    'Declara as variáveis necessárias
    Dim lPass As String
    Dim lQtdePlan As Integer
    Dim lPlanAtual As Integer
 
    'Solicita a senha
    'O método InputBox é utilizado para solicitar um valor através de um formulário
    lPass = InputBox("Proteger todas as planilhas:", "Senha", ActName)
 
    'Inicia as variáveis
    'O método Worksheets.Count passa a quantidade de planilhas existentes no arquivo
    lQtdePlan = Worksheets.Count
    lPlanAtual = 1
 
    'Loop pelas planilhas
    'A função While realiza um loop de código enquanto não passar por todas as planilhas contadas
    While lPlanAtual <= lQtdePlan
        'O método Worksheets(lPlanAtual).Activate ativa a planilha conforme o índice atual 1, 2, 3...
        Worksheets(lPlanAtual).Activate
 
        'O método .Protect proteje a planilha passando os parâmetros para proteger
        'objetos de desenho, conteúdo, cenários e passando o password digitado
        ActiveSheet.Protect DrawingObjects:=True, Contents:=True, Scenarios:=True, Password:=lPass
 
        'Muda o índice para passar para a próxima planilha
        lPlanAtual = lPlanAtual + 1
    Wend
 
    'O método MsgBox exibe um formulário de aviso ao usuário.
    MsgBox "Planilhas protegidas!"
 
End Sub
'Função que desprotege todas as planilhas de um arquivo
Sub lsDesprotegerTodasAsPlanilhas()
    'Declara as variáveis necessárias
    Dim lPass As String
    Dim lQtdePlan As Integer
    Dim lPlanAtual As Integer
 
    'Solicita a senha
    'O método InputBox é utilizado para solicitar um valor através de um formulário
    lPass = InputBox("Desproteger todas as planilhas:", "Senha", ActName)
 
    'Inicia as variáveis
    'O método Worksheets.Count passa a quantidade de planilhas existentes no arquivo
    lQtdePlan = Worksheets.Count
    lPlanAtual = 1
 
    'Loop pelas planilhas
    'A função While realiza um loop de código enquanto não passar por todas as planilhas contadas
    While lPlanAtual <= lQtdePlan
        'O método Worksheets(lPlanAtual).Activate ativa a planilha conforme o índice atual 1, 2, 3...
        Worksheets(lPlanAtual).Activate
 
        'O método .UnProtect desprotege a planilha
        ActiveSheet.Unprotect Password:=lPass
 
        'Muda o índice para passar para a próxima planilha
        lPlanAtual = lPlanAtual + 1
    Wend
 
    'O método MsgBox exibe um formulário de aviso ao usuário.
    MsgBox "Planilhas desprotegidas!"
 
End Sub
