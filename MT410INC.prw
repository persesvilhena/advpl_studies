#include 'Protheus.ch'

User Function MT410INC()


	Local cMsg  := ""
    Local cEmail      := ""
    Local aAreaSA1 := SA1->(GetArea())

    SA1->(DBSETORDER( 1 ))
    SA1->(Dbseek(xFilial('SA1')+M->C5_CLIENTE))
    cEmail := SA1->A1_EMAIL
    cMsg := M->C5_MENNOTA
   
    u_fEnviaMail(alltrim(cEmail), 'Email', {cMsg}, {})


    RESTAREA(aAreaSA1)

Return