unit CAR001;
interface

uses
  Windows, Messages, SysUtils, Classes, fcLabel, StdCtrls,
  Controls, ExtCtrls, Buttons, ComCtrls, ToolWin, Forms, wwDBigrd, DB,  dialogs, ppCtrls,
  DBCtrls, IniFiles, Grids, DBGrids, Wwdbgrid, Graphics;

type
  TFPrincipal = class(TForm)
    clbPrincipal: TCoolBar;
    tlbPrincipal: TToolBar;
    Z1sbReglas: TSpeedButton;
    Z1sbReportes: TSpeedButton;
    Z1sbSalida: TSpeedButton;
    pnlReferencias: TPanel;
    Z1sbReferencias: TSpeedButton;
    pnlProcesos: TPanel;
    BitProceso: TSpeedButton;
    Z1sbProcesos: TSpeedButton;
    pnlReportes: TPanel;
    lblVersion: TLabel;
    Z1sbCamPassw: TSpeedButton;
    Image1: TImage;
    fcLabel3: TfcLabel;
    fcLabel1: TfcLabel;
    StatusBar1: TStatusBar;
    SpeedButton1: TSpeedButton;
    sbgenpla: TSpeedButton;
    Z1sbEnvVsDesGlobal: TSpeedButton;
    fcLabel2: TfcLabel;
    fcLabel4: TfcLabel;
    SpeedButton2: TSpeedButton;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Z1sbReglasMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Z1sbMovimientosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Z1sbReportesMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure dbgMovCxPMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SacaMenu(Sender: TObject);
    procedure Z1sbMaestrosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Z1sbSalidaClick(Sender: TObject);
    procedure Z1sbSalidaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Z1sbProcesosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Z1sbReferenciasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitProcesoClick(Sender: TObject);
//    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
//    procedure Z1sbCamPasswClick(Sender: TObject);
    procedure Z1sbReglasClick(Sender: TObject);
    procedure Z1sbMaestrosClick(Sender: TObject);
    procedure Z1sbMovimientosClick(Sender: TObject);
    procedure Z1sbProcesosClick(Sender: TObject);
    procedure Z1sbReportesClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure sbgenplaClick(Sender: TObject);
    procedure Z1sbEnvVsDesGlobalClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function  VerificaVersion: Boolean;
  public
     xSQL:String;
     CAxuRep : String;
     procedure AppMessage (var Msg: TMsg; var Handled : Boolean );
     procedure ListaComponentes( xForm : TForm);
     Procedure MueveMouse(xObjeto: TObject; Shift: TShiftState; X, Y: Integer);
end;

var
  FPrincipal : TFPrincipal;
  D, M, Y : Word;
  xBusAso, FIni, xSQL2, xSQL, sSQL : string;
  xFechasys : TDate;
  xDiaSys,xAnoSys,xMesSys : Word;

implementation

uses CARDM1,  CAR002, CAR008, CAR018, CAR021, CAR023, CAR024;

{$R *.DFM}

procedure TFPrincipal.FormShow(Sender: TObject);
begin
   Screen.Cursor:=CrDefault;
end;

procedure TFPrincipal.Z1sbReglasMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
   pnlReferencias.Left := TSpeedButton(Sender).Left+10;
   pnlReferencias.Top  := TSpeedButton(Sender).Top+TSpeedButton(Sender).Height;
   pnlReferencias.Visible  := True;
   pnlProcesos.Visible     := False;
   pnlReportes.Visible     := False;

end;

procedure TFPrincipal.Z1sbMaestrosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
   pnlReferencias.Visible  := False;
   pnlProcesos.Visible     := False;
   pnlReportes.Visible     := False;
end;

procedure TFPrincipal.Z1sbMovimientosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
   pnlReferencias.Visible  := False;
   pnlProcesos.Visible     := False;
   pnlReportes.Visible     := False;
end;

procedure TFPrincipal.Z1sbReportesMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
   pnlReportes.Left := TSpeedButton(Sender).Left+10;
   pnlReportes.Top  := TSpeedButton(Sender).Top+TSpeedButton(Sender).Height;
   pnlReferencias.Visible    := False;
   pnlProcesos.Visible       := False;
   pnlReportes.Visible       := True;

end;

procedure TFPrincipal.dbgMovCxPMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  SacaMenu(Sender);
end;

procedure TFPrincipal.SacaMenu(Sender: TObject);
begin
   clbPrincipal.Enabled      := True;
   pnlReferencias.Visible    := False;
   pnlProcesos.Visible       := False;
   pnlReportes.Visible       := False;
end;


procedure TFPrincipal.AppMessage(var Msg:TMsg; var Handled:Boolean );
begin
   if Msg.message = WM_KEYDOWN then begin

      if ( Msg.wParam=VK_F5 ) then begin

         If (Copy(DMPreCob.wObjetoNombr,1,2)='Z1') or
            (Copy(DMPreCob.wObjetoNombr,1,2)='Z2') then begin
    //        CreaOpciones;
         end;
      end;

      if ( Msg.wParam=VK_F12 ) then begin
      //   CreaAccesos;
      end;
   end;
end;

procedure TFPrincipal.Z1sbSalidaClick(Sender: TObject);
begin
  pnlReportes.visible:=false;
  Close;
end;

procedure TFPrincipal.Z1sbSalidaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
   pnlProcesos.Visible       := False;
   pnlReportes.Visible       := False;
end;

procedure TFPrincipal.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  Sacamenu(Self)
end;

procedure TFPrincipal.Z1sbProcesosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
   pnlProcesos.Left := TSpeedButton(Sender).Left+10;
   pnlProcesos.Top  := TSpeedButton(Sender).Top+TSpeedButton(Sender).Height;
   pnlReferencias.Visible  := False;
   pnlProcesos.Visible     := True;
   pnlReportes.Visible     := False;

end;


procedure TFPrincipal.Z1sbReferenciasClick(Sender: TObject);
begin
  SacaMenu(Sender);
end;

procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DMPreCob.DCOM1.AppServer.ConexionOFF(DMPreCob.wUsuario, DMPreCob.ideconex);
  DMPreCob.DCOM1.Connected:=False;
  Application.Terminate;
end;

procedure TFPrincipal.BitProcesoClick(Sender: TObject);
begin
  SacaMenu(Sender);
  Try
    Fprodis := TFprodis.create(Self);
    Fprodis.ShowModal;
  Finally
    Fprodis.Free;
  end;
end;

procedure TFPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
 If key=#13 Then
  begin
    If Self.ActiveControl Is TDBMemo Then Exit;
  	key:=#0;
    perform(CM_DialogKey,VK_TAB,0);
  end;
end;


function TFPrincipal.VerificaVersion: Boolean;
begin
  Result:=False;
  xSQL:='SELECT * FROM TGE600 WHERE CODIGO=''PRCB''';
  DMPreCob.cdsQry.Close;
  DMPreCob.cdsQry.DataRequest( xSQL );
  DMPreCob.cdsQry.Open;
  If lblVersion.caption=DMPreCob.cdsQry.FieldByName('VERSION').AsString Then
    Result:=True
  Else
  begin
    ShowMessage( 'Para poder continuar, es necesario que actualice la Versión');
    DMPreCob.DCOM1.Connected:=False;
    Application.Terminate;
  end;
end;


procedure TFPrincipal.ListaComponentes(xForm: TForm);
var
  i : integer;
begin
  for i:=0 to xForm.ComponentCount-1 do
  begin
    if xForm.Components[i].ClassName = 'TPanel' then
      TPanel(xForm.components[i]).OnMouseMove := MueveMouse;
    // para botones
    if xForm.Components[i].ClassName = 'TButton' then
      TButton(xForm.components[i]).OnMouseMove := MueveMouse;
    // para bitbuttons
    if xForm.Components[i].ClassName = 'TBitBtn' then
      TBitBtn(xForm.components[i]).OnMouseMove := MueveMouse;
    // para speedbuttons
    if xForm.Components[i].ClassName = 'TSpeedButton' then
      TSpeedButton(xForm.components[i]).OnMouseMove := MueveMouse;
    // Boton de Grid
    if xForm.Components[i].ClassName = 'TwwIButton' then
      TwwIButton(xForm.components[i]).OnMouseMove := MueveMouse;
    // para la forma
    xForm.onMouseMove := MueveMouse;
  end;
end;

procedure TFPrincipal.MueveMouse(xObjeto: TObject; Shift: TShiftState; X,
  Y: Integer);
var
   xComponente : String;
   xForma : TForm;
begin
   xForma      := Screen.ActiveForm;
   xComponente := xForma.Name;

   If xObjeto is TForm Then
   Else
    begin
     xComponente := xComponente+'.'+TControl(xObjeto).Name;

     DMPreCob.wObjetoForma := xForma.Name;
     DMPreCob.wObjetoNombr := TControl(xObjeto).Name;
     If Copy(DMPreCob.wObjetoNombr,2,1)='2' Then
      DMPreCob.wObjetoDescr := DMPreCob.wObjetoDesPr+' - '+TControl(xObjeto).Hint
     Else
      begin
       DMPreCob.wObjetoDescr := TControl(xObjeto).Hint;
      end;
   end;
end;

procedure TFPrincipal.Z1sbReglasClick(Sender: TObject);
begin
   pnlReferencias.Left := TSpeedButton(Sender).Left+10;
   pnlReferencias.Top  := TSpeedButton(Sender).Top+TSpeedButton(Sender).Height;
   pnlReferencias.Visible  := True;
   pnlProcesos.Visible     := False;
   pnlReportes.Visible     := False;
end;

procedure TFPrincipal.Z1sbMaestrosClick(Sender: TObject);
begin
   pnlReferencias.Visible  := False;
   pnlProcesos.Visible     := False;
   pnlReportes.Visible     := False;
end;

procedure TFPrincipal.Z1sbMovimientosClick(Sender: TObject);
begin
   pnlReferencias.Visible  := False;
   pnlProcesos.Visible     := False;
   pnlReportes.Visible     := False;
end;

procedure TFPrincipal.Z1sbProcesosClick(Sender: TObject);
begin
   pnlProcesos.Left := TSpeedButton(Sender).Left+10;
   pnlProcesos.Top  := TSpeedButton(Sender).Top+TSpeedButton(Sender).Height;
   pnlReferencias.Visible  := False;
   pnlProcesos.Visible     := True;
   pnlReportes.Visible     := False;
end;

procedure TFPrincipal.Z1sbReportesClick(Sender: TObject);
begin
   pnlReportes.Left := TSpeedButton(Sender).Left+10;
   pnlReportes.Top  := TSpeedButton(Sender).Top+TSpeedButton(Sender).Height;
   pnlReferencias.Visible    := False;
   pnlProcesos.Visible       := False;
   pnlReportes.Visible       := True;
end;

procedure TFPrincipal.SpeedButton1Click(Sender: TObject);
begin
  SacaMenu(Sender);
  Try
    Fprodis_res := TFprodis_res.create(Self);
    Fprodis_res.ShowModal;
  Finally
    Fprodis_res.Free;
  end;
end;
(*
Procedure TFPrincipal.BitInforme01Click(Sender: TObject);
Begin
  SacaMenu(Sender);
  Try
    FenvRepUti := TFenvRepUti.create(Self);
    FenvRepUti.ShowModal;
  Finally
    FenvRepUti.Free;
  End;
End;
  *)
procedure TFPrincipal.sbgenplaClick(Sender: TObject);
  Var xnompla, xSql, xplantilla, xofdes:String;
begin
  If MessageDlg('¿Seguro de generar las plantillas ?' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
  Begin
    xofdes := DMPreCob.CrgDescrip('OFDESID='+QuotedStr(Trim(DMPreCob.wOfiId)),'APO110','OFDESNOM');
    xnompla := xofdes+'-UTILIDAD';
    xSql := 'SELECT COUNT(*) CUENTA FROM COB_INF_PLA_MAS_CAB WHERE NOMBRE = '+QuotedStr(xnompla);
    DMPreCob.cdsQry.Close;
    DMPreCob.cdsQry.DataRequest(xSql);
    DMPreCob.cdsQry.Open;
    If DMPreCob.cdsQry.FieldByName('CUENTA').AsInteger > 0 Then
    Begin
      If MessageDlg('Una plantilla con el nombre'+xnompla+' ya existe.'#13'La plantilla que se cree reemplazara a la ya creada.'#13'¿Seguro de crearlo?' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
      Begin
        xSql := 'SELECT PLANTILLA FROM COB_INF_PLA_MAS_CAB WHERE NOMBRE = '+QuotedStr(xnompla);
        DMPreCob.cdsQry.Close;
        DMPreCob.cdsQry.DataRequest(xSql);
        DMPreCob.cdsQry.Open;
        xSql := 'DELETE FROM COB_INF_PLA_MAS_CAB WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry.FieldByName('PLANTILLA').AsString);
        DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
        xSql := 'DELETE FROM COB_INF_PLA_MAS_DET WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry.FieldByName('PLANTILLA').AsString);
        DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
      End
      Else Exit;
    End;
    xSql := 'SELECT LPAD(MAX(PLANTILLA)+1,5,''0'') PLANTILLA FROM COB_INF_PLA_MAS_CAB';
    DMPreCob.cdsQry.Close;
    DMPreCob.cdsQry.DataRequest(xSql);
    DMPreCob.cdsQry.Open;
    If  DMPreCob.cdsQry.FieldByName('PLANTILLA').AsString = '' Then xplantilla := '00001'
    Else xplantilla := DMPreCob.cdsQry.FieldByName('PLANTILLA').AsString;
    // Plantilla del reporte de envio
    xSql := 'INSERT INTO COB_INF_PLA_MAS_CAB(PLANTILLA, NOMBRE, USUARIO, HREG, OFDESID, TIPO) VALUES('+QuotedStr(xplantilla)+','+QuotedStr(xofdes+'-UTILIDAD')+', ''AUTOMATICO'', SYSDATE, '+QuotedStr(DMPreCob.wOfiId)+',''1'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);

    xSql := 'INSERT INTO COB_INF_PLA_MAS_DET(PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, USUARIO, HREG, TIPCAM) VALUES ('+QuotedStr(xplantilla)+',1,''USEID'',      ''Unidad de gestión''                  ,1,  2,''AUTOMATICO'', SYSDATE, ''C'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    xSql := 'INSERT INTO COB_INF_PLA_MAS_DET(PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, USUARIO, HREG, TIPCAM) VALUES ('+QuotedStr(xplantilla)+',2,''ASOCODPAGO'', ''Código de pago''                     ,1,  8,''AUTOMATICO'', SYSDATE, ''C'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    xSql := 'INSERT INTO COB_INF_PLA_MAS_DET(PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, USUARIO, HREG, TIPCAM) VALUES ('+QuotedStr(xplantilla)+',3,''ASOCODMOD'',  ''Código modular''                     ,10,19,''AUTOMATICO'', SYSDATE, ''C'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    xSql := 'INSERT INTO COB_INF_PLA_MAS_DET(PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, USUARIO, HREG, TIPCAM) VALUES ('+QuotedStr(xplantilla)+',4,''CARGO'',      ''Código de cargo''                    ,21,26,''AUTOMATICO'', SYSDATE, ''C'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    xSql := 'INSERT INTO COB_INF_PLA_MAS_DET(PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, USUARIO, HREG, TIPCAM) VALUES ('+QuotedStr(xplantilla)+',5,''ASOAPENOM'',  ''Apellidos y nombre(s) del asociado'' ,33,63,''AUTOMATICO'', SYSDATE, ''C'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    xSql := 'INSERT INTO COB_INF_PLA_MAS_DET(PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, USUARIO, HREG, TIPCAM) VALUES ('+QuotedStr(xplantilla)+',6,''MONCOB'',     ''Monto de la cuota cobrada''          ,85,92,''AUTOMATICO'', SYSDATE, ''N'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);

    xnompla := xofdes+'-RESULTADO';
    xSql := 'SELECT COUNT(*) CUENTA FROM COB_INF_PLA_MAS_CAB WHERE NOMBRE = '+QuotedStr(xnompla);
    DMPreCob.cdsQry.Close;
    DMPreCob.cdsQry.DataRequest(xSql);
    DMPreCob.cdsQry.Open;
    If DMPreCob.cdsQry.FieldByName('CUENTA').AsInteger > 0 Then
    Begin
      If MessageDlg('Una plantilla con el nombre'+xnompla+' ya existe.'#13'La plantilla que se cree reemplazara a la ya creada.'#13'¿Seguro de crearlo?' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
      Begin
        xSql := 'SELECT PLANTILLA FROM COB_INF_PLA_MAS_CAB WHERE NOMBRE = '+QuotedStr(xnompla);
        DMPreCob.cdsQry.Close;
        DMPreCob.cdsQry.DataRequest(xSql);
        DMPreCob.cdsQry.Open;
        xSql := 'DELETE FROM COB_INF_PLA_MAS_CAB WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry.FieldByName('PLANTILLA').AsString);
        DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
        xSql := 'DELETE FROM COB_INF_PLA_MAS_DET WHERE PLANTILLA = '+QuotedStr(DMPreCob.cdsQry.FieldByName('PLANTILLA').AsString);
        DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
      End
      Else Exit;
    End;
    // Plantilla de reporte de resultados
    xSql := 'SELECT LPAD(MAX(PLANTILLA)+1,5,''0'') PLANTILLA FROM COB_INF_PLA_MAS_CAB';
    DMPreCob.cdsQry.Close;
    DMPreCob.cdsQry.DataRequest(xSql);
    DMPreCob.cdsQry.Open;
    xplantilla := DMPreCob.cdsQry.FieldByName('PLANTILLA').AsString;
    xSql := 'INSERT INTO COB_INF_PLA_MAS_CAB(PLANTILLA, NOMBRE, USUARIO, HREG, OFDESID, TIPO) VALUES('+QuotedStr(xplantilla)+','+QuotedStr(xofdes+'-RESULTADO')+',''AUTOMATICO'', SYSDATE, '+QuotedStr(DMPreCob.wOfiId)+',''2'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    xSql := 'INSERT INTO COB_INF_PLA_MAS_DET(PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, USUARIO, HREG, TIPCAM) VALUES ('+QuotedStr(xplantilla)+',1,''ASOCODMOD'',''Código modular''                    ,  1, 10, ''AUTOMATICO'', SYSDATE,''C'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    xSql := 'INSERT INTO COB_INF_PLA_MAS_DET(PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, USUARIO, HREG, TIPCAM) VALUES ('+QuotedStr(xplantilla)+',2,''CARGO'',	  ''Código de cargo''                   , 14, 19, ''AUTOMATICO'', SYSDATE,''C'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    xSql := 'INSERT INTO COB_INF_PLA_MAS_DET(PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, USUARIO, HREG, TIPCAM) VALUES ('+QuotedStr(xplantilla)+',3,''ASOAPENOM'',''Apellidos y nombre(s) del asociado'', 27, 66, ''AUTOMATICO'', SYSDATE,''C'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    xSql := 'INSERT INTO COB_INF_PLA_MAS_DET(PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, USUARIO, HREG, TIPCAM) VALUES ('+QuotedStr(xplantilla)+',4,''MONCOB'',	  ''Monto de la cuota cobrada''         , 70, 77, ''AUTOMATICO'', SYSDATE,''N'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    xSql := 'INSERT INTO COB_INF_PLA_MAS_DET(PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, USUARIO, HREG, TIPCAM) VALUES ('+QuotedStr(xplantilla)+',5,''RESULTADO'',''Resultado del proceso''             , 79, 98, ''AUTOMATICO'', SYSDATE,''C'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    xSql := 'INSERT INTO COB_INF_PLA_MAS_DET(PLANTILLA, ITEM, CAMPO, NOMBRE, DESDE, HASTA, USUARIO, HREG, TIPCAM) VALUES ('+QuotedStr(xplantilla)+',6,''SALDIS'',	  ''Saldo Disponible''               ,101,110, ''AUTOMATICO'', SYSDATE,''N'')';
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);

    MessageDlg('Las plantillas han sido importadas', mtInformation, [mbOk], 0);
  End;
end;
(*
procedure TFPrincipal.BitInforme02Click(Sender: TObject);
begin
  // Estadistica de utilidad
  SacaMenu(Sender);
  Try
    FEstUti := TFEstUti.create(Self);
    FEstUti.ShowModal;
  Finally
    FEstUti.Free;
  End;
end;

procedure TFPrincipal.SpeedButton2Click(Sender: TObject);
begin
  // Estadistica de resultados
  SacaMenu(Sender);
  Try
    FEstRes := TFEstRes.create(Self);
    FEstRes.ShowModal;
  Finally
    FEstRes.Free;
  End;
end;

procedure TFPrincipal.SpeedButton3Click(Sender: TObject);
begin
   SacaMenu(Sender);
   if DMPreCob.wEsSupervisor then
   begin
      Try
         FCambiaOficina := TFCambiaOficina.create(Self);
         FCambiaOficina.ShowModal;
      Finally
         FCambiaOficina.Free;
      end;
   end
   else
      ShowMessage('Nivel de Usuario NO permite cambio de Oficina');
end;
      *)

      (*
procedure TFPrincipal.SpeedButton4Click(Sender: TObject);
begin
  SacaMenu(Sender);
  Try
    FEnvVsRepRes := TFEnvVsRepRes.create(Self);
    FEnvVsRepRes.ShowModal;
  Finally
    FEnvVsRepRes.Free;
  End;
end;
       *)
procedure TFPrincipal.Z1sbEnvVsDesGlobalClick(Sender: TObject);
begin
  SacaMenu(Sender);
  Try
    FEnvVsRep := TFEnvVsRep.create(Self);
    FEnvVsRep.ShowModal;
  Finally
    FEnvVsRep.Free;
  End;
end;


Procedure TFPrincipal.FormActivate(Sender: TObject);
Var
   xFecha : String;
   //xFtp : String;
  // IniFile : TIniFile;
Begin


   (*
  IniFile:=TIniFile.Create('C:\SOLExes\SOLConf.ini'); xFtp:=IniFile.ReadString('FOTOS','FTP','');
  If Length(Trim(xFtp))=0 Then
  Begin
    MessageDlg(' Debe Actualizar El Archivo De Inicio Del Sistema ', mtError, [mbOk], 0);
    DMPreCob.DCOM1.Connected := False;
    Application.Terminate;
    Exit;
  End;
  *)

  sSQL := 'SELECT TO_CHAR(SYSDATE, ''DD/MM/YYYY'') FECHA FROM DUAL';
  DMPreCob.cdsReporte.Close;
  DMPreCob.cdsReporte.DataRequest(sSQL);
  DMPreCob.cdsReporte.Open;

  xFecha := DMPreCob.cdsReporte.FieldByName('FECHA').AsString;
  xFechasys := StrToDate(xFecha);
  xFechasys := Date;
  DecodeDate(xFechaSys,xAnoSys,xMesSys,xDiaSys);
  VerificaVersion;
  lblVersion.Height :=13;
  lblVersion.Left   :=8;
  lblVersion.Top    :=504;
  DMPreCob.wOfiId := DMPreCob.CrgDescrip('USERID='+QuotedStr(Trim(DMPreCob.wUsuario)),'TGE006','OFDESID');
  DMPreCob.xOfiNombre :=DMPreCob.CrgDescrip('OFDESID='+QuotedStr(DMPreCob.wOfiId),'APO110','OFDESNOM');
  Statusbar1.Panels[1].Text :='Usuario : '+ DMPreCob.wUsuario+' -   '+Trim(DMPreCob.CrgDescrip('USERID='+QuotedStr(Trim(DMPreCob.wUsuario)),'TGE006','USERNOM'));
  Statusbar1.Panels[2].Text :='Origen de Operaciones   :   '+ DMPreCob.wOfiId +' -  '+DMPreCob.CrgDescrip('OFDESID='+QuotedStr(Trim(DMPreCob.wOfiId)),'APO110','OFDESNOM');
  DMPreCob.wEsSupervisor := (DMPreCob.wOfiId ='01');
  sSQL := 'select NIVEL from USERTABLE where USERID='+quotedstr(DMPreCob.wUsuario);
  DMPreCob.cdsQry4.Close;
  DMPreCob.cdsQry4.DataRequest(sSQL);
  DMPreCob.cdsQry4.Open;
  If DMPreCob.cdsQry4.RecordCount=0 then
     DMPreCob.xNivelUsu := '01'
  Else
     DMPreCob.xNivelUsu := DMPreCob.cdsQry4.FieldByName('NIVEL').AsString;
  Caption := DMPreCob.xCaptionPrincipal + DMPreCob.xOfiNombre;
End;

procedure TFPrincipal.SpeedButton2Click(Sender: TObject);
begin
  SacaMenu(Sender);
  Try
    FEnvVsCobVsPrecob := TFEnvVsCobVsPrecob.create(Self);
    FEnvVsCobVsPrecob.ShowModal;
  Finally
    FEnvVsCobVsPrecob.Free;
  End;
end;

procedure TFPrincipal.Button1Click(Sender: TObject);
begin
  Try
    FImpDBF := TFImpDBF.create(Self);
    FImpDBF.ShowModal;
  Finally
    FImpDBF.Free;
  End;
end;

Initialization
  registerclasses([TLabel, TBevel, TppLabel]);
end.


