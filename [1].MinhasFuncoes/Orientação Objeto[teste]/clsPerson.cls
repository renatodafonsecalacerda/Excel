VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsPerson"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'this collection could contain anything, but the class
'controls access to it and ensures it will just contain people
Private Persons As New Collection
Public FirstName As String
Public Lastname As String

'Construtor
'Public Function CreatePerson(name As String, lastname As String) As clsPerson

'    Set CreatePerson = New clsPerson
'    CreatePerson.InitiateProperties name:=name, age:=lastname

'End Function

Private Sub clsPerson_Initialize(Optional fn As String = "", Optional ln As String = "")
    FirstName = ""
    Lastname = ""
End Sub

Public Sub InitializeWithValues(ByVal fn As String, ByVal ln As String)
    FirstName = fn
    Lastname = ln
End Sub

Public Sub InitializeDefaultValues()
    FirstName = "Renato"
    Lastname = "Lacerda"
End Sub

Sub Add(FirstName As String, Lastname As String)
'create a new person and add to collection
Dim p As New clsPerson
p.FirstName = FirstName
p.Lastname = Lastname
Persons.Add p
End Sub
Property Get Count() As Long
'return the number of people
Count = Persons.Count
End Property
Property Get Item(NameOrNumber As Variant) As clsPerson
'return this particular person
Set Item = Persons(NameOrNumber)
End Property
Sub Remove(NameOrNumber As Variant)
'remove this person from collection
Persons.Remove NameOrNumber
End Sub
