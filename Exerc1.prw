#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'tbiconn.ch'
User Function EXER1()
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'FAT'
    Public cCGC := ''
    Public cNREDUZ := 'PER'
    Public dDatinha := Date()
    

    cCGC := FWInputBox("Informe o cpf", "")
    cNREDUZ := FWInputBox("Informe o novo fantasia", "")
    dDatinha := CToD("09/07/95")

    FuncaoC()

    RESET ENVIRONMENT
Return
/*
Static Function FuncaoB()
    Local nI := 0
    Public cCGC := ''
    For nI := 1 To Len(aNomes)
        //MSGALERT( aNomes[nI, 1], )
        cMSG += aNomes[nI, 1] + CRLF
        IF !Empty(aNomes[nI, 2])
            if MSGYESNO( 'ver?' + aNomes[nI, 1],  )
                cCGC := aNomes[nI, 2]
            End if
        End if
    Next nI
Return
*/
/*Static Function FuncaoC()
    Local bBloco := {|| MSGAlert(cMSG,)}
    //MSGALERT( cMSG, )
    IF MSGYESNO( '?', 'teste' )
        Eval(bBloco)
    End if

    if !Empty(cCGC)
        DbSelectArea('SA1')
        SA1->(DBSETORDER( 3 ))
        
        IF SA1->(Dbseek(xFilial('SA1')+cCGC))
            MSGALERT('Cliente ' + SA1->A1_NOME + ' localizado', )
        else
            MSGALERT( cCGC,  )
        End if
        MSGALERT( cCGC,  )

        SA1->(DBCLOSEAREA(  ))
    end if
    
RETURN*/

Static Function FuncaoC()

    IF MSGYESNO( 'Deseja alterar o cliente?', 'Alterar' )
        DbSelectArea('SA1')
        SA1->(DBSETORDER( 3 ))
        
        IF SA1->(Dbseek(xFilial('SA1')+cCGC))
            RecLock("SA1", .F.)		
            SA1->A1_NREDUZ := cNREDUZ	
            SA1->A1_DTNASC := dDatinha
            MsUnLock()
            MSGALERT('Cliente ' + ALLTRIM(SA1->A1_NOME) + ' alterado com sucesso', )
        else
            MSGALERT( 'Nada foi alterado',  )
        End if

        SA1->(DBCLOSEAREA(  ))
    End if
    
RETURN