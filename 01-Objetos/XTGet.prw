#Include "Protheus.Ch"
User Function XTGet()
	Local oDlg
	Local oSay
	Local oGet, oFont
	Local cVar := space(30)
	Local bSay := { || "Mensagem" }
	Local bGet := { |u| IIF(PCount()>0,cVar:=u,cVar )}

	DEFINE MSDIALOG oDlg FROM 0,0 TO 200,500 TITLE 'Teste TGet()' PIXEL

	oFont   := TFont():New('Courier new',,-16,.T.)
	oSay := TSay():New(010,010,bSay,oDlg,,,,,,.T.,,)
	oSay:lTransparent:= .F.

	oGet := TGet():New(010,040,bGet,,,7,"@!",,,,oFont,,,.T.,,,,,.T.,)
	//TGet():New( [ nRow ], [ nCol ], [ bSetGet ], [ oWnd ], [ nWidth ], [ nHeight ], [ cPict ], [ bValid ], [ nClrFore ], [ nClrBack ], [ oFont ], [ uParam12 ], [ uParam13 ], [ lPixel ], [ uParam15 ], [ uParam16 ], [ bWhen ], [ uParam18 ], [ uParam19 ], [ bChange ], [ lReadOnly ], [ lPassword ], [ uParam23 ], [ cReadVar ], [ uParam25 ], [ uParam26 ], [ uParam27 ], [ lHasButton ], [ lNoButton ], [ uParam30 ], [ cLabelText ], [ nLabelPos ], [ oLabelFont ], [ nLabelColor ], [ cPlaceHold ], [ lPicturePriority ], [ lFocSel ] )

	oGet:cF3 := 'SA1'
	ACTIVATE MSDIALOG oDlg CENTERED

Return