#Include "Protheus.Ch"

User Function xTFolder()
	Local oFolder, oDlg, oFont, oCheck1, oCheck2
	Local lCheck1 := .T.
	Local lCheck2 := .F.
	Local aFolder := { 'Folder 1', 'Folder 2', 'Folder 3', 'Folder 4' }

	DEFINE MSDIALOG oDlg FROM 0,0 TO 400,400 PIXEL TITLE "Teste TFolder"
	oFolder := TFolder():New(0,0,aFolder,aFolder,oDlg,,,, .T.,, 200,200 )
	oFont   := TFont():New('Courier new',,-16,.T.)
	oButton := tButton():New(120,010,'FOLDER 1',oFolder:aDialogs[1],{||oDlg:End()},100,20,,oFont,,.T.)
	oButton := tButton():New(120,010,'FOLDER 2',oFolder:aDialogs[2],{||oDlg:End()},100,20,,oFont,,.T.)
	oButton := tButton():New(120,010,'FOLDER 3',oFolder:aDialogs[3],{||oDlg:End()},100,20,,oFont,,.T.)

	oCheck1 := TCheckBox():New(01,01,'CheckBox 1',,oFolder:aDialogs[4],100,210,,,,,,,,.T.,,,) //Chamada da Classe
	oCheck2 := TCheckBox():New(11,01,'CheckBox 2',,oFolder:aDialogs[4],100,210,,,,,,,,.T.,,,)

	//Validações do Box 1
	oCheck1:bSetGet := {|| lCheck1 }
	oCheck1:bLClicked := {|| lCheck1:=!lCheck1 }
	oCheck1:bWhen := {|| .T. }
	oCheck1:bChange:= {|| Alert("Checkbox 1 mudou de valor")}

	ACTIVATE MSDIALOG oDlg CENTERED

Return