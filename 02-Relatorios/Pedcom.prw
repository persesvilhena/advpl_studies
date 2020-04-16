//#INCLUDE 'fivewin.ch'
#INCLUDE 'topconn.ch'
#INCLUDE "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} PedCom
Rotina para processamento de importa็ใo de Documento de Entrada
com base em arquivo de XML

@author		Digicorp
@since		12/15/2017
@version	P12
@obs		PEDIDO DE COMPRA GRมFICO
/*/
//-------------------------------------------------------------------

User Function PEDCOM() //U_PEDCOM()

    Local aAreaSC7	:= SC7->(GetArea())
	Local aAreaSA2	:= SA2->(GetArea())
	Local aAreaSA5	:= SA5->(GetArea())   
	Local aAreaSF4	:= SF4->(GetArea())
	Local aAreaSA4  := SA4->(GetArea())
	Local aAreaCTT  := CTT->(GetArea())
	Local cPerg		:= 'RAPEDI'            

	Private	lEnd := .f.	 	

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณAjusta os parametros.ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	AjustaSX1(cPerg)

	If	( ! Pergunte(cPerg,.T.) )
		Return
	Else
		Private	cNumPed  	:= mv_par01			// Numero do Pedido de Compras
		Private	lImpPrc		:= (mv_par02==2)	// Imprime os Precos ?
		Private	cTitulo 	:= "ORDEM DE COMPRA"		// Titulo do Relatorio ?
		
		Private	lPrintCodFor:= (mv_par03==1)	// Imprime o Codigo do produto no fornecedor ?
		
		Private	cObserv1 := "Horแrio de recebimento de segunda เ quinta-feira das 8:00 เs 11:30" 
		Private cObserv2 := "Os c๓digos dos produtos informados no pedido/contrato deverใo ser inseridos na nota fiscal e faturas"
		Private cObserv3 := "E-mail para envio de notas fiscais eletronicas e arquivos XML: nfe@tel.com.br" 
		Private cObserv4 := "O nบ do pedido/contrato deve constar no campo de dados complementares da NOTA FISCAL"			
	EndIf

	DbSelectArea('SC7')
	SC7->(DbSetOrder(1))
	If	( ! SC7->(DbSeek(xFilial('SC7') + cNumPed)) )
		Help('',1,'pedcom',,OemToAnsi('Pedido nใo encontrado.'),1)
		Return .f.
	EndIf
	
	// Posiciona o centro de custo para pegar informacoes do rodape
	
	DbSelectArea("CTT")
	CTT->(DbSetOrder(1))
	CTT->(MsSeek(xFilial("CTT")+SC7->C7_CC))
	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณExecuta a rotina de impressao ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Processa({ |lEnd| xPrintRel(),OemToAnsi('Gerando o relat๓rio.')}, OemToAnsi('Aguarde...'))
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณRestaura a area anterior ao processamento. !ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	RestArea(aAreaSC7)
	RestArea(aAreaSA2)
	RestArea(aAreaSA5)
	RestArea(aAreaSF4)
	RestArea(aAreaSA4)
	RestArea(aAreaCTT)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ xPrintRelบAutor ณLuis Henrique Robustoบ Data ณ  10/09/04   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime a Duplicata...                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Funcao Principal                                           บฑฑ
ฑฑฬออออออออออุออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDATA      ณ ANALISTA ณ MOTIVO                                          บฑฑ
ฑฑฬออออออออออุออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ          ณ                                                 บฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function xPrintRel()
		Private	oPrint		:= TMSPrinter():New(OemToAnsi('Pedido de Compras')),;
				oBrush		:= TBrush():New(,CLR_HGRAY),;
				oPen		:= TPen():New(0,5,CLR_BLACK),;
				cFileLogo	:= GetSrvProfString('Startpath','') + 'DANFE0101.BMP',;
				cFilePBQPh	:= GetSrvProfString('Startpath','') + 'PBQPh' + '.BMP',;
				oFont07		:= TFont():New('Courier New',07,07,,.F.,,,,.T.,.F.),;
				oFont08		:= TFont():New('Courier New',08,08,,.F.,,,,.T.,.F.),;
				oFont09		:= TFont():New('Tahoma',09,09,,.F.,,,,.T.,.F.),;
				oFont10		:= TFont():New('Tahoma',10,10,,.F.,,,,.T.,.F.),;
				oFont10n	:= TFont():New('Courier New',10,10,,.T.,,,,.T.,.F.),;
				oFont11		:= TFont():New('Tahoma',11,11,,.F.,,,,.T.,.F.),;
				oFont12		:= TFont():New('Tahoma',12,12,,.T.,,,,.T.,.F.),;
				oFont11n	:= TFont():New('Tahoma',11,11,,.F.,,,,.T.,.F.),;
				oFont12n	:= TFont():New('Tahoma',12,12,,.F.,,,,.T.,.F.),;
				oFont10d	:= TFont():New('Tahoma',08,08,,.F.,,,,.T.,.F.),;
				oFont13		:= TFont():New('Tahoma',13,13,,.T.,,,,.T.,.F.),;
				oFont14		:= TFont():New('Tahoma',14,14,,.T.,,,,.T.,.F.),;
				oFont15		:= TFont():New('Courier New',15,15,,.T.,,,,.T.,.F.),;
				oFont18		:= TFont():New('Arial',18,18,,.T.,,,,.T.,.T.),;
				oFont15a	:= TFont():New('Arial',15,15,,.T.,,,,.T.,.F.),;
				oFont20		:= TFont():New('Arial',20,20,,.F.,,,,.T.,.F.),;
				oFont22		:= TFont():New('Arial',22,22,,.T.,,,,.T.,.F.)
		
		Private	lFlag		:= .t.,;	// Controla a impressao do fornecedor
				nLinha		:= 3000,;	// Controla a linha por extenso
				nLinFim		:= 0,;		// Linha final para montar a caixa dos itens
				lPrintDesTab:= .f.,;	// Imprime a Descricao da tabela (a cada nova pagina)
				cRepres		:= Space(80),;
				nPag        := 0,;
				cCpnjA4 := '',;
				cNomA4  := '',;
				cConA4  := ''		
		
		Private	_nQtdReg	:= 0,;		// Numero de registros para intruir a regua
				_nValMerc 	:= 0,;		// Valor das mercadorias
				_nValIPI	:= 0,;		// Valor do I.P.I.
				_nValICM    := 0,;	    // Valor do ICMS 
				_nValDesc	:= 0,;		// Valor de Desconto
				_nTotAcr	:= 0,;		// Valor total de acrescimo
				_nTotSeg	:= 0,;		// Valor de Seguro
				_nTotFre	:= 0,;		// Valor de Frete
				_nTotIcmsRet:= 0		// Valor do ICMS Retido

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณPosiciona nos arquivos necessarios. !ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSelectArea('SA2')
		SA2->(DbSetOrder(1))
		If	! SA2->(DbSeek(xFilial('SA2')+SC7->(C7_FORNECE+C7_LOJA)))
			Help('',1,'REGNOIS')
			Return .f.
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณTransportadoraณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSelectArea('SA4')
		SA4->(DbSetOrder(1))
		
		/*If SA4->(DbSeek(xFilial('SA4')+SC7->C7_XTRANS))
			cCpnjA4 :=  TransForm(SA4->A4_CGC,'@R 99.999.999/9999-99')
			cNomA4  :=  SA4->A4_NREDUZ
			cConA4  :=  SA4->A4_CONTATO
		Else	
			cCpnjA4 := '******'
			cNomA4  := '******'
			cConA4  := '******'				
		Endif */
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณDefine que a impressao deve ser RETRATOณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		oPrint:SetPortrait()

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณMonta query !ณ    //SC7.C7_CODPRF, 
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤู
		cSELECT :=	'SC7.C7_FILIAL, SC7.C7_NUM, SC7.C7_EMISSAO, SC7.C7_FORNECE, SC7.C7_LOJA, SC7.C7_UM, '+;
					'SC7.C7_ITEM, SC7.C7_PRODUTO, SC7.C7_DESCRI, SC7.C7_QUANT, '+;
					'SC7.C7_PRECO, SC7.C7_IPI, SC7.C7_TOTAL, SC7.C7_VLDESC, SC7.C7_DESPESA, '+;
					'SC7.C7_SEGURO, SC7.C7_VALFRE, SC7.C7_TES, SC7.C7_ICMSRET, SC7.C7_OBS , SC7.C7_DATPRF, SC7.C7_NUMSC, SC7.C7_VALICM '

		cFROM   :=	RetSqlName('SC7') + ' SC7 '

		cWHERE  :=	'SC7.D_E_L_E_T_ <>   '+CHR(39) + '*'            +CHR(39) + ' AND '+;
					'SC7.C7_FILIAL  =    '+CHR(39) + xFilial('SC7') +CHR(39) + ' AND '+;
					'SC7.C7_NUM     =    '+CHR(39) + cNumPed        +CHR(39) 

		cORDER  :=	'SC7.C7_FILIAL, SC7.C7_ITEM '

		cQuery  :=	' SELECT '   + cSELECT + ; 
					' FROM '     + cFROM   + ;
					' WHERE '    + cWHERE  + ;
					' ORDER BY ' + cORDER

		TCQUERY cQuery NEW ALIAS 'TRA'

		If	! USED()
			MsgBox(cQuery+'. Query errada','Erro!!!','STOP')
		EndIf

		DbSelectArea('TRA')
		Count to _nQtdReg
		ProcRegua(_nQtdReg)
		TRA->(DbGoTop())

		While 	TRA->( ! Eof() )

				xVerPag()

				If	( lFlag )

					//ฺฤฤฤฤฤฤฤฤฤฤฟ
					//ณFornecedorณ
					//ภฤฤฤฤฤฤฤฤฤฤู
					oPrint:Say(0530,0100,OemToAnsi('FORNECEDOR:'),oFont10)
					oPrint:Say(0530,0340,AllTrim(SA2->A2_NOME) + '  ('+AllTrim(SA2->A2_COD)+'/'+AllTrim(SA2->A2_LOJA)+')',oFont10)
					oPrint:Say(0580,0100,OemToAnsi('ENDEREวO:'),oFont10)
					oPrint:Say(0580,0340,SA2->A2_END,oFont10)
					oPrint:Say(0630,0100,OemToAnsi('MUN/U.F.:'),oFont10)
					oPrint:Say(0630,0340,AllTrim(SA2->A2_MUN)+'/'+AllTrim(SA2->A2_EST),oFont10)
					oPrint:Say(0630,1200,OemToAnsi('CEP:'),oFont10)
					oPrint:Say(0630,1400,TransForm(SA2->A2_CEP,'@R 99999-999'),oFont10)
					oPrint:Say(0680,0100,OemToAnsi('CONTATO:'),oFont10)
					oPrint:Say(0680,0340,Alltrim(SA2->A2_CONTATO)+" - "+SA2->A2_TEL,oFont10)
					oPrint:Say(0680,1200,OemToAnsi('FAX:'),oFont10)
					oPrint:Say(0680,1400,SA2->A2_FAX,oFont10)
					
					oPrint:Line(0800,0100,0800,2330)
					
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณNumero/Emissaoณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					oPrint:SayBitmap(0505,1955,cFilePBQPh,317,288,,.t.)
					oPrint:Say(0400,0900,OemToAnsi("Nบ"),oFont20)
					oPrint:Say(0400,0995,SC7->C7_NUM,oFont20)
					oPrint:Say(0400,1785,OemToAnsi("DATA:"),oFont20)
					oPrint:Say(0400,2000,Dtoc(SC7->C7_EMISSAO),oFont20)
					lFlag := .f.

					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณTransportadoraณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					oPrint:Say(0800,0100,OemToAnsi('TRANSPORTADORA:'),oFont10)
					oPrint:Say(0800,0500,cNomA4,oFont10)
					oPrint:Say(0850,0100,OemToAnsi('CNPJ:'),oFont10)
					oPrint:Say(0850,0500,cCpnjA4,oFont10)
					oPrint:Say(0800,1200,OemToAnsi('CONTATO:'),oFont10)
					oPrint:Say(0800,1400,cConA4,oFont10)
			
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณTransportadoraณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					oPrint:Line(0900,0100,0900,2330)
					//oPrint:Say(0950,0100,OemToAnsi('REQUISITANTE:'),oFont10)
					//oPrint:Say(0950,0300,SC7->C7_SOLICIT,oFont10)
					//oPrint:Say(0950,1200,OemToAnsi('OBRA RM:'),oFont10)
					//oPrint:Say(0950,1400,'*****',oFont10)																			
					
				EndIf
				
				If	( lPrintDesTab )
					oPrint:Line(nLinha,100,nLinha,2330)
					oPrint:Line(nLinha,100,nLinha+70,100)
					oPrint:Line(nLinha,220,nLinha+70,220)
					oPrint:Line(nLinha,435,nLinha+70,435)
					oPrint:Line(nLinha,1050,nLinha+70,1050)
					oPrint:Line(nLinha,1290,nLinha+70,1290)
					oPrint:Line(nLinha,1430,nLinha+70,1430)
					oPrint:Line(nLinha,1650,nLinha+70,1650)
					oPrint:Line(nLinha,1890,nLinha+70,1890)
					oPrint:Line(nLinha,2110,nLinha+70,2110)
					oPrint:Line(nLinha,2330,nLinha+70,2330)
					oPrint:Say(nLinha,0120,OemToAnsi('Item'),oFont10)//1
					oPrint:Say(nLinha,0230,OemToAnsi('C๓digo'),oFont10)//2
					oPrint:Say(nLinha,0445,OemToAnsi('Descri็ใo'),oFont10)//3
					//oPrint:Say(nLinha,1060,OemToAnsi('DT.Entrega'),oFont10)//4
					oPrint:Say(nLinha,1060,OemToAnsi('Embarque'),oFont10)//4 
					oPrint:Say(nLinha,1300,OemToAnsi('U.M'),oFont10)//4
					oPrint:Say(nLinha,1440,OemToAnsi('Qtde'),oFont10)//5
					oPrint:Say(nLinha,1680,OemToAnsi('Vlr.Unit.'),oFont10)//6
					oPrint:Say(nLinha,1900,OemToAnsi('IPI (%)'),oFont10)//7
					oPrint:Say(nLinha,2140,OemToAnsi('Valor Total'),oFont10)//8
					
			
					lPrintDesTab := .f.
					nLinha += 70
					oPrint:Line(nLinha,100,nLinha,2330)
				EndIf

				oPrint:Line(nLinha,100,nLinha+60,100)//1
				oPrint:Line(nLinha,220,nLinha+60,220)//2
				oPrint:Line(nLinha,435,nLinha+60,435)//3
				oPrint:Line(nLinha,1050,nLinha+60,1050)
				
				oPrint:Line(nLinha,1290,nLinha+60,1290)//4
				oPrint:Line(nLinha,1430,nLinha+60,1430)//5
				oPrint:Line(nLinha,1650,nLinha+60,1650)//6
				oPrint:Line(nLinha,1890,nLinha+60,1890)//7
				oPrint:Line(nLinha,2110,nLinha+60,2110)//8
				oPrint:Line(nLinha,2330,nLinha+60,2330)

				oPrint:Say(nLinha,0120,TRA->C7_ITEM,oFont10d)
				If	( lPrintCodFor )
					DbSelectArea('SA5')
					SA5->(DbSetOrder(1))
					If	SA5->(DbSeek(xFilial('SA5') + SA2->A2_COD + SA2->A2_LOJA + TRA->C7_PRODUTO)) .and. ( ! Empty(SA5->A5_CODPRF) )
						oPrint:Say(nLinha,0230,SA5->A5_CODPRF,oFont10d)
					Else
						oPrint:Say(nLinha,0230,TRA->C7_PRODUTO,oFont10d)
					EndIf
				Else
					oPrint:Say(nLinha,0230,TRA->C7_PRODUTO,oFont10d)
				EndIf	
				
				oPrint:Say(nLinha,445,SubStr(TRA->C7_DESCRI,1,39),oFont10d)
				//oPrint:Say(nLinha,1210,ALLTRIM(POSICIONE('SB1',1,XFILIAL('SB1')+TRA->C7_PRODUTO,'B1_XNBR')),oFont10d)
				If Len(alltrim(TRA->C7_DESCRI)) > 39
					nLinha += 30
					oPrint:Say(nLinha,445,Alltrim(SubStr(TRA->C7_DESCRI,40,LEN(TRA->C7_DESCRI))),oFont10d)
										
					oPrint:Line(nLinha,100,nLinha+60,100)
					oPrint:Line(nLinha,220,nLinha+60,220)
					oPrint:Line(nLinha,435,nLinha+60,435)
					oPrint:Line(nLinha,1050,nLinha+60,1050)
					oPrint:Line(nLinha,1290,nLinha+60,1290)
					oPrint:Line(nLinha,1430,nLinha+60,1430)
					oPrint:Line(nLinha,1650,nLinha+60,1650)
					oPrint:Line(nLinha,1890,nLinha+60,1890)
					oPrint:Line(nLinha,2110,nLinha+60,2110)
					oPrint:Line(nLinha,2330,nLinha+60,2330)
					
					//nLinha-= 30
				Endif
				
				IF !Empty(TRA->C7_OBS)
					nLinha += 30
						oPrint:Say(nLinha,0445,SUBSTR(TRA->C7_OBS,1,39),oFont10d)
					
					IF LEN(alltrim(TRA->C7_OBS)) > 39
						nLinha += 30
							oPrint:Say(nLinha,0445,SUBSTR(TRA->C7_OBS,40,LEN(TRA->C7_OBS)),oFont10d)
						nLinha-= 30												
					ENDIF
					oPrint:Line(nLinha,100,nLinha+60,100)
					oPrint:Line(nLinha,220,nLinha+60,220)
					oPrint:Line(nLinha,435,nLinha+60,435)
					oPrint:Line(nLinha,1050,nLinha+60,1050)
					oPrint:Line(nLinha,1290,nLinha+60,1290)
					oPrint:Line(nLinha,1430,nLinha+60,1430)
					oPrint:Line(nLinha,1650,nLinha+60,1650)
					oPrint:Line(nLinha,1890,nLinha+60,1890)
					oPrint:Line(nLinha,2110,nLinha+60,2110)
					oPrint:Line(nLinha,2330,nLinha+60,2330)
					//nLinha-= 30
				endif
					
				IF !Empty(TRA->C7_NUMSC)
					nLinha += 30
						oPrint:Say(nLinha,0445,'Nบ SC: ' + ALLTRIM(TRA->C7_NUMSC),oFont10d)
					
					oPrint:Line(nLinha,100,nLinha+20,100)
					oPrint:Line(nLinha,220,nLinha+20,220)
					oPrint:Line(nLinha,435,nLinha+20,435)
					oPrint:Line(nLinha,1050,nLinha+20,1050)
					oPrint:Line(nLinha,1290,nLinha+20,1290)
					oPrint:Line(nLinha,1430,nLinha+20,1430)
					oPrint:Line(nLinha,1650,nLinha+20,1650)
					oPrint:Line(nLinha,1890,nLinha+20,1890)
					oPrint:Line(nLinha,2110,nLinha+20,2110)
					oPrint:Line(nLinha,2330,nLinha+20,2330)
					nLinha-= 30	
				endif									
				oPrint:Say(nLinha,1060,cValtoChar(Stod(ALLTRIM(TRA->C7_DATPRF))),oFont10d)
				oPrint:Say(nLinha,1300,ALLTRIM(TRA->C7_UM),oFont10d)
				oPrint:Say(nLinha,1575,AllTrim(TransForm(TRA->C7_QUANT,'@E 999,999.99')),oFont10d,,,,1)
				If	( lImpPrc )
					oPrint:Say(nLinha,1805,AllTrim(TransForm(TRA->C7_PRECO,'@R 999,999.9999')),oFont10d,,,,1)
					oPrint:Say(nLinha,2035,AllTrim(TransForm(TRA->C7_IPI,'@R 999,999.99')),oFont10d,,,,1)
					oPrint:Say(nLinha,2265,AllTrim(TransForm(TRA->C7_TOTAL,'@R 99,999,999.99')),oFont10d,,,,1)
				EndIf
				nLinha += 60
				oPrint:Line(nLinha,100,nLinha,2330)

				_nValMerc 		+= TRA->C7_TOTAL
				_nValIPI		+= (TRA->C7_TOTAL * TRA->C7_IPI) / 100
				_nValDesc		+= TRA->C7_VLDESC
				_nTotAcr		+= TRA->C7_DESPESA
				_nTotSeg		+= TRA->C7_SEGURO
				_nTotFre		+= TRA->C7_VALFRE
				_nValICM        += TRA->C7_VALICM

				If	( Empty(TRA->C7_TES) )
					_nTotIcmsRet	+= TRA->C7_ICMSRET
				Else
					DbSelectArea('SF4')
					SF4->(DbSetOrder(1))
					If	SF4->(DbSeek(xFilial('SF4') + TRA->C7_TES))
						If	( AllTrim(SF4->F4_INCSOL) == 'S' )
							_nTotIcmsRet	+= TRA->C7_ICMSRET
						EndIf
					EndIf
				EndIf

				

			IncProc()
			TRA->(DbSkip())	

		End

		xVerPag()

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime TOTAL DE MERCADORIASณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If	( lImpPrc )
			oPrint:Line(nLinha,1430,nLinha+80,1430)
			oPrint:Line(nLinha,1890,nLinha+80,1890)
			oPrint:Line(nLinha,2330,nLinha+80,2330)
			oPrint:Say(nLinha+10,1440,'Valor Mercadorias',oFont10)
			oPrint:Say(nLinha+10,2000,TransForm(_nValMerc,'@R 9,999,999.99'),oFont10)
			nLinha += 80
			oPrint:Line(nLinha,1430,nLinha,2330)
		EndIf

		xVerPag()

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime TOTAL DE I.P.I. ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If	( lImpPrc ) .and. ( _nValIpi > 0 )
			oPrint:Line(nLinha,1430,nLinha+80,1430)
			oPrint:Line(nLinha,1890,nLinha+80,1890)
			oPrint:Line(nLinha,2330,nLinha+80,2330)
			oPrint:Say(nLinha+10,1440,'Valor de I. P. I. (+)',oFont10)
			oPrint:Say(nLinha+10,2000,TransForm(_nValIpi,'@R 9,999,999.99'),oFont10)
			nLinha += 80
			oPrint:Line(nLinha,1430,nLinha,2330)
		EndIf

		xVerPag()
		

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime TOTAL DE DESCONTOณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If	( lImpPrc ) .and. ( _nValDesc > 0 )
			oPrint:Line(nLinha,1430,nLinha+80,1430)
			oPrint:Line(nLinha,1890,nLinha+80,1890)
			oPrint:Line(nLinha,2330,nLinha+80,2330)
			oPrint:Say(nLinha+10,1440,'Valor de Desconto (-)',oFont10)
			oPrint:Say(nLinha+10,2000,TransForm(_nValDesc,'@R 9,999,999.99'),oFont10)
			nLinha += 80
			oPrint:Line(nLinha,1430,nLinha,2330)
		EndIf

		xVerPag()

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime TOTAL DE ACRESCIMO ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If	( lImpPrc ) .and. ( _nTotAcr > 0 )
			oPrint:Line(nLinha,1430,nLinha+80,1430)
			oPrint:Line(nLinha,1890,nLinha+80,1890)
			oPrint:Line(nLinha,2330,nLinha+80,2330)
			oPrint:Say(nLinha+10,1440,'Valor de Acresc. (+)',oFont10)
			oPrint:Say(nLinha+10,2000,TransForm(_nTotAcr,'@R 9,999,999.99'),oFont10)
			nLinha += 80
			oPrint:Line(nLinha,1430,nLinha,2330)
		EndIf

		xVerPag()

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime TOTAL DE SEGURO ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If	( lImpPrc ) .and. ( _nTotSeg > 0 )
			oPrint:Line(nLinha,1430,nLinha+80,1430)
			oPrint:Line(nLinha,1890,nLinha+80,1890)
			oPrint:Line(nLinha,2330,nLinha+80,2330)
			oPrint:Say(nLinha+10,1440,'Valor de Seguro (+)',oFont10)
			oPrint:Say(nLinha+10,2000,TransForm(_nTotSeg,'@R 9,999,999.99'),oFont10)
			nLinha += 80
			oPrint:Line(nLinha,1430,nLinha,2330)
		EndIf

		xVerPag()

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime TOTAL DE FRETE ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If	( lImpPrc ) .and. ( _nTotFre > 0 )
			oPrint:Line(nLinha,1430,nLinha+80,1430)
			oPrint:Line(nLinha,1890,nLinha+80,1890)
			oPrint:Line(nLinha,2330,nLinha+80,2330)
			oPrint:Say(nLinha+10,1440,'Valor de Frete  (+)',oFont10)
			oPrint:Say(nLinha+10,2000,TransForm(_nTotFre,'@R 9,999,999.99'),oFont10)
			nLinha += 80
			oPrint:Line(nLinha,1430,nLinha,2330)
		EndIf

		xVerPag()

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime ICMS RETIDO    ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If	( lImpPrc ) .and. ( _nTotIcmsRet > 0 )
			oPrint:Line(nLinha,1430,nLinha+80,1430)
			oPrint:Line(nLinha,1890,nLinha+80,1890)
			oPrint:Line(nLinha,2330,nLinha+80,2330)
			oPrint:Say(nLinha+10,1440,'Valor de ICMS Retido',oFont10)
			oPrint:Say(nLinha+10,2000,TransForm(_nTotIcmsRet,'@R 9,999,999.99'),oFont10)
			nLinha += 80
			oPrint:Line(nLinha,1430,nLinha,2330)
		EndIf

		xVerPag()

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime o VALOR TOTAL !ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		oPrint:FillRect({nLinha,1430,nLinha+80,2330},oBrush)
		oPrint:Line(nLinha,1430,nLinha+80,1430)
		oPrint:Line(nLinha,1890,nLinha+80,1890)
		oPrint:Line(nLinha,2330,nLinha+80,2330)
		oPrint:Say(nLinha+10,1440,'VALOR TOTAL R$ ',oFont10)
		If	( lImpPrc )
			oPrint:Say(nLinha+10,2000,TransForm(_nValMerc + _nValIPI - _nValDesc + _nTotAcr	+ _nTotSeg + _nTotFre + _nTotIcmsRet,'@R 9,999,999.99'),oFont10)
		EndIf
		nLinha += 80		
		xVerPag()
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime TOTAL DE ICMS ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If	( lImpPrc ) .and. ( _nValICM > 0 )
			oPrint:Line(nLinha,1430,nLinha+80,1430)
			oPrint:Line(nLinha,1890,nLinha+80,1890)
			oPrint:Line(nLinha,2330,nLinha+80,2330)
			oPrint:Say(nLinha+10,1440,'Valor de ICMS',oFont10)
			oPrint:Say(nLinha+10,2000,TransForm(_nValICM,'@R 9,999,999.99'),oFont10)
			nLinha += 80
			oPrint:Line(nLinha,1430,nLinha,2330)
			xVerPag()
		EndIf
		
		oPrint:Line(nLinha,1430,nLinha,2330)
		nLinha += 70

		xVerPag()

		//oPrint:Say(nLinha,0100,OemToAnsi('Faturamento:'),oFont12)
		nLinha += 60
		oPrint:Say(nLinha,0100,OemToAnsi('FATURAMENTO:'),oFont10)	
		oPrint:Say(nLinha,0355,Posicione("SE4",1,xfilial("SE4")+SC7->C7_COND,"E4_DESCRI"),oFont11)
		
		If !Empty(SC7->C7_TPFRETE) 
			nLinha += 60
			oPrint:Say(nLinha,0100,OemToAnsi('FRETE:'),oFont10)	
			oPrint:Say(nLinha,0355,IIF(SC7->C7_TPFRETE=="C","CIF","FOB"),oFont11)
		Endif
		
		nLinha += 60
		xVerPag()

		
		oPrint:Line(nLinha,100,nLinha,2330)
		
		nLinha += 60
		xVerPag()

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณFormas de pagamento /Condi็ใo de pagamento!ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		oPrint:Say(nLinha,0100,OemToAnsi('Obs:'),oFont12)
		nLinha += 50
		oPrint:Say(nLinha,0100,cObserv1,oFont11n)
		
		nLinha += 60
		xVerPag()
		
		If	( ! Empty(cObserv2) )
			oPrint:Say(nLinha,0100,cObserv2,oFont11n)
			nLinha += 60
			xVerPag()
		EndIf	
		If	( ! Empty(cObserv3) )
			oPrint:Say(nLinha,0100,cObserv3,oFont11n)
			xVerPag()
			nLinha += 60
		EndIf	
		If	( ! Empty(cObserv4) )
			oPrint:Say(nLinha,0100,cObserv4,oFont11n)
			xVerPag()
			nLinha += 60
			xVerPag()
		Endif	
	
		//nLinha += 50
		//oPrint:Say(nLinha,0100,OemToAnsi('ENTREGA:'),oFont10)
		//oPrint:Say(nLinha,0300,dTOC(SC7->C7_DATPRF),oFont11)
	
		
		nLinha += 60
		oPrint:Line(nLinha,100,nLinha,2330)
		nLinha += 60
		
		/*
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณInforma็ใo de entrega                     !ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
		oPrint:Say(nLinha,0100,OemToAnsi('Informa็๕es para entrega:'),oFont12)
		nLinha += 50
		oPrint:Say(nLinha,0100,OemToAnsi('OBRA/ CEI:'),oFont10)
		//oPrint:Say(nLinha,0300,'COND. THOMAS MORE - CEI 51.226.09354/77 ',oFont10)
		oPrint:Say(nLinha,0300,trim(CTT->CTT_DESC01) + ' - CEI ' + CTT->CTT_CEI,oFont10)
		oPrint:Say(nLinha,1200,OemToAnsi('COMPLEMENTO:'),oFont10)
		//oPrint:Say(nLinha,1465,'SUPERMERCADO ATACADรO KM36 - BR 230',oFont10)		
		oPrint:Say(nLinha,1465,trim(CTT->CTT_XCOMPL),oFont10)		
		nLinha += 50
		oPrint:Say(nLinha,0100,OemToAnsi('ENDEREวO:'),oFont10)
		//oPrint:Say(nLinha,0300,"RUA PROFESSOR JOSษ LUIS DE QUEIROZ",oFont10)
		oPrint:Say(nLinha,0300,trim(CTT->CTT_XEND),oFont10)
		oPrint:Say(nLinha,1200,OemToAnsi('TELEFONE:'),oFont10)
		//oPrint:Say(nLinha,1465,'83 32295200',oFont10)		
		oPrint:Say(nLinha,1465,trim(CTT->CTT_FONE),oFont10)		
		nLinha += 50
		oPrint:Say(nLinha,0100,OemToAnsi('CIDADE:'),oFont10)
		oPrint:Say(nLinha,0300,trim(CTT->CTT_XMUNIC),oFont11)
		oPrint:Say(nLinha,1200,OemToAnsi('EMAIL:'),oFont10)
		//oPrint:Say(nLinha,1465,"COMPRAS@GRUPORIOALTO.COM.BR",oFont10)		
		oPrint:Say(nLinha,1465,trim(CTT->CTT_EMAIL),oFont10)		
						*/		
		nLinha += 60
		oPrint:Line(nLinha,100,nLinha,2330)
		xVerPag()
		
		TRA->(DbCloseArea())
		CTT->(DbCloseArea())
		xRodape()

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime e finaliza a impressao. !ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	
		oPrint:Preview()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ xCabec() บAutor ณDigicorp		     บ Data ณ  19/12/17   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime o Cabecalho do relatorio...                        บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function xCabec()

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณImprime o cabecalho da empresa. !ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		oPrint:SayBitmap(050,100,cFileLogo,0425,125,,.t.)
		oPrint:Say(050,1300,AllTrim(Upper(SM0->M0_NOMECOM)),oFont15a)
		oPrint:Say(135,1300,Upper(AllTrim(SM0->M0_ENDCOB) + SPACE(1) + Alltrim(SM0->M0_COMPCOB)),oFont11)
		oPrint:Say(180,1300,Upper(Capital(AllTrim(SM0->M0_CIDCOB))+'/'+AllTrim(SM0->M0_ESTCOB)+ '  -  ' + AllTrim(TransForm(SM0->M0_CEPCOB,'@R 99999-999'))) + '  -  ' + AllTrim(SM0->M0_TEL),oFont11)
		oPrint:Say(225,1300,AllTrim('tel.com.br'),oFont11)
		oPrint:Line(285,1300,285,2270)
		oPrint:Say(300,1300,'CNPJ:',oFont11)
		oPrint:Say(300,1400,TransForm(SM0->M0_CGC,'@R 99.999.999/9999-99'),oFont12)
		oPrint:Say(300,1900,'I.E.:',oFont11)
		oPrint:Say(300,1985,SM0->M0_INSC,oFont12)

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณTitulo do Relatorioณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		oPrint:Say(0400,0100,OemToAnsi(cTitulo),oFont20)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ xRodape()บAutor ณDigicorp			 Data ณ  18/12/17   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function xRodape()

Local cFileTotvs	:= GetSrvProfString('Startpath','') + 'totvs_logo' + '.BMP'
Local _oFont13       := TFont():New('Arial',13,13,,.T.,,,,.T.,.F.)

	If Upper(Procname(1)) <> Upper("xVerPag")
		oPrint:Line(2860,0100,2860,500)
		oPrint:Say(2900,170,"Comprador " ,_oFont13)
		oPrint:Say(2950,200,"  /  /  ",oFont20)
		//oPrint:Line(2960,0100,2960,500)
		oPrint:Line(2860,1100,2860,1500)
		oPrint:Say(2900,1130,"Ger๊ncia " ,_oFont13)
		oPrint:Say(2950,1160,"  /  /  ",oFont20)
		oPrint:Line(2860,1900,2860,2300)
		oPrint:Say(2900,2000,"Diretoria " ,_oFont13)
		oPrint:Say(2950,2030,"  /  /  ",oFont20)
	EndIF
	nPag++
	oPrint:Line(3060,0100,3060,2300)
   	oPrint:Say(3110,1300,"Pแgina: " + cValtoChar(nPag)+" -",_oFont13)
	oPrint:SayBitmap(3070,1750,cFileTotvs,455,150,,.t.)
	oPrint:Line(3210,0100,3210,2300)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ xVerPag()บAutor ณDigicorp			 บ Data ณ  18/12/17   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Verifica se deve ou nao saltar pagina...                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑศออออออออออฯออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function xVerPag()

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณInicia a montagem da impressao.ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If	( nLinha >= 3000 )

		If	( ! lFlag )
			xRodape()
			oPrint:EndPage()
			nLinha:= 600
		Else
			nLinha:= 1000
		EndIf

		oPrint:StartPage()
		xCabec()

		lPrintDesTab := .t.

	EndIf
	

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ AjustaSX1บAutor ณDigicorpบ			   Data ณ  18/12/17   บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Ajusta o SX1 - Arquivo de Perguntas..                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function AjustaSX1(cPerg)
		
Local	aRegs   := {},;
		nX

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณCampos a serem grav. no SX1ณ
		//ณaRegs[nx][01] - X1_GRUPO   ณ
		//ณaRegs[nx][02] - X1_ORDEM   ณ
		//ณaRegs[nx][03] - X1_PERGUNTEณ
		//ณaRegs[nx][04] - X1_PERSPA  ณ
		//ณaRegs[nx][05] - X1_PERENG  ณ
		//ณaRegs[nx][06] - X1_VARIAVL ณ
		//ณaRegs[nx][07] - X1_TIPO    ณ
		//ณaRegs[nx][08] - X1_TAMANHO ณ
		//ณaRegs[nx][09] - X1_DECIMAL ณ
		//ณaRegs[nx][10] - X1_PRESEL  ณ
		//ณaRegs[nx][11] - X1_GSC     ณ
		//ณaRegs[nx][12] - X1_VALID   ณ
		//ณaRegs[nx][13] - X1_VAR01   ณ
		//ณaRegs[nx][14] - X1_DEF01   ณ
		//ณaRegs[nx][15] - X1_DEF02   ณ
		//ณaRegs[nx][16] - X1_DEF03   ณ
		//ณaRegs[nx][17] - X1_F3      ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณCria uma array, contendo todos os valores...ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		aAdd(aRegs,{cPerg,'01','Numero do Pedido   ?','Numero do Pedido   ?','Numero do Pedido   ?','mv_ch1','C', 6,0,0,'G','','mv_par01','','','','SC7'})
		aAdd(aRegs,{cPerg,'02','Imprime precos     ?','Imprime precos     ?','Imprime precos     ?','mv_ch2','N', 1,0,1,'C','','mv_par02',OemToAnsi('Nใo'),'Sim','',''})
		aAdd(aRegs,{cPerg,'03','Imp. Cod. Prod. For?','Imp. Cod. Prod. For?','Imp. Cod. Prod. For?','mv_ch3','N', 1,0,1,'C','','mv_par03',OemToAnsi('Sim'),OemToAnsi('Nใo'),'',''})

		DbSelectArea('SX1')
		SX1->(DbSetOrder(1))
		IF ! SX1->(DBSEEK(cPerg))
			For nX:=1 to Len(aRegs)
				If	RecLock('SX1',.T.)
					Replace SX1->X1_GRUPO		With aRegs[nx][01]
					Replace SX1->X1_ORDEM   	With aRegs[nx][02]
					Replace SX1->X1_PERGUNTE	With aRegs[nx][03]
					Replace SX1->X1_PERSPA		With aRegs[nx][04]
					Replace SX1->X1_PERENG		With aRegs[nx][05]
					Replace SX1->X1_VARIAVL		With aRegs[nx][06]
					Replace SX1->X1_TIPO		With aRegs[nx][07]
					Replace SX1->X1_TAMANHO		With aRegs[nx][08]
					Replace SX1->X1_DECIMAL		With aRegs[nx][09]
					Replace SX1->X1_PRESEL		With aRegs[nx][10]
					Replace SX1->X1_GSC			With aRegs[nx][11]
					Replace SX1->X1_VALID		With aRegs[nx][12]
					Replace SX1->X1_VAR01		With aRegs[nx][13]
					Replace SX1->X1_DEF01		With aRegs[nx][14]
					Replace SX1->X1_DEF02		With aRegs[nx][15]
					Replace SX1->X1_DEF03		With aRegs[nx][16]
					Replace SX1->X1_F3   		With aRegs[nx][17]
					SX1->(MsUnlock())
				Else
					Help('',1,'REGNOIS')
				Endif
			
			Next nX
		ENDIF
Return