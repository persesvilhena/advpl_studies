#include 'protheus.ch'
#include 'parmtype.ch'
User Function Exec1()
	local cNome := 'Thiago'
	local nQtdNome := 0
	Local aArray := {}

	cNome += space(1)
	cNome += 'Oliveira do Nascimento'
	nQtdNome := cValToChar(ContaNome(cNome))
	MsgInfo('nome: '+ cNome + ' Qtde Letras: ' + nQtdNome )

Return

Static Function ContaNome( cNome)
	Local nContador := 0
	Local nCount    := 0
	Local nRec      := 0
	Local nRed      := 0
	Local nMai
	for nMai := 1 to Len( cNome)
		if !Empty(substr(cNome,nMai,1))
			//Alert(substr(cNome,nMai,1))
			nRec :=	++ nCount
			nRed := nContador ++
		endif
	next nMai
	cNome := 'João'
Return nContador

User Function Str001()

	Local cNome := "Thiago Oliveira do Nascimento"
	Local aNome := strtokarr(cNome," ")
	Local nSoma:=0

	for nI:=1 to len(aNome)
		nSoma += len(aNome[nI])
	Next

	MsgInfo('nome:'+ cNome + ' Qtde Letras:' + cValToChar(nSoma) )

Return

User Function xMacro(cFunc)
	Local nRet
	nRet := &(cFunc)

Return

User Function xContem(cPesq)
	Local cNumeros := '1|2|3|4|5|6|7|8|9'

	If cPesq $ cNumeros
		Alert(cPesq + 'Contido na regra!!')
	Else
		Alert(cPesq + 'Não Contido na regra!!')
	Endif

Return