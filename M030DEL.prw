#include "protheus.ch"

USER Function M030DEL()

    Local lRet := .f.

    IF MSGYESNO('Deseja realmente excluir?',)
        lRet := .t.
    ENDIF
    
Return (lRet)