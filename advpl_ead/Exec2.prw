#include 'protheus.ch'
#include 'parmtype.ch'

user function ExecP16()

	Local cVal, nTotGer, lVarl, cTem, lCont, lTudo
	Local cNom   := ""
	Local nVal   := 5
	Private nVal1:= 7 + 6, lVal, lQuas, nValor
	Public lVar  := nVal == 5
	nVal1  += 15
	nValor := (((nVal1- nVal)/2) * 3^2 + 1 )* -1
	nTempo := "nValor * 3"
	nTotGer:= &nTempo
	nTotGer++
	cTem   := "São Paulo"
	cTem   += ", 15 de Dezembro"
	lCont  := "Dez" $ cTem
	lTudo  := cTem = "São"  
	lQuas  := cTem == "São Paulo"
	lVal   := nVal > 5
//	lValc  :=  nVal1 – 8  <= 13 
		
	fMudaFun(@nValor, lTudo, lQuas, lVal)
	
	msginfo(nValor)
Return
Static Function fMudaFun(_val, _lTudo, _lQuas, _lVal)
	msginfo(nVal1)
Return
User Function fContinua()
	Msginfo(lVar)
Return
