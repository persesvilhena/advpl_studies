#include "protheus.ch"
#include "TBICONN.ch"
User Function IncMain2()
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01'  MODULO 'FAT'
    /*Public nOPC := 0
    Public aCliente := {}
    nOPC := Val(alltrim(FwInputBox('Digite a opcao', '3,4,5')))
    Do case
    case nOPC = 3
        aCliente:={{"A1_COD" ,GETSXENUM('SA1', 'A1_COD'), Nil},{"A1_FILIAL","  ", Nil},{"A1_LOJA"  ,"01"                      ,Nil},{"A1_NOME"  ,"CLIENTE COMPRA TUDO S.A.",.F.},{"A1_NREDUZ","COMPRA TUDO"             ,.F.},{"A1_TIPO"  ,"F"                       ,.F.},{"A1_END"   ,"RUA DO ROCIO 123"        ,.F.},{"A1_MUN"   ,"SAO PAULO"               ,.F.},{"A1_EST"   ,"SP"                      ,.F.},{"A1_CGC"   ,"12345678909"             ,.F.},{"A1_COND"  ,"001"                     ,.F.}}
    case nOPC = 4
        aCliente:={{"A1_COD"   ,'000034',Nil},{"A1_LOJA"  ,"01"                      ,Nil},{"A1_NOME"  ,"CLIENTE COMPRA TUDO S.A.",Nil}}
    case nOPC = 5
        aCliente:={{"A1_COD"   ,'000023', Nil}}
    endcase
    Private lMsErroAuto := .f.
    MSExecAuto({|x,y| mata030(x,y)},aCliente,nOPC)
    If !lMsErroAuto//Mostraerro()ELSE
        MSGALERT( 'success',  )
    EndIf*/
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
    RESET ENVIRONMENT
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