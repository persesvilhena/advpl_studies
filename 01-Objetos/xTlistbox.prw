#Include "Protheus.ch"
User Function xTlistbox()
	Local oDlg, oList, nList:= 1, aItems:={}
	Aadd(aItems,"ITEM 1")
	Aadd(aItems,"ITEM 2")
	Aadd(aItems,"ITEM 3")

	DEFINE MSDIALOG oDlg FROM 0,0 TO 400,400 PIXEL TITLE "Teste Tlistbox"
	oList:= tListBox():New(010,010,{|u| iif(Pcount()>0,nList:=u,nList)},aItems,100,100,,oDlg,,,,.T.)
	oButton:=tButton():New(120,010,'fechar',oDlg,{||oDlg:End()},100,20,,,,.T.)
	ACTIVATE MSDIALOG oDlg CENTERED

	MsgStop( 'Valor da selecao '+aitems[nList])
Return NIL
