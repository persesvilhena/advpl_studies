#Include "Protheus.Ch"

//Exemplode uso da TReport sem usar metodo TRSection:Print

User Function xReport1()
Local oReport
Private cPerg:= "RNFT001"

ValidPerg()

If TRepInUse() //verifica se relatorios personalizaveis esta disponivel
	Pergunte(cPerg,.F.)
	oReport := ReportDef()
	oReport:PrintDialog()
EndIf
Return
//---------------------------------------
//Inicializa os componentes do Relatorio|
//---------------------------------------
Static Function ReportDef()
Local oReport
Local oSection

oReport := TReport():New("xReport1","Relacao das Solicitacoes de Compras","RNFT001",{|oReport| PrintReport(oReport)},"Este relatorio imprimira a relacao das Solicitacoes de compras conforme os parametros solicitados.")

oSection := TRSection():New(oReport,OemToAnsi("Solicitacoes de Compras"),{"SC1","SB1"})
TRCell():New(oSection,"C1_NUM" ,"SC1")
TRCell():New(oSection,"C1_SOLICIT","SC1")
TRCell():New(oSection,"C1_EMISSAO","SC1")
TRCell():New(oSection,"C1_ITEM","SC1")
TRCell():New(oSection,"C1_PRODUTO","SC1")
TRCell():New(oSection,"C1_DESCRI","SB1")
TRCell():New(oSection,"C1_UM","SC1")
TRCell():New(oSection,"C1_QUANT","SC1")
TRCell():New(oSection,"C1_PRECO","SC1")
TRCell():New(oSection,"C1_TOTAL","SC1")
Return oReport
//--------------------------------
//Inicia a Impressão do Relatorio|
//--------------------------------
Static Function PrintReport(oReport)
Local oSection := oReport:Section(1)
Local lShow := .T.

DbSelectArea("SC1")
SC1->(DbSetOrder(1))

If !Empty(mv_par01)
	SC1->(DbSeek(xFilial()+MV_PAR01))
Else
	SC1->(DbGoTop())
Endif

oReport:SetMeter(RecCount())
While !SC1->(Eof()) .And. xFilial("SC1") == SC1->C1_FILIAL .And. SC1->C1_NUM <= MV_PAR02
	
	cNum := SC1->C1_NUM
	lShow:= .T.
	
	IF SC1->C1_EMISSAO < MV_PAR03 .or. SC1->C1_EMISSAO > MV_PAR04
		SC1->(DbSkip())
		Loop
	Endif
	
	If oReport:Cancel()
		Exit
	EndIf
	
	While !SC1->(Eof()) .And. SC1->C1_FILIAL == xFilial("SC1") .And. SC1->C1_NUM == cNum
		DbSelectArea("SB1")
		SB1->(DbSetOrder(1))
		SB1->(DbSeek(xFilial("SB1")+SC1->C1_PRODUTO))
		oSection:Init()
		If lShow
			oSection:Cell("C1_NUM"):Show()
			oSection:Cell("C1_SOLICIT"):Show()
			oSection:Cell("C1_EMISSAO"):Show()
		Else
			oSection:Cell("C1_NUM"):Hide()
			oSection:Cell("C1_SOLICIT"):Hide()
			oSection:Cell("C1_EMISSAO"):Hide()
		EndIf
		oSection:Cell("C1_ITEM"):Show()
		oSection:Cell("C1_PRODUTO"):Show()
		oSection:Cell("C1_DESCRI"):SetValue(SB1->B1_DESC)
		oSection:Cell("C1_UM"):Show()
		oSection:Cell("C1_QUANT"):Show()
		oSection:Cell("C1_PRECO"):Show()
		oSection:Cell("C1_TOTAL"):Show()
		oSection:PrintLine()
		lShow := .F.
		SC1->(DbSkip())
	EndDo
	oSection:Finish()
	oReport:SkipLine()
	oReport:IncMeter()
EndDo
Return
//----------------
//Cria a Pertunta|
//----------------
Static Function ValidPerg()
u_GDPutSx1( cPerg,"01","S.C. de ?","S.C. de ?","S.C. de ?","mv_ch1","C", 6,0,0,"G","","SC1","","","mv_par01"," ","",""," ","","","","","","","","","","","","","","","","","" )
u_GDPutSx1( cPerg,"02","S.C. ate ?","S.C. ate ?","S.C. ate ?","mv_ch2","C", 6,0,0,"G","","SC1","","","mv_par02"," ","",""," ","","","","","","","","","","","","","","","","","" )
u_GDPutSx1( cPerg,"03","Emissao de ?","Emissao de ?","Emissao de ?","mv_ch3","D", 8,0,0,"G","","" ,"","","mv_par03"," ","",""," ","","","","","","","","","","","","","","","","","" )
u_GDPutSx1( cPerg,"04","Emissao ate ?","Emissao ate ?","Emissao ate ?","mv_ch4","D", 8,0,0,"G","","" ,"","","mv_par04"," ","",""," ","","","","","","","","","","","","","","","","","" )
Return(cPerg)
