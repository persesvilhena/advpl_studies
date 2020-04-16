#include 'protheus.ch'
User Function xtpanel()
Local oDlg := Nil
Local oPanel := Nil

DEFINE MSDIALOG oDlg FROM 0,0 TO 300,300 PIXEL TITLE 'Tpanel'
oPanel:= tPanel():New(010,010,"",oDlg,,,,,CLR_BLUE,100,50) // cria o painel
ACTIVATE MSDIALOG oDlg CENTERED

Return