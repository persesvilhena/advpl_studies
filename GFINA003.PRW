#Include 'Protheus.ch'
#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

/*/{Protheus.doc} GFINA003
//TODO Descri็ใo auto-gerada.
@author BENE FACTUM
@since 23/07/2019
@version 1.0
@param aParam, array, descricao
@type function
/*/
User Function GFINA003(aParam)

	Local cQry     := ""
	Local aDados   := {}
	Local cUserOld := ""
	Local dDtaOld  := ""

	Default	aParam	:= {"01","01"}

	RPCSetType(3) // Para a rotina nao consumir licenca de usuario

	//RpcSetEnv( "01" , "01" ) // Prepara o ambiente na empresa/filial definida nos parametros
	// alterado em 04/08/15 para atender multi empresas.
	RpcSetEnv( aParam[1], aParam[2] )

	cQry := "SELECT F1_FILIAL, F1_FORNECE, F1_LOJA , E2_NOMFOR ,E5_PREFIXO , E5_NUMERO , E5_PARCELA, E5_TIPO ,D1_PEDIDO, C7_NUMSC, C1_USER , C1_SOLICIT , E5_VALOR, E5_DATA, SE5.R_E_C_N_O_ " + CRLF
	cQry += "FROM " + RetSqlName("SE5") + " SE5 WITH(NOLOCK) " + CRLF
	cQry += "INNER JOIN " + RetSqlName("SE2") + " SE2 WITH(NOLOCK)" + CRLF
	cQry += "ON  E2_FILIAL = E5_FILIAL " + CRLF
	cQry += "AND E2_PREFIXO = E5_PREFIXO " + CRLF
	cQry += "AND E2_NUM = E5_NUMERO " + CRLF
	cQry += "AND E2_PARCELA = E5_PARCELA " + CRLF
	cQry += "AND E2_TIPO = E5_TIPO " + CRLF
	cQry += "AND E2_FORNECE = E5_FORNECE " + CRLF
	cQry += "AND E2_LOJA = E5_LOJA " + CRLF
	cQry += "AND SE2.D_E_L_E_T_ = '' " + CRLF
	cQry += "INNER JOIN " + RetSqlName("SF1") + " SF1 WITH(NOLOCK) " + CRLF
	cQry += "ON  F1_FILIAL = E2_FILORIG " + CRLF
	cQry += "AND F1_DOC = E2_NUM " + CRLF
	cQry += "AND F1_SERIE = E2_PREFIXO " + CRLF
	cQry += "AND F1_FORNECE = E2_FORNECE " + CRLF
	cQry += "AND F1_LOJA  = E2_LOJA " + CRLF
	cQry += "AND SF1.D_E_L_E_T_ = '' " + CRLF
	cQry += "INNER JOIN " + RetSqlName("SD1") + " SD1 WITH(NOLOCK) " + CRLF
	cQry += "ON  D1_FILIAL = F1_FILIAL " + CRLF
	cQry += "AND D1_DOC = F1_DOC " + CRLF
	cQry += "AND D1_SERIE = F1_SERIE " + CRLF
	cQry += "AND D1_FORNECE = F1_FORNECE " + CRLF
	cQry += "AND D1_LOJA   = F1_LOJA " + CRLF
	cQry += "AND SD1.D_E_L_E_T_ = '' " + CRLF
	cQry += "INNER JOIN " + RetSqlName("SC7") + " SC7 WITH(NOLOCK) " + CRLF
	cQry += "ON  C7_FILIAL = D1_FILIAL " + CRLF
	cQry += "AND C7_FORNECE = D1_FORNECE " + CRLF
	cQry += "AND C7_LOJA = D1_LOJA " + CRLF
	cQry += "AND C7_NUM = D1_PEDIDO " + CRLF
	cQry += "INNER JOIN " + RetSqlName("SC1") + " SC1 WITH(NOLOCK) " + CRLF
	cQry += "ON  C1_FILIAL = C7_FILIAL " + CRLF
	cQry += "AND C1_NUM = C7_NUMSC " + CRLF
	cQry += "AND SC1.D_E_L_E_T_ = '' " + CRLF
	cQry += "WHERE E5_DATA BETWEEN '" + dtoS(dDataBase - 30)+ "' AND '" + dtoS(dDataBase - 1)+ "' " + CRLF
	cQry += "AND E5_RECPAG = 'P' " + CRLF
	cQry += "AND E5_XWFPAG = '' " + CRLF
	cQry += "AND E5_TIPODOC = 'VL' " + CRLF
	cQry += "AND SE5.D_E_L_E_T_ = '' " + CRLF
	cQry += "GROUP BY F1_FILIAL, F1_FORNECE, F1_LOJA, E2_NOMFOR , E5_PREFIXO , E5_NUMERO , E5_PARCELA, E5_TIPO, D1_PEDIDO, C7_NUMSC, C1_USER , C1_SOLICIT , E5_VALOR, E5_DATA , SE5.R_E_C_N_O_" + CRLF
	cQry += "ORDER BY C1_USER, E5_DATA " + CRLF

	MemoWrite( "GFINA003.sql", cQry )

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica se ALIAS esta em uso ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If Select("TFINA003") > 0
		TFINA003->(DbCloseArea())
	Endif

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"TFINA003",.F.,.T.)

	TCSetField("TFINA003","E5_DATA","D")

	DbSelectArea("TFINA003")
	TFINA003->(DbGotop())

	DBSELECTAREA("SE5")
	SE5->(DBGOTOP())

	While TFINA003->(! Eof())

		cUserOld  := TFINA003->C1_USER
		dDtaOld   := TFINA003->E5_DATA

		AADD(aDados,{	TFINA003->F1_FILIAL, TFINA003->F1_FORNECE, TFINA003->F1_LOJA, TFINA003->E2_NOMFOR , TFINA003->E5_NUMERO, TFINA003->E5_PARCELA,;
		TFINA003->C7_NUMSC, TFINA003->D1_PEDIDO,  TFINA003->E5_VALOR, TFINA003->C1_USER , TFINA003->C1_SOLICIT , TFINA003->E5_DATA ,;
		TFINA003->R_E_C_N_O_})

		TFINA003->(DbSkip())

		IF cUserOld <> TFINA003->C1_USER  .OR. dDtaOld <> TFINA003->E5_DATA

			IF ENVMAIL(aDados)
				BEGIN TRANSACTION
					GRAVADADOS(aDados)
				END TRANSACTION
			ENDIF

			// Limpeza de Array
			aDados := {}

		ENDIF

	Enddo

	SE5->(DBCLOSEAREA())

	RPCClearEnv() // Reset do ambiente

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณENVMAIL   บAutor  Thiago Nascimento    บ Data ณ  02/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo Static que envia e-mail ao solicitando com dados	  บฑฑ
ฑฑบ          ณ coletados pela fun็ใo principal						      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GALDERMA													   ฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ENVMAIL(aDados)

	Local nX		:= 0
	Local oProcess
	Local oHtml
	Local cTit		:= "" // Incluํdo por Felipe Azevedo - ERP Plus - FCAS - 20170509_001

	Private cEmpModelo	:= ALLTRIM(SuperGetMv("GD_EMPMOD", , "")) //Nome da pasta por empresa do modelo HTML de workflow

	oProcess := TWFProcess():New( "GFINA003", "Envio de pagamentos efetuados" )
	oProcess:NewTask("Envio de pagamentos efetuados", "\WORKFLOW\MODELOS\"+cEmpModelo+"\FIN\infbxTitulo_FIN.HTM" )

	oProcess:cSubject := "PAGAMENTOS EFETUADOS A FORNECEDORES - Origem solicitante:  " + aDados[1,11]
	oProcess:cTo	  := UsrRetMail(aDados[1,10])
	oProcess:UserSiga := __cUserID
	oProcess:NewVersion(.T.)
	oProcess:nEncodeMime := 0

	oProcess:oHtml:ValByName("SOLIC"   , aDados[1,11] )
	oProcess:oHtml:ValByName("DTGER"   , dtoC(dDataBase) )
	oProcess:oHtml:ValByName("DTBAIXA" , dtoC(aDados[1,12]) )

	//(INICIO) - Alterado por Felipe Azevedo - ERP Plus - FCAS - 20170509_001
	/*
	For nX := 1 To Len(aDados)

	aadd(oProcess:oHtml:ValByName("tb.titulo"), iif(!empty(aDados[nX,6]),aDados[nX,5]+"-"+aDados[nX,6], aDados[nX,5] ))
	aadd(oProcess:oHtml:ValByName("tb.codloja"), aDados[nX,2]+"-"+aDados[nX,3])
	aadd(oProcess:oHtml:ValByName("tb.razao"), aDados[nX,4])
	aadd(oProcess:oHtml:ValByName("tb.numsc"), aDados[nX,7])
	aadd(oProcess:oHtml:ValByName("tb.numpv"), aDados[nX,8])
	aadd(oProcess:oHtml:ValByName("tb.valtit"), "R$" + TRANSFORM(aDados[nX,9],PesqPict("SE5","E5_VALOR") ) )

	Next nX
	*/

	For nX := 1 To Len(aDados)

		aadd(oProcess:oHtml:ValByName("tb.titulo"), iif(!empty(aDados[nX,6]),aDados[nX,5]+"-"+aDados[nX,6], aDados[nX,5] ))
		aadd(oProcess:oHtml:ValByName("tb.codloja"), aDados[nX,2]+"-"+aDados[nX,3])
		aadd(oProcess:oHtml:ValByName("tb.razao"), aDados[nX,4])
		aadd(oProcess:oHtml:ValByName("tb.numsc"), aDados[nX,7])
		aadd(oProcess:oHtml:ValByName("tb.numpv"), aDados[nX,8])
		If cTit <> aDados[nX,5]
			aadd(oProcess:oHtml:ValByName("tb.valtit"), "R$" + TRANSFORM(aDados[nX,9],PesqPict("SE5","E5_VALOR") ) )
			cTit := aDados[nX,5]
		Else
			aadd(oProcess:oHtml:ValByName("tb.valtit"), "" )
		EndIf

	Next nX
	//(FIM) - Alterado por Felipe Azevedo - ERP Plus - FCAS - 20170509_001

	/*
	MQM - 13/02/2015 - Fechamento do WF4 devido o method padrao SubStrAddr nao trabalhar na area correta.
	*/
	If Select("WF4") > 0
		WF4->(DbCloseArea())
	EndIF
	oProcess:Start()

	oProcess:Finish()

Return(.T.)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGRAVADADOS บAutor  Thiago Nascimento   บ Data ณ  16/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo Static que grava flag indentificando pagamento como บฑฑ
ฑฑบ          ณ jแ enviado e-mail pela rotina de WorkFlow			      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GALDERMA													   ฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function GRAVADADOS(aDados)

	Local nX

	For nX := 1 To Len(aDados)

		SE5->(DBGOTO(aDados[nX,13]))
		RECLOCK("SE5",.F.)
		REPLACE E5_XWFPAG WITH "X"
		SE5->(MSUNLOCK())

	Next nX

Return()