UNIT CAR006;

INTERFACE

USES
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, StdCtrls, Buttons, Grids, Wwdbigrd, Wwdbgrid, DBGrids, DB;

TYPE
   TFideaso = CLASS(TForm)
      dbgasociados: TwwDBGrid;
      btncerrar: TBitBtn;
      btnideaut: TBitBtn;
      btnbuscar: TBitBtn;
      BitBtn3: TBitBtn;
      DBGrid: TDBGrid;
      PROCEDURE FormActivate(Sender: TObject);
      PROCEDURE btncerrarClick(Sender: TObject);
      PROCEDURE btnideautClick(Sender: TObject);
      PROCEDURE btnbuscarClick(Sender: TObject);
      PROCEDURE dbgasociadosDblClick(Sender: TObject);
      PROCEDURE BitBtn3Click(Sender: TObject);
   Private
   Public
      TIPPLA: STRING;
      PROCEDURE actgridaso;
      PROCEDURE separarCuotasAportes(IAsoId: STRING; IRowId: STRING);
    { Public declarations }
   END;

VAR
   Fideaso: TFideaso;

IMPLEMENTATION

USES CAR007, CARDM1;

{$R *.dfm}
(******************************************************************************)

PROCEDURE TFideaso.FormActivate(Sender: TObject);
BEGIN
   dbgasociados.DataSource := DMPreCob.dsCuotas; //HPP_200902_PRCB
   actgridaso;
END;

(******************************************************************************)

PROCEDURE TFideaso.actgridaso;
VAR
   xSql: STRING;
   xmoncuotas,
      xNumAsociados: Double;
BEGIN
   xSql := 'SELECT ROWID IDE, ASOID, ASOCODMOD, UPROID, UPAGOID, USEID, ASOCODPAGO, '
      + '       CARGO, ASOAPENOM, MONCOB, ASOTIPID, ASODNI,TIPO,COBANO,COBMES '
      + '  FROM COB_INF_PLA_DET WHERE NUMERO = ' + QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString)
      + ' ORDER BY ASOID';
   DMPreCob.cdsCuotas.Close;
   DMPreCob.cdsCuotas.DataRequest(xSql);
   DMPreCob.cdsCuotas.Open;

   DMPreCob.cdsCuotas.First;
   WHILE NOT DMPreCob.cdsCuotas.Eof DO
   BEGIN
      xmoncuotas := xmoncuotas + DMPreCob.cdsCuotas.FieldByName('MONCOB').AsFloat;
      xNumAsociados := xNumAsociados + 1;
      DMPreCob.cdsCuotas.Next;
   END;

   dbgasociados.Selected.Clear;
   dbgasociados.Selected.Add('ASOID'#9'12'#9'Código de~identificación'#9#9);
   dbgasociados.Selected.Add('ASOCODMOD'#9'12'#9'Código~modular'#9#9);
   dbgasociados.Selected.Add('UPROID'#9'3'#9'Unidad~proceso'#9#9);
   dbgasociados.Selected.Add('UPAGOID'#9'3'#9'Unidad~pago'#9#9);
   dbgasociados.Selected.Add('USEID'#9'3'#9'Unidad~gestión'#9#9);
   dbgasociados.Selected.Add('ASOCODPAGO'#9'10'#9'Código~de pago'#9#9);
   dbgasociados.Selected.Add('CARGO'#9'8'#9'Cargo'#9#9);
   dbgasociados.Selected.Add('ASOAPENOM'#9'42'#9'Apellidos y nombre(s)'#9#9);
   dbgasociados.Selected.Add('ASOTIPID'#9'6'#9'Tipo'#9#9);
   dbgasociados.Selected.Add('MONCOB'#9'12'#9'Monto~cobrado'#9#9);
   dbgasociados.Selected.Add('ASODNI'#9'12'#9'DNI~Asociado'#9#9);
   dbgasociados.ApplySelected;
   TNumericField(DMPreCob.cdsCuotas.FieldByName('MONCOB')).DisplayFormat := '###,###,##0.00';

   dbgasociados.ColumnByName('ASOCODMOD').FooterValue := 'TOTAL';
   dbgasociados.ColumnByName('ASOAPENOM').FooterValue := floattostr(xNumAsociados) + ' Registro(s)';
   dbgasociados.ColumnByName('MONCOB').FooterValue := FloatTostrf(xmoncuotas, ffnumber, 15, 2);
   dbgasociados.RefreshDisplay;
   DMPreCob.cdsCuotas.First;
END;

(******************************************************************************)

PROCEDURE TFideaso.btnideautClick(Sender: TObject);
VAR
   xApo201, xSql, xSql1: STRING;
BEGIN
   Screen.Cursor := crHourGlass;

   DMPreCob.cdsCuotas.First;
   xApo201 := 'SELECT ASOID, ASOCODPAGO, ASOCODMOD, ASODNI, ASOAPENOM, CARGO, UPROID,UPAGOID,USEID '
      + 'from APO201 ';
   WHILE NOT DMPreCob.cdsCuotas.Eof DO
   BEGIN
      IF (Trim(DMPreCob.cdsCuotas.FieldByName('ASOID').AsString) = '')
         OR (Trim(DMPreCob.cdsCuotas.FieldByName('MONCOB').AsString) = '') THEN
      BEGIN
         IF length(DMPreCob.cdsCuotas.FieldByName('ASOCODMOD').AsString) > 0 THEN
            xSQL := xApo201
               + 'where ASOCODMOD = ' + QuotedStr(Trim(DMPreCob.cdsCuotas.FieldByName('ASOCODMOD').AsString))
               + '  and SUBSTR(ASOAPENOM,1,5) = '
               + QuotedStr(Copy(Trim(DMPreCob.cdsCuotas.FieldByName('ASOAPENOM').AsString), 1, 5))
         ELSE
            IF length(DMPreCob.cdsCuotas.FieldByName('ASODNI').AsString) > 0 THEN
               xSQL := xApo201
                  + 'where ASODNI = ' + QuotedStr(Trim(DMPreCob.cdsCuotas.FieldByName('ASODNI').AsString))
                  + '  and SUBSTR(ASOAPENOM,1,5) = '
                  + QuotedStr(Copy(Trim(DMPreCob.cdsCuotas.FieldByName('ASOAPENOM').AsString), 1, 5));
         DMPreCob.cdsQry.Close;
         DMPreCob.cdsQry.DataRequest(xSql);
         DMPreCob.cdsQry.Open;

         IF DMPreCob.cdsQry.RecordCount <> 1 THEN
         BEGIN
            IF length(DMPreCob.cdsCuotas.FieldByName('ASOCODMOD').AsString) > 0 THEN
               xSql := xApo201
                  + 'WHERE ASOCODMOD = ' + QuotedStr(Trim(DMPreCob.cdsCuotas.FieldByName('ASOCODMOD').AsString))
                  + ' AND SUBSTR(ASOAPENOM,1,5) = SUBSTR(REPLACE(' + QuotedStr(Trim(DMPreCob.cdsCuotas.FieldByName('ASOAPENOM').AsString)) + ',''Ñ'', ''N''),1,5)'
            ELSE
               IF length(DMPreCob.cdsCuotas.FieldByName('ASODNI').AsString) > 0 THEN
                  xSQL := xApo201
                     + 'where ASODNI = ' + QuotedStr(Trim(DMPreCob.cdsCuotas.FieldByName('ASODNI').AsString))
                     + ' AND SUBSTR(ASOAPENOM,1,5) = SUBSTR(REPLACE(' + QuotedStr(Trim(DMPreCob.cdsCuotas.FieldByName('ASOAPENOM').AsString)) + ',''Ñ'', ''N''),1,5)';
            DMPreCob.cdsQry.Close;
            DMPreCob.cdsQry.DataRequest(xSQL);
            DMPreCob.cdsQry.Open;
         END;

         IF DMPreCob.cdsQry.RecordCount <> 1 THEN
         BEGIN
            IF length(DMPreCob.cdsCuotas.FieldByName('ASOCODMOD').AsString) > 0 THEN
               xSql := xApo201
                  + 'WHERE ASOCODMOD = ' + QuotedStr(Trim(DMPreCob.cdsCuotas.FieldByName('ASOCODMOD').AsString))
            ELSE
               IF length(DMPreCob.cdsCuotas.FieldByName('ASODNI').AsString) > 0 THEN
                  xSQL := xApo201
                     + ' where ASODNI = ' + QuotedStr(Trim(DMPreCob.cdsCuotas.FieldByName('ASODNI').AsString));
            DMPreCob.cdsQry.Close;
            DMPreCob.cdsQry.DataRequest(xSQL);
            DMPreCob.cdsQry.Open;
         END;

         IF DMPreCob.cdsQry.RecordCount = 1 THEN
         BEGIN

(*
        If QuotedStr(TRIM(DMPreCob.cdsQry.FieldByName('USEID').AsString)) <> '' Then
          xSql := 'UPDATE COB_INF_PLA_DET '
                 +'   SET ASOID = '+QuotedStr(DMPreCob.cdsQry.FieldByName('ASOID').AsString)+', '
                 +'       ASOCODMOD = '+quotedstr(DMPreCob.cdsQry.FieldByName('ASOCODMOD').AsString)+', '
                 +'       ASODNI = '+quotedstr(DMPreCob.cdsQry.FieldByName('ASODNI').AsString)+', '
                 +'       CARGO = '+quotedstr(DMPreCob.cdsQry.FieldByName('CARGO').AsString)+', '
                 +'       UPROID = '+QuotedStr(DMPreCob.cdsQry.FieldByName('UPROID').AsString)+', '
                 +'       UPAGOID = '+QuotedStr(DMPreCob.cdsQry.FieldByName('UPAGOID').AsString)+', '
                 +'       USEID = '+QuotedStr(DMPreCob.cdsQry.FieldByName('USEID').AsString)+', '
                 +'       ASOTIPID = '+ QuotedStr(DMPreCob.cdsQry.FieldByName('ASOTIPID').AsString)+', '
                 +'       ASOCODPAGO = '+ QuotedStr(DMPreCob.cdsQry.FieldByName('ASOCODPAGO').AsString)
                 +' WHERE ROWID = '+QuotedStr(DMPreCob.cdsCuotas.FieldByName('IDE').AsString)
        Else
          xSql := 'UPDATE COB_INF_PLA_DET '
                 +'   SET ASOID = '+QuotedStr(DMPreCob.cdsQry.FieldByName('ASOID').AsString) +', '
                 +'       UPROID = NULL, '
                 +'       UPAGOID = NULL, '
                 +'       USEID = NULL,'
                 +'       ASOTIPID = '+ QuotedStr(DMPreCob.cdsQry.FieldByName('ASOTIPID').AsString)+', '
                 +'       ASOCODPAGO = '+ QuotedStr(DMPreCob.cdsQry.FieldByName('ASOCODPAGO').AsString)
                 +' WHERE ROWID = '+QuotedStr(DMPreCob.cdsCuotas.FieldByName('IDE').AsString);
*)

            xSql := 'UPDATE COB_INF_PLA_DET '
               + '   SET ASOID = ' + QuotedStr(Trim(DMPreCob.cdsQry.FieldByName('ASOID').AsString))
               + '       ,ASODNI = ' + quotedstr(Trim(DMPreCob.cdsQry.FieldByName('ASODNI').AsString))
               + '       ,ASOCODMOD = CASE WHEN ASOCODMOD IS NULL THEN ' + QuotedStr(Trim(DMPreCob.cdsQry.FieldByName('ASOCODMOD').AsString)) + ' ELSE ASOCODMOD END '
               + '       ,CARGO = CASE WHEN CARGO IS NULL THEN ' + QuotedStr(Trim(DMPreCob.cdsQry.FieldByName('CARGO').AsString)) + ' ELSE CARGO END ';

            IF (DMPreCob.cdsCuotas.FieldByName('TIPO').AsString = '2') THEN
            BEGIN
               xSql1 := 'SELECT UPROID,UPAGOID,USEID,ASOCODPAGO '
                  + '  FROM COB319 '
                  + ' WHERE COBANO = ' + QuotedStr(Trim(DMPreCob.cdsCuotas.FieldByName('COBANO').AsString))
                  + '   AND COBMES = ' + QuotedStr(Trim(DMPreCob.cdsCuotas.FieldByName('COBMES').AsString))
                  + '   AND ASOID = ' + QuotedStr(Trim(DMPreCob.cdsQry.FieldByName('ASOID').AsString));
               DMPreCob.cdsQry1.Close;
               DMPreCob.cdsQry1.DataRequest(xSql1);
               DMPreCob.cdsQry1.Open;

               IF DMPreCob.cdsQry1.RecordCount > 0 THEN
               BEGIN
                  DMPreCob.cdsQry1.First;
                  WHILE NOT DMPreCob.cdsQry1.Eof DO
                  BEGIN
                     IF ((Trim(DMPreCob.cdsQry1.FieldByName('UPROID').AsString) = Trim(DMPreCob.cdsQry.FieldByName('UPROID').AsString))
                        AND (Trim(DMPreCob.cdsQry1.FieldByName('UPAGOID').AsString) = Trim(DMPreCob.cdsQry.FieldByName('UPAGOID').AsString))) THEN
                        break;
                     DMPreCob.cdsQry1.Next;
                  END;
                       // SI LO ENCUENTRA LO CHANCA.. SI NO LO ENCUENTRA.. TOMA NUEVOS VALORES
                  xSql := xSql + ' ,UPROID = ' + QuotedStr(Trim(DMPreCob.cdsQry1.FieldByName('UPROID').AsString))
                     + ' ,UPAGOID = ' + QuotedStr(Trim(DMPreCob.cdsQry1.FieldByName('UPAGOID').AsString))
                     + ' ,USEID = ' + QuotedStr(Trim(DMPreCob.cdsQry1.FieldByName('USEID').AsString))
                     + ' ,ASOCODPAGO = CASE WHEN ASOCODPAGO IS NULL THEN' + QuotedStr(Trim(DMPreCob.cdsQry1.FieldByName('ASOCODPAGO').AsString)) + ' ELSE ASOCODPAGO END ';
               END
               ELSE // si no esta en el cob319.. coloca lo del apo201
               BEGIN
                  IF QuotedStr(TRIM(DMPreCob.cdsQry.FieldByName('USEID').AsString)) <> '' THEN
                  BEGIN
                     xSql := xSql + ' ,UPROID = ' + QuotedStr(Trim(DMPreCob.cdsQry.FieldByName('UPROID').AsString))
                        + ' ,UPAGOID = ' + QuotedStr(Trim(DMPreCob.cdsQry.FieldByName('UPAGOID').AsString))
                        + ' ,USEID = ' + QuotedStr(Trim(DMPreCob.cdsQry.FieldByName('USEID').AsString))
                        + ' ,ASOCODPAGO = CASE WHEN ASOCODPAGO IS NULL THEN' + QuotedStr(Trim(DMPreCob.cdsQry.FieldByName('ASOCODPAGO').AsString)) + ' ELSE ASOCODPAGO END ';
                  END;
               END;
            END
            ELSE
               xSql := xSql + '       ,ASOCODPAGO = CASE WHEN ASOCODPAGO IS NULL THEN ' + QuotedStr(Trim(DMPreCob.cdsQry.FieldByName('ASOCODPAGO').AsString)) + ' ELSE ASOCODPAGO END ';
               
            xSql := xSql + ' WHERE ROWID = ' + QuotedStr(Trim(DMPreCob.cdsCuotas.FieldByName('IDE').AsString));

            DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
            separarCuotasAportes(Trim(DMPreCob.cdsQry.FieldByName('ASOID').AsString), Trim(DMPreCob.cdsCuotas.FieldByName('IDE').AsString));
         END;
      END;
      DMPreCob.cdsCuotas.Next;
   END;
   actgridaso;
   Screen.Cursor := crDefault;
END;

(******************************************************************************)

PROCEDURE TFideaso.btnbuscarClick(Sender: TObject);
BEGIN
// Bucando asociado en forma manual
   IF (Trim(DMPreCob.cdsCuotas.FieldByName('ASOID').AsString) <> '')
      AND (Trim(DMPreCob.cdsCuotas.FieldByName('UPROID').AsString) <> '')
      AND (Trim(DMPreCob.cdsCuotas.FieldByName('UPAGOID').AsString) <> '')
      AND (Trim(DMPreCob.cdsCuotas.FieldByName('USEID').AsString) <> '') THEN
   BEGIN
      MessageDlg('Asociado ya identificado', mtError, [mbOk], 0);
      Exit;
   END
   ELSE
   BEGIN
      IF (Trim(DMPreCob.cdsCuotas.FieldByName('MONCOB').AsString) = '') THEN
      BEGIN
         showmessage('No tiene Monto Cobrado');
         exit;
      END;
      TRY
         Fbuscaasociado := TFbuscaasociado.Create(Self);
         Fbuscaasociado.ShowModal;
      FINALLY
         Fbuscaasociado.Free;
      END;
   END;
END;

(******************************************************************************)

PROCEDURE TFideaso.dbgasociadosDblClick(Sender: TObject);
BEGIN
   self.btnbuscarClick(self.btnbuscar);
END;

(******************************************************************************)

PROCEDURE TFideaso.btncerrarClick(Sender: TObject);
BEGIN
   Fideaso.Close;
END;

(******************************************************************************)

PROCEDURE TFideaso.BitBtn3Click(Sender: TObject);

    (*----------------------------------------*)

   FUNCTION isTodosTienenAsoid(): boolean;
   BEGIN
      DMPreCob.cdsCuotas.First;
      result := NOT ((Trim(DMPreCob.cdsCuotas.FieldByName('ASOID').AsString) = '')
         OR (Trim(DMPreCob.cdsCuotas.FieldByName('UPROID').AsString) = '')
         OR (Trim(DMPreCob.cdsCuotas.FieldByName('UPAGOID').AsString) = '')
         OR (Trim(DMPreCob.cdsCuotas.FieldByName('USEID').AsString) = ''));
   END;

    (*----------------------------------------*)

BEGIN
   IF isTodosTienenAsoid() THEN
   BEGIN
      DBGrid.DataSource := DMPreCob.dsCuotas;
      DMPreCob.HojaExcel('Reporte', DMPreCob.dsCuotas, DBGrid);
   END
   ELSE
      showmessage('Aun Existen Asociados sin Identificar!');
END;

(******************************************************************************)

PROCEDURE TFideaso.separarCuotasAportes(IAsoId: STRING; IRowId: STRING);
VAR
   xSql: STRING;
   {---------------------------------------------------------------------------}

   FUNCTION isAutDesApo(): boolean;
   BEGIN
      xSql := 'SELECT NVL(AUTDESAPO, ''N'') AUTDESAPO '
         + '  FROM APO201 '
         + ' WHERE ASOID = ' + QuotedStr(IAsoId);
      DMPreCob.cdsQry.Close;
      DMPreCob.cdsQry.DataRequest(xSql);
      DMPreCob.cdsQry.Open;
      DMPreCob.cdsQry.First;
      result := (DMPreCob.cdsQry.FieldByName('AUTDESAPO').AsString = 'S');
   END;
   {---------------------------------------------------------------------------}

   PROCEDURE pasarTodoACuotas();
   BEGIN
      xSql := 'UPDATE COB_INF_PLA_DET '
         + '   SET MONCUO = MONCOB'
         + ' WHERE ROWID = ' + QuotedStr(IRowId);
      DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
   END;
  {---------------------------------------------------------------------------}

   PROCEDURE pasarTodoAAportes();
   BEGIN
      xSql := 'UPDATE COB_INF_PLA_DET '
         + '   SET MONAPO = MONCOB'
         + ' WHERE ROWID = ' + QuotedStr(IRowId);
      DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
   END;

   {---------------------------------------------------------------------------}

   PROCEDURE realizarSeparacion();
   VAR
      xApoValor: Double;
      xMonCob: Double;
   BEGIN
      // SE OBTIENE EL VALOR DE LOS APORTES
      xSql := 'SELECT APOVALOR '
         + '  FROM APO117 '
         + ' WHERE (APOANO, APOMES) = '
         + '       (SELECT COBANO, COBMES '
         + '          FROM COB_INF_PLA_DET '
         + '         WHERE ROWID = ' + QuotedStr(IRowId) + ') ';
      DMPreCob.cdsQry.Close;
      DMPreCob.cdsQry.DataRequest(xSql);
      DMPreCob.cdsQry.Open;
      DMPreCob.cdsQry.First;
      xApoValor := DMPreCob.cdsQry.FieldByName('APOVALOR').Value;

      // SE OBTIENE EL VALOR DEL MONCOB
      xSql := 'SELECT MONCOB '
         + '  FROM COB_INF_PLA_DET '
         + ' WHERE ROWID = ' + QuotedStr(IRowId);
      DMPreCob.cdsQry.Close;
      DMPreCob.cdsQry.DataRequest(xSql);
      DMPreCob.cdsQry.Open;
      DMPreCob.cdsQry.First;
      xMonCob := DMPreCob.cdsQry.FieldByName('MONCOB').Value;
      IF xApoValor < xMonCob THEN
      BEGIN
         xSql := 'UPDATE COB_INF_PLA_DET '
            + '   SET MONAPO = ' + FloatToStr(xApoValor) + ', '
            + '       MONCUO = MONCOB - ' + FloatToStr(xApoValor)
            + ' WHERE ROWID = ' + QuotedStr(IRowId);
         DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
      END
      ELSE
         IF isAutDesApo THEN // si tiene autorizacion de descuento de aportes
            pasarTodoAAportes()
         ELSE
            pasarTodoACuotas();
   END;
   {---------------------------------------------------------------------------}
BEGIN
   IF self.TIPPLA = '1' THEN // cuotas + aportes
      realizarSeparacion()
   ELSE
      IF self.TIPPLA = '2' THEN // cuotas -> SE COLOCA TODO EN EL MONCUO
         pasarTodoACuotas()
      ELSE
         IF self.TIPPLA = '3' THEN // aportes -> SE COLOCA TODO EN EL MONAPO
            pasarTodoAAportes();

  // showmessage(QuotedStr(IRowId));
END;

END.

