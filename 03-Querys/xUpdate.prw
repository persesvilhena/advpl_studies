#Include "Protheus.Ch"
#Include "TopConn.Ch"

User Function xExecUpd()
	Local cQuery :=""
	Local nUpdate:= 0
	Local lOk	 := .F.

	//Monta a Query para o Update.
	//cQuery := "UPDATE "+RetSqlName("SA1")+" SET A1_NOME = 'THIAGO' WHERE D_E_L_E_T_<>'*' AND A1_COD ='000003' AND A1_FILIAL = '11'"
	cQuery := " UPDATE "+RetSqlName("SB1")+" SET B1_OBSISBN = X5_DESCRI "
	cQuery += " FROM "+RetSqlName("SB1")+" "
	cQuery += " INNER JOIN "+RetSqlName("SX5")+" "
	cQuery += " ON  X5_TABELA = '02' "
	cQuery += " AND X5_CHAVE = B1_TIPO "

	//Executa o Update.
	nUpdate := TCSQLExec(cQuery)
	//Valida se teve exito ou erro.
	If ! nUpdate < 0
		lOk := .T.
		TCSQLExec("COMMIT")
		MsgInfo("Update Ok!")
	Else
		Alert(TCSQLError())
		Return
	EndIf


Return