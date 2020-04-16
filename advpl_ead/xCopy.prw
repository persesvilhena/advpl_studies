#include 'protheus.ch'
#include 'parmtype.ch'
// fazer download para pasta local de todos os arquivos .xnu.
user function xCopy()
	LOCAL cArquivo  := '\system\'
	LOCAL cSalvo	  := 'c:\temp\'
	LOCAL aArqXNU := Directory(cArquivo+'*.xnu')

	for i := 1 to len(aArqXNU)

		IF 	CPYS2T(cArquivo+aArqXNU[i][1],cSalvo,.t.)
			CONOUT('LINHA '+cValtochar(i))
		else
			CONOUT('ERRO '+cValtochar(i))
		endif

	next i
Return Nil
