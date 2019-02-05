unit CAR021;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, wwdbedit,Qt;

type
  TFCtrlAcceso = class(TForm)
    gbControlAcceso: TGroupBox;
    lblUsuario: TLabel;
    lblContrasena: TLabel;
    dbePassword: TwwDBEdit;
    dbeUsuario: TwwDBEdit;
    bbtnOkIngreso: TBitBtn;
    bbtnCancelaIngreso: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure bbtnOkIngresoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dbePasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    wBD :String;
    { Public declarations }
    xdiasduracpass:Integer;
  end;

var
  FCtrlAcceso: TFCtrlAcceso;
  xSQL : String;

implementation

uses CARDM1, CAR001, CAR022, Math;


{$R *.dfm}




(*

var
   IniFile : TIniFile;
   xDB : String;
begin
   IniFile:=TIniFile.Create('C:\SOLExes\SOLConf.ini');
   xDB := IniFile.ReadString('BD','BASE_DE_DATOS','');
   if Length(Trim(xDB))=0 Then
      DBX_Connect1.Connected:=False
   else
      begin
         DBX_Connect1.Params.Values['DATABASE']  := xDB;
         DBX_Connect1.Params.Values['MULTIPLE TRANSACTION']  := 'True'; // para ejecutar las transacciones
      end;

             *)


procedure TFCtrlAcceso.bbtnOkIngresoClick(Sender: TObject);
Var
   xfecfin :TDate;
   xdiasexppass:Integer;
   xdiasfaltantes:Integer;
   xpassact, xctrl_ip, xingresa :String;
begin
   DMPreCob.wBD      := 'TEST';
   DMPreCob.wUsuario := dbeUsuario.Text;
   DMPreCob.wModulo  := 'PRCB';

// Obtiene IP del cliente
   Try
      DMPreCob.cIP:= DMPreCob.ObtenerIpdeNetbios(DMPreCob.computerName);
   Except
      ShowMessage( 'ERROR de Conexión.');
      ModalResult:=mrCancel;
      Exit;
   End;

// Usuario se conecta a la base de datos
   Try
      DMPreCob.DCOM1.AppServer.Conectate('xxxxxx', dbeUsuario.Text, dbePassword.Text);
   Except
      Showmessage('Usuario y/o contraseña no reconocido por la Base de Datos');
      ModalResult:=mrCancel;
      Exit;
   End;

// busca en tabla DE USUARIO (TGE006) para determinar que es un usuario de base de datos
   xSQL := 'select FECEXP, OFDESID, nvl(CTRL_IP,''S'') CTRL_IP, '
          +'       TO_DATE(nvl(FECINI_PWD,sysdate-30)) FECINI_PWD, '
          +'       TO_DATE(nvl(FECFIN_PWD, sysdate-1)) FECFIN_PWD, '
          +'       nvl(DIASEXP_PWD,7) DIASEXP_PWD,'
          +'       nvl(DIASDURAC_PWD,30) DIASDURAC_PWD '
          +'from TGE006 '
          +'where USERID = '+QuotedStr(DMPreCob.wUsuario);
   DMPreCob.cdsQry.Close;
   DMPreCob.cdsQry.DataRequest(xSql);
   DMPreCob.cdsQry.Open;
   If DMPreCob.cdsQry.RecordCount=0 then
   Begin
      Showmessage('Usuario no reconocido para el uso de Aplicaciones');
      ModalResult:=mrCancel;
      Exit;
   End;

// valida que contraseña en control de aplicaciones (TGE006), no haya expirado
   If (DMPreCob.cdsQry.FieldByName('FECEXP').AsDateTime>0) and
      (DMPreCob.cdsQry.FieldByName('FECEXP').AsDateTime<Date) Then
   Begin
      Showmessage('Usuario ha caducado para el uso de Aplicaciones');
      ModalResult:=mrCancel;
      Exit;
   End;
   xfecfin         := DMPreCob.cdsQry.FieldByName('FECFIN_PWD').AsDateTime;
   xdiasexppass    := DMPreCob.cdsQry.FieldByName('DIASEXP_PWD').AsInteger;
   xdiasduracpass  := DMPreCob.cdsQry.FieldByName('DIASDURAC_PWD').AsInteger;
   xpassact        := dbePassword.Text;
   DMPreCob.wOfiId := DMPreCob.cdsQry.FieldByName('OFDESID').AsString;
   xctrl_ip        := DMPreCob.cdsQry.FieldByName('CTRL_IP').AsString;
   DMPreCob.widepc := DMPreCob.computerName;

// determina que el usuario tenga acceso al módulo
// busca en tabla TGE006 para determinar que es un usuario de base de datos y de la aplicación
   xSQL := 'Select USUARIOS.USERID, USUARIOS.USERNOM, USUARIOGRUPO.GRUPOID, '
          +'       GRUPOS.GRUPODES, GRUPOS.GRUPOADM, ACCESOGRUPO.MODULOID, '
          +'       ACCESOGRUPO.TIPO, ACCESOGRUPO.OBJETO, ACCESOGRUPO.FORMA '
          +'From TGE006 USUARIOS, TGE007 USUARIOGRUPO, TGE003 GRUPOS, TGE001 ACCESOGRUPO '
          +'where USUARIOS.USERID='+quotedstr(DMPreCob.wUsuario) // -- TGE006 USUARIOS
          +'  and USUARIOGRUPO.USERID=USUARIOS.USERID' // -- TGE007 USUARIOGRUPO
          +'  and GRUPOS.GRUPOID=USUARIOGRUPO.GRUPOID' // -- TGE003 GRUPOS
          +'  and ACCESOGRUPO.GRUPOID=USUARIOGRUPO.GRUPOID '
          +'  and ACCESOGRUPO.MODULOID='+quotedstr(DMPreCob.wModulo)
          +'  and ACCESOGRUPO.TIPO=''0'' '; // TGE001 ACCESOGRUPO
   DMPreCob.cdsQry.Close;
   DMPreCob.cdsQry.DataRequest(xSQL);
   DMPreCob.cdsQry.Open;
   If DMPreCob.cdsQry.RecordCount=0 then
   Begin
      ShowMessage('No tiene Acceso al módulo');
      ModalResult:=mrCancel;
      Exit;
   End;

// Identifica si el usuario puede ejecutar los sistemas de cualquier maquina
// o solo de las máquina que se le han asignado
   xingresa := 'N';
   If xctrl_ip = 'S' Then
   Begin
     xSQL := 'SELECT IP_ASIGNADO FROM TGE010 WHERE USERID = '+QuotedStr(DMPreCob.wUsuario);
     DMPreCob.cdsQry.Close;
     DMPreCob.cdsQry.DataRequest(xSQL);
     DMPreCob.cdsQry.Open;
     While Not DMPreCob.cdsQry.Eof Do
     Begin
        If DMPreCob.cdsQry.FieldByName('IP_ASIGNADO').AsString = DMPreCob.cIP then xingresa := 'S';
        DMPreCob.cdsQry.Next;
     End;
   End;
   If (xingresa = 'N') And (xctrl_ip = 'S') Then
   Begin
      Showmessage('Usuario no autorizado para ingresar de este equipo');
      ModalResult:=mrCancel;
      Exit;
   End;

// DETERMINA NRO DE IDENTIFICADOR PARA GRABAR EN ARCHIVO LOG DE ACCESOS
// SE DETERMINA EN BASE A LA FECHA+HORA DE INGRESO A LA BASE DE DATOS
   xSQL := 'SELECT TO_CHAR(SYSDATE,''YYYYMMDDHH24MISS'') IDE, SYSDATE FECHORCON FROM DUAL';
   DMPreCob.cdsQry.Close;
   DMPreCob.cdsQry.DataRequest(xSQL);
   DMPreCob.cdsQry.Open;
   DMPreCob.ideconex  := DMPreCob.cdsQry.FieldByName('IDE').AsString;
   DMPreCob.fechorcon := DMPreCob.cdsQry.FieldByName('FECHORCON').AsString;

// ENVIA PARAMETROS DE LA PC DEL USUARIO HACIA LA APLICACION SERVIDOR
   DMPreCob.DCOM1.AppServer.ConexionON(DMPreCob.wUsuario, DMPreCob.cIP, DMPreCob.wModulo, DMPreCob.ideconex, DMPreCob.fechorcon, DMPreCob.widepc);

// controla caducidad de contraseña
   xSQL := 'SELECT TO_DATE('+QuotedStr(DateToStr(xfecfin))+') - TO_DATE(SYSDATE) DIASFALTANTE FROM DUAL';
   DMPreCob.cdsQry.Close;
   DMPreCob.cdsQry.DataRequest(xSQL);
   DMPreCob.cdsQry.Open;

   xdiasfaltantes := DMPreCob.cdsQry.FieldByName('DIASFALTANTE').AsInteger; // dias que faltan
   If xdiasfaltantes <= xdiasexppass Then
   Begin
      If xdiasfaltantes <= 0 then
         MessageDlg('SU CONTRASEÑA HA CADUCADO, DEBE CAMBIARLA AHORA', mtCustom, [mbOk], 0)
      else
         if xdiasfaltantes=1 then
            MessageDlg('!!! FALTA 1 DíA PARA EL VENCIMIENTO DE SU CONTRASEÑA ¡¡¡'+chr(13)
                      +'            SE SUGIERE CAMBIARLA AHORA                  ', mtInformation, [mbOk], 0)
         else
            MessageDlg('!!! FALTAN '+IntToStr(xdiasfaltantes)+' DÍAS PARA EL VENCIMIENTO DE SU CONTRASEÑA ¡¡¡'+chr(13)
                      +'            SE SUGIERE CAMBIARLA AHORA                  ', mtInformation, [mbOk], 0);
      FCambioContrasena:= TFCambioContrasena.create(self);
      Try
         FCambioContrasena.ShowModal;
      Finally
         FCambioContrasena.Free;
      End;
   End;
   If xdiasfaltantes <= 0 Then
   Begin
      ModalResult:=mrCancel;
      Exit;
   End;

   ModalResult:=mrOk;
End;

Procedure TFCtrlAcceso.FormShow(Sender: TObject);
Begin
  dbeUsuario.SetFocus;
End;

Procedure TFCtrlAcceso.FormKeyPress(Sender: TObject; var Key: Char);
Begin
  If Key = #13 then
  Begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  End;
End;


procedure TFCtrlAcceso.dbePasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key =  13 then
      bbtnOkIngreso.OnClick(bbtnOkIngreso);
end;

end.
