#Include "Protheus.Ch"

User Function xLeTxt1()
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
Local cBuffer 	:= ""
Local cFileOpen := ""
Local cFilSA1	:= ""
Local cCodSA1	:= ""
Local cLojaSA1	:= ""
Local cNomeSA1	:= ""
Local cNrzSA1	:= ""
Local cEstSA1	:= ""
Local cMunSA1	:= ""
Local cBaiSa1	:= ""
Local cTitulo1 	:= "Selecione o arquivo"
Local cExtens 	:= "Arquivo TXT | *.txt"

cFileOpen := cGetFile(cExtens,cTitulo1,,"",.T.)
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
	cFilSA1  := SubStr(cBuffer,001,002)
	cCodSA1	 := SubStr(cBuffer,003,006)
	cLojaSA1 := SubStr(cBuffer,009,002)
	cPessSA1 := Substr(cBuffer,011,001)
	cNomeSA1 := SubStr(cBuffer,012,040)
	cNrzSA1  := SubStr(cBuffer,052,020)
	cEndSA1	 := SubStr(cBuffer,072,040)
	cEstSA1	 := SubStr(cBuffer,112,002)
	cMunSA1	 := Substr(cBuffer,114,060)
	cBaiSA1	 := Substr(cBuffer,174,030)
	cCdMunSA1:= Substr(cBuffer,204,005)
	While .T.
		If SA1->(DbSeek(xFilial("SA1")+cCodSA1+cLojaSA1))
			cCodSA1 := SOMA1(cCodSA1)
			Loop
		Else
			Exit
		EndIf
	EndDo
	RecLock("SA1",.T.)
	SA1->A1_FILIAL := xFilial("SA1")
	SA1->A1_COD	   := cCodSA1
	SA1->A1_LOJA   := cLojaSA1
	SA1->A1_PESSOA := cPessSA1
	SA1->A1_TIPO   := "F"
	SA1->A1_CODMUN := cCdMunSA1
	SA1->A1_NOME   := cNomeSA1
	SA1->A1_NREDUZ := cNrzSA1
	SA1->A1_END	   := cEndSA1
	SA1->A1_EST	   := cEstSA1
	SA1->A1_COD_MUN:= cCdMunSA1
	SA1->A1_MUN	   := cMunSA1
	SA1->A1_BAIRRO := cBaiSA1
	SA1->(MsUnLock())
	FT_FSKIP()
EndDo
FT_FUSE()

MsgInfo("Processo finalizada")

Return Nil
