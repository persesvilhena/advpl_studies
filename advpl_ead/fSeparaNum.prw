#include 'protheus.ch'
#include 'parmtype.ch'
//Identifica��o
// Programa para identificar n�meros pares e impares
// Autor: Biale ADVPL e Consultoria em Inform�tica
// Data: 15 de janeiro de 2012

User function fSeparaNum()  //u_fSeparaNum()
	// Inicializa��o
	Local nBI  := 0
	Local _dDt := Date()
	Local cNomeCli := CRIAVAR('A1_NOME',.T.) 
	Private cBIImpares := "" // Vari�vel ser� utilizada para armazerar os n�meros impares
	Private cBIPares   := "" // Vari�vel ser� utilizada para armazerar os n�meros pares
	//Corpo do programa
	//Chr(13) + Chr(10) == CRLF

	For nBI:=1 to 12
		If mod(nBI,2)== 0
			cBIPares   += Alltrim(str(nBI)) + ""
		Else
			cBIImpares += Alltrim(str(nBI)) + ""
		Endif
	Next
	Declara()
	Idade()
	//Encerramento
	ExibeMSG() // FUN��O STATICA OU SEJA SOMENTE PODE SER CHAMADA AQUI NESSE ARQUIVO.
Return // Termina o programa
Static Function Declara()
	Static cComple := ' Teste Declara'
Return

Static Function ExibeMSG()
	Msginfo(cComple + "Pares: " +cBIPares + CRLF +" Impares: " + cBIImpares)  // Exibe em tela o resultado
Return

Static Function Idade()
	Local nIdade := Round( ( DATE() - sTOD('19870922')) / 365 , 0)
	MsgInfo(' Thiago tem ' + cValToChar(nIdade) + ' anos! ')
Return