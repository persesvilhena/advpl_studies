#Include "Protheus.Ch"

//TReport usando metodo TRSection:SetParentQuery

User Function XReport4()
Local oReport

If TRepInUse()
	Pergunte("RNFT01",.F.)
	oReport := ReportDef()
	oReport:PrintDialog()
EndIf
Return

Static Function ReportDef()
Local oReport
Local oSection1
Local oSection2
oReport := TReport():New("xReport4","Relatorio de solicitacoes ","RNFT01",{|oReport| PrintReport(oReport)},"Relatorio de Solicitacoes")
oSection1 := TRSection():New(oReport,"Solicitacoes","SC1")
TRCell():New(oSection1,"C1_NUM" ,"SC1")
TRCell():New(oSection1,"C1_SOLICIT","SC1")
TRCell():New(oSection1,"C1_EMISSAO","SC1")
TRFunction():New(oSection1:Cell("C1_NUM"),NIL,"COUNT",NIL,NIL,NIL,NIL,.F.)

oSection2 := TRSection():New(oSection1,"ITENS","SC1")
TRCell():New(oSection2,"C1_ITEM","SC1")
TRCell():New(oSection2,"C1_PRODUTO","SC1")
TRCell():New(oSection2,"C1_DESCRI","SB1")
TRCell():New(oSection2,"C1_UM","SC1")
TRCell():New(oSection2,"C1_QUANT","SC1")
TRCell():New(oSection2,"C1_PRECO","SC1")
TRCell():New(oSection2,"C1_TOTAL","SC1")
TRCell():New(oSection2,"C1_DATPRF","SC1")
TRFunction():New(oSection2:Cell("C1_PRODUTO"),NIL,"COUNT")
TRFunction():New(oSection2:Cell("C1_TOTAL"),NIL,"SUM")
Return oReport

Static Function PrintReport(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local cFiltro := ""

oSection1:BeginQuery()
BeginSql alias "QRYSA3"
	SELECT C1_NUM,C1_ITEM,C1_PRODUTO,C1_QUANT,C1_EMISSAO,C1_DATPRF,C1_SOLICIT,C1_PRECO,C1_TOTAL
	FROM %table:SC1% SC1,%table:SB1% SB1
	WHERE B1_COD= C1_PRODUTO AND C1_FILIAL = %xfilial:SC1%
	AND SC1.%notDel%
	AND C1_NUM >= %exp:(MV_PAR01)%
	AND C1_NUM <= %exp:(MV_PAR02)%
	AND C1_EMISSAO >= %exp:dtos(MV_PAR03)%
	AND C1_EMISSAO <= %exp:dtos(MV_PAR04)%
	ORDER BY C1_NUM,C1_ITEM
EndSql
oSection1:EndQuery(mv_par01,MV_PAR02)
oSection2:SetParentQuery()
oSection2:SetParentFilter({|cParam| QRYSA3->C1_NUM >= cParam .and. QRYSA3->C1_NUM <= cParam},{|| QRYSA3->C1_NUM})
oSection1:Print()
Return
