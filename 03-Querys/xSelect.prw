#Include "Protheus.Ch"
#Include "TopConn.Ch"

User Function xSelect()
	Local cQuery := ""
	Local cTabela:= '12'
	Local cEst1	 := 'SP'
	Local cEst2	 := 'RJ'
	Local cMSG   := ""
	//Verifica se o Alias já existe.
	If Select("TRB") > 0
		TRB->(DbCloseArea())
	EndIf
	//Monta a Query.
	/*cQuery := "SELECT A1_COD , A1_NOME, X5_DESCRI " + CRLF
	cQuery += " FROM " + RetSqlName("SA1") + " SA1, " + RetSqlName("SX5") + " SX5 " + CRLF
	cQuery += " WHERE SA1.A1_FILIAL = SX5.X5_FILIAL " + CRLF
	cQuery += " AND SX5.X5_TABELA = '"+cTabela+"' " + CRLF
	cQuery += " AND (SA1.A1_EST = '"+cEst1+"' OR SA1.A1_EST = '"+cEst2+"') " + CRLF
	cQuery += " AND SA1.A1_EST = SX5.X5_CHAVE " + CRLF
	cQuery += " AND SA1.D_E_L_E_T_ = '' " + CRLF
	cQuery += " ORDER BY X5_DESCRI " + CRLF */

	cQuery := " SELECT A1_COD,A1_NOME,X5_DESCRI, A1_DTCAD " + CRLF
	cQuery += " FROM " + RetSqlName("SA1") + " SA1 " + CRLF
	cQuery += " INNER JOIN " + RetSqlName("SX5") + "  SX5 " + CRLF
	cQuery += " ON SX5.X5_TABELA = '"+cTabela+"' " + CRLF
	cQuery += " AND SX5.X5_FILIAL = SA1.A1_FILIAL " + CRLF
	cQuery += " AND SX5.X5_CHAVE = SA1.A1_EST " + CRLF
	cQuery += " WHERE  (SA1.A1_EST = '"+cEst1+"' OR SA1.A1_EST = '"+cEst2+"') " + CRLF
	cQuery += " AND SA1.D_E_L_E_T_ = ' ' " + CRLF
	cQuery += " ORDER BY  X5_DESCRI " + CRLF

	//Executa a Query e cria uma WorkArea com o resultado.
	MemoWrite( 'teste.sql', cQuery ) // na System o arquivo .sql
	
	cQuery := ChangeQuery(cQuery)

	TCQUERY cQuery NEW ALIAS "TRB"
	//DBUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), "TRB", .F., .T.)
	
	TCSetField("TRB","A1_DTCAD","D")
	
	//Abre a WorkArea criada.
	DbSelectArea("TRB") // Tabela Temporia.
	TRB->(DbGoTop())

	While !TRB->(EOF()) // Enquanto não for final de arquivo da TRB
		cMSG += TRB->A1_COD+" "+TRB->A1_NOME+" "+TRB->X5_DESCRI + CRLF
		TRB->(DbSkip())
	EndDo
	MsgInfo(cMSG,"Teste Select")
Return
