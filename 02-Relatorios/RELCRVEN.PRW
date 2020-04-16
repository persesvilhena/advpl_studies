#Include 'Protheus.ch'
#INCLUDE 'TOPCONN.CH'

/*/{Protheus.doc} RELCRVEN
Relatório de Críticas de Vendas
@author Rodrigo Resende - siga.rodrigo@gmail.com
@since 15/03/2019
@version 1.0
@return Nil, Função não tem retorno
@example
U_RELCRVEN()
/*/
User Function RELCRVEN()

	Local oReport
	Local cPerg := "RELCRVEN"

	//Incluo/Altero as perguntas na tabela SX1
	AjustaSX1(Padr(cPerg, 10))
	//Gero a pergunta de modo oculto, ficando disponível no botão ações relacionadas
	Pergunte(cPerg, .F.)
	oReport := RptDef(cPerg)
	oReport:PrintDialog()
Return

/*---------------------------------------------------------------------*
| Funcao: RptDef                                                      |
| Autor:  Rodrigo Resende                                             |
| Data:   15/03/2019                                                  |
| Desc:   Definicoes do relatorio                                     |
*---------------------------------------------------------------------*/
Static Function RptDef(cNome)

	Local oReport
	Local oSection1
	Local oSection2
	Local oBreak
	Local oFunction
	Local oFunTot1 := Nil

	oReport := TReport():New(cNome, "Relatório de Críticas de Vendas", cNome, {|oReport| ReportPrint(oReport)}, "Descrição do relatório")
	//	oReport:SetPortrait()
	oReport:SetLandscape()

	//Primeira seção
	oSection1:= TRSection():New(oReport , "Críticas de Vendas", {"RELTMP"}, , .F., .T.)
	TRCell():New(oSection1,"C5_CLIENTE"		, "RELTMP", "Código"  		, "@!", 20)
	TRCell():New(oSection1,"C5_LOJAENT"		, "RELTMP", "Loja"	 		, "@!", 10)
	TRCell():New(oSection1,"A1_NOME"		, "RELTMP", "Cliente"    	, "@!", 30)
	TRCell():New(oSection1,"PESSOA"			, "RELTMP", "Pessoa"    	, "@!", 15)
	TRCell():New(oSection1,"A1_MUN"			, "RELTMP", "Município"     , "@!", 25)
	TRCell():New(oSection1,"A1_EST"    		, "RELTMP", "Estado"		, "@!", 10)
	TRCell():New(oSection1,"E4_DESCRI"   	, "RELTMP", "Cond.Pag"   	, "@!", 15)
	TRCell():New(oSection1,"A3_NOME"   		, "RELTMP", "Vendedor"   	, "@!", 40)
	TRCell():New(oSection1,"C5_NUM"   		, "RELTMP", "Pedido"   		, "@!", 25)
	TRCell():New(oSection1,"EMISSAO" 	  	, "RELTMP", "Emissão"   	, , 25)
	TRCell():New(oSection1,"STATUS" 	  	, "RELTMP", "Status do Pedido"   	, , 50)
	//Segunda seção
	oSection2:= TRSection():New(oReport, "Produtos", {"C6_ITEM"}, NIL, .F., .T.)
	TRCell():New(oSection2,"C6_ITEM"  	,"RELTMP", "Item"	    , "@!", 20)
	TRCell():New(oSection2,"C6_PRODUTO" ,"RELTMP", "Código"		, "@!", 30)
	TRCell():New(oSection2,"B1_DESC"	,"RELTMP", "Produto"    , "@!", 60)
	TRCell():New(oSection2,"C6_QTDVEN"	,"RELTMP", "Quant."	    , "@E 999,999", 30)
	TRCell():New(oSection2,"C6_PRCVEN"	,"RELTMP", "Preço"	    , "@E 999,999,999.99", 30)
	TRCell():New(oSection2,"C6_VALOR"	,"RELTMP", "Total"	    , "@E 999,999,999.99", 30)

	//	oBreak := TRBreak():New(oSection1,oSection2:Cell("C6_VALOR"),,.F.)

	//Totalizadores
	oFunTot1 := TRFunction():New(oSection2:Cell("C6_VALOR"),,"SUM",oBreak,"Valor Total do Pedido ---> ","@E 999,999,999.99")
	oFunTot1:SetEndReport(.F.)

	//Contador
	//TRFunction():New(oSection2:Cell("B1_COD"), NIL, "COUNT",,,,, .F., .T.)
	//oReport:SetTotalInLine(.F.)
	//Fara uma quebra por seção
	//oSection1:SetPageBreak(.T.)
	//oSection1:SetTotalText(" ")
Return(oReport)

/*---------------------------------------------------------------------*
| Funcao: ReportPrint                                                 |
| Autor:  Rodrigo Resende                                             |
| Data:   15/03/2019                                                  |
| Desc:   Impressao do relatorio                                      |
*---------------------------------------------------------------------*/
Static Function ReportPrint(oReport)

	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(2)
	Local cQuery    := ""
	Local cPed      := ""
	Local lPrim     := .T.

	//Monto minha consulta conforme parametros passados
	cQuery := "	SELECT  C5_CLIENTE, C5_LOJAENT, A1_NOME, A1_MUN, A1_EST, E4_DESCRI, A3_NOME, C5_NUM, C5_EMISSAO, C6_ITEM,"
	cQuery += " C6_PRODUTO, B1_DESC, C6_QTDVEN, C6_PRCVEN, C6_VALOR, C5_BLQ, C5_NOTA, C5_LIBEROK, C5_XBLCRED, C5_XBLEST, A1_PESSOA "
	cQuery += " FROM " + RetSQLName("SC5") + " C5, " + RetSQLName("SA1") + " A1, " + RetSQLName("SA3") + " A3, " + RetSQLName("SC6") + " C6, " + RetSQLName("SB1") + " B1, " + RetSQLName("SE4") + " E4 "
	cQuery += " WHERE C5_CLIENTE = A1_COD"
	cQuery += " AND C5_LOJAENT = A1_LOJA"
	cQuery += " AND C5_VEND1 = A3_COD"
	cQuery += " AND C5_NUM = C6_NUM"
	cQuery += " AND C5_FILIAL = C6_FILIAL"
	cQuery += " AND C6_PRODUTO = B1_COD"
	cQuery += " AND E4_CODIGO = C5_CONDPAG "
	cQuery += " AND E4_FILIAL = C5_FILIAL "
	If MV_PAR09 == 1
		cQuery += " AND C5_NOTA = ' ' "
	EndIf
	cQuery += " AND C5_NUM BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' "
	cQuery += " AND A1_COD BETWEEN '" + mv_par03 + "' AND '" + mv_par05 + "' "
	cQuery += " AND A1_LOJA BETWEEN '" + mv_par04 + "' AND '" + mv_par06 + "' "
	cQuery += "	and C5_EMISSAO BETWEEN '" + Dtos(mv_par10) + "' AND '" + Dtos(mv_par11) + "' "
	cQuery += " AND A3_COD BETWEEN '" + mv_par07 + "' AND '" + mv_par08 + "' "
	cQuery += " AND A1.d_e_l_e_t_ = ' '"
	cQuery += " AND B1.d_e_l_e_t_ = ' '"
	cQuery += " AND C5.d_e_l_e_t_ = ' '"
	cQuery += " AND C6.d_e_l_e_t_ = ' '"
	cQuery += " AND A3.d_e_l_e_t_ = ' '"
	cQuery += " AND E4.d_e_l_e_t_ = ' '"
	cQuery += " ORDER BY C5_NUM, C6_ITEM "

	cQuery := ChangeQuery(cQuery)
	If Select("RELTMP") > 0
		RELTMP->(DbCloseArea())
	EndIf
	TCQUERY cQuery NEW ALIAS "RELTMP"
	RELTMP->(DbGoTop())
	oReport:SetMeter(RELTMP->(LastRec()))
	Do While !RELTMP->(Eof())
		If oReport:Cancel()
			Exit
		EndIf
		//inicializo a primeira seção
		oSection1:Init()
		oReport:IncMeter()
		cPed := RELTMP->C5_NUM
		
		//imprimo a primeira seção
		oSection1:Cell("EMISSAO"):SetValue(STOD(RELTMP->C5_EMISSAO))

		If RELTMP->C5_LIBEROK = ' ' .AND. RELTMP->C5_NOTA = ' ' .AND. RELTMP->C5_BLQ = ' '
			oSection1:Cell("STATUS"):SetValue("Pedido em Aberto")
		ElseIf RELTMP->C5_LIBEROK <> ' ' .AND. RELTMP->C5_NOTA = ' ' .AND. RELTMP->C5_BLQ = ' '
			If Empty(RELTMP->C5_XBLCRED) .AND. Empty(RELTMP->C5_XBLEST)
				oSection1:Cell("STATUS"):SetValue("Pedido Liberado")
			ElseIf !Empty(RELTMP->C5_XBLCRED) .AND. !Empty(RELTMP->C5_XBLEST)
				oSection1:Cell("STATUS"):SetValue("Pedido Bloqueado Crédito/Estoque")
			ElseIf !Empty(RELTMP->C5_XBLCRED)
				oSection1:Cell("STATUS"):SetValue("Pedido Bloqueado Crédito")
			ElseIf !Empty(RELTMP->C5_XBLEST)
				oSection1:Cell("STATUS"):SetValue("Pedido Bloqueado Estoque")
			EndIf
		ElseIf RELTMP->C5_NOTA <> ' ' .OR. RELTMP->C5_LIBEROK == 'E' .AND. RELTMP->C5_BLQ = ' '
			oSection1:Cell("STATUS"):SetValue("Pedido Encerrado")
		ElseIf RELTMP->C5_BLQ == '1'
			oSection1:Cell("STATUS"):SetValue("Pedido Bloqueado por Regra")
		ElseIf RELTMP->C5_BLQ == '2'
			oSection1:Cell("STATUS"):SetValue("Pedido Bloqueado por Verba")
		EndIf
		
		If RELTMP->A1_PESSOA = 'F'
			oSection1:Cell("PESSOA"):SetValue("Física")
		ElseIf RELTMP->A1_PESSOA = 'J'
			oSection1:Cell("PESSOA"):SetValue("Jurídica")
		EndIf
		
		oSection1:Printline()
		//inicializo a segunda seção
		oSection2:init()
		//verifico se o codigo é o mesmo, se sim, imprimo o produto
		Do While RELTMP->C5_NUM == cPed
			oSection2:Printline()
			RELTMP->(dbSkip())
		EndDo

		//finalizo a segunda seção para que seja reiniciada para o proximo registro
		oSection2:Finish()

		//imprimo uma linha separadora
		//oReport:ThinLine()

		//finalizo a primeira seção
		oSection1:Finish()
	Enddo
Return

/*---------------------------------------------------------------------*
| Funcao: ajustaSx1                                                   |
| Autor:  Rodrigo Resende                                             |
| Data:   15/03/2019                                                  |
| Desc:   Criacao de perguntas                                        |
*---------------------------------------------------------------------*/
static function ajustaSx1(cPerg)

	//Aqui utilizo a função putSx1, ela cria a pergunta na tabela de perguntas
	U_xPutSx1(cPerg, "01", "Pedido de    ?"  		, "", "", "mv_ch1", "C", tamSx3("C5_NUM")[1],   	0, 0, "G", "", "",  	"", "", "mv_par01", "", "", "", "", 		  "", "", 	 "", "", "", "", "", "", "", "", "", "", "", {"Número do Pedido inicial."})
	U_xPutSx1(cPerg, "02", "Pedido Ate   ?"  		, "", "", "mv_ch2", "C", tamSx3("C5_NUM")[1],   	0, 0, "G", "", "",  	"", "", "mv_par02", "", "", "", "zzzzzz", 	  "", "", 	 "", "", "", "", "", "", "", "", "", "", "", {"Número do Pedido final."})
	U_xPutSx1(cPerg, "03", "Cliente De ?"  			, "", "", "mv_ch3", "C", tamSx3("A1_COD")[1], 		0, 0, "G", "", "SA1", 	"", "", "mv_par03", "", "", "", "zzzzzz", 	  "", "", 	 "", "", "", "", "", "", "", "", "", "", "", {"Código do Cliente inicial."})
	U_xPutSx1(cPerg, "04", "Loja De    ?"  			, "", "", "mv_ch4", "C", tamSx3("A1_LOJA")[1],   	0, 0, "G", "", "",    	"", "", "mv_par04", "", "", "", "zz", 		  "", "", 	 "", "", "", "", "", "", "", "", "", "", "", {"Loja do Cliente inicial."})
	U_xPutSx1(cPerg, "05", "Cliente Ate?"  			, "", "", "mv_ch5", "C", tamSx3("A1_COD")[1], 		0, 0, "G", "", "SA1", 	"", "", "mv_par05", "", "", "", "zzzzzz", 	  "", "", 	 "", "", "", "", "", "", "", "", "", "", "", {"Código do Cliente final."})
	U_xPutSx1(cPerg, "06", "Loja Ate   ?"  			, "", "", "mv_ch6", "C", tamSx3("A1_LOJA")[1],   	0, 0, "G", "", "",    	"", "", "mv_par06", "", "", "", "zz", 		  "", "", 	 "", "", "", "", "", "", "", "", "", "", "", {"Loja do Cliente final."})
	U_xPutSx1(cPerg, "07", "Vendedor De?"  			, "", "", "mv_ch7", "C", tamSx3("A3_COD")[1], 		0, 0, "G", "", "SA3", 	"", "", "mv_par07", "", "", "", "zzzzzz", 	  "", "", 	 "", "", "", "", "", "", "", "", "", "", "", {"Código do Vendedor inicial."})
	U_xPutSx1(cPerg, "08", "Vendedor Ate?"  		, "", "", "mv_ch8", "C", tamSx3("A3_COD")[1], 		0, 0, "G", "", "SA3", 	"", "", "mv_par08", "", "", "", "zzzzzz", 	  "", "", 	 "", "", "", "", "", "", "", "", "", "", "", {"Código do Vendedor final."})
	U_xPutSx1(cPerg, "09", "Pedidos Encerrados?"  	, "", "", "mv_ch9", "N", 					1,   	0, 0, "C", "", "",    	"", "", "mv_par09", "Analitico" , "", "", 		  "", "Sintetico", "", "", "", "", "", "", "", "", "", "", "", {"Considera Pedidos Encerrados?"})
	U_xPutSx1(cPerg, "10", "Dt.Emissão De ?"  		, "", "", "mv_cha", "D", tamSx3("C5_EMISSAO")[1],  	0, 0, "G", "", "",    	"", "", "mv_par10", "", "", "", "01/01/1990", "", "", 	 "", "", "", "", "", "", "", "", "", "", "", {"Data de Emissão inicial."})
	U_xPutSx1(cPerg, "11", "Dt.Emissão Ate?"  		, "", "", "mv_chb", "D", tamSx3("C5_EMISSAO")[1],  	0, 0, "G", "", "",    	"", "", "mv_par11", "", "", "", "31/12/2049", "", "", 	 "", "", "", "", "", "", "", "", "", "", "", {"Data de Emissão final."})
return

