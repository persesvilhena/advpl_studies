#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'tbiconn.ch'
USER FUNCTION xsch2()
PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'FAT'

DbSelectArea("SE2")
SE2->(DBSETORDER(1))

WHILE SE2->(!eof())
    if SE2->E2_VENCREA >= Date()
        //MSGALERT( SE2->E2_VALOR, )
        cBody := '<html>'
        cBody += '<DIV><SPAN class=610203920-12022004><FONT face=Verdana color=#ff0000 '
        cBody += '<DIV><FONT face=Verdana color=#000080 size=3><SPAN class=216593018-10022004>Nome: Perses<br>Valor: ' + cValToChar(SE2->E2_VALOR)  + '</SPAN></FONT></DIV><p>'
        //cBody += '<DIV><FONT face=Verdana color=#000080 size=3><SPAN class=216593018-10022004>' + aMsg[nInd] + '</SPAN></FONT></DIV><p>'
        cBody += '</html>'
        WFNotifyAdmin( 'tonascimentosistema@gmail.com' , 'Paga eu * -1 ', cBody, {} )

    endif

    SE2->(DBSKIP())
ENDDO

RESET ENVIRONMENT
RETURN .T.