#include "protheus.ch"
#include "TBICONN.ch"

User Function IncSA1()
PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01'  MODULO 'FAT'
    //ChamaAut(aCliente, 3)
    //ChamaAut(aCliente, 4)
    Public aCliente := {}
    aCliente:={{"A1_COD"   ,'000041', Nil}}
    ChamaAut(aCliente, , 5, , )

    /*ChamaAut(aCliente, NIL, nopc, nil, nil)
    ChamaAut(nil, ccpf, nopc, ccpo, xconteudo)
    ChamaAut(nil, ccpf, nopc, nil, nil)*/
RESET ENVIRONMENT
RETURN .t.

User Function IncSA2()
PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01'  MODULO 'FAT'
    Public aCliente := {}
    aCliente:={{"A1_COD"   ,'000034',Nil},;
  	    {"A1_LOJA"  ,"01"                      ,Nil},;
	    {"A1_NOME"  ,"CLIENTE COMPRA TUDO S.A.",Nil}}
    ChamaAut(aCliente, , 4, , )
RESET ENVIRONMENT
RETURN .t.


User Function IncSA3()
PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01'  MODULO 'FAT'
    Public aCliente := {}
    aCliente:={{"A1_COD" ,GETSXENUM('SA1', 'A1_COD'), Nil},;
        {"A1_FILIAL","  ", Nil},;
  	    {"A1_LOJA"  ,"01"                      ,Nil},;
	    {"A1_NOME"  ,"CLIENTE COMPRA TUDO S.A.",.F.},;
	    {"A1_NREDUZ","COMPRA TUDO"             ,.F.},;
	    {"A1_TIPO"  ,"F"                       ,.F.},;
	    {"A1_END"   ,"RUA DO ROCIO 123"        ,.F.},;
	    {"A1_MUN"   ,"SAO PAULO"               ,.F.},;
	    {"A1_EST"   ,"SP"                      ,.F.},;
	    {"A1_CGC"   ,"12345678909"             ,.F.},;
	    {"A1_COND"  ,"001"                     ,.F.}}
    ChamaAut(aCliente, , 3, , )
RESET ENVIRONMENT
RETURN .t.




Static Function ChamaAut(aCliente, cCGC, nOPC, cCPO, xConteudo)


Private lMsHelpAuto := .t. 
Private lMsErroAuto := .f. 

DEFAULT aCliente := {}
DEFAULT cCGC := ''
DEFAULT nOPC := 3
DEFAULT cCPO := ''
DEFAULT xConteudo := ''

MSExecAuto({|x,y| mata030(x,y)},aCliente,nOPC)	

If lMsErroAuto
    Mostraerro()
ELSE
    MSGALERT( 'success',  )
EndIf

Return .t.
