//Bibliotecas
#Include "Protheus.ch"

User Function zCadPessoa() //U_zCadPessoa()
	Local oPessoa
	Local cNome		    := M->A1_NOME
	Local dNascimento	:= M->A1_DTNASC
	Local cCodCli		:= M->A1_COD
	Local cLojaCli		:= M->A1_LOJA

	//Instanciando o objeto atraves da classe Pessoa
	oPessoa := zPessoa():New(cNome, dNascimento,cCodCli, cLojaCli)
	IF __ReadVar == "M->A1_DTNASC"
		//Chamando um metodo da classe
		oPessoa:MostraIdade()
	Endif

	IF __ReadVar == "M->A1_CEP"
		//Chamando um metodo da classe
		oPessoa:PrazoEntrega(M->A1_CEP)
		M->A1_OBSERV := oPessoa:cEntrega
	Endif

	If lBloque
		Begin Transaction
			For nI := 1 to 10

				oPessoa:BloqueCli()

			Next nI
		End TRANSACTION
	Endif

Return .T.

