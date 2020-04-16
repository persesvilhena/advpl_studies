#include "protheus.ch"

//TReport usando metodo TRSection:Print com um secao

User Function xReport3()
Local oReport

If TRepInUse()
	Pergunte("RNFT001",.F.)
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
Local oBreak

oReport := TReport():New("xReport3","Solicitacoes de Compras","RNFT001",{|oReport| PrintReport(oReport)},"Solicitacoes de compras")
oSection := TRSection():New(oReport,"Solicitacoes",{"SC1","SB1"})
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
TRCell():New(oSection,"C1_DATPRF","SC1")

oBreak := TRBreak():New(oSection,oSection:Cell("C1_NUM"),"Sub Total solicitacao")
TRFunction():New(oSection:Cell("C1_NUM"),NIL,"COUNT",oBreak)
TRFunction():New(oSection:Cell("C1_TOTAL"),NIL,"SUM",oBreak)
Return oReport
//--------------------------------
//Inicia a Impressão do Relatorio|
//--------------------------------
Static Function PrintReport(oReport)
Local oSection := oReport:Section(1)
Local cPart
Local cFiltro := ""

//Transforma parametros do tipo Range em expressao SQL para ser utilizada na query
MakeSqlExpr("TRPT3")
oSection:BeginQuery()
	BeginSql Alias "QRYSC1"
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
oSection:EndQuery(mv_par01,MV_PAR02)

oSection:Print()
Return