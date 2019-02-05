Unit CAR023;

Interface

Uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Spin, Mask, StdCtrls, Buttons, ExtCtrls, wwdblook, Wwdbdlg,
    Grids, Wwdbigrd, Wwdbgrid, ComCtrls, DBGrids, db, ppBands, ppCache,
    ppClass, ppDB, ppDBPipe, ppDBBDE, ppComm, ppRelatv, ppProd, ppReport,
    ppCtrls, ppPrnabl, ppVar, ppEndUsr, ppParameter, CARFRA001, CARFRA002,
    ImgList, DBClient;

Type
    TFEnvVsCobVsPrecob = Class(TForm)
        pagecontrol: TPageControl;
        DBGrid: TDBGrid;
        TabSheet3: TTabSheet;
        dbgprevioresgeneral: TwwDBGrid;
        ImageList1: TImageList;
        gbFiltro: TGroupBox;
        Label1: TLabel;
        Label5: TLabel;
        dblcdUPro: TwwDBLookupComboDlg;
        meUPro: TMaskEdit;
        meUPago: TMaskEdit;
        dblcdUPago: TwwDBLookupComboDlg;
        bbtnBuscar: TBitBtn;
        Panel1: TPanel;
        lblNroRegistros: TLabel;
        BitBtn3: TBitBtn;
        BitBtn1: TBitBtn;
        cmbAnho: TComboBox;
        Label2: TLabel;
        cmbMes: TComboBox;
        Label3: TLabel;
        Procedure FormActivate(Sender: TObject);
        Procedure BitBtn1Click(Sender: TObject);
        Procedure BitBtn3Click(Sender: TObject);
        Procedure FormKeyPress(Sender: TObject; Var Key: Char);
        Procedure dbgprevioresgeneralDblClick(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure dbgprevioresgeneralCalcCellColors(Sender: TObject;
            Field: TField; State: TGridDrawState; Highlight: Boolean;
            AFont: TFont; ABrush: TBrush);
        Procedure dbgprevioresgeneralTitleButtonClick(Sender: TObject;
            AFieldName: String);
        Procedure dblcdUProChange(Sender: TObject);
        Procedure dblcdUPagoChange(Sender: TObject);
        Procedure dblcdUProExit(Sender: TObject);
        Procedure dblcdUPagoExit(Sender: TObject);
        Procedure bbtnBuscarClick(Sender: TObject);
        Procedure dbgprevioresgeneralCalcTitleImage(Sender: TObject;
            Field: TField; Var TitleImageAttributes: TwwTitleImageAttributes);
        Procedure dbgprevioresgeneralMouseMove(Sender: TObject;
            Shift: TShiftState; X, Y: Integer);
    Private
        xtippla: String;
        Procedure gridResumenGeneral;
        Procedure cargarUProceso();
        Procedure cargarUPago();
        Procedure filtrarUPago(IUProId: String);
        Procedure DoSorting(cdsName: TClientDataset; AFieldName: String);
        Procedure asignarColorFilas;
        Procedure cargarDatos(IAnho, IMes, IUproId, IUPagoId: String);
    Public
    { Public declarations }
    End;

Var
    FEnvVsCobVsPrecob: TFEnvVsCobVsPrecob;

Implementation

Uses CARDM1, CAR019, CAR025, StrUtils;

{$R *.dfm}

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.FormActivate(Sender: TObject);
Var
    xSql: String;
    xFechasys: TDate;
Begin
    DMPreCob.cdsQry10.Close;
    dbgprevioresgeneral.DataSource := DMPreCob.dsQry10;
    self.cargarUProceso();
    self.cargarUPago();

    self.dblcdUPro.text := '';
    self.meUPro.Text := '';

    self.filtrarUPago('-.-');
    xFechasys := DMPreCob.FechaSys;

    cmbAnho.ItemIndex := StrToInt(RightStr(DateToStr(xFechasys), 4)) - 2000;
    cmbMes.ItemIndex := StrToInt(MidStr(DateToStr(xFechasys), 4, 2)) - 1;

End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.cargarDatos(IAnho, IMes, IUproId, IUPagoId: String);
Var
    xSQL: String;
    xSTRMonCob: String;
    xSTRMonEnv: String;
    xSTRTipPla: String;
    xWhere: String;
Begin
    Screen.Cursor := crHourGlass;

    xWhere := '';
    If (trim(IUproId) <> '') Or (trim(IUPagoId) <> '') Then
    Begin
        If (trim(IUproId) <> '') Then
            xWhere := xWhere + ' AND COB.UPROID=' + QuotedStr(trim(IUProId));
        If (trim(IUPagoId) <> '') Then
            xWhere := xWhere + ' AND COB.UPAGOID=' + QuotedStr(trim(IUPagoId));
    End;
(*
   xSQL:='SELECT ''N'' COLOREADO, COBANO,COBMES, '
        +'       DPTO.DPTODES, '
        +'       COB.UPROID, COB.UPAGOID, COB.USEID, '
        +'       SUM(1) CANT_COB319, '
        +'       SUM(CASE WHEN SUBSTR(COB304_EXISTE,1,9) =''SI_COB304'' THEN 1 ELSE 0 END) SI_COB304, '
        +'       SUM(CASE WHEN SUBSTR(PRECOB_EXISTE_UTIL,1,9) =''SI_PRECOB'' THEN 1 ELSE 0 END) SI_PRECOB_UTIL, '
        +'       SUM(CASE WHEN SUBSTR(PRECOB_EXISTE_RESUL,1,9) =''SI_PRECOB'' THEN 1 ELSE 0 END) SI_PRECOB_RESUL, '
        +'       SUM(CASE WHEN SUBSTR(COB304_EXISTE,1,9) =''NO_COB304'' THEN 1 ELSE 0 END) NO_COB304, '
        +'       SUM(CASE WHEN SUBSTR(PRECOB_EXISTE_UTIL,1,9) =''NO_PRECOB'' THEN 1 ELSE 0 END) NO_PRECOB_UTIL, '
        +'       SUM(CASE WHEN SUBSTR(PRECOB_EXISTE_RESUL,1,9) =''NO_PRECOB'' THEN 1 ELSE 0 END) NO_PRECOB_RESUL '
        +'  FROM COB_ENV_COB_PRE  COB, '
        +'       APO101 UGEL, '
        +'       APO158 DPTO '
        +' WHERE COBANO= '+QuotedStr(IAnho)
        +'   AND COBMES= '+QuotedStr(IMes)
        +'   AND COB.UPROID = UGEL.UPROID(+) '
        +'   AND COB.UPAGOID = UGEL.UPAGOID(+) '
        +'   AND COB.USEID = UGEL.USEID(+) '
        +'   AND UGEL.DPTOID=DPTO.DPTOID(+) ';
   xSQL:=xSQL+xWhere;
   xSQL:=xSQL
        +' GROUP BY COBANO, COBMES, DPTO.DPTODES, COB.UPROID, COB.UPAGOID, COB.USEID '
        +' ORDER BY COBANO, COBMES, DPTO.DPTODES, COB.UPROID, COB.UPAGOID, COB.USEID ';
*)

    xSQL := 'SELECT ''N'' COLOREADO, COBANO,COBMES, '
        + '       DPTO.DPTODES, '
        + '       COB.UPROID, COB.UPAGOID, COB.USEID, '
        + '       SUM(1) CANT_COB319, ';
    If (IAnho + IMes) = '200810' Then // esto es solo xq el 200810 se proceso de una forma distinta
        xSQL := xSQL + 'SUM(CASE WHEN SUBSTR(COB304_EXISTE,1,9) =''SI_COB304'' THEN 1 ELSE 0 END) SI_COB304, '
            + 'SUM(CASE WHEN SUBSTR(COB304_EXISTE,1,9) =''NO_COB304'' THEN 1 ELSE 0 END) NO_COB304, '
    Else
        xSQL := xSQL + 'SUM(CASE WHEN COB304_EXISTE =''SI_COB304_PK'' THEN 1 ELSE 0 END) SI_COB304, '
            + 'SUM(CASE WHEN (COB304_EXISTE =''NO_COB304'' '
            + '               OR COB304_EXISTE =''SI_PRECOB_ASOID'') THEN 1 ELSE 0 END) NO_COB304, ';

    xSQL := xSQL + ' SUM(CASE WHEN PRECOB_EXISTE_RESUL =''SI_PRECOB_PK'' THEN 1 ELSE 0 END) SI_PRECOB_RESUL, '
        + '       SUM(CASE WHEN (PRECOB_EXISTE_RESUL =''NO_PRECOB'') '
        + '                      OR (PRECOB_EXISTE_RESUL =''SI_PRECOB_ASOID'') THEN 1 ELSE 0 END) NO_PRECOB_RESUL '
        + '  FROM COB_ENV_COB_PRE COB, '
        + '       APO101 UGEL, '
        + '       APO158 DPTO '
        + ' WHERE COBANO= ' + QuotedStr(IAnho)
        + '   AND COBMES= ' + QuotedStr(IMes)
        + '   AND COB.UPROID = UGEL.UPROID(+) '
        + '   AND COB.UPAGOID = UGEL.UPAGOID(+) '
        + '   AND COB.USEID = UGEL.USEID(+) '
        + '   AND UGEL.DPTOID=DPTO.DPTOID(+) ';
    xSQL := xSQL + xWhere;
    xSQL := xSQL
        + ' GROUP BY COBANO, COBMES, DPTO.DPTODES, COB.UPROID, COB.UPAGOID, COB.USEID '
        + ' ORDER BY COBANO, COBMES, DPTO.DPTODES, COB.UPROID, COB.UPAGOID, COB.USEID ';

    DMPreCob.cdsQry10.Close;
    DMPreCob.cdsQry10.DataRequest(xSql);
    DMPreCob.cdsQry10.Open;

    asignarColorFilas();

    gridresumenGeneral;
   //agrupar(dbgprevioresgeneral,'DPTODES');

    pagecontrol.TabIndex := 0;
    Screen.Cursor := crDefault;

    Dbgprevioresgeneral.SetFocus;

End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.asignarColorFilas();
Var
    xColoreado, xTmpCambioColor: String;
Begin
    DMPreCob.cdsQry10.First;
    xColoreado := 'S';
    xTmpCambioColor := DMPreCob.cdsQry10.FieldByName('DPTODES').AsString;
    While Not DMPreCob.cdsQry10.EOF Do
    Begin
        DMPreCob.cdsQry10.Edit;
        DMPreCob.cdsQry10.FieldByName('COLOREADO').AsString := xColoreado;
        DMPreCob.cdsQry10.Post;
        DMPreCob.cdsQry10.next;
        If DMPreCob.cdsQry10.FieldByName('DPTODES').AsString <> xTmpCambioColor Then
        Begin
            If xColoreado = 'S' Then
                xColoreado := 'N'
            Else
                xColoreado := 'S';
            xTmpCambioColor := DMPreCob.cdsQry10.FieldByName('DPTODES').AsString;
        End;
    End;
    DMPreCob.cdsQry10.First;

End;
(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.BitBtn1Click(Sender: TObject);
Begin
    Close;
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.BitBtn3Click(Sender: TObject);
Begin
    Case pagecontrol.TabIndex Of
        0:
            Begin
                DBGrid.DataSource := DMPreCob.dsQry10;
                DMPreCob.HojaExcel('Reporte', DMPreCob.dsQry10, DBGrid);
            End;
    End;

End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.FormKeyPress(Sender: TObject; Var Key: Char);
Begin
    If Key = #13 Then
    Begin
        Key := #0;
        Perform(CM_DIALOGKEY, VK_TAB, 0);
    End;
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.gridResumenGeneral;
Var
    xCantCob319,
        xSiCob304, xNoCob304,
        xSiPrecobResul,
        xNoPrecobResul: Double;
    xNroRegistros: Double;
Begin
    xCantCob319 := 0;
    xSiCob304 := 0;
    xNoCob304 := 0;
    xSiPrecobResul := 0;
    xNoPrecobResul := 0;
    xNroRegistros := 0;

    If DMPreCob.cdsQry10.Active Then
    Begin
        DMPreCob.cdsQry10.First;
        While Not DMPreCob.cdsQry10.Eof Do
        Begin
            xCantCob319 := xCantCob319 + DMPreCob.cdsQry10.FieldByName('CANT_COB319').AsFloat;
            xSiCob304 := xSiCob304 + DMPreCob.cdsQry10.FieldByName('SI_COB304').AsFloat;
            xNoCob304 := xNoCob304 + DMPreCob.cdsQry10.FieldByName('NO_COB304').AsFloat;
            xSiPrecobResul := xSiPrecobResul + DMPreCob.cdsQry10.FieldByName('SI_PRECOB_RESUL').AsFloat;
            xNoPrecobResul := xNoPrecobResul + DMPreCob.cdsQry10.FieldByName('NO_PRECOB_RESUL').AsFloat;
            xNroRegistros := xNroRegistros + 1;
            DMPreCob.cdsQry10.Next;
        End;

        self.lblNroRegistros.Caption := FloatToStr(xNroRegistros) + ' Registros encontrados';

        dbgPrevioResGeneral.Selected.Clear;
        dbgPrevioResGeneral.Selected.Add('COBANO'#9'5'#9'Año');
        dbgPrevioResGeneral.Selected.Add('COBMES'#9'5'#9'Mes');
        dbgPrevioResGeneral.Selected.Add('DPTODES'#9'3'#9'Departamento');
        dbgPrevioResGeneral.Selected.Add('UPROID'#9'3'#9'Und.~Proceso');
        dbgPrevioResGeneral.Selected.Add('UPAGOID'#9'5'#9'Und.~Pago');
        dbgPrevioResGeneral.Selected.Add('USEID'#9'8'#9'Ugel');
        dbgPrevioResGeneral.Selected.Add('CANT_COB319'#9'12'#9'Generacion~de Planilla~por Cobranzas');
        dbgPrevioResGeneral.Selected.Add('SI_COB304'#9'12'#9'Descargo~de Planilla~por Cobranzas');
        dbgPrevioResGeneral.Selected.Add('SI_PRECOB_RESUL'#9'12'#9'Descargo~de TERPCRE');
        dbgPrevioResGeneral.Selected.Add('NO_COB304'#9'10'#9'NO Cobrado~por descargo~de Planilla');
        dbgPrevioResGeneral.Selected.Add('NO_PRECOB_RESUL'#9'10'#9'NO Considerado~en el descuento~de la Unidad de Proceso~según descargo de TERPCRE');

        dbgPrevioResGeneral.ApplySelected;
        TNumericField(DMPreCob.cdsQry10.FieldByName('CANT_COB319')).DisplayFormat := '###,###,##0';
        TNumericField(DMPreCob.cdsQry10.FieldByName('SI_COB304')).DisplayFormat := '###,###,##0';
        TNumericField(DMPreCob.cdsQry10.FieldByName('SI_PRECOB_RESUL')).DisplayFormat := '###,###,##0';
        TNumericField(DMPreCob.cdsQry10.FieldByName('NO_COB304')).DisplayFormat := '###,###,##0';
        TNumericField(DMPreCob.cdsQry10.FieldByName('NO_PRECOB_RESUL')).DisplayFormat := '###,###,##0';

        dbgPrevioResGeneral.ColumnByName('USEID').FooterValue := 'TOTAL';
        dbgPrevioResGeneral.ColumnByName('CANT_COB319').FooterValue := FloatToStrF(xCantCob319, ffnumber, 15, 0);
        dbgPrevioResGeneral.ColumnByName('SI_COB304').FooterValue := FloatTostrf(xSiCob304, ffnumber, 15, 0);
        dbgPrevioResGeneral.ColumnByName('SI_PRECOB_RESUL').FooterValue := FloatTostrf(xSiPrecobResul, ffnumber, 15, 0);
        dbgPrevioResGeneral.ColumnByName('NO_COB304').FooterValue := FloatTostrf(xNoCob304, ffnumber, 15, 0);
        dbgPrevioResGeneral.ColumnByName('NO_PRECOB_RESUL').FooterValue := FloatTostrf(xNoPrecobResul, ffnumber, 15, 0);
        dbgPrevioResGeneral.RefreshDisplay;
        DMPreCob.cdsQry10.First;
    End;
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.dbgprevioresgeneralDblClick(Sender: TObject);

Begin
  //showmessage( dbgprevioresgeneral.FieldName(dbgprevioresgeneral.GetActiveCol-1));
    If (dbgprevioresgeneral.FieldName(dbgprevioresgeneral.GetActiveCol) = 'NO_PRECOB_RESUL')
        Or (dbgprevioresgeneral.FieldName(dbgprevioresgeneral.GetActiveCol) = 'NO_COB304') Then
    Begin
        FEnvVsCobVsPrecob_Det := TFEnvVsCobVsPrecob_Det.create(self);
        Try
            FEnvVsCobVsPrecob_Det.XCOBANO := DMPreCob.cdsQry10.FieldByName('COBANO').AsString;
            FEnvVsCobVsPrecob_Det.XCOBMES := DMPreCob.cdsQry10.FieldByName('COBMES').AsString;
            FEnvVsCobVsPrecob_Det.XUPROID := DMPreCob.cdsQry10.FieldByName('UPROID').AsString;
            FEnvVsCobVsPrecob_Det.XUPAGOID := DMPreCob.cdsQry10.FieldByName('UPAGOID').AsString;
            FEnvVsCobVsPrecob_Det.XUSEID := DMPreCob.cdsQry10.FieldByName('USEID').AsString;
            FEnvVsCobVsPrecob_Det.XTIPO := dbgprevioresgeneral.FieldName(dbgprevioresgeneral.GetActiveCol);
            FEnvVsCobVsPrecob_Det.showmodal;
        Finally
            FEnvVsCobVsPrecob_Det.free;
        End
    End;
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.FormClose(Sender: TObject;
    Var Action: TCloseAction);
Begin
    DMPreCob.cdsUPro.Filtered := false;
    DMPreCob.cdsUPro.Close;
    DMPreCob.cdsUPago.Filtered := false;
    DMPreCob.cdsUPago.Close;
    Try
        If DMPreCob.cdsQry10.IndexDefs.Count > 0 Then
        Begin
            DMPreCob.cdsQry10.DeleteIndex('w2wTempIndex');
            DMPreCob.cdsQry10.IndexDefs.Update;
        End;
    Except
    End;
    DMPreCob.cdsQry10.Filtered := false;
    DMPreCob.cdsQry10.Close;
    Action := caFree;
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.dbgprevioresgeneralCalcCellColors(Sender: TObject;
    Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
    ABrush: TBrush);
Begin
    If dblcdUPro.Text = '' Then
    Begin
        AFont.Color := clBlack;
        If DMPreCob.cdsQry10.FieldByName('COLOREADO').AsString = 'S' Then
            ABrush.Color := clMoneyGreen //clInfoBk //$0084FF84 // $00DFFFDF
        Else
            ABrush.Color := clwhite;
    End;

    If (Field.FieldName = 'NO_PRECOB_RESUL') Then
    Begin
        If DMPreCob.cdsQry10.FieldByName('NO_PRECOB_RESUL').Value > DMPreCob.cdsQry10.FieldByName('NO_COB304').Value Then
        Begin
            AFont.Color := clRed;
            AFont.Style := [fsBold];
        End
        Else
        Begin
            If DMPreCob.cdsQry10.FieldByName('NO_PRECOB_RESUL').Value = 0 Then
                AFont.Color := clBlack
            Else
            Begin
                AFont.Color := clBlue;
                AFont.Style := [fsBold];
            End;
        End;
    End;
    If Highlight Then
    Begin
        AFont.Color := clwhite;
        ABrush.Color := clblue;
    End;
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.DoSorting(cdsName: TClientDataset; AFieldName: String);
Const
    NONSORTABLE: Set Of TFieldType = [ftBlob, ftMemo, ftOraBlob, ftOraCLob];
Begin

    Try
        With cdsName Do
        Begin
            If IsEmpty Or (FieldByName(AFieldName).DataType In NONSORTABLE) Then
                Exit;

            If (IndexFieldNames = AFieldName) Then
            Begin
                IndexDefs.Update;
                If IndexDefs.IndexOf('w2wTempIndex') > -1 Then
                Begin
                    DeleteIndex('w2wTempIndex');
                    IndexDefs.Update;
                End;
                AddIndex('w2wTempIndex', AFieldName, [ixDescending, ixCaseInsensitive], '', '', 0);
                IndexName := 'w2wTempIndex';
            End
            Else
            Begin
                IndexFieldNames := AFieldName;
            End;
        End;
    Finally
    End;
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.dbgprevioresgeneralTitleButtonClick(Sender: TObject;
    AFieldName: String);
Begin
    DoSorting(TClientDataset((Sender As TwwDBGrid).Datasource.Dataset), AFieldName);
    asignarColorFilas();
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.cargarUProceso();
Var
    xSQL: String;
Begin
    self.dblcdUPro.Text := '';
    self.meUPro.Text := '';

    xSQL := 'SELECT * FROM APO102';

    DMPreCob.cdsUPro.Close;
    DMPreCob.cdsUPro.DataRequest(xSQL);
    DMPreCob.cdsUPro.Open;

    self.dblcdUPro.LookupField := '';
    self.dblcdUPro.LookupTable := DMPreCob.cdsUPro;
    self.dblcdUPro.LookupField := 'UPROID';
    self.dblcdUPro.Selected.Clear;
    self.dblcdUPro.Selected.Add('UPROID'#9'6'#9'UPro'#9#9);
    self.dblcdUPro.Selected.Add('UPRONOM'#9'25'#9'Nombre'#9#9);
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.cargarUPago();
Var
    xSQL: String;
Begin
    self.dblcdUPago.Text := '';
    self.meUPago.Text := '';
    xSQL := 'SELECT * FROM APO103';

    DMPreCob.cdsUPago.Close;
    DMPreCob.cdsUPago.DataRequest(xSQL);
    DMPreCob.cdsUPago.Open;

    self.dblcdUPago.LookupField := '';
    self.dblcdUPago.LookupTable := DMPreCob.cdsUPago;
    self.dblcdUPago.LookupField := 'UPAGOID';
    self.dblcdUPago.Selected.Clear;
    self.dblcdUPago.Selected.Add('UPAGOID'#9'6'#9'UPago'#9#9);
    self.dblcdUPago.Selected.Add('UPAGONOM'#9'25'#9'Nombre'#9#9);
End;

(******************************************************************************)
Procedure TFEnvVsCobVsPrecob.filtrarUPago(IUProId: String);
Begin
    DMPreCob.cdsUPago.Filtered := false;
    DMPreCob.cdsUPago.Filter := 'UPROID=' + quotedstr(IUProId);
    DMPreCob.cdsUPago.Filtered := true;
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.dblcdUProChange(Sender: TObject);
Begin
    If DMPreCob.cdsUPro.Locate('UPROID', VarArrayof([self.dblcdUPro.text]), []) Then
        self.meUPro.Text := DMPreCob.cdsUPro.FieldByName('UPRONOM').AsString
    Else
    Begin
        If Not dblcdUPro.Focused Then dblcdUPro.Text := '';
        self.meUPro.text := '';
    End;
    self.dblcdUPago.Text := '';
    self.meUPago.Text := '';
    self.filtrarUPago(self.dblcdUPro.text);
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.dblcdUProExit(Sender: TObject);
Begin
    dblcdUProChange(dblcdUPro);
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.dblcdUPagoChange(Sender: TObject);
Begin
    If DMPreCob.cdsUPago.Locate('UPAGOID', VarArrayof([self.dblcdUPago.text]), []) Then
    Begin
        self.meUPago.Text := DMPreCob.cdsUPago.FieldByName('UPAGONOM').AsString;
    End
    Else
    Begin
        If Not dblcdUPago.Focused Then dblcdUPago.Text := '';
        self.meUPago.text := '';
    End;
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.dblcdUPagoExit(Sender: TObject);
Begin
    dblcdUPagoChange(dblcdUPago);
End;

(******************************************************************************)

Procedure TFEnvVsCobVsPrecob.bbtnBuscarClick(Sender: TObject);
Begin
    If DMPreCob.wEsSupervisor Then
    Begin
        cargarDatos(cmbAnho.Text, cmbMes.Text, dblcdUPro.Text, dblcdUPago.Text);
    End
End;

(******************************************************************************)
Procedure TFEnvVsCobVsPrecob.dbgprevioresgeneralCalcTitleImage(Sender: TObject;
    Field: TField; Var TitleImageAttributes: TwwTitleImageAttributes);
Begin
    With (Sender As TwwDBGrid) Do
        If Field.FieldName = TClientDataset(Datasource.Dataset).indexfieldnames Then
        Begin
            TitleImageAttributes.ImageIndex := 0;
        End
        Else
            If TClientDataset(Datasource.Dataset).indexname = 'w2wTempIndex' Then
            Begin
                TClientDataset(Datasource.Dataset).indexdefs.Update;
                If TClientDataset(Datasource.Dataset).indexdefs.Find('w2wTempIndex').Fields = Field.Fieldname Then
                    TitleImageAttributes.ImageIndex := 1;
            End;

End;

(******************************************************************************)
Procedure TFEnvVsCobVsPrecob.dbgprevioresgeneralMouseMove(Sender: TObject;
    Shift: TShiftState; X, Y: Integer);
Begin
    If (Not (DMPreCob.cdsQry10.State = dsInactive) And (DMPreCob.cdsQry10.RecordCount > 0)) Then
    Begin
        If (dbgprevioresgeneral.FieldName(dbgprevioresgeneral.MouseCoord(X, Y).X) = 'NO_PRECOB_RESUL')
            Or (dbgprevioresgeneral.FieldName(dbgprevioresgeneral.MouseCoord(X, Y).X) = 'NO_COB304') Then
            dbgprevioresgeneral.Cursor := crHandPoint
        Else
            dbgprevioresgeneral.Cursor := crDefault;
    End;
End;

(******************************************************************************)

End.

