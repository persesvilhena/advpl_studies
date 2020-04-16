#include 'Protheus.ch'

User Function MA030ROT()
    Local aRet := {}
    aAdd( aRet, { "Inclusao", "U_IncSA3", 0, 3 })
    aAdd( aRet, { "Alteracao", "U_IncSA2", 0, 3 })
    aAdd( aRet, { "Exclusao", "U_IncSA1", 0, 3 })
Return(aRet)


/*
User Function MA030ROT()
    Local aRet := {}
    aAdd( aRet, { "Copia Cliente", "U_xCopySa1", 0, 3 })
Return(aRet)

User Function xCopySa1()
    Local nY := 0
    IF MSGYESNO( 'Deseja copiar o cliente posicionado?', )
        RegToMemory("SA1", .F.)
        M->A1_COD := GetSx8Num("SA1","A1_COD")
        RECLOCK("SA1",.T.)
        FOR nY := 1 to SA1->(FCOUNT())
            FieldPut(nY, M->&(FieldName(nY)))
        NEXT nY
        SA1->(MSUNLOCK())
        ConfirmSx8()
    ENDIF

Return*/