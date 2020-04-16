#Include "Protheus.Ch"
User Function xTgroup()
	Local oGroup, oGroup2, oDlg
	Private cGet1	:= Space(30)
	Private cGet2	:= Space(30)
	Private cGet3	:= Space(30)
	Private cGet4	:= Space(30)
	Private oGet1 ,oGet2, oGet3, oGet4

	DEFINE MSDIALOG oDlg FROM 0,0 TO 410,410 TITLE "Teste Tgroup" PIXEL
	//Grupo 1
	oGroup:= tGroup():New(010,010,100,200,"Grupo 1",oDlg,,,.T.)
	@ 030,030 MSGET oGet1 VAR cGet1 SIZE 100,010 OF oGroup PIXEL
	@ 050,030 MSGET oGet2 VAR cGet2 SIZE 100,010 OF oGroup PIXEL
	@ 080,030 BUTTON 'OK' SIZE 030,015 OF oGroup PIXEL ACTION Vld()
	//Grupo 2
	oGroup2:= tGroup():New(110,010,200,200,"Grupo 2",oDlg,,,.T.)
	@ 130,030 MSGET oGet3 VAR cGet3 SIZE 100,010 OF oGroup2 PIXEL WHEN .F.
	@ 150,030 MSGET oGet4 VAR cGet4 SIZE 100,010 OF oGroup2 PIXEL WHEN .F.
	@ 180,030 Button 'Salvar' Size 45,10 OF oGroup PIXEL ACTION ( TK271CallCenter(,,3) ) 
	
	ACTIVATE MSDIALOG oDlg CENTERED

Return NIL

//Função de Validação.
Static Function Vld()
	cGet3 := cGet1
	cGet4 := cGet2
	oGet3:Refresh()
	oGet4:Refresh() //metodo 
Return
