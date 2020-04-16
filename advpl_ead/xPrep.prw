#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "TBICONN.CH"
#Include "TOPCONN.ch"

user function xPrep()

	Local cEmp     := "99"
	Local _cFilial  := "01"
	//RpcClearEnv()
	//RpcSetType(3)

	PREPARE ENVIRONMENT EMPRESA cEmp FILIAL _cFilial MODULO 'FAT' TABLES "SA1", "SA2", "SA3"

	DbSelectArea("SA1")
	SA1->(DBSETORDER(1))
	IF SA1->(DBSEEK(XFILIAL('SA1')+'000010'))
		Conout("NOME DO CLIENTE: " + SA1->A1_NOME )
	ENDIF
	
	Conout("NOME DO CLIENTE: " + Posicione("SA1",1,xFilial("SA1")+'000010', "A1_NOME") )

	DbSelectArea("SX5")
	SX5->(DBSETORDER(1))
	SX5->(DBSEEK(XFILIAL("SX5")+'02'))

	WHILE SX5->(!eof()) .AND. SX5->X5_TABELA == '02'

		Conout("Tipo de pagamento: " + SX5->X5_DESCRI )

		SX5->(DBSKIP())
	ENDDO

	RESET ENVIRONMENT
Return 