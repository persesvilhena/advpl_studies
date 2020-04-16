#include 'Protheus.ch'
user function A010TOK()
    Local lRet := .t.

    IF M->B1_PRV1 <> SB1->B1_PRV1
        Notifica(M->B1_COD, M->B1_DESC, M->B1_PRV1)
    ENDIF

RETURN(lRet)

Static Function Notifica(cCod, cDesc, nPrc)
    Local oProcess := TWFProcess():New("A010TOK", "Envio")
    oProcess:NewTask("Envio", "\WORKFLOW\emp99\MODELOS\ahtml.htm")

    oProcess:cSubject   := "Preco alterado"
    oProcess:cTo        := "persesvilhena@gmail.com"
    oProcess:UserSiga   := __cUserID
    oProcess:NewVersion(.T.)
    oProcess:nEncodeMime := 0

    oProcess:oHtml:ValByName("B1_COD", cCod)
    oProcess:oHtml:ValByName("B1_DESC", cDesc)
    oProcess:oHtml:ValByName("B1_PRV1", CVALTOCHAR( nPrc ))
    oProcess:Start()

    oProcess:Finish()
Return