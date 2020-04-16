#include 'protheus.ch'
#include 'parmtype.ch'

user function xOperadores()

	Local cOper := '10' + '15' // ALFANUMERICO
	Local nOPer :=  10  +  15  // NUMERICO
	Local cNome := 'THIAGO '

	//MsgAlert("Concatenação: " + cOPER + " Soma: " + cValTochar(nOPER))

	If cNome = 'THIAGO' .OR. nOPer = 40
		Alert('TRUE')
	Else
		Alert('false')
	Endif

return

User Function xFunP()
	Local cNUM := '10,23'
	Local nNum := Val( StrTran(cNUM, ',', '.'))
	//cVar := PADC( cConteudo,  nCount, cConteudo )
	cTexto  := "Parede"
	cVar1   := Padc(cTexto,14) + CRLF       // Retorna o conteúdo “    Parede    ”
	cVar2   := Padc(cTexto,14,"#")   + CRLF // Retorna o conteúdo “####Parede####”
	cVar1   += Padr(cTexto,14)       + CRLF  // Retorna o conteúdo “    Parede    ”
	cVar2   += Padr(cTexto,14,"#")   + CRLF// Retorna o conteúdo “####Parede####”
	cVar1   += Padl(cTexto,14)       + CRLF// Retorna o conteúdo “    Parede    ”
	cVar2   += Padl(cTexto,14,"#")   + CRLF// Retorna o conteúdo “####Parede####”
	//cVar2   += aVkey(cTexto, 'A1_NOME')
	nVar  := 1500
	cVal   := Transform(nVar, '@E 99,999.99')  // Resultado “  1.500,00”

	cVar  := '13817710805'
	cCPF := Transform(cVar, '@R 999.999.999-99')
	nAviso := 0
	cMes := MESEXTENSO( DATE() )

	//MsgInfo(cMes)
	//MsgInfo(cCPF)

	If MsgYesNo("Alert sim! aviso Não")
		Alert('ok')
	Else
		nAviso := Aviso('teste','texto aqui', {'ok','n','s'},3,'subtitulo')

		If nAviso == 1
			Alert('ok')
		Elseif nAviso == 2
			Alert('n')
		Elseif nAviso == 3
		    Alert('s')
		Endif
	Endif
Return
