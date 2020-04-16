#Include "Protheus.Ch"
#Include "TopConn.Ch"

User Function xEmbedded()
	Local cTabela:= '12'
	Local cEst1	 := 'SP'
	Local cEst2	 := 'RJ'
	Local cMSG   := ""

	//Exemplo Query 1
	/*cQuery := "SELECT A1_COD , A1_NOME, X5_DESCRI"
	cQuery += " FROM " + RetSqlName("SA1") + " SA1, " + RetSqlName("SX5") + " SX5 "
	cQuery += " WHERE SA1.A1_FILIAL = SX5.X5_FILIAL "
	cQuery += " AND SX5.X5_TABELA = '"+cTabela+"' "
	cQuery += " AND (SA1.A1_EST = '"+cEst1+"' OR SA1.A1_EST = '"+cEst2+"') "
	cQuery += " AND SA1.A1_EST = SX5.X5_CHAVE "
	cQuery += " AND SA1.D_E_L_E_T_ = '' "
	cQuery += " ORDER BY X5_DESCRI "
	TCQUERY cQuery NEW ALIAS "TRB"*/

	//Verifica se o Alias já existe.
	If Select("TRB") > 0
		TRB->(DbCloseArea())
	EndIf
	//Query via Embedded
	BeginSql Alias 'TRB'  // %Table:SA1% == RetSqlName("SA1")
		SELECT A1_COD , A1_NOME , X5_DESCRI
		FROM %Table:SA1% SA1, %Table:SX5% SX5
		WHERE
		SA1.%NotDel%
		AND SX5.X5_TABELA = %Exp:cTabela%
		AND (SA1.A1_EST = %Exp:cEst1% OR SA1.A1_EST = %Exp:cEst2%)
		AND SA1.A1_FILIAL = SX5.X5_FILIAL
		AND SA1.A1_EST = SX5.X5_CHAVE
		ORDER BY %Order:SA1%
	EndSql

	//Abre a WorkArea criada.
	DbSelectArea("TRB")
	TRB->(DbGoTop())

	While !TRB->(EOF()) // Enquanto não for final de arquivo da TRB
		cMSG += TRB->A1_COD+" "+TRB->A1_NOME+" "+TRB->X5_DESCRI + CRLF
		TRB->(DbSkip())
	EndDo
Return
