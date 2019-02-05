unit CARFRA001;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, wwdblook, Wwdbdlg, StdCtrls, Mask, ExtCtrls;

type
  TfraOficina = class(TFrame)
    Label5: TLabel;
    Oficina: TLabel;
    pnlOficina: TPanel;
    meofdes: TMaskEdit;
    dblcdOficina: TwwDBLookupComboDlg;
    procedure dblcdOficinaChange(Sender: TObject);
    procedure dblcdOficinaExit(Sender: TObject);
  private
    function  GetOficinaId(): string;
    procedure SetOficinaId(Value: string);
  public
    procedure cargar();
    Property oficinaId : string read GetOficinaId write SetOficinaId;
  end;

implementation

uses CARDM1, CAR001;

{$R *.dfm}

(******************************************************************************)

procedure TfraOficina.cargar();
var xSQL : String;
begin
   xSQL := 'select OFDESID,OFDESNOM from APO110 order by OFDESID ';
   DMPreCob.cdsOficina.Close;
   DMPreCob.cdsOficina.DataRequest(xSQL);
   DMPreCob.cdsOficina.Open;

   dblcdOficina.LookupField:='';
   dblcdOficina.LookupTable := DMPreCob.cdsOficina;
   dblcdOficina.LookupField:='OFDESID';
   dblcdOficina.Selected.Clear;
   dblcdOficina.Selected.Add('OFDESID'#9'3'#9'Id~Oficina'#9#9);
   dblcdOficina.Selected.Add('OFDESNOM'#9'15'#9'Oficina'#9#9);
   self.oficinaId := DMPreCob.wOfiId;
end;

(******************************************************************************)

function TfraOficina.GetOficinaId(): string;
begin
  Result:= dblcdOficina.text;
end;

(******************************************************************************)

procedure TfraOficina.SetOficinaId(Value: string);
begin
   If DMPreCob.cdsOficina.Locate('OFDESID',VarArrayof([Value]),[]) Then
     begin
      dblcdOficina.text := Value;
     end;
end;

(******************************************************************************)

procedure TfraOficina.dblcdOficinaChange(Sender: TObject);
begin
  If DMPreCob.cdsOficina.Locate('OFDESID',VarArrayof([self.dblcdOficina.text]),[]) Then
      begin
         meofdes.Text := DMPreCob.cdsOficina.FieldByName('OFDESNOM').AsString;
         DMPreCob.wOfiId := DMPreCob.cdsOficina.FieldByName('OFDESID').AsString;
         DMPreCob.xOfiNombre := DMPreCob.cdsOficina.FieldByName('OFDESNOM').AsString;
         FPrincipal.Caption := DMPreCob.xCaptionPrincipal + DMPreCob.xOfiNombre;
      end
  else
      begin
         if not self.dblcdOficina.Focused then self.dblcdOficina.text:='';
         self.meofdes.Text := '';
      end;
end;

(******************************************************************************)

procedure TfraOficina.dblcdOficinaExit(Sender: TObject);
begin
    self.dblcdOficinaChange(self.dblcdOficina);
end;

end.
