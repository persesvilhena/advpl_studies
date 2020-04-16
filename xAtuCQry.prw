#include 'Protheus.ch'
#include 'tbiconn.ch'
#include 'topconn.ch'

User Function xAutCQry()
    Local cCGC  := ''
    //Local cNome := ''
    Local dNasc := ''
    Local cAlias := 'TRB' //GetNEXTALIAS()
    Local cQry := ''

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01'  MODULO 'FAT'

    cCGC  := alltrim(FwInputBox('Digite o CPF', '00000000000'))
    //cNome := alltrim(FwInputBox('Nome fantasia', 'DIGITE'))
    dNasc := cTod(FwInputBox('Digite seu aniversário', 'DD/MM/AAAA'))

    If !Empty(cCGC)
        cQry := "SELECT A1_NOME, R_E_C_N_O_ AS A1RECNO FROM " + RetSqlName('SA1') + " "
        cQry += "WHERE A1_CGC = '" + cCGC + "' AND D_E_L_E_T_ = ' ' "

        MemoWrite( 'teste.sql', cQry )

        cQry := ChangeQuery(cQry)

        TCQUERY cQry NEW ALIAS (cAlias)

        While (cAlias)->(!EOF())
            MSGALERT('Cliente ' + alltrim((cAlias)->A1_NOME) + ' Localizado',)

            If MSGYESNO('Deseja alterar a data de aniversário para ' + Dtoc(dNasc))
                cQry := "UPDATE "+RetSqlName('SA1')+" SET A1_DTNASC = '"+DTOS(dNasc)+"'"
                cQry += " WHERE R_E_C_N_O_ = "+ cValtochar( (cAlias)->A1RECNO )

                IF TCSQLEXEC(cQry) < 0
                    MsgAlert(TCSQLERROR(), )
                else
                    MsgAlert('UPDATE COM SUCESSO', )
                ENDIF
            Endif

            (cAlias)->(Dbskip())
        Enddo

    Endif

Return