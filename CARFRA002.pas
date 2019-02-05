unit CARFRA002;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Mask, StdCtrls, wwdblook, Wwdbdlg;

type
  TfraUse = class(TFrame)
    Label6: TLabel;
    Label1: TLabel;
    dblcduse: TwwDBLookupComboDlg;
    meusedes: TMaskEdit;
    procedure dblcduseChange(Sender: TObject);
    procedure dblcduseExit(Sender: TObject);
  private
    function  GetUseId(): string;
    procedure SetUseId(Value: string);
    function  GetUPagoId(): string;
    function  GetUProId(): string;
  public
    procedure cargar(IOficinaId:string);
    Property useId : string read GetUseId write SetUseId;
    Property upagoId : string read GetUPagoId;
    Property uproId : string read GetUProId;
  end;

implementation

uses CARDM1;

{$R *.dfm}
(******************************************************************************)

procedure TfraUse.cargar(IOficinaId:string);
var xSQL : String;
begin
   xSql := 'SELECT UPROID, UPAGOID, USEID, USENOM FROM APO101 WHERE OFDESID = '+QuotedStr(IOficinaId);
   DMPreCob.cdsUse.Close;
   DMPreCob.cdsUse.DataRequest(xSQL);
   DMPreCob.cdsUse.Open;

   dblcdUse.LookupField:='';
   dblcdUse.LookupTable:=DMPreCob.cdsUse;
   dblcdUse.LookupField:='USEID';
   dblcdUse.Selected.Clear;
   dblcdUse.Selected.Add('USEID'#9'10'#9'Código'#9#9);
   dblcdUse.Selected.Add('USENOM'#9'25'#9'Descripción'#9#9);
end;

(******************************************************************************)

function TfraUse.GetUseId(): string;
begin
  Result:= dblcdUse.text;
end;

(******************************************************************************)

procedure TfraUse.SetUseId(Value: string);
begin
  If DMPreCob.cdsUse.Locate('USEID',VarArrayof([Value]),[]) Then
     dblcdUse.Text := Value;
end;

(******************************************************************************)

function TfraUse.GetUPagoId(): string;
begin
  Result:= DMPreCob.cdsUse.FieldByName('UPAGOID').AsString;
end;

(******************************************************************************)

function TfraUse.GetUProId(): string;
begin
  Result:= DMPreCob.cdsUse.FieldByName('UPROID').AsString;
end;

(******************************************************************************)

procedure TfraUse.dblcduseChange(Sender: TObject);
begin
  // meusedes.Text := DMPreCob.cdsUse.FieldByName('USENOM').AsString;

  If DMPreCob.cdsUse.Locate('USEID',VarArrayof([self.dblcduse.text]),[]) Then
     meusedes.Text := DMPreCob.cdsUse.FieldByName('USENOM').AsString
  else
     begin
        if not self.dblcduse.Focused then self.dblcduse.text := '';
        self.meusedes.Text := '';
     end;
end;

(******************************************************************************)
procedure TfraUse.dblcduseExit(Sender: TObject);
begin
   self.dblcduseChange(self.dblcduse);
end;

end.
