#include 'tbiconn.ch'
User Function xExerc2b()
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01'  MODULO 'FAT'
        DbSelectArea('SA1')
        While SA1->A1_XBRCAR = '0'
            RecLock("SA1", .F.)		
            SA1->A1_XBRCAR := '1'	
            MsUnLock()
            SA1->(Dbskip())
        Enddo
        SA1->(DBCLOSEAREA(  ))
    RESET ENVIRONMENT
Return