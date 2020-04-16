//Bibliotecas
#Include "Protheus.ch"

Class zPessoa
//Atributos
Data cNome
Data nIdade
Data dNascimento
Data cEntrega
Data cCodSA1
Data cLojaSA1

//Metodos
Method New() CONSTRUCTOR
Method MostraIdade()
Method PrazoEntrega()
Method BloqueCli()
EndClass

Method New(cNome, dNascimento,cCodCli, cLojaCli) Class zPessoa
	//Atribuindo valores nos atributos do objeto instanciado
	::cNome			:= cNome
	::dNascimento	:= dNascimento
	::nIdade			:= fCalcIdade(dNascimento)
	::cCodSA1		    := cCodCli
	::cLojaSA1			:= cLojaCli
Return Self

Method MostraIdade() Class zPessoa
	Local cMsg := ""
	//Criando e mostrando a mensagem
	cMsg := "A <b>pessoa</b> "+::cNome+" tem "+cValToChar(::nIdade)+" anos!"
	MsgInfo(cMsg, "Atenção")
Return

Method PrazoEntrega(cCEP) Class zPessoa
	Local oCorreios:=WSCalcPrecoPrazoWS():NEW()
	Local cDataMAX := ""

	oCorreios:CalcPrazo("40010",SM0->M0_CEPENT,cCEP)
	cDataMAX :=	oCorreios:oWSCalcPrazoResult:OWSSERVICOS:OWSCSERVICO[1]:cDATAMAXENTREGA
	::cEntrega := "A data entrega prevista é: " + alltrim(cDataMAX)
	M->A1_COMPLEM := ::cEntrega
Return .t.

Method BloqueCli() Class zPessoa

	Local xAutoCab := {}
	Private lMsErroAuto := .f.

	Aadd(xAutoCab,{"A1_FILIAL" 	,xFilial("SA1")	 	,NIL})
	Aadd(xAutoCab,{"A1_COD"	 	, ::cCodSA1	    	,NIL})
	Aadd(xAutoCab,{"A1_LOJA"		, ::cLojaSA1			,NIL})
	Aadd(xAutoCab,{"A1_MSBLQL"	,'1' 	                ,NIL})

	Begin Transaction
		lMsErroAuto := .F.

		MsExecAuto({|x,y| MATA030(x,y)}, xAutoCab, 4)

		If lMsErroAuto
			DisarmTransaction()
			MostraErro()
		EndIf

	End TRANSACTION

Return

Static Function fCalcIdade(dNascimento)
	Local nIdade

	//Chamando a função YearSub para subtrair os anos de uma data
	nIdade := DateDiffYear(dDataBase, dNascimento)
Return nIdade