#include 'Protheus.ch'
#include 'tbiconn.ch'

User Function xAtuCli()
    Local cCGC  := ''
    Local cNome := ''
    Local dNasc := ''

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01'  MODULO 'FAT'

    cCGC  := alltrim(FwInputBox('Digite o CPF', '00000000000'))
    cNome := alltrim(FwInputBox('Nome fantasia', 'DIGITE'))
    dNasc := cTod(FwInputBox('Digite seu aniversário', 'DD/MM/AAAA'))


    If !Empty(cCGC)
        DbSelectArea('SA1')
        SA1->(DBSETORDER( 3 ))
        IF SA1->(Dbseek( xFilial('SA1')+cCGC ) )
            MSGALERT('Cliente ' + alltrim(SA1->A1_NOME) + ' Localizado',)

            If MSGYESNO('Deseja alterar a data de aniversário para ' + Dtoc(dNasc))
                Reclock('SA1',.F.)
                SA1->A1_DTNASC := dNasc
                SA1->A1_NREDUZ := cNome
                SA1->(Msunlock())
            Endif

        ELSE
            MSGALERT('CPF ' + cCGC + ' Não Localizado',)
        Endif
        SA1->(DBCLOSEAREA())
    Endif

    RESET ENVIRONMENT
Return