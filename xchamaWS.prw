#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE 'Tbiconn.ch'

user function xchamaWS(cCli)

	Local oCorreios := WSCalcPrecoPrazoWS():NEW()
	Local cDataMAX  := ""
    Local cCep      := ""
    Local aAreaSA1 := SA1->(GetArea())

    SA1->(DBSETORDER( 1 ))
    SA1->(Dbseek(xFilial('SA1')+cCli))
    cCep := SA1->A1_CEP
   

	oCorreios:CalcPrazo("40010","37890000",cCep)
    //oCorreios:CalcPrazo("40010","37890000","01001001")
    
	cDataMAX :=	oCorreios:oWSCalcPrazoResult:OWSSERVICOS:OWSCSERVICO[1]:cDATAMAXENTREGA

    RESTAREA(aAreaSA1)
return("Data prevista de entrega: " + cDataMAX)

User function xUpdWS()
	Local oCorreios := WSCalcPrecoPrazoWS():NEW()
	Local cDataMAX  := ""
	Local cMsg      := ""
	Local cFiltro := 'A1_CEP <> "" '
	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"
	dbSelectArea("SA1")
	SA1->( dbSetFilter( { || &cFiltro }, cFiltro ) )
	SA1->( dbGoTop() )

	For i:= 1 to SA1->(Reccount())
		oCorreios:CalcPrazo("40010","04313002",SA1->A1_CEP)
		cDataMAX :=	oCorreios:oWSCalcPrazoResult:OWSSERVICOS:OWSCSERVICO[1]:cDATAMAXENTREGA
		cMsg := SA1->A1_COD + ' - Data de entrega maxima ' + cDataMAX + ' entre os CEPs 04313002 / ' + SA1->A1_CEP
		//MSGINFO(cMsg)

		reclock("SA1",.F.)
			SA1->A1_OBSERV := cMsg
		SA1->(msunlock())

		SA1->(dbSkip())
	Next
	RESET ENVIRONMENT
Return