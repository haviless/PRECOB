unit CAR022;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, wwdbedit;

type
  TFCambioContrasena = class(TForm)
    gbCambioContrasena: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbePwdAnterior: TwwDBEdit;
    dbePwdNuevo: TwwDBEdit;
    dbePwdNuevoConfirma: TwwDBEdit;
    bbtnCambiaPWD: TBitBtn;
    bbtnCancelaCambioPWD: TBitBtn;
    procedure bbtnCambiaPWDClick(Sender: TObject);
    procedure bbtnCancelaCambioPWDClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCambioContrasena: TFCambioContrasena;
  xSQL : String;

implementation

uses CAR021, CARDM1;


{$R *.dfm}

Procedure TFCambioContrasena.bbtnCambiaPWDClick(Sender: TObject);
Begin
   If dbePwdAnterior.Text<>FCtrlAcceso.dbePassword.Text then
   Begin
      Showmessage('Contraseña anterior no coincide con valor original');
      dbePwdAnterior.SetFocus;
      exit;
   End;

   If dbePwdAnterior.Text=dbePwdNuevo.text then
   Begin
      Showmessage('No se permite volver a digitar la misma contraseña, reintente');
      dbePwdNuevo.SetFocus;
      exit;
   End;

   if not (DMPreCob.isAlfanumerico(dbePwdNuevo.Text)) then
     begin
       Showmessage('La Contraseña solo debe tener letras de la A(a) a la Z(z) y/o numeros del 0 al 9');
       dbePwdNuevo.SetFocus;
       exit;
     end;

   If dbePwdNuevo.text<>dbePwdNuevoConfirma.text then
   Begin
      Showmessage('Contraseña Nueva no coincide con la confirmación, reintente');
      dbePwdNuevo.SetFocus;
      exit;
   End;

   (*
   xSQL := 'alter user '+FCtrlAcceso.dbeUsuario.Text+' identified by "'+dbePwdNuevo.Text+'"';
   Try
      DMPreCob.DCOM1.AppServer.EjecutaSQL(xSQL);
   Except
      ShowMessage('No se pudo cambiar Contraseña');
      exit;
   End;
   *)

   if DMPreCob.DCOM1.AppServer.setPassword(FCtrlAcceso.dbeUsuario.Text,dbePwdNuevo.Text)<>'' then
     begin
       ShowMessage('No se pudo cambiar Contraseña');
       exit;
     end;

   try
     xSQL := 'UPDATE TGE006 SET FECINI_PWD = TO_DATE(SYSDATE), '
     +'    FECFIN_PWD = TO_DATE(SYSDATE)+'+IntToStr(FCtrlAcceso.xdiasduracpass)
     +' WHERE USERID = '+QuotedStr(DMPreCob.wUsuario);
     DMPreCob.DCOM1.AppServer.EjecutaSQL(xSQL);
     showmessage('La contraseña fue cambiada correctamente, vuelva a ingresar a la Aplicación');
   except
     showmessage('Ocurrió algun error y no se pudo cambiar la Contraseña');
   end;
   Application.Terminate;
   Exit;

End;

procedure TFCambioContrasena.bbtnCancelaCambioPWDClick(Sender: TObject);
begin
   Close;
end;

procedure TFCambioContrasena.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TFCambioContrasena.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

end.
