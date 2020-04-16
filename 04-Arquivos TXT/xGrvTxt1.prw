#Include "Protheus.Ch"

User Function xGrvTxt1()
Local oGrvTXT

DEFINE MSDIALOG oGrvTXT TITLE OemToAnsi("Gera Arquivo Texto") FROM 000,000 TO 200,400 PIXEL
@ 005,005 TO 095,195 OF oGrvTXT PIXEL
@ 010,020 Say " Este programa gerara um arquivo texto, conforme os parame- "  OF oGrvTXT PIXEL
@ 018,020 Say " tros definidos pelo usuário, com os registros do arquivo de " OF oGrvTXT PIXEL
@ 026,020 Say " SA1 " OF oGrvTXT PIXEL
DEFINE SBUTTON FROM 070, 030 TYPE 1 ACTION (GravaTXT(),oGrvTXT:End()) ENABLE OF oGrvTXT
DEFINE SBUTTON FROM 070, 070 TYPE 2 ACTION (oGrvTXT:End()) ENABLE OF oGrvTXT
ACTIVATE DIALOG oGrvTXT CENTERED

Return Nil
//+-------------------------------------
//| Verifica a gravação do Arquivo TXT.|
//+-------------------------------------
Static Function GravaTXT
Private cArqTxt := "EXPSA1_Exemplo1.TXT"
Private nHdl := fCreate(cArqTxt)

If nHdl == -1
	MsgAlert("O arquivo de nome "+cArqTxt+" não pode ser gerado! Verifique osparâmetros.","Atenção!")
	Return
Endif

Processa({|| RunCont() },"Processando...")

Return Nil
//+----------------------
//| Cria o arquivo texto|
//+----------------------
Static Function RunCont
Local cLin 	 := ""
Local cAlias := "SA1"
Local lFim	 := .T.

DbSelectArea(cAlias)
(cAlias)->(DbGoTop())

ProcRegua(RecCount())
(cAlias)->(DbGoTop())
While !(cAlias)->(EOF())
	IncProc("Gerando Arquivo")
	cLin := (cAlias)->A1_FILIAL
	cLin += (cAlias)->A1_COD
	cLin += (cAlias)->A1_LOJA
	cLin += (cAlias)->A1_PESSOA
	cLin += (cAlias)->A1_NOME
	cLin += (cAlias)->A1_NREDUZ
	cLin += (cAlias)->A1_END
	cLin += (cAlias)->A1_EST
	cLin += (cAlias)->A1_MUN
	cLin += (cAlias)->A1_BAIRRO
	cLin += (cAlias)->A1_COD_MUN
	cLin += CRLF
	fWrite(nHdl,cLin,Len(cLin))
	(cAlias)->(dbSkip())
EndDo
fClose(nHdl)

If lFim
	MsgInfo("Arquivo Gerado com Sucesso"+CRLF+"Local: "+cArqTxt)
EndIf
Return Nil
