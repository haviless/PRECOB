UNIT CAR009;

INTERFACE

USES
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, StdCtrls, Buttons, FileCtrl, wwdblook, Wwdbdlg, Spin, Mask,
   ExtCtrls, DBCtrls, ToolEdit, CurrEdit, ComCtrls,StrUtils;  //HPP_200902_PRCB

TYPE
   TFimptex_res = CLASS(TForm)
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
      btnprocesar: TBitBtn;
      btnSalir: TBitBtn;
      pnlBar: TPanel;
      lblTReg: TLabel;
      pbData: TProgressBar;
      gbTipoPlanilla: TGroupBox;
      rbCuotasAportes: TRadioButton;
      rbCuotas: TRadioButton;
      rbAportes: TRadioButton;
      odLeer: TOpenDialog;
      PROCEDURE btnprocesarClick(Sender: TObject);
      PROCEDURE btnSalirClick(Sender: TObject);
      PROCEDURE FormActivate(Sender: TObject);
      PROCEDURE FormKeyPress(Sender: TObject; VAR Key: Char);
      PROCEDURE dblcdupagoidExit(Sender: TObject);
      PROCEDURE dblcdasotipidExit(Sender: TObject);
      PROCEDURE dblcduproidChange(Sender: TObject);
      PROCEDURE dblcdupagoidChange(Sender: TObject);
      PROCEDURE dblcduproidExit(Sender: TObject);
      PROCEDURE dblcdasotipidChange(Sender: TObject);
   Private
    { Private declarations }
   Public
   END;

VAR
   Fimptex_res: TFimptex_res;

IMPLEMENTATION

USES CARDM1, CAR024; //HPP_200902_PRCB

{$R *.dfm}

PROCEDURE TFimptex_res.btnprocesarClick(Sender: TObject);
VAR
   archivo: TextFile;
   S, origen: STRING;
   xSql: STRING;
   xnomarc: STRING;
   xpath: STRING;
   xtippla: STRING;
   i: integer;
   xTipoArchivo: STRING; //HPP_200902_PRCB
   MFile: TStrings;
BEGIN

   seano.Text := DMPreCob.StrZero(seano.Text, 4);
   semes.Text := DMPreCob.StrZero(semes.Text, 2);

   IF Trim(dblcduproid.Text) = '' THEN
   BEGIN
      MessageDlg('Seleccione la unidad de proceso', mtInformation, [mbOk], 0);
      screen.Cursor := crDefault;
      dblcduproid.SetFocus;
      Exit;
   END;
   IF Trim(dblcdasotipid.Text) = '' THEN
   BEGIN
      MessageDlg('Seleccione tipo de asociado', mtInformation, [mbOk], 0);
      screen.Cursor := crDefault;
      dblcdasotipid.SetFocus;
      Exit;
   END;
   IF Trim(seano.Text) = '' THEN
   BEGIN
      MessageDlg('Ingrese el año del archivo a procesar', mtInformation, [mbOk], 0);
      screen.Cursor := crDefault;
      seano.SetFocus;
      Exit;
   END;
   IF Trim(semes.Text) = '' THEN
   BEGIN
      MessageDlg('Ingrese el mes del archivo a procesar', mtInformation, [mbOk], 0);
      screen.Cursor := crDefault;
      semes.SetFocus;
      Exit;
   END;

   IF NOT (rbCuotasAportes.Checked OR rbCuotas.Checked OR rbAportes.Checked) THEN
   BEGIN
      MessageDlg('Seleccione el tipo de Planilla', mtInformation, [mbOk], 0);
      Exit;
   END;

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
      + 'where UPROID=' + quotedstr(Trim(dblcduproid.Text));
   IF length(Trim(dblcdupagoid.Text)) > 0 THEN
      xSQL := xSQL + '  and UPAGOID=' + quotedstr(Trim(dblcdupagoid.Text));
   xSQL := xSQL
      + '  and TIPPLA=' + quotedstr(xtippla)
      + '  and ANOMES=' + quotedstr(seano.Text + semes.Text)
      + '  and ASOTIPID=' + quotedstr(dblcdasotipid.Text)
      + '  and TIPO=' + quotedstr('2');
   DMPreCob.cdsQry.Close;
   DMPreCob.cdsQry.DataRequest(xSql);
   DMPreCob.cdsQry.Open;
   IF DMPreCob.cdsQry.RecordCount > 0 THEN
   BEGIN
      MessageDlg('Información ya fue Migrada', mtInformation, [mbOk], 0);
      screen.Cursor := crDefault;
      Exit;
   END;

   (***********)
   screen.Cursor := crDefault;
   odLeer.Title := 'Seleccione el documento';
   odLeer.DefaultExt := '*.TXT';
   //Inicio: HPP_200902_PRCB
   odLeer.Filter := 'Archivos LIS|*.LIS|Archivos TXT|*.TXT|Archivos DBF|*.DBF';
   //Fin: HPP_200902_PRCB
   odLeer.FileName := '';

   IF NOT odLeer.Execute THEN Exit;
   //Inicio: HPP_200902_PRCB
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
   //Fin: HPP_200902_PRCB

   screen.Cursor := crHourGlass;

   xSql := 'SELECT LPAD(MAX(NVL(NUMERO,0)+1),10,''0'') NUMERO FROM COB_INF_PLA_CAB';
   DMPreCob.cdsQry.Close;
   DMPreCob.cdsQry.DataRequest(xSql);
   DMPreCob.cdsQry.Open;
   IF DMPreCob.cdsQry.FieldByName('NUMERO').AsString = '' THEN
      DMPreCob.xNumero := '0000000001'
   ELSE
      DMPreCob.xNumero := DMPreCob.cdsQry.FieldByName('NUMERO').AsString;

   // se graba la cabecera
   DMPreCob.DCOM1.AppServer.IniciaTransaccion;
   TRY
      xSql := 'INSERT INTO COB_INF_PLA_CAB(NUMERO, UPROID, UPAGOID, ANOMES, TIPPLA, USUARIO, FECHOR, ASOTIPID, TIPO,OFDESID)'
         + ' VALUES(' + QuotedStr(DMPreCob.xNumero)
         + ',' + QuotedStr(dblcduproid.Text)
         + ',' + QuotedStr(dblcdupagoid.Text)
         + ',' + QuotedStr(seano.Text + semes.Text)
         + ',' + QuotedStr(xtippla)
         + ',' + QuotedStr(DMPreCob.wUsuario) + ', SYSDATE'
         + ',' + QuotedStr(dblcdasotipid.Text)
         + ',''2'',' + QuotedStr(DMPreCob.wOfiId) + ')';
      DMPreCob.DCOM1.AppServer.EjecutaSQL(xSql);
      DMPreCob.DCOM1.AppServer.GrabaTransaccion;
   EXCEPT
      DMPreCob.DCOM1.AppServer.RetornaTransaccion;
      showmessage('No se pudo grabar la cabecera, por favor intente nuevamente');
      screen.Cursor := crDefault;
      exit;
   END;

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
            xSQL := 'insert into COB_INF_PLA_DET(NUMERO,LINEA,COBANO,COBMES,TIPO,ASOTIPID)'
               + ' values(' + quotedstr(DMPreCob.xNumero) + ',' + quotedstr(MFile[i]) + ',' + quotedstr(seano.Text) + ',' + quotedstr(semes.Text) + ','
               + '''2'',' + quotedstr(dblcdasotipid.Text) + ')';
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

PROCEDURE TFimptex_res.btnSalirClick(Sender: TObject);
BEGIN
   Fimptex_res.Close;
END;

PROCEDURE TFimptex_res.FormActivate(Sender: TObject);
VAR
   xSql: STRING;
BEGIN

   dblcduproid.LookupTable := DMPreCob.cdsUPro;
   dblcdupagoid.LookupTable := DMPreCob.cdsUPago;
   dblcdasotipid.LookupTable := DMPreCob.cdsTAso;

   xSql := 'SELECT UPROID, UPRONOM FROM APO102 WHERE UPROID IN (SELECT UPROID FROM APO101 WHERE OFDESID = ' + QuotedStr(DMPreCob.wOfiId)
      + ' GROUP BY UPROID) ORDER BY UPROID';
   DMPreCob.cdsUPro.Close;
   DMPreCob.cdsUPro.DataRequest(xSql);
   DMPreCob.cdsUPro.Open;
   dblcduproid.Selected.Clear;
   dblcduproid.Selected.Add('UPROID'#9'3'#9'Código'#9#9);
   dblcduproid.Selected.Add('UPRONOM'#9'32'#9'Descripción'#9#9);

   xSql := 'SELECT ASOTIPID, ASOTIPDES FROM APO107 WHERE ASOTIPID IN (''DO'',''CO'',''CE'')';
   DMPreCob.cdsTAso.Close;
   DMPreCob.cdsTAso.DataRequest(xSql);
   DMPreCob.cdsTAso.Open;
   dblcdasotipid.Selected.Clear;
   dblcdasotipid.Selected.Add('ASOTIPID'#9'3'#9'Código'#9#9);
   dblcdasotipid.Selected.Add('ASOTIPDES'#9'17'#9'Descripción'#9#9);
   seano.Text := Copy(DateToStr(date), 7, 4);
   semes.Text := Copy(DateToStr(date), 4, 2);
   dblcduproid.SetFocus;
END;

PROCEDURE TFimptex_res.FormKeyPress(Sender: TObject; VAR Key: Char);
BEGIN
   IF Key = #13 THEN
   BEGIN
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   END;
END;

PROCEDURE TFimptex_res.dblcduproidChange(Sender: TObject);
VAR
   xSql: STRING;
BEGIN
  //If Trim(dblcduproid.Text) = '' Then Exit;
   IF DMPreCob.cdsUPro.Locate('UPROID', dblcduproid.Text, []) THEN
   BEGIN
      meupronom.Text := DMPreCob.cdsUPro.FieldByName('UPRONOM').asstring;
      dblcdupagoid.Text := '';
      meupagonom.Text := '';
   END
   ELSE
   BEGIN
      IF NOT dblcduproid.Focused THEN dblcduproid.Text := '';
      meupronom.Text := '';
      dblcdupagoid.Text := '';
      meupagonom.Text := '';
    //dblcduproid.SetFocus;
   END;
   xSql := 'SELECT UPROID, UPAGOID, UPAGONOM FROM APO103 WHERE UPROID = ' + QuotedStr(dblcduproid.Text) + ' AND UPAGONOM IS NOT NULL';
   DMPreCob.cdsUPago.Close;
   DMPreCob.cdsUPago.DataRequest(xSql);
   DMPreCob.cdsUPago.Open;
   dblcdupagoid.Selected.Clear;
   dblcdupagoid.Selected.Add('UPAGOID'#9'3'#9'Código'#9#9);
   dblcdupagoid.Selected.Add('UPAGONOM'#9'32'#9'Descripción'#9#9);
END;

PROCEDURE TFimptex_res.dblcduproidExit(Sender: TObject);
BEGIN
   dblcduproidChange(dblcduproid);
END;

PROCEDURE TFimptex_res.dblcdupagoidChange(Sender: TObject);
BEGIN
  //If Trim(dblcdupagoid.Text) = '' Then Exit;
   IF DMPreCob.cdsUPago.Locate('UPROID;UPAGOID', VarArrayof([dblcduproid.Text, dblcdupagoid.Text]), []) THEN
   BEGIN
      meupagonom.Text := DMPreCob.cdsUPago.FieldByName('UPAGONOM').asstring;
   END
   ELSE
   BEGIN
      IF NOT dblcdupagoid.Focused THEN dblcdupagoid.Text := '';
      meupagonom.Text := '';
    //dblcdupagoid.SetFocus;
   END;
END;

PROCEDURE TFimptex_res.dblcdupagoidExit(Sender: TObject);
BEGIN
   dblcdupagoidChange(dblcdupagoid);
END;

PROCEDURE TFimptex_res.dblcdasotipidChange(Sender: TObject);
BEGIN
  //If Trim(dblcdasotipid.Text) = '' Then Exit;
   IF DMPreCob.cdsTAso.Locate('ASOTIPID', dblcdasotipid.Text, []) THEN
      measotipdes.Text := DMPreCob.cdsTAso.FieldByName('ASOTIPDES').asstring
   ELSE
   BEGIN
      IF NOT dblcdasotipid.Focused THEN dblcdasotipid.Text := '';
      measotipdes.Text := '';
      //dblcdasotipid.SetFocus;
   END;
   rbCuotasAportes.Enabled := NOT ((dblcdasotipid.Text = 'CE') OR (dblcdasotipid.Text = 'CO'));
   rbAportes.Enabled := NOT ((dblcdasotipid.Text = 'CE') OR (dblcdasotipid.Text = 'CO'));
   rbCuotas.Checked := ((dblcdasotipid.Text = 'CE') OR (dblcdasotipid.Text = 'CO')); // para q  se selecciones por defecto;
END;

PROCEDURE TFimptex_res.dblcdasotipidExit(Sender: TObject);
BEGIN
   dblcdasotipidChange(dblcdasotipid);
END;

END.

