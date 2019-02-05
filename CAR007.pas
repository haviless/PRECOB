Unit CAR007;

Interface

Uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Grids, Wwdbigrd, Wwdbgrid, Buttons, Mask, ExtCtrls;

Type
    TFbuscaasociado = Class(TForm)
        dbgbuscar: TwwDBGrid;
        btncerrar: TBitBtn;
        rgtipsel: TRadioGroup;
        pnlbuscar: TPanel;
        mebusqueda: TMaskEdit;
        btnbuscar: TBitBtn;
        Procedure btncerrarClick(Sender: TObject);
        Procedure btnbuscarClick(Sender: TObject);
        Procedure FormActivate(Sender: TObject);
        Procedure rgtipselClick(Sender: TObject);
        Procedure dbgbuscarDblClick(Sender: TObject);
    Private
    { Private declarations }
    Public
    { Public declarations }
    End;

Var
    Fbuscaasociado: TFbuscaasociado;

Implementation

Uses CAR006, CARDM1;

{$R *.dfm}

Procedure TFbuscaasociado.btncerrarClick(Sender: TObject);
Begin
    Fbuscaasociado.Close;
End;

Procedure TFbuscaasociado.btnbuscarClick(Sender: TObject);
Var
    xSql: String;
Begin
    If rgtipsel.ItemIndex = 0 Then
        xSql := 'SELECT A.ASOID, A.ASOCODMOD, A.ASODNI, A.ASOAPENOM, A.UPROID, A.UPAGOID, A.USEID, B.USENOM, A.ASOTIPID, A.ASOCODPAGO FROM APO201 A, APO101 B WHERE ASOAPENOM LIKE ' + QuotedStr(Trim(mebusqueda.Text) + '%')
            + ' AND A.UPROID = B.UPROID(+) AND A.UPAGOID = B.UPAGOID(+) AND A.USEID = B.USEID(+)'
    Else
        If rgtipsel.ItemIndex = 1 Then
            xSql := 'SELECT A.ASOID, A.ASOCODMOD, A.ASODNI, A.ASOAPENOM, A.UPROID, A.UPAGOID, A.USEID, B.USENOM, A.ASOTIPID, A.ASOCODPAGO FROM APO201 A, APO101 B WHERE ASOCODMOD LIKE ' + QuotedStr(Trim(mebusqueda.Text) + '%')
                + ' AND A.UPROID = B.UPROID(+) AND A.UPAGOID = B.UPAGOID(+) AND A.USEID = B.USEID(+)'
        Else
            If rgtipsel.ItemIndex = 2 Then
                xSql := 'SELECT A.ASOID, A.ASOCODMOD, A.ASODNI, A.ASOAPENOM, A.UPROID, A.UPAGOID, '
                    + '       A.USEID, B.USENOM, A.ASOTIPID, A.ASOCODPAGO '
                    + 'FROM APO201 A, APO101 B '
                    + 'WHERE ASODNI LIKE ' + QuotedStr(Trim(mebusqueda.Text) + '%')
                    + '  AND A.UPROID = B.UPROID(+) AND A.UPAGOID = B.UPAGOID(+) AND A.USEID = B.USEID(+)';
    DMPreCob.cdsAso.Close;
    DMPreCob.cdsAso.DataRequest(xSql);
    DMPreCob.cdsAso.Open;
End;

Procedure TFbuscaasociado.FormActivate(Sender: TObject);
Var
    xSql: String;
Begin
    rgtipsel.ItemIndex := 1;
    mebusqueda.Text := DMPreCob.cdsCuotas.FieldByName('ASOCODMOD').AsString;
    xSql := 'SELECT A.ASOID, A.ASOCODMOD, A.ASODNI, A.ASOAPENOM, '
        + '       A.UPROID, A.UPAGOID, A.USEID, B.USENOM, A.ASOTIPID, A.ASOCODPAGO '
        + '  FROM APO201 A, APO101 B '
        + 'WHERE ASOAPENOM LIKE ' + QuotedStr(Trim(mebusqueda.Text) + '%')
        + '   AND A.UPROID = B.UPROID(+) AND A.UPAGOID = B.UPAGOID(+) AND A.USEID = B.USEID(+)';
    DMPreCob.cdsAso.Close;
    DMPreCob.cdsAso.DataRequest(xSql);
    DMPreCob.cdsAso.Open;
    dbgbuscar.Selected.Clear;
    dbgbuscar.Selected.Add('ASOCODMOD'#9'10'#9'Código~modular'#9#9);
    dbgbuscar.Selected.Add('ASODNI'#9'8'#9'DNI'#9#9);
    dbgbuscar.Selected.Add('ASOAPENOM'#9'42'#9'Apellidos y nombres(s)'#9#9);
    dbgbuscar.Selected.Add('UPROID'#9'3'#9'Unidad~proceso'#9#9);
    dbgbuscar.Selected.Add('UPAGOID'#9'3'#9'Unidad~pago'#9#9);
    dbgbuscar.Selected.Add('USEID'#9'3'#9'Unidad~gestión'#9#9);
    dbgbuscar.Selected.Add('USENOM'#9'25'#9'Descripció~unidad de gestión'#9#9);
    dbgbuscar.Selected.Add('ASOTIPID'#9'6'#9'Tipo'#9#9);
    dbgbuscar.Selected.Add('ASOCODPAGO'#9'25'#9'Codigo Pago'#9#9);
    dbgbuscar.ApplySelected;
    btnbuscar.OnClick(btnbuscar);
    Fbuscaasociado.Top := 280;
    Fbuscaasociado.Left := 59;

{
  dbgCabecera.Selected.Clear;
  dbgCabecera.Selected.Add('FECPRO'#9'12'#9'Fecha de~Proceso'#9#9);
  dbgCabecera.Selected.Add('NUMCUE'#9'10'#9'Número de~Cuenta'#9#9);
  dbgCabecera.Selected.Add('CANTOT'#9'10'#9'Cantidad de Pagos~Realizados'#9#9);
  dbgCabecera.Selected.Add('CODMON'#9'12'#9'Tipo de~Moneda'#9#9);
  dbgCabecera.Selected.Add('MONTOT'#9'15'#9'Monto Total~Pagado'#9#9);
  dbgCabecera.Selected.Add('CODSUC'#9'12'#9'Código de~sucursal'#9#9);
  dbgCabecera.Selected.Add('CIERRE'#9'12'#9'Estado del~descargo'#9#9);
  dbgCabecera.ApplySelected;
  TNumericField(DMPreCob.cdsCuentas.FieldByName('MONTOT')).DisplayFormat := '###,###,##0.00';
  TNumericField(DMPreCob.cdsCuentas.FieldByName('CANTOT')).DisplayFormat := '###,###,##0';
  dbgAportes.ColumnByName('TRANSCUO').FooterValue := FloatToStrF(DMPreCob.OperClientDataSet(DMPreCob.cdsAutdisk , 'SUM(TRANSCUO)',''), ffNumber, 15, 2);
}

End;

Procedure TFbuscaasociado.rgtipselClick(Sender: TObject);
Begin
    If rgtipsel.ItemIndex = 0 Then
    Begin
        mebusqueda.Text := DMPreCob.cdsCuotas.FieldByName('ASOAPENOM').AsString;
        mebusqueda.Width := 383;
        pnlbuscar.Width := 384;
        btnbuscar.Left := 458;
    End
    Else
        If rgtipsel.ItemIndex = 1 Then
        Begin
            mebusqueda.Text := DMPreCob.cdsCuotas.FieldByName('ASOCODMOD').AsString;
            mebusqueda.Width := 80;
            pnlbuscar.Width := 81;
            btnbuscar.Left := 155;
        End
        Else
            If rgtipsel.ItemIndex = 2 Then
            Begin
                mebusqueda.Text := DMPreCob.cdsCuotas.FieldByName('ASODNI').AsString;
                mebusqueda.Width := 60;
                pnlbuscar.Width := 61;
                btnbuscar.Left := 151;
            End;
End;

Procedure TFbuscaasociado.dbgbuscarDblClick(Sender: TObject);
Var
    xSql, xSql1: String;
    xuproid, xupagoid, xuseid, xasocodpago: String;
Begin
    If MessageDlg('¿Seguro que selecciono el asociado correcto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes Then
    Begin

    (*

    if QuotedStr(TRIM(DMPreCob.cdsAso.FieldByName('USEID').AsString))<>'' then
      xSql := 'UPDATE COB_INF_PLA_DET '
             +'   SET ASOID = '+QuotedStr(DMPreCob.cdsAso.FieldByName('ASOID').AsString) +', '
             +'       UPROID = '+QuotedStr(DMPreCob.cdsAso.FieldByName('UPROID').AsString)+', '
             +'       UPAGOID = '+QuotedStr(DMPreCob.cdsAso.FieldByName('UPAGOID').AsString)+','
             +'       USEID = '+QuotedStr(DMPreCob.cdsAso.FieldByName('USEID').AsString)+','
             +'       ASOTIPID = '+QuotedStr(DMPreCob.cdsAso.FieldByName('ASOTIPID').AsString)+','
             +'       ASOCODPAGO = '+QuotedStr(DMPreCob.cdsAso.FieldByName('ASOCODPAGO').AsString)
             +' WHERE ROWID = '+QuotedStr(DMPreCob.cdsCuotas.FieldByName('IDE').AsString)
    else
      xSql := 'UPDATE COB_INF_PLA_DET '
             +'   SET ASOID = '+QuotedStr(DMPreCob.cdsAso.FieldByName('ASOID').AsString) +', '
             +'       UPROID = NULL, '
             +'       UPAGOID = NULL,'
             +'       USEID = NULL,'
             +'       ASOTIPID = '+QuotedStr(DMPreCob.cdsAso.FieldByName('ASOTIPID').AsString)+', '
             +'       ASOCODPAGO = '+QuotedStr(DMPreCob.cdsAso.FieldByName('ASOCODPAGO').AsString)
             +' WHERE ROWID = '+QuotedStr(DMPreCob.cdsCuotas.FieldByName('IDE').AsString);

      *)

        xSql := 'UPDATE COB_INF_PLA_DET '
            + '   SET ASOID = ' + QuotedStr(DMPreCob.cdsAso.FieldByName('ASOID').AsString)
            + '       ,ASODNI = ' + quotedstr(DMPreCob.cdsAso.FieldByName('ASODNI').AsString);
        If (DMPreCob.cdsCuotas.FieldByName('TIPO').AsString = '2') Then
        Begin
            xSql1 := 'SELECT UPROID,UPAGOID,USEID,ASOCODPAGO '
                + '  FROM COB319 '
                + ' WHERE COBANO = ' + QuotedStr(DMPreCob.cdsCuotas.FieldByName('COBANO').AsString)
                + '   AND COBMES = ' + QuotedStr(DMPreCob.cdsCuotas.FieldByName('COBMES').AsString)
                + '   AND ASOID = ' + QuotedStr(DMPreCob.cdsAso.FieldByName('ASOID').AsString);
            DMPreCob.cdsQry1.Close;
            DMPreCob.cdsQry1.DataRequest(xSql1);
            DMPreCob.cdsQry1.Open;

            If DMPreCob.cdsQry1.RecordCount > 0 Then
            Begin
                DMPreCob.cdsQry1.First;
                While Not DMPreCob.cdsQry1.Eof Do
                Begin
                    If ((DMPreCob.cdsQry1.FieldByName('UPROID').AsString = DMPreCob.cdsAso.FieldByName('UPROID').AsString)
                        And (DMPreCob.cdsQry1.FieldByName('UPAGOID').AsString = DMPreCob.cdsAso.FieldByName('UPAGOID').AsString)) Then
                        break;
                    DMPreCob.cdsQry1.Next;
                End;
                       // SI LO ENCUENTRA LO CHANCA.. SI NO LO ENCUENTRA.. TOMA NUEVOS VALORES
                xSql := xSql + ' ,UPROID = ' + QuotedStr(DMPreCob.cdsQry1.FieldByName('UPROID').AsString)
                    + ' ,UPAGOID = ' + QuotedStr(DMPreCob.cdsQry1.FieldByName('UPAGOID').AsString)
                    + ' ,USEID = ' + QuotedStr(DMPreCob.cdsQry1.FieldByName('USEID').AsString)
                    + ' ,ASOCODPAGO = ' + QuotedStr(DMPreCob.cdsQry1.FieldByName('ASOCODPAGO').AsString);
                xuproid := DMPreCob.cdsQry1.FieldByName('UPROID').AsString;
                xupagoid := DMPreCob.cdsQry1.FieldByName('UPAGOID').AsString;
                xuseid := DMPreCob.cdsQry1.FieldByName('USEID').AsString;
                xasocodpago := DMPreCob.cdsQry1.FieldByName('ASOCODPAGO').AsString;
            End
            Else // si no esta en el cob319.. coloca lo del apo201
            Begin
                If QuotedStr(TRIM(DMPreCob.cdsAso.FieldByName('USEID').AsString)) <> '' Then
                Begin
                    xSql := xSql + ' ,UPROID = ' + QuotedStr(DMPreCob.cdsAso.FieldByName('UPROID').AsString)
                        + ' ,UPAGOID = ' + QuotedStr(DMPreCob.cdsAso.FieldByName('UPAGOID').AsString)
                        + ' ,USEID = ' + QuotedStr(DMPreCob.cdsAso.FieldByName('USEID').AsString)
                        + ' ,ASOCODPAGO = ' + QuotedStr(DMPreCob.cdsAso.FieldByName('ASOCODPAGO').AsString);
                    xuproid := DMPreCob.cdsAso.FieldByName('UPROID').AsString;
                    xupagoid := DMPreCob.cdsAso.FieldByName('UPAGOID').AsString;
                    xuseid := DMPreCob.cdsAso.FieldByName('USEID').AsString;
                    xasocodpago := DMPreCob.cdsAso.FieldByName('ASOCODPAGO').AsString;
                End;
            End;
        End;
        xSql := xSql + ' WHERE ROWID = ' + QuotedStr(DMPreCob.cdsCuotas.FieldByName('IDE').AsString);

        DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
        Fideaso.separarCuotasAportes(DMPreCob.cdsAso.FieldByName('ASOID').AsString, DMPreCob.cdsCuotas.FieldByName('IDE').AsString);
        DMPreCob.cdsCuotas.Edit;
        DMPreCob.cdsCuotas.FieldByName('ASOID').AsString := DMPreCob.cdsAso.FieldByName('ASOID').AsString;
        DMPreCob.cdsCuotas.FieldByName('ASOTIPID').AsString := DMPreCob.cdsAso.FieldByName('ASOTIPID').AsString;
        DMPreCob.cdsCuotas.FieldByName('UPROID').AsString := xuproid;
        DMPreCob.cdsCuotas.FieldByName('UPAGOID').AsString := xupagoid;
        DMPreCob.cdsCuotas.FieldByName('USEID').AsString := xuseid;
        DMPreCob.cdsCuotas.FieldByName('ASOCODPAGO').AsString := xasocodpago;
        DMPreCob.cdsCuotas.Post;
        DMPreCob.cdsCuotas.First;
        MessageDlg('Actualización correcta', mtInformation, [mbOk], 0);
    End;
    Fbuscaasociado.Close;
End;

End.

