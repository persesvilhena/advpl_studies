#include 'protheus.ch'
#include 'parmtype.ch'

user function xTelas1(cVar)

	Local cAlias := cVar
	Local cTitulo := "Cadastro de Municipios "
	Local cVldExc := "U_vldtel()"
	Local cVldAlt := ".T."

	(cAlias)->(dbSetOrder(1))
	AxCadastro(cAlias,cTitulo,cVldExc,cVldAlt)

Return Nil

User Function xPerg()

	Private cPerg := PADR("AULAXX",10)

	ValidPerg()

	If Pergunte(cPerg, .T.)
		U_xTelas1(MV_PAR01)
	Else
		MsgInfo("Usuario clicou em cancelar", "ADV0001 – Funcao modelo")

	Endif
Return

Static Function ValidPerg()
	Local aArea  := SX1->(GetArea()) //1000 RECNO
	Local aRegs := {}
	Local i,j

	aadd( aRegs, { cPerg,"01","Tabela?","Tabela?","Tabela?","mv_ch1","C", 3,0,0,"G","","","","","mv_par01"," ","",""," ","","","","","","","","","","","","","","","","",""          } )

	DbselectArea('SX1')
	SX1->(DBSETORDER(1))
	For i:= 1 To Len(aRegs)
		If ! SX1->(DBSEEK( AvKey(cPerg,"X1_GRUPO") +aRegs[i,2]) )
			Reclock('SX1', .T.)
			FOR j:= 1 to SX1->( FCOUNT() )
				IF j <= Len(aRegs[i])
					FieldPut(j,aRegs[i,j])
				ENDIF
			Next j
			SX1->(MsUnlock())
		Endif
	Next i //300
	RestArea(aArea) //1000
Return(cPerg)

User Function vldtel()
	Local lRet := .t.

	If !MsgYesNo("Esta certo disso?")
		lRet := .f.
	Endif

Return(lRet)

User Function brw00001()

	Private cCadastro   := "Cadastro de Exemplo"
	Private aRotina     := {}
	AADD(aRotina,{"Pesquisar" ,"AxPesqui",0,1})
	AADD(aRotina,{"Visualizar" ,"AxVisual",0,2})
	AADD(aRotina,{"Incluir" ,"AxInclui",0,3})
	AADD(aRotina,{"Alterar" ,"AxAltera",0,4})
	AADD(aRotina,{"Excluir" ,"AxDeleta",0,5})
	AADD(aRotina,{"Pergunta" ,"U_xPerg",0,6})
	
	Private cString := "SA1"
	
	DbSelectArea("SA1")
	SA1->(dbSetOrder(1))
	
	mBrowse( ,,,,cString)

Return

