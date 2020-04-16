#include 'protheus.ch'
#include 'parmtype.ch'

user function xBloco()
	Local bCli  := {||mata030() } //mata030()
	Local bFOR  := {||mata020() } // mata020()

	If AVISO("Cadastros", "Qual cadastro?", { "Cliente","Fornecedor"}, 2) == 1
		Eval(bCli) // chama cliente.
	Else
		Eval(bFor)// Chama fornecedor.
	Endif

return
User Function xBlo2(cTabela) //u_xBlo2('00')
	Local aTabela := {}
	Local bAcao     := {|| aAdd(aTabela,{X5_CHAVE,Capital(X5_DESCRI)})}
	Local bCondicao := {|| X5_TABELA==cTabela}
	DbSelectArea('SX5')
	SX5->(DBSETORDER(1))
	SX5->(DBSEEK(XFILIAL('SX5')+cTabela))

	SX5->( dbEval(bAcao,,bCondicao) )

Return

User Function xBlo3()

	aNomes := {"Roberto","Joao","Ana"} 
	bAcao := {|X,Y| Msginfo(X+" "+CVALTOCHAR(Y)) } 
	aEval(aNomes, bAcao)
	
Return