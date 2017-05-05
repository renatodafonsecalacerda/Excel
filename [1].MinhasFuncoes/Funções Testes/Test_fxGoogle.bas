Attribute VB_Name = "Test_fxGoogle"
Public Sub Google_Translate()

Dim Google_Translate_Internet_Explorer_Automation As Object

Set Google_Translate_Internet_Explorer_Automation = CreateObject("InternetExplorer.Application")

Google_Translate_Internet_Explorer_Automation.Navigate "http://translate.google.com/translate_t#"
Google_Translate_Internet_Explorer_Automation.Visible = True
Wait_Between_Google_Translate_Cycles = Range("G1").Value

Let Column = 0

While Range("f9").Offset(0, Column).Value <> tom

    Do While Google_Translate_Internet_Explorer_Automation.busy
        Call WaitSeconds(Wait_Between_Google_Translate_Cycles)
    Loop
    
    Let to_language_code = Range("f9").Offset(0, Column).Value

    Do While Google_Translate_Internet_Explorer_Automation.busy
        Call WaitSeconds(Wait_Between_Google_Translate_Cycles)
    Loop

    Let Google_Translate_Internet_Explorer_Automation.document.forms("text_form").elements(5).Value = to_language_code

    Do While Google_Translate_Internet_Explorer_Automation.busy
        Call WaitSeconds(Wait_Between_Google_Translate_Cycles)
    Loop

    Let rad = 0

    While Range("c10").Offset(rad, 0).Value <> tom

        If Range("f10").Offset(rad, Column).Value = tom Then

            Let from_language_code = Range("a10").Offset(rad, 0).Value
            Let Google_Translate_Internet_Explorer_Automation.document.forms("text_form").elements(4).Value = from_language_code

            Do While Google_Translate_Internet_Explorer_Automation.busy
                Call WaitSeconds(Wait_Between_Google_Translate_Cycles)
            Loop

            Let Google_Translate_Text = Range("c10").Offset(rad, 0).Value

            While Google_Translate_Internet_Explorer_Automation.busy
                Call WaitSeconds(Wait_Between_Google_Translate_Cycles)
            Wend

            Let Google_Translate_Internet_Explorer_Automation.document.forms("text_form").elements("source").Value = Google_Translate_Text

            While Google_Translate_Internet_Explorer_Automation.busy
                Call WaitSeconds(Wait_Between_Google_Translate_Cycles)
            Wend

            Google_Translate_Internet_Explorer_Automation.document.getElementById("text_form").submit

            While Google_Translate_Internet_Explorer_Automation.busy
                Call WaitSeconds(Wait_Between_Google_Translate_Cycles)
            Wend

            Let dd2 = Google_Translate_Internet_Explorer_Automation.document.forms(1).elements(4).Value

            While Google_Translate_Internet_Explorer_Automation.busy
                Call WaitSeconds(Wait_Between_Google_Translate_Cycles)
            Wend

            Let Google_Translate_Variable1 = Replace(dd2, Chr(13), "")
            Let Range("f10").Offset(rad, Column).Value = Google_Translate_Variable1

        End If

        Let rad = rad + 1
    Wend

    Let Column = Column + 1
Wend

Google_Translate_Internet_Explorer_Automation.Quit

Set Google_Translate_Internet_Explorer_Automation = Nothing

End Sub

Public Sub WaitSeconds(sek)


Let newHour = Hour(Now())

Let newMinute = Minute(Now())

Let newSecond = Second(Now()) + sek

Let waitTime = TimeSerial(newHour, newMinute, newSecond)



Application.Wait waitTime


End Sub
