#INCLUDE "protheus.ch"
#INCLUDE "apwebsrv.ch"

/* ===============================================================================
WSDL Location    http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx?WSDL
Gerado em        03/09/20 19:45:43
Observa��es      C�digo-Fonte gerado por ADVPL WSDL Client 1.120703
                 Altera��es neste arquivo podem causar funcionamento incorreto
                 e ser�o perdidas caso o c�digo-fonte seja gerado novamente.
=============================================================================== */

User Function _ANLRDXI ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSCalcPrecoPrazoWS
------------------------------------------------------------------------------- */

WSCLIENT WSCalcPrecoPrazoWS

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD CalcPrecoPrazo
	WSMETHOD CalcPrecoPrazoData
	WSMETHOD CalcPrecoPrazoRestricao
	WSMETHOD CalcPreco
	WSMETHOD CalcPrecoData
	WSMETHOD CalcPrazo
	WSMETHOD CalcPrazoData
	WSMETHOD CalcPrazoRestricao
	WSMETHOD CalcPrecoFAC
	WSMETHOD CalcDataMaxima
	WSMETHOD ListaServicos
	WSMETHOD ListaServicosSTAR
	WSMETHOD VerificaModal
	WSMETHOD getVersao

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   cnCdEmpresa               AS string
	WSDATA   csDsSenha                 AS string
	WSDATA   cnCdServico               AS string
	WSDATA   csCepOrigem               AS string
	WSDATA   csCepDestino              AS string
	WSDATA   cnVlPeso                  AS string
	WSDATA   nnCdFormato               AS int
	WSDATA   nnVlComprimento           AS decimal
	WSDATA   nnVlAltura                AS decimal
	WSDATA   nnVlLargura               AS decimal
	WSDATA   nnVlDiametro              AS decimal
	WSDATA   csCdMaoPropria            AS string
	WSDATA   nnVlValorDeclarado        AS decimal
	WSDATA   csCdAvisoRecebimento      AS string
	WSDATA   oWSCalcPrecoPrazoResult   AS CalcPrecoPrazoWS_cResultado
	WSDATA   csDtCalculo               AS string
	WSDATA   oWSCalcPrecoPrazoDataResult AS CalcPrecoPrazoWS_cResultado
	WSDATA   oWSCalcPrecoPrazoRestricaoResult AS CalcPrecoPrazoWS_cResultado
	WSDATA   oWSCalcPrecoResult        AS CalcPrecoPrazoWS_cResultado
	WSDATA   oWSCalcPrecoDataResult    AS CalcPrecoPrazoWS_cResultado
	WSDATA   oWSCalcPrazoResult        AS CalcPrecoPrazoWS_cResultado
	WSDATA   oWSCalcPrazoDataResult    AS CalcPrecoPrazoWS_cResultado
	WSDATA   oWSCalcPrazoRestricaoResult AS CalcPrecoPrazoWS_cResultado
	WSDATA   cstrDataCalculo           AS string
	WSDATA   oWSCalcPrecoFACResult     AS CalcPrecoPrazoWS_cResultado
	WSDATA   ccodigoObjeto             AS string
	WSDATA   oWSCalcDataMaximaResult   AS CalcPrecoPrazoWS_cResultadoObjeto
	WSDATA   oWSListaServicosResult    AS CalcPrecoPrazoWS_cResultadoServicos
	WSDATA   oWSListaServicosSTARResult AS CalcPrecoPrazoWS_cResultadoServicos
	WSDATA   oWSVerificaModalResult    AS CalcPrecoPrazoWS_cResultadoModal
	WSDATA   oWSgetVersaoResult        AS CalcPrecoPrazoWS_versao

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSCalcPrecoPrazoWS
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O C�digo-Fonte Client atual requer os execut�veis do Protheus Build [7.00.191205P-20200220] ou superior. Atualize o Protheus ou gere o C�digo-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSCalcPrecoPrazoWS
	::oWSCalcPrecoPrazoResult := CalcPrecoPrazoWS_CRESULTADO():New()
	::oWSCalcPrecoPrazoDataResult := CalcPrecoPrazoWS_CRESULTADO():New()
	::oWSCalcPrecoPrazoRestricaoResult := CalcPrecoPrazoWS_CRESULTADO():New()
	::oWSCalcPrecoResult := CalcPrecoPrazoWS_CRESULTADO():New()
	::oWSCalcPrecoDataResult := CalcPrecoPrazoWS_CRESULTADO():New()
	::oWSCalcPrazoResult := CalcPrecoPrazoWS_CRESULTADO():New()
	::oWSCalcPrazoDataResult := CalcPrecoPrazoWS_CRESULTADO():New()
	::oWSCalcPrazoRestricaoResult := CalcPrecoPrazoWS_CRESULTADO():New()
	::oWSCalcPrecoFACResult := CalcPrecoPrazoWS_CRESULTADO():New()
	::oWSCalcDataMaximaResult := CalcPrecoPrazoWS_CRESULTADOOBJETO():New()
	::oWSListaServicosResult := CalcPrecoPrazoWS_CRESULTADOSERVICOS():New()
	::oWSListaServicosSTARResult := CalcPrecoPrazoWS_CRESULTADOSERVICOS():New()
	::oWSVerificaModalResult := CalcPrecoPrazoWS_CRESULTADOMODAL():New()
	::oWSgetVersaoResult := CalcPrecoPrazoWS_VERSAO():New()
Return

WSMETHOD RESET WSCLIENT WSCalcPrecoPrazoWS
	::cnCdEmpresa        := NIL 
	::csDsSenha          := NIL 
	::cnCdServico        := NIL 
	::csCepOrigem        := NIL 
	::csCepDestino       := NIL 
	::cnVlPeso           := NIL 
	::nnCdFormato        := NIL 
	::nnVlComprimento    := NIL 
	::nnVlAltura         := NIL 
	::nnVlLargura        := NIL 
	::nnVlDiametro       := NIL 
	::csCdMaoPropria     := NIL 
	::nnVlValorDeclarado := NIL 
	::csCdAvisoRecebimento := NIL 
	::oWSCalcPrecoPrazoResult := NIL 
	::csDtCalculo        := NIL 
	::oWSCalcPrecoPrazoDataResult := NIL 
	::oWSCalcPrecoPrazoRestricaoResult := NIL 
	::oWSCalcPrecoResult := NIL 
	::oWSCalcPrecoDataResult := NIL 
	::oWSCalcPrazoResult := NIL 
	::oWSCalcPrazoDataResult := NIL 
	::oWSCalcPrazoRestricaoResult := NIL 
	::cstrDataCalculo    := NIL 
	::oWSCalcPrecoFACResult := NIL 
	::ccodigoObjeto      := NIL 
	::oWSCalcDataMaximaResult := NIL 
	::oWSListaServicosResult := NIL 
	::oWSListaServicosSTARResult := NIL 
	::oWSVerificaModalResult := NIL 
	::oWSgetVersaoResult := NIL 
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSCalcPrecoPrazoWS
Local oClone := WSCalcPrecoPrazoWS():New()
	oClone:_URL          := ::_URL 
	oClone:cnCdEmpresa   := ::cnCdEmpresa
	oClone:csDsSenha     := ::csDsSenha
	oClone:cnCdServico   := ::cnCdServico
	oClone:csCepOrigem   := ::csCepOrigem
	oClone:csCepDestino  := ::csCepDestino
	oClone:cnVlPeso      := ::cnVlPeso
	oClone:nnCdFormato   := ::nnCdFormato
	oClone:nnVlComprimento := ::nnVlComprimento
	oClone:nnVlAltura    := ::nnVlAltura
	oClone:nnVlLargura   := ::nnVlLargura
	oClone:nnVlDiametro  := ::nnVlDiametro
	oClone:csCdMaoPropria := ::csCdMaoPropria
	oClone:nnVlValorDeclarado := ::nnVlValorDeclarado
	oClone:csCdAvisoRecebimento := ::csCdAvisoRecebimento
	oClone:oWSCalcPrecoPrazoResult :=  IIF(::oWSCalcPrecoPrazoResult = NIL , NIL ,::oWSCalcPrecoPrazoResult:Clone() )
	oClone:csDtCalculo   := ::csDtCalculo
	oClone:oWSCalcPrecoPrazoDataResult :=  IIF(::oWSCalcPrecoPrazoDataResult = NIL , NIL ,::oWSCalcPrecoPrazoDataResult:Clone() )
	oClone:oWSCalcPrecoPrazoRestricaoResult :=  IIF(::oWSCalcPrecoPrazoRestricaoResult = NIL , NIL ,::oWSCalcPrecoPrazoRestricaoResult:Clone() )
	oClone:oWSCalcPrecoResult :=  IIF(::oWSCalcPrecoResult = NIL , NIL ,::oWSCalcPrecoResult:Clone() )
	oClone:oWSCalcPrecoDataResult :=  IIF(::oWSCalcPrecoDataResult = NIL , NIL ,::oWSCalcPrecoDataResult:Clone() )
	oClone:oWSCalcPrazoResult :=  IIF(::oWSCalcPrazoResult = NIL , NIL ,::oWSCalcPrazoResult:Clone() )
	oClone:oWSCalcPrazoDataResult :=  IIF(::oWSCalcPrazoDataResult = NIL , NIL ,::oWSCalcPrazoDataResult:Clone() )
	oClone:oWSCalcPrazoRestricaoResult :=  IIF(::oWSCalcPrazoRestricaoResult = NIL , NIL ,::oWSCalcPrazoRestricaoResult:Clone() )
	oClone:cstrDataCalculo := ::cstrDataCalculo
	oClone:oWSCalcPrecoFACResult :=  IIF(::oWSCalcPrecoFACResult = NIL , NIL ,::oWSCalcPrecoFACResult:Clone() )
	oClone:ccodigoObjeto := ::ccodigoObjeto
	oClone:oWSCalcDataMaximaResult :=  IIF(::oWSCalcDataMaximaResult = NIL , NIL ,::oWSCalcDataMaximaResult:Clone() )
	oClone:oWSListaServicosResult :=  IIF(::oWSListaServicosResult = NIL , NIL ,::oWSListaServicosResult:Clone() )
	oClone:oWSListaServicosSTARResult :=  IIF(::oWSListaServicosSTARResult = NIL , NIL ,::oWSListaServicosSTARResult:Clone() )
	oClone:oWSVerificaModalResult :=  IIF(::oWSVerificaModalResult = NIL , NIL ,::oWSVerificaModalResult:Clone() )
	oClone:oWSgetVersaoResult :=  IIF(::oWSgetVersaoResult = NIL , NIL ,::oWSgetVersaoResult:Clone() )
Return oClone

// WSDL Method CalcPrecoPrazo of Service WSCalcPrecoPrazoWS

WSMETHOD CalcPrecoPrazo WSSEND cnCdEmpresa,csDsSenha,cnCdServico,csCepOrigem,csCepDestino,cnVlPeso,nnCdFormato,nnVlComprimento,nnVlAltura,nnVlLargura,nnVlDiametro,csCdMaoPropria,nnVlValorDeclarado,csCdAvisoRecebimento WSRECEIVE oWSCalcPrecoPrazoResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CalcPrecoPrazo xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("nCdEmpresa", ::cnCdEmpresa, cnCdEmpresa , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sDsSenha", ::csDsSenha, csDsSenha , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nCdServico", ::cnCdServico, cnCdServico , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepOrigem", ::csCepOrigem, csCepOrigem , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepDestino", ::csCepDestino, csCepDestino , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlPeso", ::cnVlPeso, cnVlPeso , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nCdFormato", ::nnCdFormato, nnCdFormato , "int", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlComprimento", ::nnVlComprimento, nnVlComprimento , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlAltura", ::nnVlAltura, nnVlAltura , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlLargura", ::nnVlLargura, nnVlLargura , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlDiametro", ::nnVlDiametro, nnVlDiametro , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCdMaoPropria", ::csCdMaoPropria, csCdMaoPropria , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlValorDeclarado", ::nnVlValorDeclarado, nnVlValorDeclarado , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCdAvisoRecebimento", ::csCdAvisoRecebimento, csCdAvisoRecebimento , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</CalcPrecoPrazo>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/CalcPrecoPrazo",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSCalcPrecoPrazoResult:SoapRecv( WSAdvValue( oXmlRet,"_CALCPRECOPRAZORESPONSE:_CALCPRECOPRAZORESULT","cResultado",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CalcPrecoPrazoData of Service WSCalcPrecoPrazoWS

WSMETHOD CalcPrecoPrazoData WSSEND cnCdEmpresa,csDsSenha,cnCdServico,csCepOrigem,csCepDestino,cnVlPeso,nnCdFormato,nnVlComprimento,nnVlAltura,nnVlLargura,nnVlDiametro,csCdMaoPropria,nnVlValorDeclarado,csCdAvisoRecebimento,csDtCalculo WSRECEIVE oWSCalcPrecoPrazoDataResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CalcPrecoPrazoData xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("nCdEmpresa", ::cnCdEmpresa, cnCdEmpresa , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sDsSenha", ::csDsSenha, csDsSenha , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nCdServico", ::cnCdServico, cnCdServico , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepOrigem", ::csCepOrigem, csCepOrigem , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepDestino", ::csCepDestino, csCepDestino , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlPeso", ::cnVlPeso, cnVlPeso , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nCdFormato", ::nnCdFormato, nnCdFormato , "int", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlComprimento", ::nnVlComprimento, nnVlComprimento , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlAltura", ::nnVlAltura, nnVlAltura , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlLargura", ::nnVlLargura, nnVlLargura , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlDiametro", ::nnVlDiametro, nnVlDiametro , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCdMaoPropria", ::csCdMaoPropria, csCdMaoPropria , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlValorDeclarado", ::nnVlValorDeclarado, nnVlValorDeclarado , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCdAvisoRecebimento", ::csCdAvisoRecebimento, csCdAvisoRecebimento , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sDtCalculo", ::csDtCalculo, csDtCalculo , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</CalcPrecoPrazoData>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/CalcPrecoPrazoData",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSCalcPrecoPrazoDataResult:SoapRecv( WSAdvValue( oXmlRet,"_CALCPRECOPRAZODATARESPONSE:_CALCPRECOPRAZODATARESULT","cResultado",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CalcPrecoPrazoRestricao of Service WSCalcPrecoPrazoWS

WSMETHOD CalcPrecoPrazoRestricao WSSEND cnCdEmpresa,csDsSenha,cnCdServico,csCepOrigem,csCepDestino,cnVlPeso,nnCdFormato,nnVlComprimento,nnVlAltura,nnVlLargura,nnVlDiametro,csCdMaoPropria,nnVlValorDeclarado,csCdAvisoRecebimento,csDtCalculo WSRECEIVE oWSCalcPrecoPrazoRestricaoResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CalcPrecoPrazoRestricao xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("nCdEmpresa", ::cnCdEmpresa, cnCdEmpresa , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sDsSenha", ::csDsSenha, csDsSenha , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nCdServico", ::cnCdServico, cnCdServico , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepOrigem", ::csCepOrigem, csCepOrigem , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepDestino", ::csCepDestino, csCepDestino , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlPeso", ::cnVlPeso, cnVlPeso , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nCdFormato", ::nnCdFormato, nnCdFormato , "int", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlComprimento", ::nnVlComprimento, nnVlComprimento , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlAltura", ::nnVlAltura, nnVlAltura , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlLargura", ::nnVlLargura, nnVlLargura , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlDiametro", ::nnVlDiametro, nnVlDiametro , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCdMaoPropria", ::csCdMaoPropria, csCdMaoPropria , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlValorDeclarado", ::nnVlValorDeclarado, nnVlValorDeclarado , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCdAvisoRecebimento", ::csCdAvisoRecebimento, csCdAvisoRecebimento , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sDtCalculo", ::csDtCalculo, csDtCalculo , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</CalcPrecoPrazoRestricao>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/CalcPrecoPrazoRestricao",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSCalcPrecoPrazoRestricaoResult:SoapRecv( WSAdvValue( oXmlRet,"_CALCPRECOPRAZORESTRICAORESPONSE:_CALCPRECOPRAZORESTRICAORESULT","cResultado",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CalcPreco of Service WSCalcPrecoPrazoWS

WSMETHOD CalcPreco WSSEND cnCdEmpresa,csDsSenha,cnCdServico,csCepOrigem,csCepDestino,cnVlPeso,nnCdFormato,nnVlComprimento,nnVlAltura,nnVlLargura,nnVlDiametro,csCdMaoPropria,nnVlValorDeclarado,csCdAvisoRecebimento WSRECEIVE oWSCalcPrecoResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CalcPreco xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("nCdEmpresa", ::cnCdEmpresa, cnCdEmpresa , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sDsSenha", ::csDsSenha, csDsSenha , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nCdServico", ::cnCdServico, cnCdServico , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepOrigem", ::csCepOrigem, csCepOrigem , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepDestino", ::csCepDestino, csCepDestino , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlPeso", ::cnVlPeso, cnVlPeso , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nCdFormato", ::nnCdFormato, nnCdFormato , "int", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlComprimento", ::nnVlComprimento, nnVlComprimento , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlAltura", ::nnVlAltura, nnVlAltura , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlLargura", ::nnVlLargura, nnVlLargura , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlDiametro", ::nnVlDiametro, nnVlDiametro , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCdMaoPropria", ::csCdMaoPropria, csCdMaoPropria , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlValorDeclarado", ::nnVlValorDeclarado, nnVlValorDeclarado , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCdAvisoRecebimento", ::csCdAvisoRecebimento, csCdAvisoRecebimento , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</CalcPreco>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/CalcPreco",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSCalcPrecoResult:SoapRecv( WSAdvValue( oXmlRet,"_CALCPRECORESPONSE:_CALCPRECORESULT","cResultado",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CalcPrecoData of Service WSCalcPrecoPrazoWS

WSMETHOD CalcPrecoData WSSEND cnCdEmpresa,csDsSenha,cnCdServico,csCepOrigem,csCepDestino,cnVlPeso,nnCdFormato,nnVlComprimento,nnVlAltura,nnVlLargura,nnVlDiametro,csCdMaoPropria,nnVlValorDeclarado,csCdAvisoRecebimento,csDtCalculo WSRECEIVE oWSCalcPrecoDataResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CalcPrecoData xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("nCdEmpresa", ::cnCdEmpresa, cnCdEmpresa , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sDsSenha", ::csDsSenha, csDsSenha , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nCdServico", ::cnCdServico, cnCdServico , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepOrigem", ::csCepOrigem, csCepOrigem , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepDestino", ::csCepDestino, csCepDestino , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlPeso", ::cnVlPeso, cnVlPeso , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nCdFormato", ::nnCdFormato, nnCdFormato , "int", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlComprimento", ::nnVlComprimento, nnVlComprimento , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlAltura", ::nnVlAltura, nnVlAltura , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlLargura", ::nnVlLargura, nnVlLargura , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlDiametro", ::nnVlDiametro, nnVlDiametro , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCdMaoPropria", ::csCdMaoPropria, csCdMaoPropria , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlValorDeclarado", ::nnVlValorDeclarado, nnVlValorDeclarado , "decimal", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCdAvisoRecebimento", ::csCdAvisoRecebimento, csCdAvisoRecebimento , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sDtCalculo", ::csDtCalculo, csDtCalculo , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</CalcPrecoData>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/CalcPrecoData",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSCalcPrecoDataResult:SoapRecv( WSAdvValue( oXmlRet,"_CALCPRECODATARESPONSE:_CALCPRECODATARESULT","cResultado",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CalcPrazo of Service WSCalcPrecoPrazoWS

WSMETHOD CalcPrazo WSSEND cnCdServico,csCepOrigem,csCepDestino WSRECEIVE oWSCalcPrazoResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CalcPrazo xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("nCdServico", ::cnCdServico, cnCdServico , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepOrigem", ::csCepOrigem, csCepOrigem , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepDestino", ::csCepDestino, csCepDestino , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</CalcPrazo>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/CalcPrazo",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSCalcPrazoResult:SoapRecv( WSAdvValue( oXmlRet,"_CALCPRAZORESPONSE:_CALCPRAZORESULT","cResultado",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CalcPrazoData of Service WSCalcPrecoPrazoWS

WSMETHOD CalcPrazoData WSSEND cnCdServico,csCepOrigem,csCepDestino,csDtCalculo WSRECEIVE oWSCalcPrazoDataResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CalcPrazoData xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("nCdServico", ::cnCdServico, cnCdServico , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepOrigem", ::csCepOrigem, csCepOrigem , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepDestino", ::csCepDestino, csCepDestino , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sDtCalculo", ::csDtCalculo, csDtCalculo , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</CalcPrazoData>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/CalcPrazoData",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSCalcPrazoDataResult:SoapRecv( WSAdvValue( oXmlRet,"_CALCPRAZODATARESPONSE:_CALCPRAZODATARESULT","cResultado",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CalcPrazoRestricao of Service WSCalcPrecoPrazoWS

WSMETHOD CalcPrazoRestricao WSSEND cnCdServico,csCepOrigem,csCepDestino,csDtCalculo WSRECEIVE oWSCalcPrazoRestricaoResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CalcPrazoRestricao xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("nCdServico", ::cnCdServico, cnCdServico , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepOrigem", ::csCepOrigem, csCepOrigem , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepDestino", ::csCepDestino, csCepDestino , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sDtCalculo", ::csDtCalculo, csDtCalculo , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</CalcPrazoRestricao>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/CalcPrazoRestricao",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSCalcPrazoRestricaoResult:SoapRecv( WSAdvValue( oXmlRet,"_CALCPRAZORESTRICAORESPONSE:_CALCPRAZORESTRICAORESULT","cResultado",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CalcPrecoFAC of Service WSCalcPrecoPrazoWS

WSMETHOD CalcPrecoFAC WSSEND cnCdServico,cnVlPeso,cstrDataCalculo WSRECEIVE oWSCalcPrecoFACResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CalcPrecoFAC xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("nCdServico", ::cnCdServico, cnCdServico , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("nVlPeso", ::cnVlPeso, cnVlPeso , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("strDataCalculo", ::cstrDataCalculo, cstrDataCalculo , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</CalcPrecoFAC>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/CalcPrecoFAC",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSCalcPrecoFACResult:SoapRecv( WSAdvValue( oXmlRet,"_CALCPRECOFACRESPONSE:_CALCPRECOFACRESULT","cResultado",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method CalcDataMaxima of Service WSCalcPrecoPrazoWS

WSMETHOD CalcDataMaxima WSSEND ccodigoObjeto WSRECEIVE oWSCalcDataMaximaResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<CalcDataMaxima xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("codigoObjeto", ::ccodigoObjeto, ccodigoObjeto , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</CalcDataMaxima>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/CalcDataMaxima",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSCalcDataMaximaResult:SoapRecv( WSAdvValue( oXmlRet,"_CALCDATAMAXIMARESPONSE:_CALCDATAMAXIMARESULT","cResultadoObjeto",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ListaServicos of Service WSCalcPrecoPrazoWS

WSMETHOD ListaServicos WSSEND NULLPARAM WSRECEIVE oWSListaServicosResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ListaServicos xmlns="http://tempuri.org/">'
cSoap += "</ListaServicos>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/ListaServicos",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSListaServicosResult:SoapRecv( WSAdvValue( oXmlRet,"_LISTASERVICOSRESPONSE:_LISTASERVICOSRESULT","cResultadoServicos",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ListaServicosSTAR of Service WSCalcPrecoPrazoWS

WSMETHOD ListaServicosSTAR WSSEND NULLPARAM WSRECEIVE oWSListaServicosSTARResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ListaServicosSTAR xmlns="http://tempuri.org/">'
cSoap += "</ListaServicosSTAR>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/ListaServicosSTAR",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSListaServicosSTARResult:SoapRecv( WSAdvValue( oXmlRet,"_LISTASERVICOSSTARRESPONSE:_LISTASERVICOSSTARRESULT","cResultadoServicos",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VerificaModal of Service WSCalcPrecoPrazoWS

WSMETHOD VerificaModal WSSEND cnCdServico,csCepOrigem,csCepDestino WSRECEIVE oWSVerificaModalResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VerificaModal xmlns="http://tempuri.org/">'
cSoap += WSSoapValue("nCdServico", ::cnCdServico, cnCdServico , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepOrigem", ::csCepOrigem, csCepOrigem , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("sCepDestino", ::csCepDestino, csCepDestino , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</VerificaModal>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/VerificaModal",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSVerificaModalResult:SoapRecv( WSAdvValue( oXmlRet,"_VERIFICAMODALRESPONSE:_VERIFICAMODALRESULT","cResultadoModal",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method getVersao of Service WSCalcPrecoPrazoWS

WSMETHOD getVersao WSSEND NULLPARAM WSRECEIVE oWSgetVersaoResult WSCLIENT WSCalcPrecoPrazoWS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<getVersao xmlns="http://tempuri.org/">'
cSoap += "</getVersao>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://tempuri.org/getVersao",; 
	"DOCUMENT","http://tempuri.org/",,,; 
	"http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx")

::Init()
::oWSgetVersaoResult:SoapRecv( WSAdvValue( oXmlRet,"_GETVERSAORESPONSE:_GETVERSAORESULT","versao",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure cResultado

WSSTRUCT CalcPrecoPrazoWS_cResultado
	WSDATA   oWSServicos               AS CalcPrecoPrazoWS_ArrayOfCServico OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CalcPrecoPrazoWS_cResultado
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CalcPrecoPrazoWS_cResultado
Return

WSMETHOD CLONE WSCLIENT CalcPrecoPrazoWS_cResultado
	Local oClone := CalcPrecoPrazoWS_cResultado():NEW()
	oClone:oWSServicos          := IIF(::oWSServicos = NIL , NIL , ::oWSServicos:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CalcPrecoPrazoWS_cResultado
	Local oNode1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_SERVICOS","ArrayOfCServico",NIL,NIL,NIL,"O",NIL,NIL) 
	If oNode1 != NIL
		::oWSServicos := CalcPrecoPrazoWS_ArrayOfCServico():New()
		::oWSServicos:SoapRecv(oNode1)
	EndIf
Return

// WSDL Data Structure cResultadoObjeto

WSSTRUCT CalcPrecoPrazoWS_cResultadoObjeto
	WSDATA   oWSObjetos                AS CalcPrecoPrazoWS_ArrayOfCObjeto OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CalcPrecoPrazoWS_cResultadoObjeto
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CalcPrecoPrazoWS_cResultadoObjeto
Return

WSMETHOD CLONE WSCLIENT CalcPrecoPrazoWS_cResultadoObjeto
	Local oClone := CalcPrecoPrazoWS_cResultadoObjeto():NEW()
	oClone:oWSObjetos           := IIF(::oWSObjetos = NIL , NIL , ::oWSObjetos:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CalcPrecoPrazoWS_cResultadoObjeto
	Local oNode1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_OBJETOS","ArrayOfCObjeto",NIL,NIL,NIL,"O",NIL,NIL) 
	If oNode1 != NIL
		::oWSObjetos := CalcPrecoPrazoWS_ArrayOfCObjeto():New()
		::oWSObjetos:SoapRecv(oNode1)
	EndIf
Return

// WSDL Data Structure cResultadoServicos

WSSTRUCT CalcPrecoPrazoWS_cResultadoServicos
	WSDATA   oWSServicosCalculo        AS CalcPrecoPrazoWS_ArrayOfCServicosCalculo OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CalcPrecoPrazoWS_cResultadoServicos
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CalcPrecoPrazoWS_cResultadoServicos
Return

WSMETHOD CLONE WSCLIENT CalcPrecoPrazoWS_cResultadoServicos
	Local oClone := CalcPrecoPrazoWS_cResultadoServicos():NEW()
	oClone:oWSServicosCalculo   := IIF(::oWSServicosCalculo = NIL , NIL , ::oWSServicosCalculo:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CalcPrecoPrazoWS_cResultadoServicos
	Local oNode1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_SERVICOSCALCULO","ArrayOfCServicosCalculo",NIL,NIL,NIL,"O",NIL,NIL) 
	If oNode1 != NIL
		::oWSServicosCalculo := CalcPrecoPrazoWS_ArrayOfCServicosCalculo():New()
		::oWSServicosCalculo:SoapRecv(oNode1)
	EndIf
Return

// WSDL Data Structure cResultadoModal

WSSTRUCT CalcPrecoPrazoWS_cResultadoModal
	WSDATA   oWSServicosModal          AS CalcPrecoPrazoWS_ArrayOfCModal OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CalcPrecoPrazoWS_cResultadoModal
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CalcPrecoPrazoWS_cResultadoModal
Return

WSMETHOD CLONE WSCLIENT CalcPrecoPrazoWS_cResultadoModal
	Local oClone := CalcPrecoPrazoWS_cResultadoModal():NEW()
	oClone:oWSServicosModal     := IIF(::oWSServicosModal = NIL , NIL , ::oWSServicosModal:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CalcPrecoPrazoWS_cResultadoModal
	Local oNode1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_SERVICOSMODAL","ArrayOfCModal",NIL,NIL,NIL,"O",NIL,NIL) 
	If oNode1 != NIL
		::oWSServicosModal := CalcPrecoPrazoWS_ArrayOfCModal():New()
		::oWSServicosModal:SoapRecv(oNode1)
	EndIf
Return

// WSDL Data Structure versao

WSSTRUCT CalcPrecoPrazoWS_versao
	WSDATA   cversaoAtual              AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CalcPrecoPrazoWS_versao
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CalcPrecoPrazoWS_versao
Return

WSMETHOD CLONE WSCLIENT CalcPrecoPrazoWS_versao
	Local oClone := CalcPrecoPrazoWS_versao():NEW()
	oClone:cversaoAtual         := ::cversaoAtual
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CalcPrecoPrazoWS_versao
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cversaoAtual       :=  WSAdvValue( oResponse,"_VERSAOATUAL","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure ArrayOfCServico

WSSTRUCT CalcPrecoPrazoWS_ArrayOfCServico
	WSDATA   oWScServico               AS CalcPrecoPrazoWS_cServico OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CalcPrecoPrazoWS_ArrayOfCServico
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CalcPrecoPrazoWS_ArrayOfCServico
	::oWScServico          := {} // Array Of  CalcPrecoPrazoWS_CSERVICO():New()
Return

WSMETHOD CLONE WSCLIENT CalcPrecoPrazoWS_ArrayOfCServico
	Local oClone := CalcPrecoPrazoWS_ArrayOfCServico():NEW()
	oClone:oWScServico := NIL
	If ::oWScServico <> NIL 
		oClone:oWScServico := {}
		aEval( ::oWScServico , { |x| aadd( oClone:oWScServico , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CalcPrecoPrazoWS_ArrayOfCServico
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_CSERVICO","cServico",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWScServico , CalcPrecoPrazoWS_cServico():New() )
			::oWScServico[len(::oWScServico)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfCObjeto

WSSTRUCT CalcPrecoPrazoWS_ArrayOfCObjeto
	WSDATA   oWScObjeto                AS CalcPrecoPrazoWS_cObjeto OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CalcPrecoPrazoWS_ArrayOfCObjeto
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CalcPrecoPrazoWS_ArrayOfCObjeto
	::oWScObjeto           := {} // Array Of  CalcPrecoPrazoWS_COBJETO():New()
Return

WSMETHOD CLONE WSCLIENT CalcPrecoPrazoWS_ArrayOfCObjeto
	Local oClone := CalcPrecoPrazoWS_ArrayOfCObjeto():NEW()
	oClone:oWScObjeto := NIL
	If ::oWScObjeto <> NIL 
		oClone:oWScObjeto := {}
		aEval( ::oWScObjeto , { |x| aadd( oClone:oWScObjeto , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CalcPrecoPrazoWS_ArrayOfCObjeto
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_COBJETO","cObjeto",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWScObjeto , CalcPrecoPrazoWS_cObjeto():New() )
			::oWScObjeto[len(::oWScObjeto)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfCServicosCalculo

WSSTRUCT CalcPrecoPrazoWS_ArrayOfCServicosCalculo
	WSDATA   oWScServicosCalculo       AS CalcPrecoPrazoWS_cServicosCalculo OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CalcPrecoPrazoWS_ArrayOfCServicosCalculo
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CalcPrecoPrazoWS_ArrayOfCServicosCalculo
	::oWScServicosCalculo  := {} // Array Of  CalcPrecoPrazoWS_CSERVICOSCALCULO():New()
Return

WSMETHOD CLONE WSCLIENT CalcPrecoPrazoWS_ArrayOfCServicosCalculo
	Local oClone := CalcPrecoPrazoWS_ArrayOfCServicosCalculo():NEW()
	oClone:oWScServicosCalculo := NIL
	If ::oWScServicosCalculo <> NIL 
		oClone:oWScServicosCalculo := {}
		aEval( ::oWScServicosCalculo , { |x| aadd( oClone:oWScServicosCalculo , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CalcPrecoPrazoWS_ArrayOfCServicosCalculo
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_CSERVICOSCALCULO","cServicosCalculo",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWScServicosCalculo , CalcPrecoPrazoWS_cServicosCalculo():New() )
			::oWScServicosCalculo[len(::oWScServicosCalculo)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ArrayOfCModal

WSSTRUCT CalcPrecoPrazoWS_ArrayOfCModal
	WSDATA   oWScModal                 AS CalcPrecoPrazoWS_cModal OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CalcPrecoPrazoWS_ArrayOfCModal
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CalcPrecoPrazoWS_ArrayOfCModal
	::oWScModal            := {} // Array Of  CalcPrecoPrazoWS_CMODAL():New()
Return

WSMETHOD CLONE WSCLIENT CalcPrecoPrazoWS_ArrayOfCModal
	Local oClone := CalcPrecoPrazoWS_ArrayOfCModal():NEW()
	oClone:oWScModal := NIL
	If ::oWScModal <> NIL 
		oClone:oWScModal := {}
		aEval( ::oWScModal , { |x| aadd( oClone:oWScModal , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CalcPrecoPrazoWS_ArrayOfCModal
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_CMODAL","cModal",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWScModal , CalcPrecoPrazoWS_cModal():New() )
			::oWScModal[len(::oWScModal)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure cServico

WSSTRUCT CalcPrecoPrazoWS_cServico
	WSDATA   nCodigo                   AS int
	WSDATA   cValor                    AS string OPTIONAL
	WSDATA   cPrazoEntrega             AS string OPTIONAL
	WSDATA   cValorMaoPropria          AS string OPTIONAL
	WSDATA   cValorAvisoRecebimento    AS string OPTIONAL
	WSDATA   cValorValorDeclarado      AS string OPTIONAL
	WSDATA   cEntregaDomiciliar        AS string OPTIONAL
	WSDATA   cEntregaSabado            AS string OPTIONAL
	WSDATA   cErro                     AS string OPTIONAL
	WSDATA   cMsgErro                  AS string OPTIONAL
	WSDATA   cValorSemAdicionais       AS string OPTIONAL
	WSDATA   cobsFim                   AS string OPTIONAL
	WSDATA   cDataMaxEntrega           AS string OPTIONAL
	WSDATA   cHoraMaxEntrega           AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CalcPrecoPrazoWS_cServico
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CalcPrecoPrazoWS_cServico
Return

WSMETHOD CLONE WSCLIENT CalcPrecoPrazoWS_cServico
	Local oClone := CalcPrecoPrazoWS_cServico():NEW()
	oClone:nCodigo              := ::nCodigo
	oClone:cValor               := ::cValor
	oClone:cPrazoEntrega        := ::cPrazoEntrega
	oClone:cValorMaoPropria     := ::cValorMaoPropria
	oClone:cValorAvisoRecebimento := ::cValorAvisoRecebimento
	oClone:cValorValorDeclarado := ::cValorValorDeclarado
	oClone:cEntregaDomiciliar   := ::cEntregaDomiciliar
	oClone:cEntregaSabado       := ::cEntregaSabado
	oClone:cErro                := ::cErro
	oClone:cMsgErro             := ::cMsgErro
	oClone:cValorSemAdicionais  := ::cValorSemAdicionais
	oClone:cobsFim              := ::cobsFim
	oClone:cDataMaxEntrega      := ::cDataMaxEntrega
	oClone:cHoraMaxEntrega      := ::cHoraMaxEntrega
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CalcPrecoPrazoWS_cServico
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nCodigo            :=  WSAdvValue( oResponse,"_CODIGO","int",NIL,"Property nCodigo as s:int on SOAP Response not found.",NIL,"N",NIL,NIL) 
	::cValor             :=  WSAdvValue( oResponse,"_VALOR","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cPrazoEntrega      :=  WSAdvValue( oResponse,"_PRAZOENTREGA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cValorMaoPropria   :=  WSAdvValue( oResponse,"_VALORMAOPROPRIA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cValorAvisoRecebimento :=  WSAdvValue( oResponse,"_VALORAVISORECEBIMENTO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cValorValorDeclarado :=  WSAdvValue( oResponse,"_VALORVALORDECLARADO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cEntregaDomiciliar :=  WSAdvValue( oResponse,"_ENTREGADOMICILIAR","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cEntregaSabado     :=  WSAdvValue( oResponse,"_ENTREGASABADO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cErro              :=  WSAdvValue( oResponse,"_ERRO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cMsgErro           :=  WSAdvValue( oResponse,"_MSGERRO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cValorSemAdicionais :=  WSAdvValue( oResponse,"_VALORSEMADICIONAIS","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cobsFim            :=  WSAdvValue( oResponse,"_OBSFIM","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cDataMaxEntrega    :=  WSAdvValue( oResponse,"_DATAMAXENTREGA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cHoraMaxEntrega    :=  WSAdvValue( oResponse,"_HORAMAXENTREGA","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure cObjeto

WSSTRUCT CalcPrecoPrazoWS_cObjeto
	WSDATA   ccodigo                   AS string OPTIONAL
	WSDATA   cservico                  AS string OPTIONAL
	WSDATA   ccepOrigem                AS string OPTIONAL
	WSDATA   ccepDestino               AS string OPTIONAL
	WSDATA   nprazoEntrega             AS int
	WSDATA   cdataPostagem             AS string OPTIONAL
	WSDATA   cdataPostagemCalculo      AS string OPTIONAL
	WSDATA   cdataMaxEntrega           AS string OPTIONAL
	WSDATA   cpostagemDH               AS string OPTIONAL
	WSDATA   cdataUltimoEvento         AS string OPTIONAL
	WSDATA   ccodigoUltimoEvento       AS string OPTIONAL
	WSDATA   ctipoUltimoEvento         AS string OPTIONAL
	WSDATA   cdescricaoUltimoEvento    AS string OPTIONAL
	WSDATA   cerro                     AS string OPTIONAL
	WSDATA   cmsgErro                  AS string OPTIONAL
	WSDATA   cnuTicket                 AS string OPTIONAL
	WSDATA   cformaPagamento           AS string OPTIONAL
	WSDATA   cvalorPagamento           AS string OPTIONAL
	WSDATA   cnuContrato               AS string OPTIONAL
	WSDATA   cnuCartaoPostagem         AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CalcPrecoPrazoWS_cObjeto
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CalcPrecoPrazoWS_cObjeto
Return

WSMETHOD CLONE WSCLIENT CalcPrecoPrazoWS_cObjeto
	Local oClone := CalcPrecoPrazoWS_cObjeto():NEW()
	oClone:ccodigo              := ::ccodigo
	oClone:cservico             := ::cservico
	oClone:ccepOrigem           := ::ccepOrigem
	oClone:ccepDestino          := ::ccepDestino
	oClone:nprazoEntrega        := ::nprazoEntrega
	oClone:cdataPostagem        := ::cdataPostagem
	oClone:cdataPostagemCalculo := ::cdataPostagemCalculo
	oClone:cdataMaxEntrega      := ::cdataMaxEntrega
	oClone:cpostagemDH          := ::cpostagemDH
	oClone:cdataUltimoEvento    := ::cdataUltimoEvento
	oClone:ccodigoUltimoEvento  := ::ccodigoUltimoEvento
	oClone:ctipoUltimoEvento    := ::ctipoUltimoEvento
	oClone:cdescricaoUltimoEvento := ::cdescricaoUltimoEvento
	oClone:cerro                := ::cerro
	oClone:cmsgErro             := ::cmsgErro
	oClone:cnuTicket            := ::cnuTicket
	oClone:cformaPagamento      := ::cformaPagamento
	oClone:cvalorPagamento      := ::cvalorPagamento
	oClone:cnuContrato          := ::cnuContrato
	oClone:cnuCartaoPostagem    := ::cnuCartaoPostagem
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CalcPrecoPrazoWS_cObjeto
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::ccodigo            :=  WSAdvValue( oResponse,"_CODIGO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cservico           :=  WSAdvValue( oResponse,"_SERVICO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::ccepOrigem         :=  WSAdvValue( oResponse,"_CEPORIGEM","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::ccepDestino        :=  WSAdvValue( oResponse,"_CEPDESTINO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::nprazoEntrega      :=  WSAdvValue( oResponse,"_PRAZOENTREGA","int",NIL,"Property nprazoEntrega as s:int on SOAP Response not found.",NIL,"N",NIL,NIL) 
	::cdataPostagem      :=  WSAdvValue( oResponse,"_DATAPOSTAGEM","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cdataPostagemCalculo :=  WSAdvValue( oResponse,"_DATAPOSTAGEMCALCULO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cdataMaxEntrega    :=  WSAdvValue( oResponse,"_DATAMAXENTREGA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cpostagemDH        :=  WSAdvValue( oResponse,"_POSTAGEMDH","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cdataUltimoEvento  :=  WSAdvValue( oResponse,"_DATAULTIMOEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::ccodigoUltimoEvento :=  WSAdvValue( oResponse,"_CODIGOULTIMOEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::ctipoUltimoEvento  :=  WSAdvValue( oResponse,"_TIPOULTIMOEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cdescricaoUltimoEvento :=  WSAdvValue( oResponse,"_DESCRICAOULTIMOEVENTO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cerro              :=  WSAdvValue( oResponse,"_ERRO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cmsgErro           :=  WSAdvValue( oResponse,"_MSGERRO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cnuTicket          :=  WSAdvValue( oResponse,"_NUTICKET","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cformaPagamento    :=  WSAdvValue( oResponse,"_FORMAPAGAMENTO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cvalorPagamento    :=  WSAdvValue( oResponse,"_VALORPAGAMENTO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cnuContrato        :=  WSAdvValue( oResponse,"_NUCONTRATO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cnuCartaoPostagem  :=  WSAdvValue( oResponse,"_NUCARTAOPOSTAGEM","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure cServicosCalculo

WSSTRUCT CalcPrecoPrazoWS_cServicosCalculo
	WSDATA   ccodigo                   AS string OPTIONAL
	WSDATA   cdescricao                AS string OPTIONAL
	WSDATA   ccalcula_preco            AS string OPTIONAL
	WSDATA   ccalcula_prazo            AS string OPTIONAL
	WSDATA   cerro                     AS string OPTIONAL
	WSDATA   cmsgErro                  AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CalcPrecoPrazoWS_cServicosCalculo
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CalcPrecoPrazoWS_cServicosCalculo
Return

WSMETHOD CLONE WSCLIENT CalcPrecoPrazoWS_cServicosCalculo
	Local oClone := CalcPrecoPrazoWS_cServicosCalculo():NEW()
	oClone:ccodigo              := ::ccodigo
	oClone:cdescricao           := ::cdescricao
	oClone:ccalcula_preco       := ::ccalcula_preco
	oClone:ccalcula_prazo       := ::ccalcula_prazo
	oClone:cerro                := ::cerro
	oClone:cmsgErro             := ::cmsgErro
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CalcPrecoPrazoWS_cServicosCalculo
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::ccodigo            :=  WSAdvValue( oResponse,"_CODIGO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cdescricao         :=  WSAdvValue( oResponse,"_DESCRICAO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::ccalcula_preco     :=  WSAdvValue( oResponse,"_CALCULA_PRECO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::ccalcula_prazo     :=  WSAdvValue( oResponse,"_CALCULA_PRAZO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cerro              :=  WSAdvValue( oResponse,"_ERRO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cmsgErro           :=  WSAdvValue( oResponse,"_MSGERRO","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure cModal

WSSTRUCT CalcPrecoPrazoWS_cModal
	WSDATA   ccodigo                   AS string OPTIONAL
	WSDATA   cmodal                    AS string OPTIONAL
	WSDATA   cobs                      AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CalcPrecoPrazoWS_cModal
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CalcPrecoPrazoWS_cModal
Return

WSMETHOD CLONE WSCLIENT CalcPrecoPrazoWS_cModal
	Local oClone := CalcPrecoPrazoWS_cModal():NEW()
	oClone:ccodigo              := ::ccodigo
	oClone:cmodal               := ::cmodal
	oClone:cobs                 := ::cobs
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CalcPrecoPrazoWS_cModal
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::ccodigo            :=  WSAdvValue( oResponse,"_CODIGO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cmodal             :=  WSAdvValue( oResponse,"_MODAL","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cobs               :=  WSAdvValue( oResponse,"_OBS","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return


