#include 'protheus.ch'
User Function XTsay()
Local oDlg
Local oSay

DEFINE MSDIALOG oDlg FROM 0,0 TO 200,200 TITLE 'Teste TSay()' PIXEL

oSay := TSay():New(10, 10, { || "Mensagem" } ,oDlg,,,,,, .T.,, )
oSay:lTransparent:= .F.

ACTIVATE MSDIALOG oDlg CENTERED

Return
