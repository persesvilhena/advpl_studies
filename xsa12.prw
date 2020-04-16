#include "protheus.ch"
#include "TBICONN.ch"
User Function IncMain()
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01'  MODULO 'FAT'
    Public nOPC := 0
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
    EndIf
    RESET ENVIRONMENT
Return .t.