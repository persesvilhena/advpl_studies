#Include "Protheus.Ch"

User Function xClientes()
Private cCadastro 	:= "Ler arquivo texto"
Private nOpc 		:= 0
Private aSay 		:= {}
Private aButton 	:= {}

AADD( aSay, "O objetivo desta rotina e efetuar a leitura em um arquivo texto" )
AADD( aButton, { 1,.T.,{|| nOpc := 1,FechaBatch()}})
AADD( aButton, { 2,.T.,{|| FechaBatch() }} )

FormBatch( cCadastro, aSay, aButton )

If nOpc == 1
	Processa( {|| LerTxt() }, "Processando..." )
Endif

Return Nil
//+----------------------------------------------------
//| Le o Arquivo Texto encontrado e efetua a gravação.|
//+----------------------------------------------------
Static Function LerTxt()
Local cBuffer 		:= ""
Local cFileOpen 	:= ""
Local cCodSA1		:= ""
Local cTitulo1 		:= "Selecione o arquivo"
Local cExtens 		:= "Arquivo TXT | *.txt"
Private xAutoCab 	:= {}
Private lMsErroAuto := .F.

cFileOpen := cGetFile(cExtens,cTitulo1,,"\SYSTEM_NFT\",.T.)
If !File(cFileOpen)
	MsgAlert("Arquivo texto: "+cFileOpen+" não localizado",cCadastro)
	Return
Endif

DbSelectArea("SA1")
SA1->(DbSetOrder(1)) //A1_FILIAL+A1_COD+A1_LOJA

FT_FUSE(cFileOpen)
FT_FGOTOP()

ProcRegua(FT_FLASTREC())

While !FT_FEOF()
	IncProc("Lendo Arquivo")
	cBuffer  := FT_FREADLN()
	cCodSA1	 := SubStr(cBuffer,003,006)
	cLojaSA1 := SubStr(cBuffer,009,002)
	While .T.
		If SA1->(DbSeek(xFilial("SA1")+cCodSA1+cLojaSA1))
			cCodSA1 := SOMA1(cCodSA1)
			Loop
		Else
			Exit
		EndIf
	EndDo
	//Monta Array para Execução.
	xAutoCab := {}
	Aadd(xAutoCab,{"A1_FILIAL" 	,xFilial("SA1")		 	,NIL})
	Aadd(xAutoCab,{"A1_COD"	 	,cCodSA1				,NIL})
	Aadd(xAutoCab,{"A1_LOJA"	,cLojaSA1				,NIL})
	Aadd(xAutoCab,{"A1_PESSOA" 	,Substr(cBuffer,011,001),NIL})
	Aadd(xAutoCab,{"A1_TIPO" 	,"F"					,NIL})
	Aadd(xAutoCab,{"A1_NOME"	,SubStr(cBuffer,012,040),NIL})
	Aadd(xAutoCab,{"A1_NREDUZ" 	,SubStr(cBuffer,052,020),NIL})
	Aadd(xAutoCab,{"A1_END"	 	,SubStr(cBuffer,072,040),NIL})
	Aadd(xAutoCab,{"A1_EST"	 	,SubStr(cBuffer,112,002),NIL})
	Aadd(xAutoCab,{"A1_MUN"		,Substr(cBuffer,114,060),NIL})
	Aadd(xAutoCab,{"A1_COD_MUN"	,Substr(cBuffer,204,005),NIL})
	Aadd(xAutoCab,{"A1_BAIRRO" 	,Substr(cBuffer,174,030),NIL})
	
	Begin Transaction
	lMsErroAuto := .F.
	
	MsExecAuto({|x,y| MATA030(x,y)}, xAutoCab, 3)
	
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
	EndIf
	
	End TRANSACTION
	
	FT_FSKIP()
EndDo
FT_FUSE()

MsgInfo("Processo finalizada")

Return Nil