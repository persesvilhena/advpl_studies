#include 'protheus.ch'
User Function xTbutton()
	Local lRet := .F.
	Local lFun := .F.
	Local lGer := .F.
	Local lTrn := .F.
	Local oDlg
	Local oButton

	DEFINE MSDIALOG oDlg FROM 0,0 TO 600,600 TITLE 'Teste TButton' PIXEL
		oFont   := TFont():New('Courier new',,-16,.T.) 
		oButton := tButton():New(090,010,'Fechar',oDlg,{||lRet := .T.,oDlg:End()},100,020,,oFont,,.T.,) 
		oButton1 := tButton():New(120,010,'Limpar',oDlg,{||Limpar()},100,020,,oFont,,.T.,) 
		oButton2 := tButton():New(150,010,'Gerar',oDlg,{||Gerar()},100,020,,oFont,,.T.,)
		oButton3 := tButton():New(180,010,'Trucate',oDlg,{||truncate()},100,020,,oFont,,.T.,) 

	ACTIVATE MSDIALOG oDlg CENTERED

	If lRet
		MsgAlert('executado')
	Endif

	If lFun
		FWMsgRun(,{|| Limpar() },'Aguarde...')
		MSGALERT( 'Fim',  )
	Endif

	If lGer
		FWMsgRun(,{|| Gerar() },'Aguarde...')
		MSGALERT( 'Fim',  )
	Endif

	If lTrn
		FWMsgRun(,{|| truncate() },'Aguarde...')
		MSGALERT( 'Fim',  )
	Endif

Return NIL




Static Function Limpar()
    DbSelectArea('SE2')
    While SE2->(!EOF())

            Public aTitulo := {}
            aTitulo := {;
                { "E2_NUM"      , SE2->E2_NUM       , NIL },;
				}
            excTitu(aTitulo)
        SE2->(Dbskip())
    Enddo
    
    SE2->(DBCLOSEAREA())
Return .t.


//////////////////////
///// GERAR
//////////////

Static Function Gerar()
    Public cCont := '000001'
    DbSelectArea('SA2')
    While SA2->(!EOF())
        if SA2->A2_SALDUP > 0
            Public aTitulo := {}
            aTitulo := {;
                { "E2_PREFIXO"  , "PAG"             , NIL },;
                { "E2_NUM"      , cCont             , NIL },;
                { "E2_TIPO"     , "NF"              , NIL },;
                { "E2_NATUREZ"  , "NDF"             , .F. },;
                { "E2_FORNECE"  , SA2->A2_COD       , NIL },;
                { "E2_EMISSAO"  , CtoD("17/02/2012"), NIL },;
                { "E2_VENCTO"   , CtoD("17/02/2012"), NIL },;
                { "E2_VENCREA"  , CtoD("17/02/2012"), NIL },;
                { "E2_VALOR"    , SA2->A2_SALDUP    , NIL },;
                { "E2_LOJA"     , SA2->A2_LOJA      , NIL }}
            cCont := Soma1(cCont)
            //msgalert(aTitulo[2][2], )
            IncluiTitulo(aTitulo)
        Endif
        SA2->(Dbskip())
    Enddo
    
    SA2->(DBCLOSEAREA())
Return .t.


Static Function IncluiTitulo(aTitulo)
Private lMsHelpAuto := .t. 
Private lMsErroAuto := .f. 
DEFAULT aTitulo := {}
MSExecAuto({|x,y,z| fina050(x,y,z)},aTitulo,,3)	

If lMsErroAuto
    Mostraerro()
ELSE
    CONOUT( "foi", aTitulo[1][2] )
EndIf

Return .t.


Static Function excTitu(aTitulo)
Private lMsHelpAuto := .t. 
Private lMsErroAuto := .f. 
DEFAULT aTitulo := {}
MSExecAuto({|x,y,z| fina050(x,y,z)},aTitulo,,5)	

If lMsErroAuto
    Mostraerro()
ELSE
    CONOUT( "foi", aTitulo[1][2] )
EndIf

Return .t.
/*
Static Function excTitufi(aTitulo)
cQry := " delete from "+RetSqlName('SE2')+" where E2_NUM = '" + aTitulo[1][2] + "' "

//DELETE "+RetSqlName('SA1')+" SET A1_XBRCAR = '1'"
//cQry += " WHERE R_E_C_N_O_ = "+ cValtochar( (cAlias)->A1RECNO )

IF TCSQLEXEC(cQry) < 0
	MsgAlert(TCSQLERROR(), )
else
	//MsgAlert('UPDATE COM SUCESSO', )
ENDIF
Return .t.
*/


Static Function truncate()
Local cQry := ''
cQry := " TRUNCATE TABLE "+RetSqlName('SE2')

IF TCSQLEXEC(cQry) < 0
	MsgAlert(TCSQLERROR(), )
else
	//MsgAlert('UPDATE COM SUCESSO', )
ENDIF
Return .t.



