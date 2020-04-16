#include 'protheus.ch'
#include 'parmtype.ch'

user function xCap12()

	cTemProc := ""//"Menu: " + CARQMNU + CRLF //Nome do menu
	cTemProc += "Modulo: " + cModulo+ CRLF // Modulo atual
	cTemProc += "Ambiente: " + Getenvserver() + CRLF //Ambiente atual
	cTemProc += "Usuario: " + cUserName + CRLF //Nome Usuario
	cTemProc += "Programa: " + funname() + CRLF //Funcao chamada Menu
	cTemProc += "Tema: " + GetTheme() + CRLF //Tema do usuario
	cTemProc += "Extensao Base Local: " + GetDBExtension() + CRLF //Extensão LocalFiles
	cTemProc += "Tipo Indice: " + OrdBagExt() + CRLF //Extensao de índices
	cTemProc += "Caminho Startpath: " + GetSrvProfString("Startpath","") + CRLF
	cTemProc += "Caminho RootPath:  " + GetSrvProfString("RootPath","")  + CRLF
	cTemProc += "Caminho SourcePath (RPO):  " + GetSrvProfString("SourcePath","") + CRLF

	conout(cTemProc)

	RPOdados()
Return Nil

Static Function RPOdados()

	Local aVar   := {}
	Local aDados :={}
	Local nI
	Local aType, aFile, aLine, aDate,aTime

	aVar := GetFuncArray( "*" , @aType, @aFile, @aLine, @aDate,@aTime )
	For nI := 1 To Len(aVar)
		Aadd( aDados ,GetApoInfo(aFile[nI] ) )
	Next nI

	//1 Nome do arquivo 2 Codigicada em ADVPL 3 Quem Compilou, TOTVS ou Cliente  4 Data da última Modificação.
	For nI := 1 To Len(aDados)
		Conout("****************************************" + CRLF)
		Conout("Nome do arquivo: " + aDados[nI,1] + CRLF )
		Conout("Codigicada em ADVPL: " + aDados[nI,2] + CRLF )
		Conout("Quem Compilou: " + aDados[nI,3] + CRLF )
		Conout("Data da última Modificação: " + dTOs(aDados[nI,4]) + CRLF )
		Conout("****************************************" + CRLF)
	Next nI

Return

