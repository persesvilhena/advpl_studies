#include 'protheus.ch'
#include 'parmtype.ch'

user function CadM3()
	Private cAlias1  := "SC5"
	Private cAlias2   := "SC6"
	Private aHeader   := {}
	Private aCols     := {}
	Private cCadastro := "Modelo 3"
	Private aRotina   := {}
	AAdd(aRotina, {"Pesquisar" , "axPesqui"  , 0, 1})
	AAdd(aRotina, {"Visualizar", "U_Incmod3" , 0, 2})
	AAdd(aRotina, {"Incluir"   , "u_Incmod3" , 0, 3})
	AAdd(aRotina, {"Altera"    , "u_Incmod3" , 0, 4})
	AAdd(aRotina, {"Excluir"   , "u_Incmod3" , 0, 5})
	mBrowse(,,,,cAlias1)
Return
//===============================================
User Function Incmod3(cAlias, nReg, nOpc)
	Local nAdi := 0
	Local i    := 0
	Private j:=1
	//Criar as variaveis de memoria
	RegToMemory(cAlias1, (nOpc==3))
	RegToMemory(cAlias2, (nOpc==3))
	aHeader   := {}
	aCols     := {}
	//Monta  aheader
	dbSelectArea("SX3")
	dbSetorder(1)
	dbSeek(cAlias2)

	While SX3->(!EOF()) .AND. SX3->X3_ARQUIVO == cAlias2
		If X3USO(SX3->X3_USADO) .AND. cNIVEL >= SX3->X3_NIVEL
			//.AND. ALLTRIM(SX3>X3_CAMPO) $ "C6_ITEM/C6_PRODUTO/C6_UM/C6_QTDVEN/C6_PRCVEN/C6_VALOR"
			AAdd (aHeader, {Trim(SX3->X3_TITULO),;//01 - titulo
			SX3->X3_CAMPO        ,;    //02- nome do campo
			SX3->X3_PICTURE      ,;    //03 - mascara do campo
			SX3->X3_TAMANHO      ,;    //04 - tamanho
			SX3->X3_DECIMAL      ,;    //05 - decimais
			SX3->X3_VALID        ,;    //06 - validacao
			SX3->X3_USADO        ,;    //07 - USADO
			SX3->X3_TIPO         ,;    //08 - TIPO DO CAMPO
			SX3->X3_ARQUIVO      ,;    //09 - ALIAS
			SX3->X3_CONTEXT})         //10 - Virtual ou Real
		ENDIF  
		SX3->(DBSKIP())
	ENDDO
	//Monta  acols
	If nOpc ==  3 //Inclusão
		AAdd(aCols, Array(Len(aHeader) + 1))
		For nAdi:= 1 to Len(aHeader)
			aCols[1][nADI] := Criavar(aHeader[nADI][2])
		Next  
		ACols[1][len(aHeader)+1] := .F.
	Else  //Visual/Altera/Exclui
		(cAlias2)->(dbSetOrder(1))
		(cAlias2)->(dbSeek(xFilial(cAlias2) + (cAlias1)->C5_NUM))
		While (cAlias2)->(!EOF()).And.(cAlias2)->C6_FILIAL == xFilial(cAlias2) .And.;
		(cAlias2)->C6_NUM == (cAlias1)->C5_NUM
			AAdd(aCols, Array(len(aHeader)+1))
			For i := 1 To Len(aHeader)
				If aHeader[i][10] <> "V"
					aCols[len(aCols)][i] := (cAlias2)->&(aHeader[i][2])
				Else
					aCols[len(aCols)][i] := CriaVar(aHeader[i][2])
				EndIf
			Next
			ACols[j][len(aHeader)+1] := .F.
			(cAlias2)->(dbSkip())
			j++
		Enddo
	Endif
	lRet := Modelo3(cCadastro, cAlias1, cAlias2, ,"Allwaystrue","Allwaystrue" ,  nOpc, nOpc)

	Return

return