#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'tbiconn.ch'
USER FUNCTION xsch()
PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'FAT'
cBody := '<html>'
cBody += '<DIV><SPAN class=610203920-12022004><FONT face=Verdana color=#ff0000 '
cBody += '<DIV><FONT face=Verdana color=#000080 size=3><SPAN class=216593018-10022004>Hoje é dia: ' + DTOC(DATE())  + ' e são: ' + Time() + '</SPAN></FONT></DIV><p>'
cBody += '</html>'
WFNotifyAdmin( 'persesvilhena@gmail.com' , 'Refresh do servidor', cBody, {} )
RESET ENVIRONMENT
RETURN .T.