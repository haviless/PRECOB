unit CAR008;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, CARFRA001;

type
  TFprodis_res = class(TForm)
    dbgcabecera: TwwDBGrid;
    wwDBGrid1IButton: TwwIButton;
    btnplantilla: TBitBtn;
    btndepura: TBitBtn;
    btneliminar: TBitBtn;
    btnidentificacion: TBitBtn;
    btncerrar: TBitBtn;
    btncierre: TBitBtn;
    GroupBox1: TGroupBox;
    fraOficina: TfraOficina;
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
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure fraOficinadblcdOficinaExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure actgridcab;
  end;

var
  Fprodis_res: TFprodis_res;

implementation

uses CARDM1, CAR009, CAR005, CAR010, CAR006;



{$R *.dfm}

(******************************************************************************)

procedure TFprodis_res.FormCreate(Sender: TObject);
begin
     dbgcabecera.DataSource:=DMPreCob.dsCredito;
     fraOficina.cargar();
end;

(******************************************************************************)

procedure TFprodis_res.FormActivate(Sender: TObject);
begin
  self.fraOficina.Enabled:=False;
  if DMPreCob.wEsSupervisor then
  begin
     self.fraOficina.Enabled:=true;
  end;
end;

(******************************************************************************)

procedure TFprodis_res.fraOficinadblcdOficinaChange(Sender: TObject);
begin
  fraOficina.dblcdOficinaChange(Sender);
  actgridcab;
end;

(******************************************************************************)

procedure TFprodis_res.wwDBGrid1IButtonClick(Sender: TObject);
begin
  Try
    Fimptex_res := TFimptex_res.create(Self);
    Fimptex_res.ShowModal;
  Finally
    Fimptex_res.Free;
  end;
  actgridcab;
end;

(******************************************************************************)

procedure TFprodis_res.actgridcab;
Var
   xSql:String;
begin
  xSql := 'SELECT A.DESUGEL, A.ANOMES, A.DESCAM, A.NUMERO, A.UPROID, B.UPRONOM, A.UPAGOID, C.UPAGONOM, A.ASOTIPID, D.ASOTIPDES, A.TIPPLA,'
  +' CASE WHEN A.TIPPLA = ''1'' THEN ''CUOTAS+APORTES'' ELSE CASE WHEN A.TIPPLA = ''2'' THEN ''CUOTAS'' ELSE'
  +' CASE WHEN A.TIPPLA = ''3'' THEN ''APORTES'' END END END TIPPLADES, A.USUARIO, A.FECHOR,'
  +' SUBSTR(trim(F_MES(SUBSTR(A.ANOMES,5,2)))||''/''||SUBSTR(A.ANOMES,1,4),1,14) PERIODO, A.CIERRE, A.TIPO, A.CIERRE CERRADO'
  +' FROM COB_INF_PLA_CAB A, APO102 B, APO103 C, APO107 D'
  +' WHERE A.TIPO = ''2'''
  +' AND (A.OFDESID = '+QuotedStr(fraOficina.oficinaId)+')'
//  +'   OR A.USUARIO='+quotedstr(DMPreCob.wUsuario)+')'
  +' AND A.UPROID = B.UPROID AND A.UPROID = C.UPROID(+) AND A.UPAGOID = C.UPAGOID(+)'
  +' AND A.ASOTIPID = D.ASOTIPID ORDER BY A.ANOMES, A.UPROID';
  DMPreCob.cdsCredito.Close;
  DMPreCob.cdsCredito.DataRequest(xSql);
  DMPreCob.cdsCredito.Open;

  dbgCabecera.Selected.Clear;
  dbgCabecera.Selected.Add('PERIODO'#9'14'#9'Periodo'#9#9);
  dbgCabecera.Selected.Add('UPRONOM'#9'27'#9'Unidad~proceso'#9#9);
  dbgCabecera.Selected.Add('UPAGONOM'#9'32'#9'Unidad~pago'#9#9);
  dbgCabecera.Selected.Add('DESUGEL'#9'15'#9'Descripción~de UGELES'#9#9);
  dbgCabecera.Selected.Add('TIPPLADES'#9'14'#9'Tipo de~archivo'#9#9);
  dbgCabecera.Selected.Add('ASOTIPDES'#9'9'#9'Tipo de~asociado'#9#9);
  dbgCabecera.Selected.Add('USUARIO'#9'15'#9'Usuario'#9#9);
  dbgCabecera.Selected.Add('FECHOR'#9'20'#9'Fecha y~hora'#9#9);
  dbgCabecera.Selected.Add('CERRADO'#9'1'#9'Cerrado'#9#9);
  dbgCabecera.ApplySelected;
end;

(******************************************************************************)

procedure TFprodis_res.btndepuraClick(Sender: TObject);
begin
  If DMPreCob.cdsCredito.FieldByName('CIERRE').AsString = 'S' Then
  Begin
    MessageDlg('Reporte de resultado ya cerrado', mtError, [mbOk], 0);
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

procedure TFprodis_res.btnplantillaClick(Sender: TObject);
begin
  If DMPreCob.cdsCredito.FieldByName('CIERRE').AsString = 'S' Then
  Begin
    MessageDlg('Reporte de resultado ya cerrado', mtError, [mbOk], 0);
    Exit;
  End;
  Try
    Fproinfpla_res := TFproinfpla_res.Create(Self);
    Fproinfpla_res.ShowModal;
  Finally
    Fproinfpla_res.Free;
  End;
end;

(******************************************************************************)

procedure TFprodis_res.btnidentificacionClick(Sender: TObject);
begin

  If DMPreCob.cdsCredito.FieldByName('CIERRE').AsString = 'S' Then
  Begin
    MessageDlg('Reporte de resultado ya cerrado', mtError, [mbOk], 0);
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

Procedure TFprodis_res.btncierreClick(Sender: TObject);
Var xSql:String;
Begin
  If DMPreCob.cdsCredito.FieldByName('CIERRE').AsString = 'S' Then
  Begin
    MessageDlg('Reporte de resultado ya cerrado', mtError, [mbOk], 0);
    Exit;
  End;
  // Verificando si todos los asociados cuentan con ASOID
  xSql := 'SELECT COUNT(*) CANTIDAD FROM COB_INF_PLA_DET WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString)
  +' AND ASOID IS NULL';
  DMPreCob.cdsQry.Close;
  DMPreCob.cdsQry.DataRequest(xSql);
  DMPreCob.cdsQry.Open;
  If DMPreCob.cdsQry.FieldByName('CANTIDAD').AsInteger <> 0 Then
  Begin
    MessageDlg('Existen registros sin identificación de asociado', mtError, [mbOk], 0);
    Exit;
  End;
  xSql := 'UPDATE COB_INF_PLA_CAB SET CIERRE = ''S'' WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
  DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
  actgridcab;
  (*
  DMPreCob.cdsCredito.Edit;
  DMPreCob.cdsCredito.FieldByName('CIERRE').AsString := 'S';
  DMPreCob.cdsCredito.Post;*)
End;

(******************************************************************************)

procedure TFprodis_res.btneliminarClick(Sender: TObject);
Var xSql, xnumero:String;
begin
  If DMPreCob.cdsCredito.FieldByName('CIERRE').AsString = 'S' Then
  Begin
    MessageDlg('Reporte de resultado ya cerrado', mtError, [mbOk], 0);
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

procedure TFprodis_res.btncerrarClick(Sender: TObject);
begin
Fprodis_res.Close;
end;

(******************************************************************************)

procedure TFprodis_res.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
  begin
    Key := #0;
    Perform(CM_DIALOGKEY, VK_TAB, 0);
  End;
end;

procedure TFprodis_res.fraOficinadblcdOficinaExit(Sender: TObject);
begin
  //fraOficina.dblcdOficinaExit(Sender);
  fraOficinadblcdOficinaChange(fraOficina.dblcdOficina);
end;

end.
