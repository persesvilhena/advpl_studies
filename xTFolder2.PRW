#Include "Protheus.Ch"
#Include "TopConn.Ch"
#Include "Tbiconn.Ch"
#include 'parmtype.ch'

User Function xTFolder()
	Local oFolder,oButton,oButton1,oButton2
	Local oSay, oSay1, oSay2, oSay3, oSay4, oSay5, oSay6, oSay7, oSay8
	Local oGet, oGet1, oGet2,oGet3, oGet5, oGet6, oGet7, oGet8
	Local cVar  := space(TamSX3('A1_COD')[1])  // A1_COD
	Local cVar1 := space(TamSX3('A1_LOJA')[1]) // A1_LOJA
	Local cVar2 := space(TamSX3('A1_NOME')[1]) // A1_NOME
	Local cVar3 := space(TamSX3('A2_COD')[1]) // A2_COD
	Local cVar4 := space(TamSX3('A2_LOJA')[1]) // A2_LOJA
	Local cVar5 := space(TamSX3('A2_NOME')[1]) // A2_NOME
	Local cVar6 := space(TamSX3('B1_COD')[1]) // B1_COD
	Local cVar7 := space(TamSX3('B1_DESC')[1]) // B1_DESC
	Local bSay  :=  { || "Cliente" }
	Local bSay1 :=  { || "Loja" }
	Local bSay2 :=  { || "Novo nome" }
	Local bSay3 :=  { || "Fornecedor" }
	Local bSay4 :=  { || "Loja" }
	Local bSay5 :=  { || "Novo nome" }
	Local bSay6 :=  { || "Produto" }
	Local bSay7 :=  { || "Novo nome" }
	Local bGet  :=  { |u| IIF(PCount()>0,cVar:=u,cVar )}
	Local bGet1 :=  { |u| IIF(PCount()>0,cVar1:=u,cVar1 )}
	Local bGet2 :=  { |u| IIF(PCount()>0,cVar2:=u,cVar2 )}
	Local bGet3 :=  { |u| IIF(PCount()>0,cVar3:=u,cVar3 )}
	Local bGet4 :=  { |u| IIF(PCount()>0,cVar4:=u,cVar4 )}
	Local bGet5 :=  { |u| IIF(PCount()>0,cVar5:=u,cVar5 )}
	Local bGet6 :=  { |u| IIF(PCount()>0,cVar6:=u,cVar6 )}
	Local bGet7 :=  { |u| IIF(PCount()>0,cVar7:=u,cVar7 )}
	Local aFolder := { 'Cliente', 'Fornecedor', 'Produto' }

	DEFINE MSDIALOG oDlg FROM 0,0 TO 300,600 PIXEL TITLE "Teste TFolder"
	oFolder := TFolder():New(0,0,aFolder,aFolder,oDlg,,,, .T.,, 300,200 )
	//////////////****************INICIO FOLDER 1 ********************************////////////////////
	oSay := TSay():New(010,010,bSay,oFolder:aDialogs[1],,,,,,.T.,,)
	oSay:lTransparent:= .F.
	oSay1 := TSay():New(030,010,bSay1,oFolder:aDialogs[1],,,,,,.T.,,)
	oSay1:lTransparent:= .F.
	oSay2 := TSay():New(050,010,bSay2,oFolder:aDialogs[1],,,,,,.T.,,)
	oSay2:lTransparent:= .F.
	oGet    :=TGet():New(010,040,bGet,oFolder:aDialogs[1],,7,"@!",,,,,,,.T.,,,,,.T.,)
	oGet:cF3 := "SA1"
	oGet1   :=TGet():New(030,040,bGet1,oFolder:aDialogs[1],,7,"@!",,,,,,,.T.,,,,,.T.,)
	oGet2   :=TGet():New(050,040,bGet2,oFolder:aDialogs[1],,7,"@!",,,,,,,.T.,,,,,.T.,)
	oButton :=tButton():New(080,060,'Atualizar Cliente',oFolder:aDialogs[1],{||xUpdate('CLI',cVar,cVar1,cVar2)},050,020,,,,.T.)
	//////////////////************ FIM FOLDER 1 *******************************////////////////////////

	//////////////****************INICIO FOLDER 2 ********************************////////////////////
	oSay3 := TSay():New(010,010,bSay3,oFolder:aDialogs[2],,,,,,.T.,,)
	oSay3:lTransparent:= .F.
	oSay4 := TSay():New(030,010,bSay4,oFolder:aDialogs[2],,,,,,.T.,,)
	oSay4:lTransparent:= .F.
	oSay5 := TSay():New(050,010,bSay5,oFolder:aDialogs[2],,,,,,.T.,,)
	oSay5:lTransparent:= .F.
	oGet3   :=TGet():New(010,040,bGet3,oFolder:aDialogs[2],,7,"@!",,,,,,,.T.,,,,,.T.,)
	oGet3:cF3 := "SA2"
	oGet4   :=TGet():New(030,040,bGet4,oFolder:aDialogs[2],,7,"@!",,,,,,,.T.,,,,,.T.,)
	oGet5   :=TGet():New(050,040,bGet5,oFolder:aDialogs[2],,7,"@!",,,,,,,.T.,,,,,.T.,)
	oButton1 :=tButton():New(080,060,'Atualizar Fornecedor',oFolder:aDialogs[2],{||xUpdate('FOR',cVar3,cVar4,cVar5)},050,020,,,,.T.)
	//////////////////************ FIM FOLDER 2 *******************************////////////////////////

	//////////////****************INICIO FOLDER 3 ********************************////////////////////
	oSay6 := TSay():New(010,010,bSay6,oFolder:aDialogs[3],,,,,,.T.,,)
	oSay6:lTransparent:= .F.
	oSay7 := TSay():New(030,010,bSay7,oFolder:aDialogs[3],,,,,,.T.,,)
	oSay7:lTransparent:= .F.
	oGet6    :=TGet():New(010,040,bGet6,oFolder:aDialogs[3],,7,"@!",,,,,,,.T.,,,,,.T.,)
	oGet6:cF3 := "SB1"
	oGet7    :=TGet():New(030,040,bGet7,oFolder:aDialogs[3],,7,"@!",,,,,,,.T.,,,,,.T.,)
	oButton2 :=tButton():New(080,060,'Atualizar Produto',oFolder:aDialogs[3],{||xUpdate('PROD',cVar6,,cVar7)},050,020,,,,.T.)
	//////////////****************FIM FOLDER 3 ********************************////////////////////
	ACTIVATE MSDIALOG oDlg CENTERED

Return

Static Function xUpdate(cTipo, cCodCli, cLoja, cNewName )

	Local cQuery :=""
	Local nUpdate:= 0
	Local lOk	 := .t.
	Private xAutoCab 	:= {}
	Private lMsErroAuto := .F.

	IF cTIPO == 'CLI'

		xAutoCab := {}
		Aadd(xAutoCab,{"A1_FILIAL" 	,xFilial("SA1")		 	,NIL})
		Aadd(xAutoCab,{"A1_COD"	 	,cCodCli				,NIL})
		Aadd(xAutoCab,{"A1_LOJA"	,cLoja					,NIL})
		Aadd(xAutoCab,{"A1_NOME"	,cNewName               ,NIL})

		Begin Transaction
			lMsErroAuto := .F.

			MsExecAuto({|x,y| MATA030(x,y)}, xAutoCab, 4)

			If lMsErroAuto
				DisarmTransaction()
				MostraErro()
				lOk := .f.
			EndIf

		End TRANSACTION

		If lOk
			//Verifica se o Alias já existe.
			If Select("TRB") > 0
				TRB->(DbCloseArea())
			EndIf
			cQuery := "SELECT A1_COD , A1_NOME"
			cQuery += " FROM " + RetSqlName("SA1") + " SA1 "
			cQuery += " WHERE "
			cQuery += " SA1.D_E_L_E_T_ = '' "
			cQuery += " AND SA1.A1_COD = '"+cCodCli+"' "
			//Executa a Query e cria uma WorkArea com o resultado.
			TCQUERY cQuery NEW ALIAS "TRB"
			//Abre a WorkArea criada.
			DbSelectArea("TRB")
			TRB->(DbGoTop())

			While !TRB->(EOF())
				MsgInfo(TRB->A1_COD+" "+AllTrim(TRB->A1_NOME)+" <--- Alterado","Teste Select")
				TRB->(DbSkip())
			EndDo
			//Fecha o Alias.
			TRB->(DbCloseArea())
		EndIf

	ElseIF cTIPO == 'FOR'

		xAutoCab := {}
		Aadd(xAutoCab,{"A2_FILIAL" 	,xFilial("SA2")		 	,NIL})
		Aadd(xAutoCab,{"A2_COD"	 	,cCodCli				,NIL})
		Aadd(xAutoCab,{"A2_LOJA"	,cLoja					,NIL})
		Aadd(xAutoCab,{"A2_NOME"	,cNewName               ,NIL})

		Begin Transaction
			lMsErroAuto := .F.

			MsExecAuto({|x,y| MATA020(x,y)}, xAutoCab, 4)

			If lMsErroAuto
				DisarmTransaction()
				MostraErro()
				lOk := .f.
			EndIf

		End TRANSACTION

		If lOk
			//Verifica se o Alias já existe.
			If Select("TRB") > 0
				TRB->(DbCloseArea())
			EndIf
			cQuery := "SELECT A2_COD , A2_NOME"
			cQuery += " FROM " + RetSqlName("SA2") + " SA2 "
			cQuery += " WHERE "
			cQuery += " SA2.D_E_L_E_T_ = '' "
			cQuery += " AND SA2.A2_COD = '"+cCodCli+"' "
			//Executa a Query e cria uma WorkArea com o resultado.
			TCQUERY cQuery NEW ALIAS "TRB"
			//Abre a WorkArea criada.
			DbSelectArea("TRB")
			TRB->(DbGoTop())

			While !TRB->(EOF())
				MsgInfo(TRB->A2_COD+" "+AllTrim(TRB->A2_NOME)+" <--- Alterado","Teste Select")
				TRB->(DbSkip())
			EndDo
			//Fecha o Alias.
			TRB->(DbCloseArea())
		EndIf

	ElseIF cTIPO == 'PROD'

		xAutoCab := {}
		Aadd(xAutoCab,{"B1_FILIAL" 	,xFilial("SB1")		 	,NIL})
		Aadd(xAutoCab,{"B1_COD"	 	,cCodCli				,NIL})
		Aadd(xAutoCab,{"B1_DESC"	,cNewName               ,NIL})

		Begin Transaction
			lMsErroAuto := .F.

			MsExecAuto({|x,y| MATA010(x,y)}, xAutoCab, 4)

			If lMsErroAuto
				DisarmTransaction()
				MostraErro()
				lOk := .f.
			EndIf

		End TRANSACTION

		If lOk
			//Verifica se o Alias já existe.
			If Select("TRB") > 0
				TRB->(DbCloseArea())
			EndIf
			cQuery := "SELECT B1_COD , B1_DESC"
			cQuery += " FROM " + RetSqlName("SB1") + " SB1 "
			cQuery += " WHERE "
			cQuery += " SB1.D_E_L_E_T_ = '' "
			cQuery += " AND SB1.B1_COD = '"+cCodCli+"' "
			//Executa a Query e cria uma WorkArea com o resultado.
			TCQUERY cQuery NEW ALIAS "TRB"
			//Abre a WorkArea criada.
			DbSelectArea("TRB")
			TRB->(DbGoTop())

			While !TRB->(EOF())
				MsgInfo(TRB->B1_COD+" "+AllTrim(TRB->B1_DESC)+" <--- Alterado","Teste Select")
				TRB->(DbSkip())
			EndDo
			//Fecha o Alias.
			TRB->(DbCloseArea())
		EndIf

	ENDIF

Return