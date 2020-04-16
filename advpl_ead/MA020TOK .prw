#include 'protheus.ch'
#include 'parmtype.ch'

user function MA020TOK()
	Local lRet := .t.
	
	If Empty(M->A2_SIMPNAC) .And. M->A2_TIPO == 'J'
		lRet := .f.
		MsgInfo("Optante Simples Nacional Obrigatorio.")
	Endif

RETURN(lRet)