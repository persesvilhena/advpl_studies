#include 'Protheus.ch'
#include 'tbiconn.ch'
#include 'topconn.ch'

User Function xExerc2()
    //Local cCGC  := ''
    //Local cNome := ''
    //Local dNasc := ''
    Local cAlias := GetNEXTALIAS()
    Local cQry := ''

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01'  MODULO 'FAT'

    //cCGC  := alltrim(FwInputBox('Digite o CPF', '00000000000'))
    //cNome := alltrim(FwInputBox('Nome fantasia', 'DIGITE'))
    //dNasc := cTod(FwInputBox('Digite seu aniversário', 'DD/MM/AAAA'))

    //If !Empty(cCGC)
        BEGINSQL alias cAlias
            SELECT A1_XBRCAR, R_E_C_N_O_ AS A1RECNO
            FROM %table:SA1% SA1
        ENDSQL
        cQry := ChangeQuery(cQry)
        MemoWrite( 'teste.sql', cQry )

    
        While (cAlias)->(!EOF())


            //If MSGYESNO('Deseja integrar ' + cValtochar((cAlias)->A1RECNO))
                cQry := "UPDATE "+RetSqlName('SA1')+" SET A1_XBRCAR = '1'"
                cQry += " WHERE R_E_C_N_O_ = "+ cValtochar( (cAlias)->A1RECNO )

                IF TCSQLEXEC(cQry) < 0
                    MsgAlert(TCSQLERROR(), )
                else
                    //MsgAlert('UPDATE COM SUCESSO', )
                ENDIF
            //Endif

            (cAlias)->(Dbskip())
        Enddo

    //Endif

Return