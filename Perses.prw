#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'tbiconn.ch'
User Function PERSES()
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'FAT'
    Private aNomes := {}
    PRIVATE cMSG := ''

    aadd(aNomes, {'THIAGO', ''})
    aadd(aNomes, {'JOSE', ''})
    aadd(aNomes, {'PATRICK', ''})
    aadd(aNomes, {'PERSES', '10817915605'})
    aadd(aNomes, {'RONI', ''})
    aadd(aNomes, {'DUDU', ''})

    
    
    FuncaoB(aNomes)
    FuncaoC()

    RESET ENVIRONMENT
Return

Static Function FuncaoB(aNomes)
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

Static Function FuncaoC()
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
    
RETURN