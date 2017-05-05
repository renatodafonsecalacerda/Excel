Attribute VB_Name = "fxCryptDecrypt"
Option Explicit

''' NOTE: The encrypted data must be stored in a location that supports Unicode text.
''' Such locations include the registry and even plain text files.
''' For demonstration purposes we simply use a public String variable.
Public gszData As String


''' This procedure asks the user for a string and then encrypts it.
Public Sub DemoEncryptData()
    gszData = CStr(Application.InputBox("Enter a string to be encrypted.", "Encyrption Demo"))
    ''' Continue if the user didn't cancel the InputBox or OK it with no entry.
    If (gszData <> CStr(False)) And (Len(gszData) > 0) Then
        ''' Encrypt the specified data string by passing it through the encryption procedure once.
        EncryptDecrypt gszData
        MsgBox "The encrypted string is:" & vbLf & vbLf & gszData, vbInformation, "Encryption Demo"
        Range("a1") = gszData
        
    Else
        gszData = vbNullString
    End If
End Sub


''' This procedure decrypts the string that was encrypted by the procedure above.
Public Sub DemoDecryptData()
    ''' If there is encrypted data stored in our public String variable....
    If Len(gszData) > 0 Then
        ''' Decrypt the specified data string by passing it through the encryption procedure a second time.
        EncryptDecrypt gszData
        MsgBox "The decrypted string is:" & vbLf & vbLf & gszData, vbInformation, "Encryption Demo"
    Else
        MsgBox "There is no stored data to decrypt.", vbExclamation, "Encryption Demo"
    End If
End Sub


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''' Comments:   Performs Xor encryption/decryption on string data. Passing a
'''             string through the procedure once encrypts it. Passing it
'''             through a second time decrypts it.
'''
''' Arguments:  szData          [in|out] A string containing the data to
'''                             encrypt or decrypt.
'''
''' Date        Developer       Action
''' --------------------------------------------------------------------------
''' 05/18/05    Rob Bovey       Created
'''
Private Sub EncryptDecrypt(ByRef szData As String)

    Const lKEY_VALUE As Long = 215
    
    Dim bytData() As Byte
    Dim lCount As Long
    
    bytData = szData
    
    For lCount = LBound(bytData) To UBound(bytData)
        bytData(lCount) = bytData(lCount) Xor lKEY_VALUE
    Next lCount

    szData = bytData
    
End Sub

