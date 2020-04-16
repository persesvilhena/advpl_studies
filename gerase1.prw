#include 'protheus.ch'
#include 'parmtype.ch'
#include 'tbiconn.ch'

user function geraSE1()

	Local cFile		:= ''

	Private nPOSFIL, nPOSNAT, nPOSCGC,;
	nPOSMOV, nPOSEMI, nPOSHIS, nPOSDOC,;
	nPOSVAL, nPOSATU ,nPOSVEN

	PRIVATE lMsErroAuto := .F.
	PRIVATE	_cFileLog := ''
	PRIVATE	_cLogPath := ''
	PRIVATE _Handle	  := ''

	cFile := cGetFile("Arquivo CSV (*.CSV) |*.CSV|", "Selecione o Arquivo", , , .T., GETF_NETWORKDRIVE+GETF_LOCALHARD)

	If !File(cFile)
		MsgAlert("Arquivo: "+cFileOpen+" não localizado")
	Else
		// Processo Leitura do .CSV
		Processa( {|| ReadCSV(cFile) },"Importando Orçamento...")
	Endif
Return

Static Function ReadCSV(cFile)

	Local _aHeader  := {}
	Local _aCols    := {}
	Local nHdl      := FT_FUse(cFile)
	Local nPROC     := FT_FLASTREC()
	LOCAL aArray    := {}
	Local cCliente  := ''
	Local cLoja     := ''

	FT_FGOTOP()
	PROCREGUA(nPROC)

	//MONTAGEM DO AHEADER E ACOLS
	WHILE ! FT_FEOF()

		INCPROC("Lendo arquivo .CSV, aguarde...")

		IF "COD_FILIAL" $ UPPER(FT_FREADLN())
			_aHeader := SEPARA(UPPER(FT_FREADLN()) ,";" ,.T.)
		ELSE
			AADD(_aCols   , SEPARA(UPPER(FT_FREADLN()) , ";" ,.T.) )
		ENDIF

		FT_FSKIP()

	ENDDO

	nPOSFIL  := aScan(_aHeader,{|x| upper(ALLTRIM(x))=="COD_FILIAL"})
	nPOSNAT  := aScan(_aHeader,{|x| upper(ALLTRIM(x))=="NATUREZA"})
	nPOSCGC  := aScan(_aHeader,{|x| upper(ALLTRIM(x))=="CNPJ"})
	nPOSMOV  := aScan(_aHeader,{|x| upper(ALLTRIM(x))=="MOVIMENTO"})
	nPOSDOC  := aScan(_aHeader,{|x| upper(ALLTRIM(x))=="DOCUMENTO"})

	nPOSEMI  := aScan(_aHeader,{|x| upper(ALLTRIM(x))=="DATA_EMISSAO"})
	nPOSHIS  := aScan(_aHeader,{|x| upper(ALLTRIM(x))=="HISTORICO"})
	nPOSVAL  := aScan(_aHeader,{|x| upper(ALLTRIM(x))=="VALOR_PARCELA"})
	nPOSVEN  := aScan(_aHeader,{|x| upper(ALLTRIM(x))=="VENCTO_DATA"})

	PROCREGUA(Len(_aCols))

	If LEN(_aHeader) > 0  .AND. LEN(_aCols) > 0

		cpLogTxt(1,)

		FOR nY := 1 To Len(_aCols)

			ProcRegua(Len(_aCols))

			aArray := {}

			INCPROC("Gravando titulo..." +  _aCols[nY,nPOSDOC] )

			If xSa1(_aCols[nY,nPOSCGC] , @cCliente, @cLoja)

				aArray := {{"E1_FILIAL"  , _aCols[nY,nPOSFIL]             , NIL },;
				{ "E1_PREFIXO"  , "IMP"             , NIL },;
				{ "E1_NUM"      , _aCols[nY,nPOSDOC]            , NIL },;
				{ "E1_TIPO"     , "NF"              , NIL },;
				{ "E1_NATUREZ"  , _aCols[nY,nPOSNAT]             , NIL },;
				{ "E1_CLIENTE"  , cCliente            , NIL },;
				{ "E1_LOJA"     , cLoja               , NIL },;
				{ "E1_EMISSAO"  , CtoD(_aCols[nY,nPOSEMI])                   ,  NIL },;
				{ "E1_VENCTO"   , CtoD(_aCols[nY,nPOSVEN])                   ,  NIL },;
				{ "E1_VENCREA"  , CtoD(_aCols[nY,nPOSVEN])                   ,  NIL },;
				{ "E1_HIST"     , "Teste sem hist" /*_aCols[nY,nPOSHIS]    */                     ,  NIL },;
				{ "E1_VALOR"    , Val(StrTran(_aCols[nY,nPOSVAL],",",".") )  ,  NIL },;
				{ "CBCOAUTO"    , ""             , NIL },;
				{ "CAGEAUTO"    , ""            , NIL },;
				{ "CCTAAUTO"    , ""          , NIL },;
				{ "E1_SALDO"    , Val(StrTran(_aCols[nY,nPOSVAL],',','.'))    , NIL }}

				xAauto(aArray)

			Else
				cpLogTxt( 2,"CLIENTE N CADASTRADO " + _aCols[nY,nPOSCGC] + CRLF)
			Endif

		NEXT nY
		cpLogTxt(3,)
	Endif
	FT_FUse()
Return

Static Function xSa1( cCgc , cCliente, cLoja)

	Local lRet := .f.

	DbSelectArea("SA1")
	SA1->(DbSetOrder(3)) //A2_FILIAL+A2_CGC

	If SA1->(DbSeek(xFilial('SA1')+cCgc))
		cCliente := SA1->A1_COD
		cLoja    := SA1->A1_LOJA
		lRet := .t.
	Endif

Return(lRet)

Static Function xAauto(aArray)

	MsExecAuto( { |x,y,z| FINA040(x,y,z)}, aArray,, 3)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão

	If lMsErroAuto
		MostraErro()
	Endif

return

Static Function cpLogTxt(_nOpc, _cTxtLog)
	Local _lRet	:= Nil
	Local _nOpc, _cTxtLog
	Local cLogIni	:= ""

	Default _nOpc		:= 0
	Default _cTxtLog 	:= ""

	Do Case
		Case _nOpc == 1
		//_cFileLog	 	:= Criatrab(,.F.)
		_cFileLog		:= ALLTRIM(SUBSTR(cUsuario,7,15))+"_"+DTOS(DDATABASE)+"_"+STRTRAN(TIME(),":","-")
		_cLogPath		:= AllTrim(GetTempPath())+_cFileLog+".txt"
		_Handle			:= FCREATE(_cLogPath,0)	//| Arquivo de Log

		cLogIni	:= "**** INICIO ****"+CRLF
		cLogIni	+= 'DATABASE...........: ' + DtoC(dDataBase)+CRLF
		cLogIni	+= 'DATA - HORA........: ' + DtoC(Date())+" - "+Time()+CRLF
		cLogIni	+= 'ENVIRONMENT........: ' + GetEnvServer()+CRLF
		cLogIni	+= 'EMPRESA / FILIAL...: ' + SM0->M0_CODIGO + '/' + SM0->M0_CODFIL+CRLF
		cLogIni	+= 'USUÁRIO............: ' + cUserName+CRLF
		cLogIni	+= REPLICATE("-",80)+CRLF

		FWRITE (_Handle, cLogIni+CRLF+_cTxtLog)

		Case _nOpc == 2
		IF !EMPTY(_cTxtLog)
			FWRITE (_Handle, _cTxtLog)
		ENDIF

		Case _nOpc == 3

		cLogIni	:= REPLICATE("-",80)+CRLF
		cLogIni	+= 'DATA - HORA........: ' + DtoC(Date())+" - "+Time()+CRLF
		cLogIni	+= "**** FIM ****"+CRLF

		FWRITE (_Handle, cLogIni+CRLF+_cTxtLog)

		FCLOSE(_Handle)
		WINEXEC("NOTEPAD "+_cLogPath)
	EndCase

Return(_lRet)