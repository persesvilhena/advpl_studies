#include 'protheus.ch'
#include 'parmtype.ch'

user function xMod2()

	Private cCenario, _cRevCen,	cNomCena, _cMSBLQL,	_dDtIni, _dDtFim
	Private INCLUI,	ALTERA
	Private cLinhaOk	:= ".T."
	Private cTudoOk		:= ".T."
	Private cIniCpos := "+X5_CHAVE" // String com o nome dos campos que devem inicializados ao pressionar a seta para baixo.
	Private aAliasM2 := "SX5"
	Private cChave	:=	"SX5->(X5_FILIAL+X5_TABELA)"//| Chave do Cabecalho
	Private nIndChv	:=	1

	Private aAC,cTITULO , cCADASTRO , lEND, cDELFUNC, aROTINA

	Private aCabec	:= {}
	Private aChvUnq	:= {}

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//� Cria HELPs utilizados na rotina �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//	AjustaHlp()

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� CABECALHO - Defini�coes do cabelho                         �
	//� aCabec[<cCAMPO>, <VAR>, <nLINHA>, <nCOLUNA>, <cVALIDACAO>] �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	AADD(aCabec,{"X5_TABELA",,15, 10, ".T." })
	AADD(aCabec,{"X5_DESCRI",,15,100, ".T." })

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Campos que compeem a chave Unica �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	aChvUnq	:= {"X5_TABELA", "X5_CHAVE"}

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Campo com ID UNICO Sequencial - Somente utlizado na Gravacao     �
	//� Nunca se repete mesmo que o registro seja deletado               �
	//� {<cCAMPO>, <cFuncao Gera Unico> }                                �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	//	aIDUniq	:= {"POO_ID", "GetUniq()"}

	aAC:={"Abandona","Confirma"}
	cTitulo := "Configurador Importa豫o "
	cCadastro := OemToAnsi (cTitulo)
	lEnd := .F.
	CdelFunc := ".T."

	aRotina := {{"Pesquis","AxPesqui ", 0, 1},;
	{"Visual"	,"U_xTelM2(2)", 0, 2},;
	{"Incluir"	,"U_xTelM2(3)", 0, 3},;
	{"Alterar"	,"U_xTelM2(4)", 0, 4},;
	{"Exclusao"	,"U_xTelM2(5)", 0, 5}}

	dbSelectArea(aAliasM2)
	dbSetOrder(nIndChv)
	mBrowse(06,01,22,75,aAliasM2,,,30)
return

User Function xTelM2(cOpcao)
	Local nGrava, cQuebra
	Local nScan		:= 0
	Local cChvReg	:= ""
	Local aPosChv	:= {}
	Local aCpoLog	:= {} 	//| LOG

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Opcao de acesso para o Modelo 2                              �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	// 3,4 Permitem alterar getdados e incluir linhas
	// 6 So permite alterar getdados e nao incluir linhas
	// Qualquer outro numero so visualiza
	nOpcx:=cOpcao

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Montando aHeader                                             �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	dbSelectArea("SX3")
	SX3->(dbSetOrder(1))
	SX3->(dbSeek(aAliasM2))

	nUsado	:= 0
	aHeader	:= {}

	While SX3->(!Eof()) .And. (SX3->x3_arquivo == aAliasM2)

		nScan	:= Ascan(aCabec,{|x| Alltrim(Upper(x[1]))==Alltrim(SX3->X3_CAMPO)})
		If nScan <> 0 //Alltrim(SX3->X3_CAMPO)=="POU_CENARI" //.OR. Alltrim(SX3->X3_CAMPO)=="POM_FILUSO"

			aadd(aCabec[nScan],SX3->X3_CONTEXT)
			SX3->(dbSkip())
			Loop
		EndIf

		IF X3USO(x3_usado) .AND. cNivel >= x3_nivel
			nUsado:=nUsado+1
			AADD(aHeader,{ TRIM(x3_titulo),;
			x3_campo,;
			x3_picture,;
			x3_tamanho,;
			x3_decimal,;
			x3_valid,;
			x3_usado,;
			x3_tipo,;
			x3_arquivo,;
			x3_context } )
		Endif
		SX3->(dbSkip())
	EndDo

	//旼컴컴컴컴컴컴컴컴�
	//�                 �
	//� MONTA INTERFACE �
	//�                 �
	//읕컴컴컴컴컴컴컴컴�
	//旼컴컴컴컴커
	//� Inclusao �
	//읕컴컴컴컴켸
	If nOpcx==3
		INCLUI	:= .T.
		ALTERA	:= .F.
		aCols := Array(1,nUsado+1)
		dbSelectArea("SX3")
		SX3->(dbSeek(aAliasM2))

		nUsado:=0

		While SX3->(!Eof()) .And. (x3_arquivo == aAliasM2)

			If Ascan(aCabec,{|x| Alltrim(Upper(x[1]))==Alltrim(SX3->X3_CAMPO)}) <> 0
				dbSelectArea("SX3")
				SX3->(dbSkip())
				Loop

			EndIf

			IF X3USO(x3_usado) .AND. cNivel >= x3_nivel
				nUsado++
				IF nOpcx == 3
					aCOLS[1][nUsado]	:= CRIAVAR(SX3->X3_CAMPO, .T.)
				Endif
			Endif
			SX3->(dbSkip())
		EndDO

		aCOLS[1][nUsado+1] := .F.	//| Delete
		aCOLS[1,1]	:= "001"

		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� alteracao/exclusao/visualizacao �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	ElseIf nOpcx <> 3
		INCLUI	:= .F.
		ALTERA	:= .T.

		aCols:={}

		dbSelectArea(aAliasM2)
		(aAliasM2)->(dbSetOrder(nIndChv))
		(aAliasM2)->(dbSeek(&(cChave)))

		REGTOMEMORY(aAliasM2, .F.)

		//旼컴컴컴컴컴�
		//� CABECALHO �
		//읕컴컴컴컴컴�
		FOR _ni := 1 TO LEN(aCabec)
			aCabec[_ni,2]	:=	M->&(aCabec[_ni,1])
		NEXT _ni

		//旼컴컴컴컴컴컴컴컴컴컴커
		//� ITENS -  Monta aCols �
		//읕컴컴컴컴컴컴컴컴컴컴켸
		cQuebra	:=	&(cChave)
		While (aAliasM2)->(!Eof()) .And. cQuebra == &(cChave)

			AADD(aCols,Array(nUsado+1))

			REGTOMEMORY(aAliasM2, .F.)

			For _ni:=1 to nUsado
				aCols[Len(aCols),_ni]	:=	M->&(aHeader[_ni,2])
			Next

			aCols[Len(aCols),nUsado+1]	:=	.F.

			(aAliasM2)->( dbSkip() )
		Enddo

	EndIf

	aAreaSX3	:= SX3->(GetArea())
	SX3->(DBSETORDER(2))

	aC:={}
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Array com descricao dos campos do Cabecalho do Modelo 2      �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	// aC[n,1] = Nome da Variavel Ex.:"cCliente"
	// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
	// aC[n,3] = Titulo do Campo
	// aC[n,4] = Picture
	// aC[n,5] = Validacao
	// aC[n,6] = F3
	// aC[n,7] = Se campo e' editavel .t. se nao .f.

	//旼컴컴컴컴컴컴컴컴컴커
	//� CABECALHO MODELO 2 �
	//읕컴컴컴컴컴컴컴컴컴켸
	If nOpcx==3

		//	REGTOMEMORY(aAliasM2,.T.)

		FOR ni := 1 TO LEN(aCabec)
			aCabec[nI,2]	:= CriaVar(aCabec[nI,1],.T.)

			//| Posiciona SX3
			SX3->(DBSEEK(aCabec[nI,1],.F.))

			cValidCpo	:= IIF(EMPTY(SX3->X3_VALID),".T. ",SX3->X3_VALID)+" .AND. "+IIF(EMPTY(SX3->X3_VLDUSER)," .T.",SX3->X3_VLDUSER)
			AADD(aC,{"aCabec["+alltrim(str(ni))+",2]"	,{aCabec[nI,3], aCabec[nI,4]}  ,ALLTRIM(SX3->X3_TITULO)   ,SX3->X3_PICTURE	,cValidCpo,SX3->X3_F3, IIF(SX3->X3_VISUAL == "V",.F., &(SX3->X3_WHEN))	})

		NEXT nI

	Else

		(aAliasM2)->(dbSeek(cQuebra))

		FOR ni := 1 TO LEN(aCabec)

			//| Posiciona SX3
			SX3->(DBSEEK(aCabec[nI,1],.F.))

			AADD(aC,{"aCabec["+alltrim(str(ni))+",2]"	,{aCabec[nI,3], aCabec[nI,4]}  ,ALLTRIM(SX3->X3_TITULO)   ,SX3->X3_PICTURE	, aCabec[nI,5] ,SX3->X3_F3, IIF(SX3->X3_VISUAL == "V",.F., &(SX3->X3_WHEN))	})
		NEXT nI

	EndIf

	RestArea(aAreaSX3)

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Array com descricao dos campos do Rodape do Modelo 2         �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	aR:={}
	// aR[n,1] = Nome da Variavel Ex.:"cCliente"
	// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
	// aR[n,3] = Titulo do Campo
	// aR[n,4] = Picture
	// aR[n,5] = Validacao
	// aR[n,6] = F3
	// aR[n,7] = Se campo e' editavel .t. se nao .f.

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Array com coordenadas da GetDados no modelo2                 �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	aCGD:={85,5,118,315}

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Chamada da Modelo2                                           �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	lRetMod2 := Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk, , , cIniCpos,999999,,,.T.)

	//旼컴컴컴컴컴컴컴컴컴커
	//�                    �
	//� GRAVACAO DOS DADOS �
	//�                    �
	//읕컴컴컴컴컴컴컴컴컴켸
	If lRetMod2

		//旼컴컴컴컴컴컴컴컴커
		//� *** INCLUSAO *** �
		//읕컴컴컴컴컴컴컴컴켸
		If nOpcx==3
			For nGrava:=1 To Len(aCols)

				//| Desconsidera registro deletado
				If Acols[nGrava,Len(aHeader)+1]
					Loop
				EndIf

				//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
				//� Alimenta campo do Cabecalho �
				//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
				RecLock( aAliasM2,.T.)
				FOR nX	:= 1 TO LEN(aCabec)
					//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
					//� Desconsidera campos virtuais �
					//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
					IF aCabec[nX, Len(aCabec[nX])]	<> "V"
						&(aAliasM2+"->"+aCabec[nX,1])		:= aCabec[nX,2]

					ENDIF
				Next nX

				//旼컴컴컴컴컴컴컴컴컴컴컴컴커
				//� Alimenta Campo dos Itens �
				//읕컴컴컴컴컴컴컴컴컴컴컴컴켸
				For nX:=1 To Len(aHeader)
					IF aHeader[nX,10] <> "V"

						&(aAliasM2+"->"+aHeader[nX,2])	:= 	Acols[nGrava,nX]
					ENDIF
				Next nX
				MsUnLock()
				ConfirmSx8()

			Next  nGrava

			//旼컴컴컴컴컴컴컴컴컴�
			//� *** ALTERACAO *** �
			//읕컴컴컴컴컴컴컴컴컴�
		ElseIf nOpcx==4

			dbSelectArea(aAliasM2)
			dbSetOrder(nIndChv)

			For nGrava:=1 To Len(aCols)

				//旼컴컴컴컴컴컴�
				//� Monta Chave �
				//읕컴컴컴컴컴컴�
				cChvReg	:= XFILIAL(aAliasM2)
				FOR nI := 1 TO LEN(aChvUnq)

					//| Cabec
					nPos	:=	Ascan(aCabec,{|x| Alltrim(Upper(x[1]))== aChvUnq[nI]  })
					IF nPos <> 0
						cChvReg	+= 	aCabec[nPos,2] //|aCols[nGrava, aPosChv[nI]]
					ENDIF

					//| Itens
					nPos	:=	Ascan(aHeader,{|x| Alltrim(Upper(x[2]))== aChvUnq[nI]  })
					IF nPos <> 0
						cChvReg	+= aCols[nGrava, nPos]
					ENDIF
				Next nI

				//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
				//� Posiciona no registro a ser Alterado ou Excluido �
				//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
				IF (aAliasM2)->(DBSEEK(cChvReg,.F.))

					//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
					//� EXCLUSAO                                                         �
					//� Caso linha tenha sido deletada, EXCLUI registro da tabela Fisica �
					//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
					If Acols[nGrava,Len(aHeader)+1]
						RECLOCK(aAliasM2,.F.)
						(aAliasM2)->(DBDELETE())
						MSUNLOCK()

						LOOP
					EndIf

					//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
					//� ALTERACAO                                                        �
					//�                                                                  �
					//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

					//旼컴컴컴컴컴�
					//� CABECALHO �
					//읕컴컴컴컴컴�
					FOR nI := 1 TO LEN(aCabec)
						M->&(aCabec[nI,1])	:= aCabec[nI,2]
					Next nI

					//旼컴컴컴�
					//� ITENS �
					//읕컴컴컴�
					FOR nI := 1 TO LEN(aHeader)
						IF aHeader[nI,10] <> "V"
							M->&(aHeader[nI,2])	:= aCols[nGrava,nI]
						ENDIF
					Next nI

					//旼컴컴컴컴컴컴컴컴�
					//� Grava Alteracao �
					//읕컴컴컴컴컴컴컴컴�
					nCpoAlt	:= 0
					For nY := 1 To (aAliasM2)->(FCOUNT())

						//| Armazena dados para gravacao do LOG
						IF (aAliasM2)->&(FieldName(nY)) <> M->&(FieldName(nY))
							aAdd( aCpoLog , { FieldName(nY) , (aAliasM2)->&(FieldName(nY)) , M->&(FieldName(nY)) } )

							nCpoAlt++

							//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
							//� Otimizacao de Performance                               �
							//� Somente abre transacao se ao menos 1 campo foi alterado �
							//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
							IF nCpoAlt == 1
								RECLOCK(aAliasM2, .F.)
							ENDIF

							(aAliasM2)->&(FieldName(nY))	:= M->&(FieldName(nY))
						ENDIF
					Next nY

					(aAliasM2)->(MSUNLOCK())
					aCpoLog	:= {}

					//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
					//� INCLUSAO                                                         �
					//� Quando o registro nao e localizado,inclui registro               �
					//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
				ELSE

					//| Desconsidera registros deletados
					If Acols[nGrava,Len(aHeader)+1]

						LOOP
					EndIf

					//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
					//� Alimenta campo do Cabecalho �
					//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
					RecLock( aAliasM2,.T.)
					FOR nX	:= 1 TO LEN(aCabec)
						//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
						//� Desconsidera campos virtuais �
						//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
						IF aCabec[nX, Len(aCabec[nX])]	<> "V"
							&(aAliasM2+"->"+aCabec[nX,1])		:= aCabec[nX,2]

						ENDIF
					Next nX

					//旼컴컴컴컴컴컴컴컴컴컴컴컴커
					//� Alimenta Campo dos Itens �
					//읕컴컴컴컴컴컴컴컴컴컴컴컴켸
					For nX:=1 To Len(aHeader)
						IF aHeader[nX,10] <> "V"

							&(aAliasM2+"->"+aHeader[nX,2])	:= 	Acols[nGrava,nX]
						ENDIF
					Next
					MsUnLock()

				ENDIF

			Next nGrava

			//旼컴컴컴컴컴컴컴컴커
			//� *** EXCLUSAO *** �
			//읕컴컴컴컴컴컴컴컴켸
		ElseIf nOpcx==5

			dbSelectArea(aAliasM2)
			(aAliasM2)->(dbSetOrder(nIndChv))
			(aAliasM2)->(dbSeek(&(cChave)))

			cQuebra	:=	&(cChave)
			While (aAliasM2)->(!Eof()) .And. cQuebra == &(cChave)

				RECLOCK(aAliasM2, .F.)
				(aAliasM2)->(DBDELETE())
				MSUNLOCK()

				(aAliasM2)->(dbSkip())
			Enddo
		Endif
	ELSE
		ROLLBACKSX8()

	Endif

Return()
