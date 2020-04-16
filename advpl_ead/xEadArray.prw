#include 'protheus.ch'
#include 'parmtype.ch'

user function xEadArray()

Local aVetor := {}
Local aNomes := {}
	Aadd(aVetor , {"Thiago"   , "SP", 31 }  )
	Aadd(aVetor , {"Pablo"    , "MG", 31 }  )
	Aadd(aVetor , {"Alexandre", "SP", 31 }  )
	
	ASORT(aVetor, , ,{|X,Y| X[1] > Y[1] } ) // Orderna a partir da Coluna 1 
	
	Aadd(aNomes , 'Thiago' )
	Aadd(aNomes , 'Pablo' )
	Aadd(aNomes , 'Alexandre' )
	
	aSort(aNomes, , ,{|X,Y| X > Y }) // Ordenação de Array Simples.
	
return