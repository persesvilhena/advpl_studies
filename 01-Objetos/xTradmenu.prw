#include "protheus.ch"
User Function xTradmenu()
Local oDlg
Local oButton
Local oRadio
Local nRadio:=1
Local aOptions:={"Feminino","Masculino","Autorizado pelo supremo"}

DEFINE MSDIALOG oDlg FROM 0,0 TO 300,300 PIXEL TITLE "Teste Tradmenu"
oRadio := tRadMenu():New(010,010,aOptions,{|u| iif(PCount()>0,nRadio :=u,nRadio )},oDlg,,,,,,,,100,20,,,,.T.)

@ 040,010 BUTTON "Sair" SIZE 030,015 OF oDlg PIXEL ACTION (lRET:=.T.,oDlg:End())
ACTIVATE MSDIALOG oDlg CENTERED

MsgStop("Item escolhido " + aOptions[nRadio] )

Return NIL