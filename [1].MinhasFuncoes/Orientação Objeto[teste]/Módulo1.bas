Attribute VB_Name = "Módulo1"
Sub t()
Dim m As New clsPerson

'm = m.CreatePerson("renato", "lacerda")
m.InitializeDefaultValues

Debug.Print m.Item(0)

End Sub

