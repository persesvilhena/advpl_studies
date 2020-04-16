#Include 'Protheus.Ch'
User Function xTCheckBox()
	Local lCheck1 := .T.
	Local lCheck2 := .F.
	Local oCheck1
	Local oCheck2
	Local oDlg

	DEFINE MSDIALOG oDlg FROM 0,0 TO 270,400 PIXEL TITLE 'Teste Checkbox'

	oCheck1 := TCheckBox():New(01,01,'CheckBox 1',,oDlg,100,210,,,,,,,,.T.,,,) //Chamada da Classe
	oCheck2 := TCheckBox():New(11,01,'CheckBox 2',,oDlg,100,210,,,,,,,,.T.,,,)

	//Validações do Box 1
	oCheck1:bSetGet := {|| lCheck1 }
	oCheck1:bLClicked := {|| lCheck1:=!lCheck1 }
	oCheck1:bWhen := {|| .T. }
	oCheck1:bChange:= {|| Alert("Checkbox 1 mudou de valor")}
	//Validações do Box 2
	oCheck2:bSetGet := {|| lCheck2 }
	oCheck2:bLClicked := {|| lCheck2:=!lCheck2 }
	oCheck2:bWhen := {|| .T. }
	oCheck2:bValid := {|| Alert(IIF(lCheck1,"Duas opcoes selecionadas","Somente segunda opcao selecionada")) }
	//Botão
	oBtn := TButton():New( 060, 001, 'Ver CheckBox',oDlg,{|| Alert(iif(lcheck1 .and. !lCheck2 ,"Checkbox 1 clicado",IIF(lcheck2 .and. !lcheck1 ,"Checkbox 2 clicado","Outras selecoes"))) }, 120,010,,,.F.,.T.,.F.,,.F.,,,.F. )
	ACTIVATE MSDIALOG oDlg CENTERED

Return