USER FUNCTION fEnviaMail(cTo, cTitle, aMsg, aFiles )
Local cBody, nInd
//DEFAULT aMsg := {}
//DEFAULT aFiles := {}

cBody := '<html>'
cBody += '<DIV><SPAN class=610203920-12022004><FONT face=Verdana color=#ff0000 '
cBody += 'size=2><STRONG> WorkFlow - TOTVS Protheus - Serviço Envio de Mensagens</STRONG></FONT></SPAN></DIV><hr>'
For nInd := 1 TO Len(aMsg)
	cBody += '<DIV><FONT face=Verdana color=#000080 size=3><SPAN class=216593018-10022004>' + aMsg[nInd] + '</SPAN></FONT></DIV><p>'
Next
cBody += '</html>'

RETURN WFNotifyAdmin( cTo , cTitle, cBody, aFiles )