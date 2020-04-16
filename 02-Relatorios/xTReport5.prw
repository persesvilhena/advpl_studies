#include "protheus.ch"

//TReport usando metodo TRSection:Print com um secao

User Function xReport5()
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

oReport := TReport():New("xReport5","Exercicio","RNFT001",{|oReport| PrintReport(oReport)},"Solicitacoes de compras")
oSection := TRSection():New(oReport,"Solicitacoes",{"SA2","SE2"})
TRCell():New(oSection,"A2_NOME" ,"SA2")
TRCell():New(oSection,"E2_NUM","SE2")
TRCell():New(oSection,"E2_VALOR","SE2")
/*
oBreak := TRBreak():New(oSection,oSection:Cell("C1_NUM"),"Sub Total solicitacao")
TRFunction():New(oSection:Cell("C1_NUM"),NIL,"COUNT",oBreak)
TRFunction():New(oSection:Cell("C1_TOTAL"),NIL,"SUM",oBreak)*/
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
		SELECT A2_NOME,E2_NUM,E2_VALOR
		FROM %table:SA2% SA2,%table:SE2% SE2
		WHERE E2_FORNECE = A2_COD //AND C1_FILIAL = %xfilial:SA2%
		AND SE2.%notDel%
		/*AND C1_NUM >= %exp:(MV_PAR01)%
		AND C1_NUM <= %exp:(MV_PAR02)%
		AND C1_EMISSAO >= %exp:dtos(MV_PAR03)%
		AND C1_EMISSAO <= %exp:dtos(MV_PAR04)%*/
		//ORDER BY C1_NUM,C1_ITEM
	EndSql
oSection:EndQuery(mv_par01,MV_PAR02)

oSection:Print()
Return