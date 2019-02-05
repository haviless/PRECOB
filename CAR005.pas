unit CAR005;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Wwdbigrd, Wwdbgrid, StdCtrls, Buttons, Mask, Spin,
  ExtCtrls, fcpanel,Db;

type
  TFdeparc = class(TForm)
    dbgPlantilla: TwwDBGrid;
    Panel4: TPanel;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    seinicio: TSpinEdit;
    sefinal: TSpinEdit;
    StaticText1: TStaticText;
    BitBtn6: TBitBtn;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    btnmartod: TBitBtn;
    GroupBox9: TGroupBox;
    btnmarigu: TBitBtn;
    StaticText2: TStaticText;
    GroupBox11: TGroupBox;
    Label3: TLabel;
    Label8: TLabel;
    btnmarlin: TBitBtn;
    selinini: TSpinEdit;
    selinfin: TSpinEdit;
    btndesmarcar: TBitBtn;
    btneliminar: TBitBtn;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label9: TLabel;
    btnmarlinbus: TBitBtn;
    mebuscacad: TMaskEdit;
    Panel3: TPanel;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    mebusca: TMaskEdit;
    mereemplaza: TMaskEdit;
    StaticText3: TStaticText;
    btnreemplazar: TBitBtn;
    btncerrar: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure dbgPlantillaDblClick(Sender: TObject);
    procedure btnmartodClick(Sender: TObject);
    procedure btndesmarcarClick(Sender: TObject);
    procedure btnmariguClick(Sender: TObject);
    procedure btneliminarClick(Sender: TObject);
    procedure btnmarlinClick(Sender: TObject);
    procedure btnreemplazarClick(Sender: TObject);
    procedure btncerrarClick(Sender: TObject);
    procedure btnmarlinbusClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure actdetdat;
    procedure procesoconcluido;
    { Public declarations }
  end;

var
  Fdeparc: TFdeparc;

implementation

uses CARDM1;

{$R *.dfm}

procedure TFdeparc.FormActivate(Sender: TObject);
begin
  actdetdat;

end;

procedure TFdeparc.BitBtn6Click(Sender: TObject);
Var xSql:String;
begin
  Screen.Cursor := crHourGlass;
  xSql := ' UPDATE COB_INF_PLA_DET SET LINEA = SUBSTR(LINEA,1,'+IntToStr(seinicio.Value-1)+')||'
  +' SUBSTR(LINEA, '+IntToStr(sefinal.Value+1) +','+IntToStr(DMPreCob.cdsQry4.FieldByName('LINEA').Size)+')'
  +' WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
  DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
  actdetdat;
  procesoconcluido;
  Screen.Cursor := crDefault;
end;

procedure TFdeparc.actdetdat;
Var xlin1, xlin2, xSql:String;
    xCol:Integer;
begin
  xSql := 'SELECT ROWID IDE, ROWNUM NUMERO, CHK, LINEA FROM'
  +' (SELECT ROWID IDE, LINEA, CHK FROM COB_INF_PLA_DET WHERE NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString)+' ORDER BY LINEA)';
  DMPreCob.cdsQry4.Close;
  DMPreCob.cdsQry4.DataRequest(xSql);
  DMPreCob.cdsQry4.Open;
  xLin1 := '         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22        23        24        25';
  xLin2 := '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
  xCol := 250;

  DMPreCob.cdsQry4.FieldByName('NUMERO').DisplayLabel := 'Número';
  DMPreCob.cdsQry4.FieldByName('NUMERO').DisplayWidth := 6;
  DMPreCob.cdsQry4.FieldByName('CHK').DisplayLabel := 'Marca';
  DMPreCob.cdsQry4.FieldByName('CHK').DisplayWidth := 1;
  DMPreCob.cdsQry4.FieldByName('LINEA').DisplayLabel := Copy(xLin1,1,xCol)+'~'+Copy(xLin2,1,xCol);
//  DMPreCob.cdsQry4.FieldByName('LINEA').DisplayWidth := 250;
  DMPreCob.cdsQry4.FieldByName('IDE').Visible := False;
end;

procedure TFdeparc.dbgPlantillaDblClick(Sender: TObject);
begin
  If DMPreCob.cdsQry4.FieldByName('CHK').AsString = 'X' Then
  Begin
    DMPreCob.cdsQry4.Edit;
    DMPreCob.cdsQry4.FieldByName('CHK').AsString := '';
  End
  Else
  Begin
   DMPreCob.cdsQry4.Edit;
   DMPreCob.cdsQry4.FieldByName('CHK').AsString := 'X';
  End;


end;

procedure TFdeparc.btnmartodClick(Sender: TObject);
var bmk: TBookmark;
begin
  bmk := DMPreCob.cdsQry4.GetBookmark;
  DMPreCob.cdsQry4.First;
  While Not DMPreCob.cdsQry4.Eof Do
  Begin
    DMPreCob.cdsQry4.Edit;
    DMPreCob.cdsQry4.FieldByName('CHK').AsString := 'X';
    DMPreCob.cdsQry4.Next;
  End;
  DMPreCob.cdsQry4.GotoBookmark(bmk);
  DMPreCob.cdsQry4.FreeBookmark(bmk);
  procesoconcluido;
end;

procedure TFdeparc.btndesmarcarClick(Sender: TObject);
var bmk: TBookmark;
begin
  bmk := DMPreCob.cdsQry4.GetBookmark;
  DMPreCob.cdsQry4.First;
  While Not DMPreCob.cdsQry4.Eof Do
  Begin
    DMPreCob.cdsQry4.Edit;
    DMPreCob.cdsQry4.FieldByName('CHK').AsString := '';
    DMPreCob.cdsQry4.Next;
  End;
  DMPreCob.cdsQry4.GotoBookmark(bmk);
  DMPreCob.cdsQry4.FreeBookmark(bmk);
  procesoconcluido;
end;

procedure TFdeparc.btnmariguClick(Sender: TObject);
Var xlinea:String;
var bmk: TBookmark;
begin
  bmk := DMPreCob.cdsQry4.GetBookmark;
  xlinea := DMPreCob.cdsQry4.FieldByName('LINEA').AsString;
  While Not DMPreCob.cdsQry4.Eof Do
  Begin
    If DMPreCob.cdsQry4.FieldByName('LINEA').AsString = xlinea Then
    Begin
      DMPreCob.cdsQry4.Edit;
      DMPreCob.cdsQry4.FieldByName('CHK').AsString := 'X';
    End;
    DMPreCob.cdsQry4.Next;
  End;
  DMPreCob.cdsQry4.GotoBookmark(bmk);
  DMPreCob.cdsQry4.FreeBookmark(bmk);
  procesoconcluido;
end;

procedure TFdeparc.btneliminarClick(Sender: TObject);
Var xSql, xeli:String;
begin
  xeli := 'N';
  If MessageDlg( '¿Seguro de eliminar los registros marcados? ', mtConfirmation, [mbYes, mbNo], 0) = mrYes Then
  Begin
    Screen.Cursor := crHourGlass;
    DMPreCob.cdsQry4.First;
    While Not DMPreCob.cdsQry4.Eof Do
    Begin
      If DMPreCob.cdsQry4.FieldByName('CHK').AsString = 'X' Then
      Begin
        xeli := 'S';
        xSql := 'DELETE FROM COB_INF_PLA_DET WHERE ROWID = '+QuotedStr(DMPreCob.cdsQry4.FieldByName('IDE').AsString);
        DMPreCob.DCOM1.AppServer.EjecutaSQL(xSql);
      End;
      DMPreCob.cdsQry4.Next;
    End;
    If xeli = 'S' Then
    Begin
      actdetdat;
      MessageDlg('Las lineas marcadas con "X" se'#13'han eliminando correctamente', mtInformation, [mbOk], 0);
    End
    Else MessageDlg('No existen registros marcados con "X" para eliminar',mtError, [mbOk], 0);
    Screen.Cursor := crDefault;
  End;
end;

procedure TFdeparc.btnmarlinClick(Sender: TObject);
var bmk: TBookmark;
begin
  bmk := DMPreCob.cdsQry4.GetBookmark;
  DMPreCob.cdsQry4.First;
  While Not DMPreCob.cdsQry4.Eof Do
  Begin
    If (DMPreCob.cdsQry4.FieldByName('NUMERO').AsInteger >= selinini.Value) And (DMPreCob.cdsQry4.FieldByName('NUMERO').AsInteger <= selinfin.Value) Then
    Begin
      DMPreCob.cdsQry4.Edit;
      DMPreCob.cdsQry4.FieldByName('CHK').AsString := 'X';
    End;
    DMPreCob.cdsQry4.Next;
  End;
  DMPreCob.cdsQry4.GotoBookmark(bmk);
  DMPreCob.cdsQry4.FreeBookmark(bmk);
  procesoconcluido;
End;

procedure TFdeparc.btnreemplazarClick(Sender: TObject);
Var xSql:String;
begin
// Reemplazar
  Screen.Cursor := crHourGlass;
  If Trim(mebusca.Text) = '' Then
  Begin
    MessageDlg('Ingrese caracter a buscar', mtError, [mbOk], 0);
    mebusca.SetFocus;
    Exit;
  End;
  If length(mereemplaza.Text) = 0 Then
  Begin
    MessageDlg('Ingrese caracter a reemplazar', mtError, [mbOk], 0);
    mereemplaza.SetFocus;
    Exit;
  End;
  If MessageDlg('Seguro de modificar los caracteres' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
  Begin
    Screen.Cursor:= crHourGlass;
    xSql := 'UPDATE COB_INF_PLA_DET '
           +'SET LINEA = REPLACE(LINEA,'+QuotedStr(Trim(mebusca.Text))+','+QuotedStr(mereemplaza.Text)+')'
    +' WHERE  NUMERO = '+QuotedStr(DMPreCob.cdsCredito.FieldByName('NUMERO').AsString);
    DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
    actdetdat;
    Screen.Cursor:= crDefault;
    procesoconcluido;
  End;
  Screen.Cursor := crDefault;
end;

procedure TFdeparc.btncerrarClick(Sender: TObject);
begin
  Fdeparc.close;
end;

procedure TFdeparc.btnmarlinbusClick(Sender: TObject);
Var xSql, xlinea:String;
var bmk: TBookmark;
begin
  bmk := DMPreCob.cdsQry4.GetBookmark;
  DMPreCob.cdsQry4.First;
  While Not DMPreCob.cdsQry4.Eof Do
  Begin
    If Pos(Trim(mebuscacad.Text) , DMPreCob.cdsQry4.FieldByName('LINEA').AsString ) > 0 Then
    Begin
      DMPreCob.cdsQry4.Edit;
      DMPreCob.cdsQry4.FieldByName('CHK').AsString := 'X';
    End;
    DMPreCob.cdsQry4.Next;
  End;
  DMPreCob.cdsQry4.GotoBookmark(bmk);
  DMPreCob.cdsQry4.FreeBookmark(bmk);
  procesoconcluido;
end;

procedure TFdeparc.procesoconcluido;
begin
  MessageDlg('Proceso concluido', mtInformation, [mbOk], 0);
end;

end.
