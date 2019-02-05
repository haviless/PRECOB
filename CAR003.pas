UNIT CAR003;

INTERFACE

USES
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, StdCtrls, Buttons, FileCtrl, wwdblook, Wwdbdlg, Spin, Mask,
   ExtCtrls, DBCtrls, ToolEdit, ComCtrls;

TYPE
   Tfimptexto = CLASS(TForm)
      GroupBox1: TGroupBox;
      Label1: TLabel;
      dblcduproid: TwwDBLookupComboDlg;
      Panel1: TPanel;
      meupronom: TMaskEdit;
      Label5: TLabel;
      Label6: TLabel;
      seano: TSpinEdit;
      semes: TSpinEdit;
      Label7: TLabel;
      Label8: TLabel;
      Label3: TLabel;
      dblcdupagoid: TwwDBLookupComboDlg;
      Panel2: TPanel;
      meupagonom: TMaskEdit;
      Label4: TLabel;
      Label9: TLabel;
      Label10: TLabel;
      dblcdasotipid: TwwDBLookupComboDlg;
      Panel3: TPanel;
      measotipdes: TMaskEdit;
      Label2: TLabel;
      GroupBox2: TGroupBox;
      odLeer: TOpenDialog;
      pnlBar: TPanel;
      pbData: TProgressBar;
      btnprocesar: TBitBtn;
      btnSalir: TBitBtn;
      Label11: TLabel;
      Label12: TLabel;
      dblcduseid: TwwDBLookupComboDlg;
      Panel4: TPanel;
      meusenom: TMaskEdit;
      gbTipoPlanilla: TGroupBox;
      rbCuotasAportes: TRadioButton;
      rbCuotas: TRadioButton;
      rbAportes: TRadioButton;
      cemoncob: TEdit;
      PROCEDURE btnprocesarClick(Sender: TObject);
      PROCEDURE btnSalirClick(Sender: TObject);
      PROCEDURE FormActivate(Sender: TObject);
      PROCEDURE dblcduproidExit(Sender: TObject);
      PROCEDURE FormKeyPress(Sender: TObject; VAR Key: Char);
      PROCEDURE dblcdupagoidExit(Sender: TObject);
      PROCEDURE dblcdasotipidExit(Sender: TObject);
      PROCEDURE dblcduseidExit(Sender: TObject);
      PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
      PROCEDURE dblcduproidChange(Sender: TObject);
      PROCEDURE dblcdupagoidChange(Sender: TObject);
      PROCEDURE dblcduseidChange(Sender: TObject);
      PROCEDURE dblcdasotipidChange(Sender: TObject);
   Private
    { Private declarations }
   Public
   END;

VAR
   fimptexto: Tfimptexto;

IMPLEMENTATION

USES CARDM1, StrUtils, CAR024;

{$R *.dfm}

PROCEDURE Tfimptexto.btnprocesarClick(Sender: TObject);
VAR
   archivo: TextFile;
   S, origen: STRING;
   xSql: STRING;
   xnomarc: STRING;
   xpath: STRING;
   xtippla: STRING;
   i: integer;
   xTipoArchivo: STRING;
   MFile: TStrings;
   xMonto :double;  // HPP_200902_PRCB

   FUNCTION isParametrosValidos(): boolean;
   BEGIN
      IF Trim(cemoncob.Text) = '' THEN
      BEGIN
         MessageDlg('Ingrese monto cobrado ', mtInformation, [mbOk], 0);
         screen.Cursor := crDefault;
         cemoncob.SetFocus;
         result := false;
         Exit;
      END;
      IF Trim(dblcduproid.Text) = '' THEN
      BEGIN
         MessageDlg('Seleccione la unidad de proceso', mtInformation, [mbOk], 0);
         screen.Cursor := crDefault;
         dblcduproid.SetFocus;
         result := false;
         Exit;
      END;
      IF Trim(dblcdupagoid.Text) = '' THEN
      BEGIN
         MessageDlg('Seleccione la unidad de pago', mtInformation, [mbOk], 0);
         screen.Cursor := crDefault;
         dblcduproid.SetFocus;
         result := false;
         Exit;
      END;
      IF Trim(dblcduseid.Text) = '' THEN
      BEGIN
         MessageDlg('Seleccione la Ugel', mtInformation, [mbOk], 0);
         screen.Cursor := crDefault;
         dblcduseid.SetFocus;
         result := false;
         Exit;
      END;
      IF Trim(dblcdasotipid.Text) = '' THEN
      BEGIN
         MessageDlg('Seleccione tipo de asociado', mtInformation, [mbOk], 0);
         screen.Cursor := crDefault;
         dblcdasotipid.SetFocus;
         result := false;
         Exit;
      END;
      IF Trim(seano.Text) = '' THEN
      BEGIN
         MessageDlg('Ingrese el año del archivo a procesar', mtInformation, [mbOk], 0);
         screen.Cursor := crDefault;
         seano.SetFocus;
         result := false;
         Exit;
      END;
      IF Trim(semes.Text) = '' THEN
      BEGIN
         MessageDlg('Ingrese el mes del archivo a procesar', mtInformation, [mbOk], 0);
         screen.Cursor := crDefault;
         semes.SetFocus;
         result := false;
         Exit;
      END;
      IF NOT (rbCuotasAportes.Checked OR rbCuotas.Checked OR rbAportes.Checked) THEN
      BEGIN
         MessageDlg('Seleccione el tipo de planilla', mtInformation, [mbOk], 0);
         result := false;
         Exit;
      END;
      result := true;
   END;

BEGIN
   seano.Text := DMPreCob.StrZero(seano.Text, 4);
   semes.Text := DMPreCob.StrZero(semes.Text, 2);

   IF NOT isParametrosValidos THEN exit;

   IF rbCuotasAportes.Checked THEN
      xtippla := '1'
   ELSE
      IF rbCuotas.Checked THEN
         xtippla := '2'
      ELSE
         IF rbAportes.Checked THEN
            xtippla := '3';

   screen.Cursor := crHourGlass;
   xSQL := 'select NUMERO '
      + 'from COB_INF_PLA_CAB '
      + 'where UPROID=' + quotedstr(Trim(dblcduproid.Text))
      + '  and UPAGOID=' + quotedstr(Trim(dblcdupagoid.Text))
      + '  and USEID=' + quotedstr(Trim(dblcduseid.Text))
      + '  and TIPPLA=' + quotedstr(xtippla)
      + '  and ANOMES=' + quotedstr(seano.Text + semes.Text)
      + '  and ASOTIPID=' + quotedstr(dblcdasotipid.Text)
      + '  and TIPO=' + quotedstr('1');
   DMPreCob.cdsQry.Close;
   DMPreCob.cdsQry.DataRequest(xSql);
   DMPreCob.cdsQry.Open;
   IF DMPreCob.cdsQry.RecordCount > 0 THEN
   BEGIN
      MessageDlg('Información ya fue Migrada', mtInformation, [mbOk], 0);
      screen.Cursor := crDefault;
      Exit;
   END;

   // prepara el tipo de archivos que se pueden utilizar
   screen.Cursor := crDefault;
   odLeer.Title := 'Seleccione el documento';
   odLeer.DefaultExt := '*.TXT';
    //odLeer.Filter := 'Archivos LIS|*.LIS|Archivos TXT|*.TXT';
   odLeer.Filter := 'Archivos LIS|*.LIS|Archivos TXT|*.TXT|Archivos DBF|*.DBF';
   odLeer.FileName := '';

   IF NOT odLeer.Execute THEN Exit;

   xTipoArchivo := UpperCase(RightStr(odLeer.FileName, 3));

   // trabajar los dbf
   IF xTipoArchivo = 'DBF' THEN
   BEGIN
      FImpDBF := TFImpDBF.Create(self);
      TRY
         FImpDBF.xArchivoDBF := odLeer.FileName;
         odLeer.FileName := 'c:\tmpTxt.txt'; // nuevo archivo q sera generado
         FImpDBF.xArchivoGenerarTxt := odLeer.FileName;
         IF NOT (FImpDBF.ShowModal = mrOK) THEN exit;
      FINALLY
         FImpDBF.Free;
      END;
   END;

   screen.Cursor := crHourGlass;
   // OBTENER EL ID PARA LA CABECERA
   xSql := 'SELECT  LPAD(MAX(NVL(NUMERO,0)+1),10,''0'') NUMERO FROM COB_INF_PLA_CAB';
   DMPreCob.cdsQry.Close;
   DMPreCob.cdsQry.DataRequest(xSql);
   DMPreCob.cdsQry.Open;
   IF DMPreCob.cdsQry.FieldByName('NUMERO').AsString = '' THEN
      DMPreCob.xNumero := '0000000001'
   ELSE
      DMPreCob.xNumero := DMPreCob.cdsQry.FieldByName('NUMERO').AsString;

   // GRABAR LA CABECERA
   DMPreCob.DCOM1.AppServer.IniciaTransaccion;
   TRY
      xMonto := strtofloat(cemoncob.Text);
      xSQL := 'INSERT INTO COB_INF_PLA_CAB(NUMERO, UPROID, UPAGOID, USEID, ANOMES, TIPPLA, USUARIO, '
         + '                            FECHOR, ASOTIPID, MONTOTCOB, TIPO,OFDESID) '
         + 'VALUES(' + QuotedStr(DMPreCob.xNumero) + ','
         + QuotedStr(dblcduproid.Text) + ','
         + QuotedStr(dblcdupagoid.Text) + ','
         + QuotedStr(dblcduseid.Text) + ','
         + QuotedStr(seano.Text + semes.Text) + ','
         + QuotedStr(xtippla) + ','
         + QuotedStr(DMPreCob.wUsuario) + ', SYSDATE' + ','
         + QuotedStr(dblcdasotipid.Text) + ','
         + floattostr(xMonto) + ',''1'',' + QuotedStr(DMPreCob.wOfiId) + ')';
      DMPreCob.DCOM1.AppServer.EjecutaSQL(xSql);
      DMPreCob.DCOM1.AppServer.GrabaTransaccion;
   EXCEPT
      DMPreCob.DCOM1.AppServer.RetornaTransaccion;
      showmessage('No se pudo grabar la cabecera, por favor intente nuevamente');
      screen.Cursor := crDefault;
      exit;
   END;

   // GRABAR EL DETALLE
   DMPreCob.DCOM1.AppServer.IniciaTransaccion;
   TRY
           // se lee el archivo
           // SI OCURREL ALGUN ERROR EN LA LECTURA, TAMBIEN BORRA LA CABECERA CREADA

      MFile := TStringList.Create;
      TRY
         MFile.Clear;
         MFile.LoadFromFile(odLeer.FileName);

         pbData.Max := MFile.Count;
         pbData.Min := 0;
         pbData.Position := 0;
         pnlBar.Visible := True;
         pnlBar.Refresh;

           // GRABA EL DETALLE
         FOR i := 0 TO MFile.Count - 1 DO
         BEGIN
            xSQL := 'insert into COB_INF_PLA_DET(NUMERO,LINEA,COBANO,COBMES,TIPO,ASOTIPID,UPROID, UPAGOID, USEID)'
               + ' values(' + quotedstr(DMPreCob.xNumero) + ',' + quotedstr(MFile[i]) + ',' + quotedstr(seano.Text) + ',' + quotedstr(semes.Text) + ','
               + '''1'',' + quotedstr(dblcdasotipid.Text) + ','
               + QuotedStr(dblcduproid.Text) + ',' + QuotedStr(dblcdupagoid.Text) + ',' + QuotedStr(dblcduseid.Text)
               + ')';
            DMPreCob.DCOM1.AppServer.EjecutaSQL(xSql);
            pbData.Position := pbData.Position + 1;
            pnlBar.Refresh;
         END;
      FINALLY
         MFile.Free;
      END;

      DMPreCob.DCOM1.AppServer.GrabaTransaccion;
   EXCEPT
      DMPreCob.DCOM1.AppServer.RetornaTransaccion;
      // SE BORRA LA CABECERA QUE SE GRABO CON ATERIORIDAD
      xSQL := 'DELETE FROM COB_INF_PLA_CAB WHERE NUMERO=' + quotedstr(DMPreCob.xNumero);
      DMPreCob.DCOM1.AppServer.EjecutaSQL(xSql);
      showmessage('Ocurrio algun error.. No se pudo grabar el detalle');
      screen.Cursor := crDefault;
      exit;
   END;

   screen.Cursor := crDefault;
   DMPreCob.cdsCredito.Last;
   MessageDlg('Importación ha concluido', mtInformation, [mbOk], 0);
   close();
END;

PROCEDURE Tfimptexto.btnSalirClick(Sender: TObject);
BEGIN
   Close;
END;

PROCEDURE Tfimptexto.FormActivate(Sender: TObject);
VAR
   xSql: STRING;
BEGIN
   dblcduproid.LookupTable := DMPreCob.cdsUPro;
   dblcdupagoid.LookupTable := DMPreCob.cdsUPago;
   dblcduseid.LookupTable := DMPreCob.cdsUSE;
   dblcdasotipid.LookupTable := DMPreCob.cdsTAso;

   xSql := 'SELECT ASOTIPID, ASOTIPDES FROM APO107 WHERE ASOTIPID IN (''DO'',''CO'',''CE'')';
   DMPreCob.cdsTAso.Close;
   DMPreCob.cdsTAso.DataRequest(xSql);
   DMPreCob.cdsTAso.Open;
   dblcdasotipid.Selected.Clear;
   dblcdasotipid.Selected.Add('ASOTIPID'#9'3'#9'Código'#9#9);
   dblcdasotipid.Selected.Add('ASOTIPDES'#9'17'#9'Descripción'#9#9);
   seano.Text := Copy(DateToStr(date), 7, 4);
   semes.Text := Copy(DateToStr(date), 4, 2);

  //CARGA USE
   dblcduseid.Text := '';
   meusenom.Text := '';
   xSql := 'SELECT UPROID, UPAGOID, USEID, USENOM '
      + '  FROM APO101 '
      + ' WHERE USENOM IS NOT NULL';

   DMPreCob.cdsUSE.Close;
   DMPreCob.cdsUSE.DataRequest(xSql);
   DMPreCob.cdsUSE.Open;

   dblcduseid.Selected.Clear;
   dblcduseid.Selected.Add('USEID'#9'3'#9'Código'#9#9);
   dblcduseid.Selected.Add('USENOM'#9'32'#9'Descripción'#9#9);

  //CARGA UPAGO
   xSql := 'SELECT UPROID, UPAGOID, UPAGONOM '
      + '  FROM APO103 '
      + ' WHERE UPAGONOM IS NOT NULL';

   DMPreCob.cdsUPago.Close;
   DMPreCob.cdsUPago.DataRequest(xSql);
   DMPreCob.cdsUPago.Open;

   dblcdupagoid.Selected.Clear;
   dblcdupagoid.Selected.Add('UPAGOID'#9'3'#9'Código'#9#9);
   dblcdupagoid.Selected.Add('UPAGONOM'#9'32'#9'Descripción'#9#9);

  //CARGA UPRO
   xSql := 'SELECT UPROID, UPRONOM '
      + '  FROM APO102 '
      + ' WHERE UPROID IN (SELECT UPROID '
      + '                    FROM APO101 '
      + '                   WHERE OFDESID = ' + QuotedStr(DMPreCob.wOfiId)
      + '                   GROUP BY UPROID) '
      + ' ORDER BY UPROID';

   DMPreCob.cdsUPro.Close;
   DMPreCob.cdsUPro.DataRequest(xSql);
   DMPreCob.cdsUPro.Open;
   dblcduproid.Selected.Clear;
   dblcduproid.Selected.Add('UPROID'#9'3'#9'Código'#9#9);
   dblcduproid.Selected.Add('UPRONOM'#9'32'#9'Descripción'#9#9);

  //FILTROS
   DMPreCob.cdsUPago.Filtered := False;
   DMPreCob.cdsUPago.Filter := 'UPROID=''-.-''';
   DMPreCob.cdsUPago.Filtered := True;

   DMPreCob.cdsUSE.Filtered := False;
   DMPreCob.cdsUSE.Filter := 'UPROID=''-.-'' AND UPAGOID =''-.-''';
   DMPreCob.cdsUSE.Filtered := True;

   dblcduproid.SetFocus;
END;

PROCEDURE Tfimptexto.FormKeyPress(Sender: TObject; VAR Key: Char);
BEGIN
   IF Key = #13 THEN
   BEGIN
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   END;
END;

(******************************************************************************)

PROCEDURE Tfimptexto.FormClose(Sender: TObject; VAR Action: TCloseAction);
BEGIN
   DMPreCob.cdsUSE.Filtered := false;
   DMPreCob.cdsUPro.Filtered := false;
   DMPreCob.cdsUPago.Filtered := false;

   DMPreCob.cdsTAso.Close;
   DMPreCob.cdsUSE.Close;
   DMPreCob.cdsUPro.Close;
   DMPreCob.cdsUPago.Close;

   Action := caFree;
END;

(******************************************************************************)

PROCEDURE Tfimptexto.dblcduproidChange(Sender: TObject);
BEGIN
   IF DMPreCob.cdsUPro.Locate('UPROID', dblcduproid.Text, []) THEN
   BEGIN
      meupronom.Text := DMPreCob.cdsUPro.FieldByName('UPRONOM').asstring;
   END
   ELSE
   BEGIN
      IF NOT dblcduproid.Focused THEN dblcduproid.Text := '';
      meupronom.Text := '';
   END;
   dblcdupagoid.Text := '';
   meupagonom.Text := '';

   DMPreCob.cdsUPago.Filtered := false;
   DMPreCob.cdsUPago.Filter := 'UPROID = ' + QuotedStr(dblcduproid.Text);
   DMPreCob.cdsUPago.Filtered := true;
    //self.dblcdupagoidExit(self.dblcdupagoid);
END;

PROCEDURE Tfimptexto.dblcduproidExit(Sender: TObject);
BEGIN
   self.dblcduproidChange(self.dblcduproid);
END;

PROCEDURE Tfimptexto.dblcdupagoidChange(Sender: TObject);
BEGIN
   IF DMPreCob.cdsUPago.Locate('UPROID;UPAGOID', VarArrayof([dblcduproid.Text, dblcdupagoid.Text]), []) THEN
   BEGIN
      meupagonom.Text := DMPreCob.cdsUPago.FieldByName('UPAGONOM').asstring;
   END
   ELSE
   BEGIN
      IF NOT dblcdupagoid.Focused THEN dblcdupagoid.Text := '';
      meupagonom.Text := '';
   END;
   self.dblcduseid.Text := '';
   self.meusenom.Text := '';

   DMPreCob.cdsUSE.Filtered := False;
   DMPreCob.cdsUSE.Filter := 'UPROID=' + QuotedStr(dblcduproid.Text) + ' AND UPAGOID =' + QuotedStr(dblcdupagoid.Text);
   DMPreCob.cdsUSE.Filtered := True;

END;

PROCEDURE Tfimptexto.dblcdupagoidExit(Sender: TObject);
BEGIN
   dblcdupagoidChange(dblcdupagoid);
END;

PROCEDURE Tfimptexto.dblcduseidChange(Sender: TObject);
BEGIN
   IF DMPreCob.cdsuse.Locate('UPROID;UPAGOID;USEID', VarArrayof([dblcduproid.Text, dblcdupagoid.Text, dblcduseid.Text]), []) THEN
   BEGIN
      meusenom.Text := DMPreCob.cdsuse.FieldByName('USENOM').asstring;
   END
   ELSE
   BEGIN
      IF NOT dblcduseid.Focused THEN dblcduseid.Text := '';
      meusenom.Text := '';
   END;
END;

(******************************************************************************)

PROCEDURE Tfimptexto.dblcduseidExit(Sender: TObject);
BEGIN
   dblcduseidChange(dblcduseid);
END;

PROCEDURE Tfimptexto.dblcdasotipidChange(Sender: TObject);
BEGIN
   IF DMPreCob.cdsTAso.Locate('ASOTIPID', dblcdasotipid.Text, []) THEN
      measotipdes.Text := DMPreCob.cdsTAso.FieldByName('ASOTIPDES').asstring
   ELSE
   BEGIN
      IF NOT dblcdasotipid.Focused THEN dblcdasotipid.Text := '';
      measotipdes.Text := '';
   END;
   rbCuotasAportes.Enabled := NOT ((dblcdasotipid.Text = 'CE') OR (dblcdasotipid.Text = 'CO'));
   rbAportes.Enabled := NOT ((dblcdasotipid.Text = 'CE') OR (dblcdasotipid.Text = 'CO'));
   rbCuotas.Checked := ((dblcdasotipid.Text = 'CE') OR (dblcdasotipid.Text = 'CO')); // para q  se selecciones por defecto;
END;

(******************************************************************************)

PROCEDURE Tfimptexto.dblcdasotipidExit(Sender: TObject);
BEGIN
   dblcdasotipidChange(dblcdasotipid);
END;

(******************************************************************************)
END.

