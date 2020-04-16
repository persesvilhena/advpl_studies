#Include "Protheus.Ch"

//TReport sem usar o metodo TRSection:Print com series

User Function xReport2()
Local oReport

If TRepInUse()
	Pergunte("RNFT01",.F.)
	oReport := ReportDef()
	oReport:PrintDialog()
EndIf
Return
//---------------------------------------
//Inicializa os componentes do Relatorio|
//---------------------------------------
Static Function ReportDef()
Local oReport
Local oSection1
Local oSection2

oReport := TReport():New("xReport2","Relacao das Solicitaçcoes de Compra","RNFT01",{|oReport| PrintReport(oReport)},"Este relatorio ira imprimir a relacao das Solicitacoes de Compras conforme os parametros solicitados.")
oSection1 := TRSection():New(oReport,"SOLICITACOES",{"SC1","SB1"})
oSection2 := TRSection():New(oSection1,"ITENS SOLICITACOES",{"SC1","SB1"})
TRCell():New(oSection1,"C1_NUM" ,"SC1")
TRCell():New(oSection1,"C1_SOLICIT","SC1")
TRCell():New(oSection1,"C1_EMISSAO","SC1")

TRCell():New(oSection2,"C1_ITEM","SC1")
TRCell():New(oSection2,"C1_PRODUTO","SC1")
TRCell():New(oSection2,"C1_DESCRI","SB1")
TRCell():New(oSection2,"C1_UM","SC1")
TRCell():New(oSection2,"C1_QUANT","SC1")
TRCell():New(oSection2,"C1_PRECO","SC1")
TRCell():New(oSection2,"C1_TOTAL","SC1")
TRCell():New(oSection2,"C1_DTPRF","SC1")
TRPosition():New(oSection2,"SB1",1,{|| xFilial("SC1") + SC1->C1_PRODUTO})
Return oReport
//--------------------------------
//Inicia a Impressão do Relatorio|
//--------------------------------
Static Function PrintReport(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)

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
	If oReport:Cancel()
		Exit
	EndIf
	oSection1:Init()
	oSection1:PrintLine()
	oSection2:Init()
	While !SC1->(Eof()) .And. SC1->C1_FILIAL == xFilial("SC1") .And. SC1->C1_NUM == cNum
		DbSelectArea("SB1")
		SB1->(DbSetOrder(1))
		SB1->(DbSeek(xFilial("SB1")+SC1->C1_PRODUTO))
		oSection2:PrintLine()
		SC1->(DbSkip())
	EndDo
	oSection2:Finish()
	oSection1:Finish()
	oReport:IncMeter()
End
Return