unit CAR002;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, wwdblook, Wwdbdlg,
  Mask, ExtCtrls, CARFRA001, Spin;

type
  TFprodis = class(TForm)
    dbgcabecera: TwwDBGrid;
    wwDBGrid1IButton: TwwIButton;
    btnplantilla: TBitBtn;
    btndepura: TBitBtn;
    btneliminar: TBitBtn;
    btnidentificacion: TBitBtn;
    btncerrar: TBitBtn;
    btncierre: TBitBtn;
    GroupBox1: TGroupBox;
    fraOficina: TFRAOFICINA;
    lblAno: TLabel;
    seano: TSpinEdit;
    lblMes: TLabel;
    semes: TSpinEdit;
    btnprocesar: TBitBtn;
    rgFiltraPeriodo: TRadioGroup;
    procedure wwDBGrid1IButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnplantillaClick(Sender: TObject);
    procedure btndepuraClick(Sender: TObject);
    procedure btneliminarClick(Sender: TObject);
    procedure btncerrarClick(Sender: TObject);
    procedure btnidentificacionClick(Sender: TObject);
    procedure btncierreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fraOficinadblcdOficinaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure fraOficinadblcdOficinaExit(Sender: TObject);
    procedure btnprocesarClick(Sender: TObject);
    procedure rgFiltraPeriodoClick(Sender: TObject);
  private
    evento:variant;
//    procedure Limpia;
  public
    procedure actgridcab;
  end;

var
  Fprodis: TFprodis;

implementation

uses CAR003, CARDM1, CAR004, CAR005, CAR006;

{$R *.dfm}

(******************************************************************************)

procedure TFprodis.FormCreate(Sender: TObject);
begin
     dbgcabecera.DataSource:=DMPreCob.dsCredito;
     fraOficina.cargar();
end;

(******************************************************************************)

procedure TFprodis.FormActivate(Sender: TObject);
begin
  self.fraOficina.Enabled:=DMPreCob.wEsSupervisor;
  rgFiltraPeriodo.ItemIndex := 0;
  lblAno.Enabled := False;
  seano.Enabled := False;
  lblMes.Enabled := False;
  semes.Enabled := False;
end;

(******************************************************************************
procedure TFprodis.fraOficinadblcdOficinaChange(Sender: TObject);
begin
  fraOficina.dblcdOficinaChange(Sender);
  actgridcab;
end;

******************************************************************************)

procedure TFprodis.actgridcab;
var xSQL:String;
begin
//   Limpia;
   xSql := 'SELECT A.DESUGEL, A.DESCAM, A.NUMERO,'
   +' A.UPROID, B.UPRONOM, A.UPAGOID, C.UPAGONOM, '
   +' A.USEID, E.USENOM, '
   +' A.ASOTIPID, D.ASOTIPDES, A.TIPPLA, A.CIERRE,'
   +' CASE WHEN A.TIPPLA = ''1'' THEN ''CUOTAS+APORTES'' ELSE CASE WHEN A.TIPPLA = ''2'' THEN ''CUOTAS'' ELSE'
   +' CASE WHEN A.TIPPLA = ''3'' THEN ''APORTES'' END END END TIPPLADES, A.USUARIO, A.FECHOR,'
   +' SUBSTR(trim(F_MES(SUBSTR(A.ANOMES,5,2)))||''/''||SUBSTR(A.ANOMES,1,4),1,14) PERIODO, A.TIPO, A.MONTOTCOB, A.CIERRE CERRADO'
   +' FROM COB_INF_PLA_CAB A, APO102 B, APO103 C, APO107 D, APO101 E'
   +' WHERE A.TIPO = ''1'''
   +' AND (A.OFDESID = '+QuotedStr(DMPreCob.wOfiId)+')'
//   +'   OR A.USUARIO='+quotedstr(DMPreCob.wUsuario)+')'
   +' AND A.UPROID = B.UPROID '
   +' AND A.UPROID = C.UPROID AND A.UPAGOID = C.UPAGOID '
   +' AND A.UPROID = E.UPROID AND A.UPAGOID = E.UPAGOID '
   +' AND A.USEID = E.USEID '
   +' AND A.ASOTIPID = D.ASOTIPID ORDER BY A.ANOMES, A.UPROID';
   DMPreCob.cdsCredito.Close;
   DMPreCob.cdsCredito.DataRequest(xSql);
   DMPreCob.cdsCredito.Open;

   dbgCabecera.Selected.Clear;
   dbgCabecera.Selected.Add('UPROID'#9'3'#9'U.Proceso'#9#9);
   //dbgCabecera.Selected.Add('UPRONOM'#9'27'#9'Descripción~proceso'#9#9);
   dbgCabecera.Selected.Add('UPAGOID'#9'3'#9'U.Pago'#9#9);
   //dbgCabecera.Selected.Add('UPAGONOM'#9'32'#9'Descripción~pago'#9#9);
   dbgCabecera.Selected.Add('USEID'#9'3'#9'UGEL'#9#9);
   dbgCabecera.Selected.Add('USENOM'#9'32'#9'Descripción~UGEL'#9#9);
   //dbgCabecera.Selected.Add('DESUGEL'#9'15'#9'Identificación~de UGELES'#9#9);
   dbgCabecera.Selected.Add('ASOTIPID'#9'2'#9'Tipo~asociado'#9#9);
   dbgCabecera.Selected.Add('PERIODO'#9'12'#9'Periodo'#9#9);
   dbgCabecera.Selected.Add('TIPPLADES'#9'11'#9'Tipo de~planilla'#9#9);
   dbgCabecera.Selected.Add('USUARIO'#9'15'#9'Usuario'#9#9);
   dbgCabecera.Selected.Add('FECHOR'#9'20'#9'Fecha y~hora'#9#9);
   dbgCabecera.Selected.Add('CIERRE'#9'1'#9'Cerrado'#9#9);
   dbgCabecera.ApplySelected;
   dbgCabecera.RefreshDisplay;
end;

(******************************************************************************)

procedure TFprodis.wwDBGrid1IButtonClick(Sender: TObject);
begin
  Try
    Fimptexto := TFimptexto.create(Self);
    Fimptexto.ShowModal;
  Finally
    fimptexto.Free;
  end;
  actgridcab;
end;

(******************************************************************************)

procedure TFprodis.btndepuraClick(Sender: TObject);
begin
  If DMPreCob.cdsCredito.FieldByName('CIERRE').AsString = 'S' Then
  Begin
    MessageDlg('Reporte de utilidad ya cerrado', mtError, [mbOk], 0);
    Exit;
  End;
  Try
    Fdeparc := TFdeparc.create(Self);
    Fdeparc.ShowModal;
  Finally
    Fdeparc.Free;
  end;
end;

(******************************************************************************)

procedure TFprodis.btnplantillaClick(Sender: TObject);
begin
  If DMPreCob.cdsCredito.FieldByName('CIERRE').AsString = 'S' Then
  Begin
    MessageDlg('Reporte de utilidad ya cerrado', mtError, [mbOk], 0);
    Exit;
  End;
  Try
    Fproinfpla := TFproinfpla.Create(Self);
    Fproinfpla.ShowModal;
  Finally
    Fproinfpla.Free;
  End;
end;

(******************************************************************************)

procedure TFprodis.btnidentificacionClick(Sender: TObject);
begin
  If DMPreCob.cdsCredito.FieldByName('CIERRE').AsString = 'S' Then
  Begin
    MessageDlg('Reporte de utilidad ya cerrado', mtError, [mbOk], 0);
    Exit;
  End;
  Try
    Fideaso := TFideaso.create(Self);
    Fideaso.TIPPLA:=DMPreCob.cdsCredito.FieldByName('TIPPLA').AsString;
    Fideaso.ShowModal;
  Finally
    Fideaso.Free;
  end;
end;

(******************************************************************************)

Procedure TFprodis.btncierreClick(Sender: TObject);
Var xuses, xflg, xSql:String;
  xmoncob :Double;
  xcantidad:Integer;
Begin
  If DMPreCob.cdsCredito.FieldByName('CIERRE').AsString = 'S' Then
  Begin
    MessageDlg('Reporte de utilidad ya cerrado', mtError, [mbOk], 0);
    Exit;
  End;
  xflg  := '1';
  xuses := '';
  xSql := 'SELECT USEID FROM COB_INF_PLA_DET WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString)+' GROUP BY USEID';
  DMPreCob.cdsQry.Close;
  DMPreCob.cdsQry.DataRequest(xSql);
  DMPreCob.cdsQry.Open;
  While Not DMPreCob.cdsQry.Eof Do
  Begin
    If xflg = '2' Then xuses := xuses +', ';
    xuses := xuses + DMPreCob.cdsQry.FieldByName('USEID').AsString;
    xflg := '2';
    DMPreCob.cdsQry.Next;
  End;

  If DMPreCob.cdsCredito.FieldByName('TIPO').AsString = '1' Then
  Begin
    xSql := 'SELECT SUM(NVL(MONCOB,0)) MONTO FROM COB_INF_PLA_DET WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
    DMPreCob.cdsQry.Close;
    DMPreCob.cdsQry.DataRequest(xSql);
    DMPreCob.cdsQry.Open;
    xmoncob := DMPreCob.cdsQry.FieldByName('MONTO').AsFloat;
    If xmoncob <> DMPreCob.cdsCredito.FieldByName('MONTOTCOB').AsFloat Then
    Begin
      MessageDlg('El monto ingresado al importar el'#13'archivo no cuadra con el detalle, verifique', mtError , [mbOk], 0);
      Exit;
    End;
    xSql := 'SELECT COUNT(*) CUENTA FROM COB_INF_PLA_DET WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString)+' AND ASOID IS NULL';
    DMPreCob.cdsQry.Close;
    DMPreCob.cdsQry.DataRequest(xSql);
    DMPreCob.cdsQry.Open;
    xcantidad := DMPreCob.cdsQry.FieldByName('CUENTA').AsInteger;
    If xcantidad <> 0 Then
    Begin
      MessageDlg('Existen asociados sin identificar, verifique', mtError , [mbOk], 0);
      Exit;
    End;
    If (xcantidad = 0) And (xmoncob = DMPreCob.cdsCredito.FieldByName('MONTOTCOB').AsFloat) Then
    Begin
      xSql := 'UPDATE COB_INF_PLA_CAB SET DESUGEL = '+QuotedStr(xuses)+',CIERRE = ''S'' WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
      DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
      actgridcab;
      MessageDlg('El archivo de utilidad ha sido concluido correctamente', mtInformation , [mbOk], 0);
    End;
  End
  Else
  Begin
    xSql := 'SELECT COUNT(*) CUENTA FROM COB_INF_PLA_DET WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString)+' AND ASOID IS NULL';
    DMPreCob.cdsQry.Close;
    DMPreCob.cdsQry.DataRequest(xSql);
    DMPreCob.cdsQry.Open;
    xcantidad := DMPreCob.cdsQry.FieldByName('CUENTA').AsInteger;
    If xcantidad = 0 Then
    begin
      xSql := 'UPDATE COB_INF_PLA_CAB SET CIERRE = ''S'' WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
      DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
      actgridcab;
      MessageDlg('El archivo de resultado ha sido concluido correctamente', mtInformation , [mbOk], 0);
    End
    Else MessageDlg('Existen asociados sin identificar, verifique', mtError , [mbOk], 0);
  End;
End;

(******************************************************************************)

procedure TFprodis.btneliminarClick(Sender: TObject);
Var xSql, xnumero:String;
begin
  If DMPreCob.cdsCredito.FieldByName('CIERRE').AsString = 'S' Then
  Begin
    MessageDlg('Reporte de utilidad ya cerrado', mtError, [mbOk], 0);
    Exit;
  End;
  If MessageDlg('¿Seguro de eliminar la planilla?' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
  Begin
    Screen.Cursor:= crHourGlass;
    xnumero := DMPreCob.cdsCredito.FieldByName('NUMERO').AsString;
    xSql := 'DELETE FROM COB_INF_PLA_CAB WHERE NUMERO = '+QuotedStr(xnumero);
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    xSql := 'DELETE FROM COB_INF_PLA_DET WHERE NUMERO = '+QuotedStr(xnumero);
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    actgridcab;
    Screen.Cursor:= crDefault;
  End;
end;

(******************************************************************************)

procedure TFprodis.btncerrarClick(Sender: TObject);
begin
  Fprodis.Close;
end;

(******************************************************************************

procedure TFprodis.dblcdOficinasChange(Sender: TObject);
Var
   xSql:String;
begin
   //meOfDes.Text := DMPreCob.cdsQry2.FieldByName('OFDESNOM').AsString;
   xSql := 'SELECT UPROID, UPAGOID, USEID, USENOM '
          +'FROM APO101 '
          +'WHERE OFDESID = '+QuotedStr(self.fraOficina.oficinaDes);
   DMPreCob.cdsConsulta.Close;
   DMPreCob.cdsConsulta.DataRequest(xSql);
   DMPreCob.cdsConsulta.Open;
end;

procedure TFprodis.sbCambiaOficinaClick(Sender: TObject);
begin
   if DMPreCob.wEsSupervisor then
   begin
      Try
         FCambiaOficina := TFCambiaOficina.create(Self);
         FCambiaOficina.ShowModal;
      Finally
         FCambiaOficina.Free;
      end;
      actgridcab;
   end
   else
      ShowMessage('Nivel de Usuario NO permite cambio de Oficina');
end;
*)




procedure TFprodis.fraOficinadblcdOficinaChange(Sender: TObject);
begin
  fraOficina.dblcdOficinaChange(Sender);
  actgridcab;
  rgFiltraPeriodo.ItemIndex := 0;
  lblAno.Enabled := False;
  seano.Enabled := False;
  lblMes.Enabled := False;
  semes.Enabled := False;
end;

(*
procedure TFprodis.Limpia;
var xSQL:String;
begin
   xSQL := 'SELECT A.DESUGEL, A.DESCAM, A.NUMERO, A.UPROID, B.UPRONOM, A.UPAGOID, C.UPAGONOM, A.ASOTIPID, D.ASOTIPDES, A.TIPPLA, A.CIERRE,'
   +' CASE WHEN A.TIPPLA = ''1'' THEN ''CUOTAS+APORTES'' ELSE CASE WHEN A.TIPPLA = ''2'' THEN ''CUOTAS'' ELSE'
   +' CASE WHEN A.TIPPLA = ''3'' THEN ''APORTES'' END END END TIPPLADES, A.USUARIO, A.FECHOR,'
   +' SUBSTR(trim(F_MES(SUBSTR(A.ANOMES,5,2)))||''/''||SUBSTR(A.ANOMES,1,4),1,14) PERIODO, A.TIPO, A.MONTOTCOB, A.CIERRE CERRADO'
   +' FROM COB_INF_PLA_CAB A, APO102 B, APO103 C, APO107 D'
   +' WHERE A.TIPO = ''X'''
   +' AND (A.USUARIO IN (SELECT USERID FROM TGE006 WHERE OFDESID = '+QuotedStr(fraOficina.oficinaId)+')'
   +'   OR A.USUARIO='+quotedstr(DMPreCob.wUsuario)+')'
   +' AND A.UPROID = B.UPROID AND A.UPROID = C.UPROID AND A.UPAGOID = C.UPAGOID'
   +' AND A.ASOTIPID = D.ASOTIPID ORDER BY A.ANOMES, A.UPROID';
   DMPreCob.cdsCredito.Close;
   DMPreCob.cdsCredito.DataRequest(xSql);
   DMPreCob.cdsCredito.Open;

   dbgCabecera.Selected.Clear;
   dbgCabecera.Selected.Add('UPROID'#9'3'#9'Ide~Proceso'#9#9);
   dbgCabecera.Selected.Add('UPRONOM'#9'27'#9'Descripción~proceso'#9#9);
   dbgCabecera.Selected.Add('UPAGOID'#9'3'#9'Ide~Pago'#9#9);
   dbgCabecera.Selected.Add('UPAGONOM'#9'32'#9'Descripción~pago'#9#9);
   dbgCabecera.Selected.Add('DESUGEL'#9'15'#9'Identificación~del UGELES'#9#9);
   dbgCabecera.Selected.Add('ASOTIPID'#9'2'#9'Tipo~asociado'#9#9);
   dbgCabecera.Selected.Add('PERIODO'#9'12'#9'Departamento'#9#9);
   dbgCabecera.Selected.Add('TIPPLADES'#9'11'#9'Tipo de~planilla'#9#9);
   dbgCabecera.Selected.Add('USUARIO'#9'15'#9'Usuario'#9#9);
   dbgCabecera.Selected.Add('FECHOR'#9'20'#9'Fecha y~hora'#9#9);
   dbgCabecera.Selected.Add('CIERRE'#9'1'#9'Cerrado'#9#9);
   dbgCabecera.ApplySelected;
   dbgCabecera.RefreshDisplay;
end;

*)
procedure TFprodis.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action:=caFree;
end;

procedure TFprodis.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
  begin
    Key := #0;
    Perform(CM_DIALOGKEY, VK_TAB, 0);
  End;
end;

procedure TFprodis.fraOficinadblcdOficinaExit(Sender: TObject);
begin
  //fraOficina.dblcdOficinaExit(Sender);
  self.fraOficinadblcdOficinaChange(self.fraOficina.dblcdOficina);
end;

procedure TFprodis.btnprocesarClick(Sender: TObject);
var
   xSQL, xAno, xMes : String;
begin
   xSql := 'SELECT A.DESUGEL, A.DESCAM, A.NUMERO,'
   +' A.UPROID, B.UPRONOM, A.UPAGOID, C.UPAGONOM, '
   +' A.USEID, E.USENOM, '
   +' A.ASOTIPID, D.ASOTIPDES, A.TIPPLA, A.CIERRE,'
   +' CASE WHEN A.TIPPLA = ''1'' THEN ''CUOTAS+APORTES'' ELSE CASE WHEN A.TIPPLA = ''2'' THEN ''CUOTAS'' ELSE'
   +' CASE WHEN A.TIPPLA = ''3'' THEN ''APORTES'' END END END TIPPLADES, A.USUARIO, A.FECHOR,'
   +' SUBSTR(trim(F_MES(SUBSTR(A.ANOMES,5,2)))||''/''||SUBSTR(A.ANOMES,1,4),1,14) PERIODO, A.TIPO, A.MONTOTCOB, A.CIERRE CERRADO'
   +' FROM COB_INF_PLA_CAB A, APO102 B, APO103 C, APO107 D, APO101 E'
   +' WHERE A.TIPO = ''1'''
   +' AND (A.OFDESID = '+QuotedStr(DMPreCob.wOfiId)+')'
   +' AND A.UPROID = B.UPROID '
   +' AND A.UPROID = C.UPROID AND A.UPAGOID = C.UPAGOID '
   +' AND A.UPROID = E.UPROID AND A.UPAGOID = E.UPAGOID AND A.USEID = E.USEID '
   +' AND A.ASOTIPID = D.ASOTIPID ';
   if rgFiltraPeriodo.ItemIndex=1 then
   begin
      xAno := seano.Text;
      xMes := DMPreCob.StrZero(seMes.Text,2);
      xSQL := xSQL+' and ANOMES='+quotedstr(xAno+xMes);
   end;
   xSQL := xSQL + ' ORDER BY A.ANOMES, A.UPROID';
   DMPreCob.cdsCredito.Close;
   DMPreCob.cdsCredito.DataRequest(xSql);
   DMPreCob.cdsCredito.Open;

end;

procedure TFprodis.rgFiltraPeriodoClick(Sender: TObject);
begin
   if rgFiltraPeriodo.ItemIndex=1 then
   begin
      lblAno.Enabled := True;
      seano.Enabled := True;
      lblMes.Enabled := True;
      semes.Enabled := True;
   end
   else
   begin
      lblAno.Enabled := False;
      seano.Enabled := False;
      lblMes.Enabled := False;
      semes.Enabled := False;
   end;
end;

end.
