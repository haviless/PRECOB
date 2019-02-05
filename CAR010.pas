unit CAR010;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, wwdblook,
  DBCtrls, Wwdbspin, Mask, wwdbedit, Buttons, Wwdbdlg, db;

type
  TFproinfpla_res = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    dbgcabecera: TwwDBGrid;
    StaticText1: TStaticText;
    sbBase: TScrollBox;
    dbgPlantilla: TwwDBGrid;
    GroupBox2: TGroupBox;
    dbgdetalle: TwwDBGrid;
    dbgcabeceraIButton: TwwIButton;
    btntransferir: TBitBtn;
    pnlCab: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    bbtnOkC: TBitBtn;
    bbtnCancC: TBitBtn;
    pnlDet: TPanel;
    Label9: TLabel;
    bbtnOkD: TBitBtn;
    bbtnCancD: TBitBtn;
    gbposicion: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    spDesde: TwwDBSpinEdit;
    spHasta: TwwDBSpinEdit;
    menombre: TMaskEdit;
    pnlcodigo: TPanel;
    mecodigo: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    dbgdetalleIButton: TwwIButton;
    dblcdnomcam: TwwDBLookupComboDlg;
    StaticText2: TStaticText;
    Label4: TLabel;
    pnl: TPanel;
    medescam: TMaskEdit;
    StaticText3: TStaticText;
    GroupBox3: TGroupBox;
    dbgtransferido: TwwDBGrid;
    BitBtn3: TBitBtn;
    btnelireg: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure dbgcabeceraCellChanged(Sender: TObject);
    procedure dbgcabeceraIButtonClick(Sender: TObject);
    procedure bbtnOkCClick(Sender: TObject);
    procedure bbtnCancCClick(Sender: TObject);
    procedure dbgcabeceraDblClick(Sender: TObject);
    procedure dbgdetalleIButtonClick(Sender: TObject);
    procedure bbtnCancDClick(Sender: TObject);
    procedure dblcdnomcamExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure bbtnOkDClick(Sender: TObject);
    procedure dbgdetalleDblClick(Sender: TObject);
    procedure btntransferirClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btneliregClick(Sender: TObject);
  private
    procedure actcabpla;
    procedure actdetpla;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fproinfpla_res: TFproinfpla_res;

implementation

uses CARDM1;


{$R *.dfm}

procedure TFproinfpla_res.FormActivate(Sender: TObject);
Var xlin1, xlin2, xSql:String;
   xcol:Integer;
begin
  Screen.Cursor := crHourGlass;
  xSql := 'SELECT LINEA FROM COB_INF_PLA_DET WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
  DMPreCob.cdsQry4.Close;
  DMPreCob.cdsQry4.DataRequest(xSql);
  DMPreCob.cdsQry4.Open;
  xLin1 := '         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22        23        24        25';
  xLin2 := '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';  
  xCol := 250;
  DMPreCob.cdsQry4.FieldByName('LINEA').DisplayLabel := Copy(xLin1,1,xCol)+'~'+Copy(xLin2,1,xCol);
  DMPreCob.cdsQry4.FieldByName('LINEA').DisplayWidth := xCol;
  xSql := 'SELECT * FROM COB_CAM_MIG_PLA';
  DMPreCob.cdsQry3.Close;
  DMPreCob.cdsQry3.DataRequest(xSql);
  DMPreCob.cdsQry3.Open;
  dblcdnomcam.Selected.Clear;
  dblcdnomcam.Selected.Add('NOMCAM'#9'15'#9'Código'#9#9);
  dblcdnomcam.Selected.Add('DESCAM'#9'30'#9'Descripción'#9#9);
  actcabpla;
  Screen.Cursor := crDefault;
  If DMPreCob.cdsQry2.Active = True Then DMPreCob.cdsQry2.Close;
end;

procedure TFproinfpla_res.dbgcabeceraCellChanged(Sender: TObject);
begin
  actdetpla;
end;

procedure TFproinfpla_res.dbgcabeceraIButtonClick(Sender: TObject);
begin
  DMPreCob.xCnd := 'I';
  pnlCab.Visible := True;
  pnlCab.Left := 54;
  pnlCab.Top := 213;
  menombre.SetFocus;
end;

procedure TFproinfpla_res.bbtnOkCClick(Sender: TObject);
Var xSql, xcodpla :String;
begin
  If Trim(menombre.Text) = '' Then
  Begin
    MessageDlg('Ingrese nombre de la plantilla', mtError, [mbOk], 0);
    menombre.SetFocus;
    Exit;
  End;
  If DMPreCob.xCnd = 'I' Then
  Begin
    If MessageDlg('¿ Seguro de insertar nueva plantilla?' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
    Begin
      xSql := 'SELECT LPAD(NVL(MAX(PLANTILLA),0)+1,5,''0'') PLANTILLA FROM COB_INF_PLA_MAS_CAB';
      DMPreCob.cdsQry.Close;
      DMPreCob.cdsQry.DataRequest(xSql);
      DMPreCob.cdsQry.Open;
      xcodpla := DMPreCob.cdsQry.FieldByName('PLANTILLA').AsString;
      xSql := 'INSERT INTO COB_INF_PLA_MAS_CAB (PLANTILLA, NOMBRE, USUARIO, HREG, OFDESID, TIPO)'
      +' VALUES ('+QuotedStr(xcodpla)+','+QuotedStr(menombre.Text)+','+QuotedStr(DMPreCob.wUsuario)
      +', SYSDATE,+'+QuotedStr(DMPreCob.wOfiId)
      +','+QuotedStr(DMPreCob.cdsCredito.FieldByName('TIPO').AsString)+')';
      DMPreCob.DCOM1.AppServer.EjecutaSql(xSQL);
      MessageDlg('Registro insertado', mtInformation , [mbOk], 0);
      actcabpla;
      pnlCab.Visible := False;
    End;
  End;
  If DMPreCob.xCnd = 'M' Then
  Begin
    If MessageDlg('¿ Seguro de modificar el nombre de la plantilla?' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
    Begin
      xSql := 'UPDATE COB_INF_PLA_MAS_CAB SET NOMBRE = '+QuotedStr(menombre.Text)+' WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry5.FieldByName('PLANTILLA').AsString);
      DMPreCob.DCOM1.AppServer.EjecutaSql(xSQL);
      MessageDlg('Registro modificado', mtInformation , [mbOk], 0);
      actcabpla;
      pnlCab.Visible := False;
    End;
  End;
end;

procedure TFproinfpla_res.bbtnCancCClick(Sender: TObject);
begin
  pnlCab.Visible := False;
end;

procedure TFproinfpla_res.actcabpla;
Var xSql, xplantilla, xflg :String;
begin
  xflg := 'N';
  If DMPreCob.cdsQry5.Active = True Then
  Begin
    xplantilla := DMPreCob.cdsQry5.FieldByName('PLANTILLA').AsString;
    xflg := 'S';
  End;
  xSql := 'SELECT PLANTILLA, NOMBRE FROM COB_INF_PLA_MAS_CAB A WHERE'
  +' TIPO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('TIPO').AsString)
  +' AND OFDESID = '+QuotedStr(DMPreCob.wOfiId);
  DMPreCob.cdsQry5.Close;
  DMPreCob.cdsQry5.DataRequest(xSql);
  DMPreCob.cdsQry5.Open;
  dbgCabecera.Selected.Clear;
  dbgCabecera.Selected.Add('PLANTILLA'#9'5'#9'Plantilla'#9#9);
  dbgCabecera.Selected.Add('NOMBRE'#9'30'#9'Descripción'#9#9);
  dbgCabecera.ApplySelected;
  If xflg = 'S' Then DMPreCob.cdsQry5.Locate('PLANTILLA',xplantilla,[]);
end;

procedure TFproinfpla_res.dbgcabeceraDblClick(Sender: TObject);
begin
  DMPreCob.xCnd := 'M';
  pnlCab.Visible := True;
  mecodigo.Text := DMPreCob.cdsQry5.FieldByName('PLANTILLA').AsString;
  menombre.Text := DMPreCob.cdsQry5.FieldByName('NOMBRE').AsString;
end;

procedure TFproinfpla_res.actdetpla;
Var xSql, xplantilla, xitem :String;
begin
  // actualizando detalle de plantilla
  xplantilla := '';
  xitem      := '';
  If DMPreCob.cdsQry6.Active = True Then
  Begin
    xplantilla := DMPreCob.cdsQry6.FieldByName('PLANTILLA').AsString;
    xitem      := DMPreCob.cdsQry6.FieldByName('ITEM').AsString;
  End;

  xSql := 'SELECT PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, TIPCAM '
         +'FROM COB_INF_PLA_MAS_DET '
         +'WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry5.FieldByName('PLANTILLA').AsString)
         +' ORDER BY ITEM';
  DMPreCob.cdsQry6.Close;
  DMPreCob.cdsQry6.DataRequest(xSql);
  DMPreCob.cdsQry6.Open;
  dbgdetalle.Selected.Clear;
  dbgdetalle.Selected.Add('CAMPO'#9'15'#9'Campo'#9#9);
  dbgdetalle.Selected.Add('NOMBRE'#9'25'#9'Descripción'#9#9);
  dbgdetalle.Selected.Add('DESDE'#9'6'#9'Posición~inicial'#9#9);
  dbgdetalle.Selected.Add('HASTA'#9'6'#9'Posición~final'#9#9);
  dbgdetalle.ApplySelected;

  If xplantilla <> '' Then DMPreCob.cdsQry6.Locate('PLANTILLA;ITEM',VarArrayof([xplantilla, xitem]),[]);

end;

procedure TFproinfpla_res.dbgdetalleIButtonClick(Sender: TObject);
begin
  DMPreCob.xCnd := 'I';
  dblcdnomcam.Text := '';
  medescam.Text    := '';
  spDesde.Text     := '';
  spHasta.Text     := '';
  pnlDet.Visible := True;
  pnlDet.Top     := 201;
  pnlDet.Left    := 330;
end;

procedure TFproinfpla_res.bbtnCancDClick(Sender: TObject);
begin
  pnlDet.Visible := False;
end;

procedure TFproinfpla_res.dblcdnomcamExit(Sender: TObject);
begin
  medescam.Text := DMPreCob.cdsQry3.FieldByName('DESCAM').AsString;
end;

procedure TFproinfpla_res.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key=#13 Then
  Begin
    key:=#0;
    perform(CM_DialogKey,VK_TAB,0);
  End;
end;

procedure TFproinfpla_res.bbtnOkDClick(Sender: TObject);
Var xSql:String;
    xitem, xlongitud :Integer;

begin
  If Trim(dblcdnomcam.Text) = '' Then
  Begin
    MessageDlg('Ingrese nombre del campo', mtError, [mbOk], 0);
    menombre.SetFocus;
    Exit;
  End;
  If Trim(spDesde.Text) = '' Then
  Begin
    MessageDlg('Ingrese la posición inicial', mtError, [mbOk], 0);
    spDesde.SetFocus;
    Exit;
  End;
  If Trim(spHasta.Text) = '' Then
  Begin
    MessageDlg('Ingrese la posición final', mtError, [mbOk], 0);
    spHasta.SetFocus;
    Exit;
  End;
  xlongitud := (StrToInt(spHasta.text)-StrToInt(spDesde.Text))+1;

  If DMPreCob.cdsQry3.FieldByName('CAMFIJ').AsString = 'S' Then
  Begin
    If DMPreCob.cdsQry3.FieldByName('TAMMAXCAP').AsInteger <> xlongitud Then
    Begin
      MessageDlg('El Tamaño del campo'#13'solo puede ser de '+DMPreCob.cdsQry3.FieldByName('TAMMAXCAP').AsString, mtError, [mbOk], 0);
      spHasta.SetFocus;
      Exit;
    End;
  End
  Else
  Begin
    If DMPreCob.cdsQry3.FieldByName('TAMMAXCAP').AsInteger < xlongitud Then
    Begin
      MessageDlg('El Tamaño maximo del campo'#13'no puede exceder de '+DMPreCob.cdsQry3.FieldByName('TAMMAXCAP').AsString, mtError, [mbOk], 0);
      spHasta.SetFocus;
      Exit;
    End;
  End;

  If DMPreCob.xCnd = 'I' Then
  Begin
    If MessageDlg('¿Seguro de insertar nuevo detalle de la plantilla?' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
    Begin
      xSql := 'SELECT NVL(MAX(ITEM),0)+1 ITEM FROM COB_INF_PLA_MAS_DET WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry5.FieldByName('PLANTILLA').AsString);
      DMPreCob.cdsQry.Close;
      DMPreCob.cdsQry.DataRequest(xSql);
      DMPreCob.cdsQry.Open;
      xitem := DMPreCob.cdsQry.FieldByName('ITEM').AsInteger;
      xSql := 'INSERT INTO COB_INF_PLA_MAS_DET (PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, TIPCAM, USUARIO, HREG)'
      +' VALUES ('+QuotedStr(DMPreCob.cdsQry5.FieldByName('PLANTILLA').AsString)
      +','+IntToStr(xitem)
      +','+QuotedStr(dblcdnomcam.Text)
      +','+QuotedStr(medescam.Text)
      +','+spDesde.Text
      +','+spHasta.Text
      +','+QuotedStr(DMPreCob.cdsQry3.FieldByName('TIPCAM').AsString)
      +','+QuotedStr(DMPreCob.wUsuario)
      +', SYSDATE)';
      DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
      MessageDlg('Registro insertado', mtInformation , [mbOk], 0);
      actdetpla;
      pnlCab.Visible := False;
    End;
  End;
  If DMPreCob.xCnd = 'M' Then
  Begin
    If MessageDlg('¿Seguro de modificar nuevo detalle de la plantilla?' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
    Begin
      xSql := 'UPDATE COB_INF_PLA_MAS_DET SET CAMPO = '+QuotedStr(dblcdnomcam.Text)
      +', NOMBRE = '+QuotedStr(medescam.Text)
      +', DESDE  = '+spDesde.Text
      +', HASTA  = '+spHasta.Text
      +', TIPCAM   = '+QuotedStr(DMPreCob.cdsQry6.FieldByName('TIPCAM').AsString)
      +' WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry6.FieldByName('PLANTILLA').AsString)+' AND ITEM = '+QuotedStr(DMPreCob.cdsQry6.FieldByName('ITEM').AsString);
      DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
      MessageDlg('Registro modificado', mtInformation , [mbOk], 0);
      actdetpla;
      pnlCab.Visible := False;
    End;
  End;
end;

procedure TFproinfpla_res.dbgdetalleDblClick(Sender: TObject);
begin
    DMPreCob.xCnd := 'M';
    pnlDet.Visible   := True;
    dblcdnomcam.Text := DMPreCob.cdsQry6.FieldByName('CAMPO').AsString;
    medescam.Text    := DMPreCob.cdsQry6.FieldByName('NOMBRE').AsString;
    spDesde.Text     := DMPreCob.cdsQry6.FieldByName('DESDE').AsString;
    spHasta.Text     := DMPreCob.cdsQry6.FieldByName('HASTA').AsString;
    DMPreCob.cdsQry3.Locate('NOMCAM', dblcdnomcam.Text, []);
    dblcdnomcam.SetFocus;
end;

procedure TFproinfpla_res.btntransferirClick(Sender: TObject);
Var xSql, xflg:String;
    xpos, xInicioRes:Integer;
    xcampos:String;
    xmoncob:Double;
    //xmonenv:Double;
begin
// Verificando si existe el campo COD.MOD
  xSQL := 'SELECT * FROM COB_INF_PLA_MAS_DET '
         +'WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry5.FieldByName('PLANTILLA').AsString)
         +' AND CAMPO = ''ASOCODMOD''';
  DMPreCob.cdsQry.Close;
  DMPreCob.cdsQry.DataRequest(xSql);
  DMPreCob.cdsQry.Open;
  If DMPreCob.cdsQry.RecordCount <> 1 Then
  Begin
     xSql := 'SELECT * FROM COB_INF_PLA_MAS_DET '
            +'WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry5.FieldByName('PLANTILLA').AsString)
            +'  AND CAMPO = ''ASODNI'' ';
     DMPreCob.cdsQry.Close;
     DMPreCob.cdsQry.DataRequest(xSql);
     DMPreCob.cdsQry.Open;
     If DMPreCob.cdsQry.RecordCount <> 1 Then
     Begin
        MessageDlg('La plantilla seleccionada no contiene ni el campo ASOCODMOD ni el campo ASODNI'#13'Incluya el campo dentro de la plantilla', mtError, [mbOk], 0);
        Exit;
     end;
  End;
// Verificando si existe el campo ASOAPENOM
  xSql := 'SELECT * FROM COB_INF_PLA_MAS_DET WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry5.FieldByName('PLANTILLA').AsString)
  +' AND CAMPO = ''ASOAPENOM''';
  DMPreCob.cdsQry.Close;
  DMPreCob.cdsQry.DataRequest(xSql);
  DMPreCob.cdsQry.Open;
  If DMPreCob.cdsQry.RecordCount <> 1 Then
  Begin
    MessageDlg('La plantilla seleccionada no contiene el campo ASOAPENOM'#13'Incluya el campo dentro de la plantilla', mtError, [mbOk], 0);
    Exit;
  End;
// Verificando si existe el campo CARGO
  (*
  xSql := 'SELECT * FROM COB_INF_PLA_MAS_DET WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry5.FieldByName('PLANTILLA').AsString)
  +' AND CAMPO = ''CARGO''';
  DMPreCob.cdsQry.Close;
  DMPreCob.cdsQry.DataRequest(xSql);
  DMPreCob.cdsQry.Open;
  If DMPreCob.cdsQry.RecordCount <> 1 Then
  Begin
    MessageDlg('La plantilla seleccionada no contiene el campo CARGO'#13'Incluya el campo dentro de la plantilla', mtError, [mbOk], 0);
    Exit;
  End;
  *)
// Verificando si existe el campo MON_COB
  xSql := 'SELECT * FROM COB_INF_PLA_MAS_DET WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry5.FieldByName('PLANTILLA').AsString)
  +' AND CAMPO = ''MONCOB''';
  DMPreCob.cdsQry.Close;
  DMPreCob.cdsQry.DataRequest(xSql);
  DMPreCob.cdsQry.Open;
  If DMPreCob.cdsQry.RecordCount <> 1 Then
  Begin
    MessageDlg('La plantilla seleccionada no contiene el campo MONCOB'#13'Incluya el campo dentro de la plantilla', mtError, [mbOk], 0);
    Exit;
  End;

// Verificando si existe el campo RESULTADO
  xSql := 'SELECT * FROM COB_INF_PLA_MAS_DET WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry5.FieldByName('PLANTILLA').AsString)
  +' AND CAMPO = ''RESULTADO''';
  DMPreCob.cdsQry.Close;
  DMPreCob.cdsQry.DataRequest(xSql);
  DMPreCob.cdsQry.Open;
  If DMPreCob.cdsQry.RecordCount <> 1 Then
  Begin
    MessageDlg('La plantilla seleccionada no contiene el campo RESULTADO'#13'Incluya el campo dentro de la plantilla', mtError, [mbOk], 0);
    Exit;
  End;

  Screen.Cursor := crHourGlass;

// DETERMINA COLUMNA INICIAL DE CAMPO RESULTADO
  xInicioRes := 0;
  DMPreCob.cdsQry6.First;
  While Not DMPreCob.cdsQry6.Eof Do
  begin
     if DMPreCob.cdsQry6.FieldByName('CAMPO').AsString='RESULTADO' then
     begin
        xInicioRes := DMPreCob.cdsQry6.FieldByName('DESDE').AsInteger;
        break;
     end;
     DMPreCob.cdsQry6.Next;
  end;

  DMPreCob.cdsQry6.First;
  xSql    := 'UPDATE COB_INF_PLA_DET SET ';
  xflg := '';
  While Not DMPreCob.cdsQry6.Eof Do
  Begin
    If xflg = 'X' Then
    Begin
     xSql := xSql + ',';
    End;
    xpos := (DMPreCob.cdsQry6.FieldByName('HASTA').AsInteger-DMPreCob.cdsQry6.FieldByName('DESDE').AsInteger)+1;
    If DMPreCob.cdsQry6.FieldByName('TIPCAM').AsString = 'C' Then // TIPO CHARACTER
    Begin
      xSql := xSql + DMPreCob.cdsQry6.FieldByName('CAMPO').AsString
      +' = SUBSTR(LINEA,'+DMPreCob.cdsQry6.FieldByName('DESDE').AsString+','+IntToStr(xpos)+')';
      xflg := 'X';
    End
    Else // TIPO NUMBER
    Begin
       if (DMPreCob.cdsQry6.FieldByName('CAMPO').AsString='MONCOB') then
       begin
          xSQL := xSQL+'MONCOB=(CASE WHEN SUBSTR(LINEA,'+inttostr(xInicioRes)+',16)=''Registro Cobrado'' '
                      +'             THEN TO_NUMBER(SUBSTR(LINEA,'+DMPreCob.cdsQry6.FieldByName('DESDE').AsString+','
                      +                            IntToStr(xpos)+'),''9999.99'')'
                      +'             ELSE 0.00 '
                      +'        END)'
       end
       else
          xSql := xSql + DMPreCob.cdsQry6.FieldByName('CAMPO').AsString
                       +' = TO_NUMBER(SUBSTR(LINEA,'+DMPreCob.cdsQry6.FieldByName('DESDE').AsString+','
                       +IntToStr(xpos)+'),''9999.99'')';
      xflg := 'X';
    End;
    DMPreCob.cdsQry6.Next;
  End;
  xSql := xSql +' WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
  DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
  xcampos := '';
  xflg := '';
  DMPreCob.cdsQry6.First;
  While Not DMPreCob.cdsQry6.Eof Do
  Begin
    If xflg = 'X' Then xcampos := xcampos +',';
    xcampos := xcampos + DMPreCob.cdsQry6.FieldByName('CAMPO').AsString;
    xflg := 'X';
    DMPreCob.cdsQry6.Next;
  End;
  xSql := 'UPDATE COB_INF_PLA_CAB SET DESCAM = '+QuotedStr(xcampos)
  +' WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
  DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
  actcabpla;
  DMPreCob.cdsCredito.Edit;
  DMPreCob.cdsCredito.FieldByName('DESCAM').AsString := xcampos;
  If Pos('UPROID', DMPreCob.cdsCredito.FieldByName('DESCAM').AsString) = 0 Then
  Begin
    xSql := 'UPDATE COB_INF_PLA_CAB SET DESCAM = DESCAM||'',UPROID'' WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
  End;

  If Pos('UPAGOID', DMPreCob.cdsCredito.FieldByName('DESCAM').AsString) = 0 Then
  Begin
    xSql := 'UPDATE COB_INF_PLA_CAB SET DESCAM = DESCAM||'',UPAGOID'' WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
  End;

  If Pos('USEID', DMPreCob.cdsCredito.FieldByName('DESCAM').AsString) = 0 Then
  Begin
    xSql := 'UPDATE COB_INF_PLA_CAB SET DESCAM = DESCAM||'',USEID'' WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
  End;

  xSql := 'UPDATE COB_INF_PLA_DET SET UPROID = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('UPROID').AsString)
  +', UPAGOID = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('UPAGOID').AsString)+' WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
  DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);

  xSql := 'SELECT DESCAM FROM COB_INF_PLA_CAB WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
  DMPreCob.cdsQry.Close;
  DMPreCob.cdsQry.DataRequest(xSql);
  DMPreCob.cdsQry.Open;

  xSql := 'SELECT '+DMPreCob.cdsQry.FieldByName('DESCAM').AsString+' FROM COB_INF_PLA_DET WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
  DMPreCob.cdsQry2.Close;
  DMPreCob.cdsQry2.DataRequest(xSql);
  DMPreCob.cdsQry2.Open;
  xmoncob := 0;
  //xmonenv := 0;
  DMPreCob.cdsQry2.First;
  While Not DMPreCob.cdsQry2.Eof Do
  Begin
    xmoncob := xmoncob + DMPreCob.cdsQry2.FieldByName('MONCOB').AsFloat;
    //xmonenv := xmonenv + DMPreCob.cdsQry2.FieldByName('MONENV').AsFloat;
    DMPreCob.cdsQry2.Next;
  End;
  TNumericField(DMPreCob.cdsQry2.FieldByName('MONCOB')).DisplayFormat := '##,###,##0.#0';
  //TNumericField(DMPreCob.cdsQry2.FieldByName('MONENV')).DisplayFormat := '##,###,##0.#0';
  dbgtransferido.ColumnByName('MONCOB').FooterValue := FloatToStrF(xmoncob, ffNumber, 15, 2);
  //dbgtransferido.ColumnByName('MONENV').FooterValue := FloatToStrF(xmonenv, ffNumber, 15, 2);
  Screen.Cursor := crDefault;
end;

procedure TFproinfpla_res.BitBtn3Click(Sender: TObject);
begin
  Fproinfpla_res.Close;
end;



procedure TFproinfpla_res.btneliregClick(Sender: TObject);
Var xSql:String;
begin
  // Elimina registro
  xSql := 'DELETE FROM COB_INF_PLA_MAS_DET'
  +' WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry6.FieldByName('PLANTILLA').AsString)
  +' AND ITEM = '+QuotedStr(DMPreCob.cdsQry6.FieldByName('ITEM').AsString);
  DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
 actdetpla;  
end;

end.
