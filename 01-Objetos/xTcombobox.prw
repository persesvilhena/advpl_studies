#Include 'Protheus.Ch'
User Function xTcombobox()
	Local oDlg, oButton, oCombo, cCombo
	aItems:= {'Solteiro','Casado','Divorciado', 'Outros', 'Enrolado'}
	cCombo:= aItems[4]

	DEFINE MSDIALOG oDlg FROM 0,0 TO 300,300 PIXEL TITLE 'Teste Combobox'
	oCombo:= tComboBox():New(010,010,{|u|if(PCount()>0,cCombo:=u,cCombo)},;
	aItems,100,20,oDlg,,{|| M->A1_XSITU:= cCombo} ,,,,.T.,,,,,,,,,'cCombo')
	oButton:=tButton():New(030,010,'fechar',oDlg,{||oDlg:End()},70,20,,,,.T.)
	ACTIVATE MSDIALOG oDlg CENTERED
Return NIL