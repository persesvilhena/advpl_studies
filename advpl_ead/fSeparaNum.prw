#include 'protheus.ch'
#include 'parmtype.ch'
//Identificação
// Programa para identificar números pares e impares
// Autor: Biale ADVPL e Consultoria em Informática
// Data: 15 de janeiro de 2012

User function fSeparaNum()  //u_fSeparaNum()
	// Inicialização
	Local nBI  := 0
	Local _dDt := Date()
	Local cNomeCli := CRIAVAR('A1_NOME',.T.) 
	Private cBIImpares := "" // Variável será utilizada para armazerar os números impares
	Private cBIPares   := "" // Variável será utilizada para armazerar os números pares
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
	ExibeMSG() // FUNÇÃO STATICA OU SEJA SOMENTE PODE SER CHAMADA AQUI NESSE ARQUIVO.
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