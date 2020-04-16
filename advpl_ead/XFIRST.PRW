#include 'protheus.ch'
#include 'parmtype.ch'

/*/{Protheus.doc} xfirst
//Meu primeiro programa em ADVPL.
@author thi_n
@since 29/01/2019
@version 1.0
@type function
/*/
user function xfirst()
	Local cMsg   := "Mensagem a ser exibida" // Essa variavel é tipo Texto.
	Local cNome  := "Thiago"
	Local cEnd   := "São Paulo"
	Local cTel   := "11981444433"
	Local cEmail := "tnascimento@benefactum.com.br"
	Local cchar  := 'telefonia'
	If !Empty(cNome) .And. !Empty(cEnd) .And. ;
	!Empty(cTel)  .And. ;
	!Empty(cEmail)
		MsgAlert('TRUE')
	endif
	If cchar = 'TELEFONIA'
		MsgAlert('TRUE')
	Else
		MsgAlert('FALSE')
	Endif
Return