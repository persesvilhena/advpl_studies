#INCLUDE "TOTVS.CH"
#INCLUDE "FWBROWSE.CH"
#INCLUDE "FWMVCDEF.CH"
#Include "FWMBROWSE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE "FWMVCDEF.CH"

Static cTAB    	 := "MARK"

User Function XPROC003()

	Local aObjects    := {}
	Local aInfo       := {}
	Local aPosObj     := {}
	Local aSize       := MsAdvSize()

	Local lBotFecha	  := !(oAPP:lMDI)
	Local oColumn     := Nil
	Local oStaFin	  := NIL
	Local cFiltro     := ""

	Local oAP         := LoadBitmap( GetResources(), "BR_VERDE" )
	Local oNA         := LoadBitmap( GetResources(), "BR_VERMELHO" )
	Local oNo         := LoadBitmap( GetResources(), "UNCHECKED" )
	Local oOut        := LoadBitmap( GetResources(), "BR_AMARELO" )
	Local nQtdItens   := 0
	Local nTotVen     := 0
	Local aOpcRight   := {}

	Private oDlg        := NIL
	Private oLayer1     := NIL
	Private oLayer2     := NIL
	Private oLayer3     := NIL
	Private oTPane1     := NIL
	Private oTPane2     := NIL
	Private oTPane3     := NIL
	Private oTPane4     := NIL
	Private oTPane5     := NIL

	Private cStaFin	  := ""
	Private cTabDe	  := SPACE(3)
	Private cTabAte   := Replicate("Z",3)
	Private dDataDe	  := Date()
	Private dDataAte  := Date()

	Private oBrw1     := Nil
	Private oBrw2     := Nil
	Private aSL2      := {}
	Private cWorkBr1  := "TRB1" //GetNextAlias()
	Private cWorKBr2  := "TRB2" //GetNextAlias()

	Private aFieldZZA   := {}
	Private aFieldSL2   := {}
	AAdd( aObjects, { 0, 040, .T., .F. })
	AAdd( aObjects, { 0, 030, .T., .F. })
	AAdd( aObjects, { 0, 070, .T., .F. })
	AAdd( aObjects, { 0, 045, .T., .F. })

	aInfo    := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 2, 2 }
	aPosObj  := MsObjSize( aInfo, aObjects )

	DEFINE MSDIALOG oDlg TITLE  "Integração Rest" FROM  aSize[7],0 To aSize[6],aSize[5]  OF oMainWnd COLOR "W+/W" STYLE nOR(WS_VISIBLE,WS_POPUP) PIXEL
	oDlg:lMaximized := .T.
	oDlg:lEscClose  := .F.

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³MONTAGEM PAINEL FILTRO						   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	oLayer1 := FWLayer():New()
	oLayer1:Init(oDlg,lBotFecha)

	oLayer1:AddCollumn("COLUMN_LEFT", 15, .F.)
	oLayer1:AddWindow("COLUMN_LEFT", "WND_SEARCH", "Filtros", 99.7, .F., .F., {|| })
	oTPane1 := oLayer1:GetWinPanel("COLUMN_LEFT", "WND_SEARCH")
	oTPane1S := TPanel():New(0,0,"",oTPane1,NIL,.T.,.F.,NIL,RGB(160,183,237),oTPane1:nWidth,oTPane1:nHeight,.T.,.F.)

	@ 005, 005 SAY "Tabela de:" 	Of oTPane1S Pixel
	@ 015, 005 MSGET oProdDe 		VAR cTabDe 			OF oTPane1S SIZE 050,009 PIXEL HASBUTTON F3 "SX2"

	@ 030, 005 SAY "Tabela ate:" 	Of oTPane1S Pixel
	@ 040, 005 MSGET oProdAte 		VAR cTabAte 			OF oTPane1S SIZE 050,009 PIXEL HASBUTTON F3 "SX2"

	@ 192,005 Button "Pesquisa" Size 035,15 OF oTPane1S Pixel Action	;
	MsgRun( "Aguarde... Gerando dados.", , ;
	{|| ( oBrw1:Alias())->(dbCloseArea())	,;
	oBrw1:DeActivate(.T.)			        ,;
	oBrw1:SetQuery(LdDados(1))              ,;
	oBrw1:Activate()						,;
	oBrw1:GoTop(.T.)						,;
	oBrw1:Refresh()                         ,;
	( oBrw2:Alias())->(dbCloseArea())	,;
	oBrw2:DeActivate(.T.)			        ,;
	oBrw2:SetQuery(LdDados(2,( oBrw1:Alias() )->ZZA_ALIAS ,( oBrw1:Alias() )->ZZA_TIPO ) )  ,;
	oBrw2:Activate()						,;
	oBrw2:GoTop(.T.)						,;
	oBrw2:Refresh()                          } )

	@ 192,045 Button "Sair" Size 035,15  OF oTPane1S Pixel Action (oDlg:End())

	@ 172,005 Button "Incluir" Size 035,15  OF oTPane1S Pixel Action (ChamaInc(3))
	@ 172,045 Button "Excluir" Size 035,15  OF oTPane1S Pixel Action (ChamaInc(5))

	oLayer1:AddCollumn("COLUMN_CENTER",85,.F.)

	oTpPane2 := oLayer1:GetColPanel("COLUMN_CENTER")
	oLayer2 := FWLayer():New()
	oLayer2:Init(oTpPane2,.F.)
	oLayer2:SetStyle( "ROUND" )

	oLayer2:AddLine( 'UP', 30, .T. )
	oLayer2:AddLine( 'DOWN', 63, .T. )
	//oLayer2:AddLine( 'RODA', 07, .T. )

	oLayer2:AddCollumn('COL_UP1',100,.F.,'UP')
	oLayer2:AddCollumn('COL_UP2',100,.F.,'DOWN')
	//oLayer2:AddCollumn('COL_RD1',50,.F.,'RODA')
	//oLayer2:AddCollumn('COL_RD2',50,.F.,'RODA')

	oLayer2:addWindow( 'COL_UP1' , 'Wnd1', "Tabelas de integração"	,  100, .F., .T., {|| }, 'UP' )

	oTPane2 := oLayer2:GetWinPanel( 'COL_UP1', 'Wnd1', 'UP' )

	oBrw1 := FWBrowse():New()
	oBrw1:SetDataQuery(.T.)
	oBrw1:SetQuery(LdDados(1))
	oBrw1:DisableReport()
	oBrw1:DisableConfig()
	oBrw1:SetOwner( oTPane2 )
	oBrw1:SetDescription( "Tabelas de integração" )
	oBrw1:SetAlias(cWorkBr1)
	oBrw1:SetSeek()

	oColumn := FWBrwColumn():New()
	oColumn:SetData( {|| (cWorkBr1)->ZZA_FILIAL} )
	oColumn:SetTitle( "Filial" )
	oColumn:SetAlign("CENTER")
	oColumn:SetSize( TamSX3("ZZA_FILIAL")[1] )
	oColumn:SetDecimal( 0 )
	oColumn:SetPicture( "@!" )
	aAdd(aFieldZZA, oColumn)

	oColumn := FWBrwColumn():New()
	oColumn:SetData( {|| (cWorkBr1)->ZZA_ALIAS} )
	oColumn:SetTitle( "Tabela" )
	oColumn:SetAlign("LEFT")
	oColumn:SetSize( 3 )
	oColumn:SetDecimal( 0 )
	oColumn:SetPicture( "@!" )
	aAdd(aFieldZZA, oColumn)

	oColumn := FWBrwColumn():New()
	oColumn:SetData( {|| Iif( (cWorkBr1)->ZZA_TIPO=="P","Post","Get" ) })
	oColumn:SetTitle( "Tipo" )
	oColumn:SetAlign("CENTER")
	oColumn:SetSize( 05 )
	oColumn:SetDecimal( 0 )
	oColumn:SetPicture( "@!" )
	aAdd(aFieldZZA, oColumn)

	//oBrw1:SetDoubleClick( {|oObject,nX,nY| OpcRight(nX,nY,oObject, oBrw1:nAt) })
	oBrw1:SetColumns( aFieldZZA )
	oBrw1:Activate()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³MONTAGEM PAINEL ITENS						   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	oLayer2:AddWindow( 'COL_UP2' , 'Wnd2', "Campos de integração"	,  100, .F., .T., {|| }, 'DOWN' )
	oTPane3	:= oLayer2:GetWinPanel( 'COL_UP2', 'Wnd2', 'DOWN' )

	oBrw2:= FWBrowse():New()
	oBrw2:SetDataQuery(.T.)
	oBrw2:SetQuery(LdDados(2))
	oBrw2:DisableReport()
	oBrw2:DisableConfig()
	oBrw2:SetOwner( oTPane3 )
	oBrw2:SetDescription( "Campos de integração" )
	oBrw2:SetAlias(cWorkBr2)
	oBrw2:SetSeek()

	oColumn := FWBrwColumn():New()
	oColumn:SetData( {|| (cWorkBr2)->ZZB_CAMPO } )
	oColumn:SetTitle( "Campo" )
	oColumn:SetAlign("Left")
	oColumn:SetSize( TamSX3("ZZB_CAMPO")[1] )
	oColumn:SetDecimal( 0 )
	oColumn:SetPicture( "@!" )
	aAdd(aFieldSL2, oColumn)

	oColumn := FWBrwColumn():New()
	oColumn:SetData( {|| GetSx3Cache((cWorkBr2)->ZZB_CAMPO,"X3_DESCRIC") } )
	oColumn:SetTitle( "Descrição" )
	oColumn:SetAlign("CENTER")
	oColumn:SetSize( 30 )
	oColumn:SetDecimal( 0 )
	oColumn:SetPicture( "@!" )
	aAdd(aFieldSL2, oColumn)

	/*aAdd(aFieldSL2, oColumn) */

	oBrw2:SetColumns( aFieldSL2 )

	oBrw2:Activate()

	oLayer1:SetColSplit("COLUMN_LEFT", CONTROL_ALIGN_RIGHT,, {||  oLayer2:oPANEL:nWIDTH := 1175+176, oLayer2:Show() })
	oBrw1:SetChange( {|| CheckLine()} )

	/*oLayer2:addWindow( 'COL_RD1' , 'Wnd1', "Total Itens =  "+ AllTrim(Transform(nQtdItens,"@E 99999")),  100, .F., .F., {|| }, 'RODA' )
	oLayer2:addWindow( 'COL_RD2' , 'Wnd2', "CMV Valor =  "+ AllTrim(Transform(nTotVen,"@E 9,999,999.99")),  100, .F., .F., {|| }, 'RODA' )
	oTPane4 := oLayer2:GetWinPanel( 'COL_RD1', 'Wnd1', 'RODA' )
	oTPane5 := oLayer2:GetWinPanel( 'COL_RD2', 'Wnd2', 'RODA' )
	*/
	// Inicializa
	CheckLine()

	ACTIVATE MSDIALOG oDlg

Return Nil

//-----------------------------------------------------------------------
/*/{Protheus.doc} LdDados
Cria Query para selecao de dados do ZA6

@author Eduardo Fernandes
@since  09/01/2015
@return cQuery
@version P11

/*/
//-----------------------------------------------------------------------
Static Function LdDados(nOpc,cTab,cTipo)
	Local _cQuery	:= ""

	Default cTab := ""
	Default cTipo := ""

	If nOpc == 1
		_cQuery := "SELECT distinct ZZA_FILIAL,                                        					 			"	+ CRLF
		_cQuery += "       ZZA_ALIAS,                                           					 			"	+ CRLF
		_cQuery += "       ZZA_TIPO                                           					 			"	+ CRLF
		_cQuery += "FROM   " + RetSqlName("ZZA") + " ZZA                       							 			"	+ CRLF
		_cQuery += "       INNER JOIN " + RetSqlName("ZZB") + " ZZB             							 			"	+ CRLF
		_cQuery += "        ON  ZZB_FILIAL = ZZA_FILIAL                   										"	+ CRLF
		_cQuery += "        AND ZZB_TABELA = ZZA_ALIAS              										"	+ CRLF
		_cQuery += "        AND ZZB.D_E_L_E_T_ = ' '                 										"	+ CRLF
		_cQuery += "  WHERE ZZA_FILIAL = '" + xfilial("ZZA") + "' "	+ CRLF
		_cQuery += "  AND   ZZA_ALIAS BETWEEN '" + cTabDe + "' AND '" + cTabAte + "' 				"	+ CRLF
		_cQuery += "  AND   ZZA.D_E_L_E_T_ = ' '                  										"	+ CRLF
		_cQuery += "  ORDER BY ZZA_ALIAS                  										"	+ CRLF

		/*		_cQuery += "	        PIVOT	"
		_cQuery += "	        (	"
		_cQuery += "	         SUM(TOTAL)	"
		_cQuery += "	         FOR DC4_DESZON IN ("+cWDC4CBKFZ+")	"
		_cQuery += "	        )	ORDER BY 1"
		*/
	Else

		/*SELECT ISNULL(CONVERT(VARCHAR(2047), CONVERT(VARBINARY(2047), ZZC_CTOLD)),'') AS ZZC_CTOLD
		FROM ZZC990
		WHERE CONDICAO
		_cQuery := "SELECT ZZC_FILIAL, ZZC_ALIAS, ZZC_RECNO,ZZC_TIPO, ZZC_CPOALT ,
		_cQuery += " ISNULL(CONVERT(VARCHAR(2047), CONVERT(VARBINARY(2047), ZZC_CTOLD)),'') AS ZZC_CTOLD,  "	+ CRLF
		_cQuery += " ISNULL(CONVERT(VARCHAR(2047), CONVERT(VARBINARY(2047), ZZC_CTATU)),'') AS ZZC_CTATU   "	+ CRLF
		_cQuery += "FROM   " + RetSqlName("ZZC") + " ZZC                       					    "	+ CRLF
		_cQuery += "  WHERE ZZC_FILIAL = '" + xfilial("ZZC") + "' 							        "	+ CRLF
		_cQuery += "  AND   ZZC_ALIAS BETWEEN '" + cTabDe + "' AND '" + cTabAte + "' 				"	+ CRLF
		_cQuery += "  AND   ZZC.D_E_L_E_T_ = ' '                  									"	+ CRLF */

		_cQuery := "SELECT distinct ZZA_FILIAL,                                        					 			"	+ CRLF
		_cQuery += "       ZZA_ALIAS,  ZZB_CAMPO,                                         					 			"	+ CRLF
		_cQuery += "       ZZB_TIPO                                           					 			"	+ CRLF
		_cQuery += "FROM   " + RetSqlName("ZZA") + " ZZA                       							 			"	+ CRLF
		_cQuery += "       INNER JOIN " + RetSqlName("ZZB") + " ZZB             							 			"	+ CRLF
		_cQuery += "        ON  ZZB_FILIAL = ZZA_FILIAL                   										"	+ CRLF
		_cQuery += "        AND ZZB_TABELA = ZZA_ALIAS              										"	+ CRLF
		_cQuery += "        AND ZZB.D_E_L_E_T_ = ' '                 										"	+ CRLF
		_cQuery += "  WHERE ZZA_FILIAL = '" + xfilial("ZZA") + "' "	+ CRLF
		_cQuery += "  AND   ZZA_ALIAS = '" + cTab + "'			"	+ CRLF
		_cQuery += "  AND   ZZA_TIPO = '" + cTipo + "'			"	+ CRLF
		_cQuery += "  AND   ZZA.D_E_L_E_T_ = ' '                  										"	+ CRLF

	Endif

Return _cQuery

/*/{Protheus.doc} ChamaInc
@author thiag
@since 26/11/2019
@version 1.0
@param cTab, characters, descricao
@type function
/*/
Static Function ChamaInc(nOpc)

	Local aPergs    := {}													//-- Parametros ParamBox
	Local aRet      := {}													//-- Retorno ParamBox

	Local aCampos   := {}
	Local cIndice1    := ""
	Local cIndice2    := ""
	Local cIndice3    := ""
	Private cAliasMK  := GetNextAlias()
	Private cArq      := ""
	Private cOpt      := ""
	Private cTabela   :=  SPACE(03)

	AADD( aPergs, {1,"Tabela"     ,cTabela,"@!","","SX2PAD","",003,.F.})
	aAdd( aPergs ,{2,"Post ou Get","Não",{"POST", "GET" },60,"",.T.})

	If ParamBox(aPergs ,"Tabela SX2",@aRet,,,,,,,,.F.,.F.)
		cTabela := aRet[1]
		cOpt    := aRet[2]

		If nOpc == 5 // Se for exclusão valida se existe a tabela para excluir
			DbSelectArea("ZZA")
			ZZA->(DbSetOrder(1))
			If !ZZA->(DbSeek(xFilial("ZZA")+cTabela+cOpt))
				MSGALERT("Tabela e tipo de integração não existe na base para exclusão")
				Return
			Endif
		Endif
	Endif

	MontaQuery(cTabela,cOpt,nOpc)

	If(cAliasMK)->(!Eof())

		Ferase(cArq+GetDBExtension())
		Ferase(cArq+OrdBagExt())
		cArq := ""

		aCampos := {}

		AAdd(aCampos,{"OK"  	    ,"C",002,0}) //Este campo será usado para marcar/desmarcar
		AAdd(aCampos,{"X3_ARQUIVO"  ,"C",003,0})
		AAdd(aCampos,{"X3_CAMPO"    ,"C",010,0})
		AAdd(aCampos,{"X3_ORDEM" 	,"C",002,0})
		AAdd(aCampos,{"X3_TITULO" 	,"C",013,0})
		AAdd(aCampos,{"X3_TIPO" 	,"C",1,0})

		cArq   := CriaTrab(aCampos,.T.)

		IF select(cTAB) > 0
			//oBrowse:oBrowse:DeActivate(.t.)
			GFEDelTab(cTab)
		Endif

		cIndice1 := Alltrim(CriaTrab(,.F.))
		cIndice2 := cIndice1
		cIndice3 := cIndice1

		cIndice1 := Left(cIndice1,5) + Right(cIndice1,2) + "A"
		cIndice2 := Left(cIndice2,5) + Right(cIndice2,2) + "B"
		cIndice3 := Left(cIndice3,5) + Right(cIndice3,2) + "C"

		//Se indice existir excluir
		If File(cIndice1+OrdBagExt())
			FErase(cIndice1+OrdBagExt())
		EndIf

		If File(cIndice2+OrdBagExt())
			FErase(cIndice2+OrdBagExt())
		EndIf

		DBUSEAREA(.t.,,cArq,(cTab))

		//A função IndRegua cria um índice temporário para o alias especificado, podendo ou não ter um filtro
		IndRegua(cTAB, cIndice1, "X3_ARQUIVO+X3_ORDEM+X3_CAMPO"	,,, "Arquivo+Ordem+Campo...")
		IndRegua(cTAB, cIndice2, "X3_TIPO",,, "Tipo...")
		IndRegua(cTAB, cIndice3, "X3_TITULO",,, "Titulo...")

		//Fecha todos os índices da área de trabalho corrente.
		dbClearIndex()

		//Acrescenta uma ou mais ordens de determinado índice de ordens ativas da área de trabalho.
		dbSetIndex(cIndice1+OrdBagExt())
		dbSetIndex(cIndice2+OrdBagExt())
		dbSetIndex(cIndice3+OrdBagExt())
		DbSelectArea(cTab)

		(cAliasMK)->(dbGotop())

		While (cAliasMK)->(!Eof())

			RecLock((cTab),.T.)

			(cTab)->X3_ARQUIVO := (cAliasMK)->X3_ARQUIVO
			(cTab)->X3_CAMPO   := (cAliasMK)->X3_CAMPO
			(cTab)->X3_TITULO  := (cAliasMK)->X3_TITULO

			(cAliasMK)->(dbSkip())

		Enddo

		If nOpc <> 5
			MkBrw(cTab,.f., cOpt)
		Else
			MkBrw(cTab,.t., cOpt)
		Endif

	Endif
Return

Static Function MkBrw(cTab,lExc,cOpt)

	Local aAreaAnt   := GetArea()
	Local bKeyF5     := Nil
	Local aSeek      := {}
	Local aStruct    := {}
	Local aFieldsFil := {}
	Local nI         := 0
	Private cTab     := cTab

	//Irei criar a pesquisa que será apresentada na tela
	aAdd(aSeek,{"Tabela",{{"","C",003,0,"Tabela"	,"@!"}} } )
	aAdd(aSeek,{"Campos",{{"","C",010,0,"Campo"	,"@!"}} } )

	oBrowse:= FWMarkBrowse():New()

	If !lExc
		oBrowse:SetDescription("Incluir Campos SX3")
		oBrowse:AddButton("Incluir"        ,   "U_xProcok",, 3, 0)
	Else
		oBrowse:SetDescription("Excluir Campos SX3")
		oBrowse:AddButton("Excluir"        ,   "U_xProcEx",, 3, 0)
	Endif

	oBrowse:SetMenuDef("XPROC003")
	oBrowse:SetAlias(cTab)
	oBrowse:SetFieldMark("OK")
	oBrowse:SetValid({||.t.})

	//oBrowse:SetOwner(oWIN_RGT)
	oBrowse:oBrowse:SetDBFFilter(.T.)
	oBrowse:oBrowse:SetUseFilter(.T.)

	aStruct := (cTab)->( DBStruct())

	For nI := 1 to Len(aStruct)
		aadd(aFieldsFil,{aStruct[nI,1],aStruct[nI,1],aStruct[nI,2],aStruct[nI,3],aStruct[nI,4],})
	Next nI

	oBrowse:oBrowse:odata:aFieldsfilter := aFieldsFil

	oBrowse:oBrowse:SetFixedBrowse(.T.)
	oBrowse:SetTemporary()
	oBrowse:SetWalkThru(.F.)
	oBrowse:oBrowse:SetFilterDefault("")
	oBrowse:SetAmbiente(.F.)
	//oBrowse:AddStatusColumns( {|| BrwStatus(cTab,lExc)}, {|| BrwLegend()} )
	oBrowse:GoTop(.T.)
	//Adiciona uma coluna no Browse em tempo de execução

	oBrowse:SetColumns(OmsCollums("X3_ARQUIVO" ,"Tabela"	,03,"@!",0,03,0))
	oBrowse:SetColumns(OmsCollums("X3_CAMPO"   ,"Campo"  	,10,"@!",0,10,0))

	oBrowse:Activate()

	oBrowse:oBrowse:Setfocus() //Seta o foco na grade

Return

/*/{Protheus.doc} MontaQuery
@author thiag
@since 26/11/2019
@version 1.0
@param lExc, logical, descricao
@type function
/*/
Static Function MontaQuery(cTAB,cTipo,nOpc)
	Local aAreaSX3 := {}
	Local aCpoEnch := {}
	Local aCampos  := {}
	
	DBSELECTAREA("SX3")
	aAreaSX3	:= GETAREA()

	DbSelectArea("ZZB")
	ZZB->(DbSetOrder(1))

	SX3->(DBSETORDER(1))
	SX3->(DBSEEK(cTAB))

	WHILE SX3->X3_ARQUIVO == cTAB .AND. SX3->(!EOF())

		IF X3USO(SX3->X3_USADO) .AND. cNivel>=SX3->X3_NIVEL
			IF SX3->X3_CONTEXT <> 'V'
				AADD(aCpoEnch, {SX3->X3_ARQUIVO,;
				SX3->X3_CAMPO,;
				SX3->X3_ORDEM,;
				SX3->X3_TITULO,;
				SX3->X3_TIPO})
			ENDIF

		ENDIF
		SX3->(DBSKIP())

	ENDDO

	AAdd(aCampos,{"X3_ARQUIVO"  ,"C",003,0})
	AAdd(aCampos,{"X3_CAMPO"    ,"C",010,0})
	AAdd(aCampos,{"X3_ORDEM" 	,"C",002,0})
	AAdd(aCampos,{"X3_TITULO" 	,"C",013,0})
	AAdd(aCampos,{"X3_TIPO" 	,"C",1,0})

	cArq   := CriaTrab(aCampos,.T.)

	DBUSEAREA(.t.,,cArq,(cAliasMK))

	For nI := 1 To Len(aCpoEnch)

		If nOpc = 3

			If !ZZB->(DbSeek(xFilial("ZZB")+cTabela+aCpoEnch[nI,2]+cTipo))
				RecLock((cAliasMK),.T.)
				(cAliasMK)->X3_ARQUIVO := aCpoEnch[nI,1]
				(cAliasMK)->X3_CAMPO   := aCpoEnch[nI,2]
				(cAliasMK)->X3_TITULO  := aCpoEnch[nI,4]
				(cAliasMK)->(MsUnlock())
			Endif

		Else
			If ZZB->(DbSeek(xFilial("ZZB")+cTabela+aCpoEnch[nI,2]+cTipo))
				RecLock((cAliasMK),.T.)
				(cAliasMK)->X3_ARQUIVO := aCpoEnch[nI,1]
				(cAliasMK)->X3_CAMPO   := aCpoEnch[nI,2]
				(cAliasMK)->X3_TITULO  := aCpoEnch[nI,4]
				(cAliasMK)->(MsUnlock())
			Endif
		Endif

	Next nI

	RestArea(aAreaSX3)

Return()

/*/{Protheus.doc} OmsCollums
////Função para criar as colunas do grid
@author thi_n
@since 13/09/2019
@version 1.0
@param cCampo, characters, descricao
@param cTitulo, characters, descricao
@param nArrData, numeric, descricao
@param cPicture, characters, descricao
@param nAlign, numeric, descricao
@param nSize, numeric, descricao
@param nDecimal, numeric, descricao
@type function
/*/
Static Function OmsCollums(cCampo,cTitulo,nArrData,cPicture,nAlign,nSize,nDecimal)
	Local aColumn
	Local bData 	:= {||}
	Default nAlign 	:= 1
	Default nSize 	:= 20
	Default nDecimal:= 0
	Default nArrData:= 0

	If nArrData > 0
		bData := &("{||" + cCampo +"}") //&("{||oBrowse:DataArray[oBrowse:At(),"+STR(nArrData)+"]}")
	EndIf

	/* Array da coluna
	[n][01] Título da coluna
	[n][02] Code-Block de carga dos dados
	[n][03] Tipo de dados
	[n][04] Máscara
	[n][05] Alinhamento (0=Centralizado, 1=Esquerda ou 2=Direita)
	[n][06] Tamanho
	[n][07] Decimal
	[n][08] Indica se permite a edição
	[n][09] Code-Block de validação da coluna após a edição
	[n][10] Indica se exibe imagem
	[n][11] Code-Block de execução do duplo clique
	[n][12] Variável a ser utilizada na edição (ReadVar)
	[n][13] Code-Block de execução do clique no header
	[n][14] Indica se a coluna está deletada
	[n][15] Indica se a coluna será exibida nos detalhes do Browse
	[n][16] Opções de carga dos dados (Ex: 1=Sim, 2=Não)
	*/
	aColumn := {cTitulo,bData,,cPicture,nAlign,nSize,nDecimal,.F.,{||.T.},.F.,{||.T.},NIL,{||.T.},.F.,.F.,{}}
Return { aColumn }

User Function xProcok()

	Local aMark := {}
	Local lret  := .t.
	Local cMarca     := oBrowse:Mark()

	(cTab)->( dbGoTop() )
	While (cTab)->( !Eof() )
		If oBrowse:IsMark(cMarca)
			aAdd( aMark, (cTab)->X3_CAMPO  )
		EndIf
		(cTab)->( dbSkip() )
	EndDo

	If Len(aMark) == 0
		MsgAlert("Não foi selecionada nenhum campo","TOTVS")
		lRet := .F.
	Else

		If Aviso("TOTVS", "Confirma a inclusão desses campos para Integração?",{"SIM","NÃO"},1) == 1

			Processa( {|| ProcZZ(aMark,cTabela,cOpt)}, "Aguarde...", "Incluindo Campos",.f.)

			MsgRun( "Aguarde... Atualizando dados.", , ;
			{|| ( oBrw1:Alias())->(dbCloseArea())	,;
			oBrw1:DeActivate(.T.)			        ,;
			oBrw1:SetQuery(LdDados(1))              ,;
			oBrw1:Activate()						,;
			oBrw1:GoTop(.T.)						,;
			oBrw1:Refresh()                          } )

		Endif
	Endif

Return lret

/*/{Protheus.doc} xProcEx
@author thiag
@since 26/11/2019
@version 1.0
@param aMark, array, descricao
@param cTab, characters, descricao
@param nOpt, numeric, descricao
@type function
/*/
User Function xProcEx()

	Local aMark := {}
	Local lret  := .t.
	Local cMarca     := oBrowse:Mark()

	(cTab)->( dbGoTop() )
	While (cTab)->( !Eof() )
		If oBrowse:IsMark(cMarca)
			aAdd( aMark, (cTab)->X3_CAMPO  )
		EndIf
		(cTab)->( dbSkip() )
	EndDo

	If Len(aMark) == 0
		MsgAlert("Não foi selecionada nenhum campo","TOTVS")
		lRet := .F.
	Else

		If Aviso("TOTVS", "Confirma a exclusão desses campos para Integração?",{"SIM","NÃO"},1) == 1

			Processa( {|| ProcEX(aMark,cTabela,cOpt)}, "Aguarde...", "Excluindo Campos",.f.)

			MsgRun( "Aguarde... Atualizando dados.", , ;
			{|| ( oBrw1:Alias())->(dbCloseArea())	,;
			oBrw1:DeActivate(.T.)			        ,;
			oBrw1:SetQuery(LdDados(1))              ,;
			oBrw1:Activate()						,;
			oBrw1:GoTop(.T.)						,;
			oBrw1:Refresh()                          } )

		Endif
	Endif

Return lret

/*/{Protheus.doc} ProcZZ
@author thiag
@since 26/11/2019
@version 1.0
@param aMark, array, descricao
@param cTab, characters, descricao
@param nOpt, numeric, descricao
@type function
/*/
Static Function ProcZZ(aMark,cTabela,cOpt)

	Local cTipo := cOpt
	ProcRegua(Len(aMark))

	DbSelectArea("ZZA")
	ZZA->(DbSetOrder(1))

	If !ZZA->(DbSeek(xFilial("ZZA")+cTabela+cTipo))

		Reclock("ZZA", .T.)
		ZZA->ZZA_FILIAL := xFilial("ZZA")
		ZZA->ZZA_ALIAS  := cTabela
		ZZA->ZZA_TIPO   := cTipo
		ZZA->(Msunlock())

	Endif

	DbSelectArea("ZZB")
	ZZB->(DbSetOrder(1))

	For nI := 1 to Len(aMark)
		IncProc("Aguarde...")
		If !ZZB->(DbSeek(xFilial("ZZB")+cTabela+aMark[nI]+cTipo))
			Reclock("ZZB", .T.)
			ZZB->ZZB_FILIAL := xFilial("ZZB")
			ZZB->ZZB_TABELA := cTabela
			ZZB->ZZB_CAMPO  := aMark[nI]
			ZZB->ZZB_TIPO   := cTipo
			ZZB->(Msunlock())
		Endif
	Next nI

	Eval( oBrowse:oBrowse:oBrowse:Ownd:Ownd:bclose )
	eval(oBrowse:oBrowse:oBrowseui:bbtnclose)

Return

/*/{Protheus.doc} ProcEx
@author thiag
@since 26/11/2019
@version 1.0
@param aMark, array, descricao
@param cTab, characters, descricao
@param nOpt, numeric, descricao
@type function
/*/
Static Function ProcEx(aMark,cTabela,cOpt)

	Local cTipo := cOpt
	ProcRegua(Len(aMark))

	DbSelectArea("ZZB")
	ZZB->(DbSetOrder(1))

	For nI := 1 to Len(aMark)
		IncProc("Aguarde...")
		If ZZB->(DbSeek(xFilial("ZZB")+cTabela+aMark[nI]+cTipo))
			Reclock("ZZB", .F.)
			ZZB->( dbDelete())
			ZZB->(Msunlock())
		Endif
	Next nI

	ZZB->(DbSetOrder(2))
	If !ZZB->(DbSeek(xFilial("ZZB")+cTabela+cTipo))
		DbSelectArea("ZZA")
		ZZA->(DbSetOrder(1))
		If ZZA->(DbSeek(xFilial("ZZA")+cTabela+cTipo))
			Reclock("ZZA", .F.)
			ZZA->( dbDelete())
			ZZA->(Msunlock())
		Endif
	Endif

	Eval( oBrowse:oBrowse:oBrowse:Ownd:Ownd:bclose )
	eval(oBrowse:oBrowse:oBrowseui:bbtnclose)
Return

/*/{Protheus.doc} GetStru
@author thiag
@since 26/11/2019
@version 1.0
@param cAlias, characters, descricao
@param cTipo, characters, descricao
@type function
/*/
User Function GetStru(cAlias,cTipo)

	Local cQry := ""
	Local cAliasSt := GetNextAlias()
	Local aRet     := {}

	cQry := " SELECT DISTINCT ZZB_CAMPO FROM "+ RetSqlName("ZZA") + " ZZA "
	cQry += " INNER JOIN "+ RetSqlName("ZZB") +" ZZB "
	cQry += " ON  ZZB_FILIAL = ZZA_FILIAL
	cQry += " AND ZZB_TABELA = ZZA_ALIAS
	cQry += " AND ZZB.D_E_L_E_T_ = ' ' "
	cQry += " WHERE ZZA_ALIAS = '" + cTAB + "'"
	cQry += " AND ZZA_TIPO = '"+cTipo+"' "
	cQry += " AND ZZA.D_E_L_E_T_ = ' ' "

	TCQuery cQry New Alias &(cAliasSt)

	While (cAliasSt)->(!Eof())

		aadd(aRet, (cAliasSt)->ZZB_CAMPO)

		(cAliasSt)->(dbSkip())

	Enddo

Return(aRet)

/*/{Protheus.doc} GrvZZC
@author thiag
@since 26/11/2019
@version 1.0
@param _cFilial, , descricao
@param _cAlias, , descricao
@param _nRecno, , descricao
@param _cTipo, , descricao
@param _cCampo, , descricao
@param _cCold, , descricao
@param _cCatu, , descricao
@type function
/*/
User Function GrvZZC(_cFilial,_cAlias,_nRecno,_cTipo,_cCampo,_cCold,_cCatu)

	DbSelectArea("ZZC")
	ZZC->(dbSetOrder(1))
	Reclock("ZZC", .t.)

	ZZC->ZZC_FILIAL := _cFilial
	ZZC->ZZC_ALIAS  := _cAlias
	ZZC->ZZC_RECNO  := _nRecno
	ZZC->ZZC_TIPO   := _cTipo
	ZZC->ZZC_CPOALT := _cCampo
	ZZC->ZZC_CTOLD  := _cCold
	ZZC->ZZC_CTATU  := _cCatu

	ZZC->(MsUnlock())

Return

/*/{Protheus.doc} CheckLine
//TODO Descrição auto-gerada.
@author BENE FACTUM
@since 10/01/2020
@version 1.0
@type function
/*/
Static Function CheckLine()
	MsgRun( "Aguarde... Atualizando dados.", , ;
	{|| ( oBrw2:Alias())->(dbCloseArea())	,;
	oBrw2:DeActivate(.T.)			        ,;
	oBrw2:SetQuery(LdDados(2,( oBrw1:Alias() )->ZZA_ALIAS ,( oBrw1:Alias() )->ZZA_TIPO ) )              ,;
	oBrw2:Activate()						,;
	oBrw2:GoTop(.T.)						,;
	oBrw2:Refresh()                          } )
Return