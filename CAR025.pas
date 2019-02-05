unit CAR025;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Spin, Mask, StdCtrls, Buttons, ExtCtrls, wwdblook, Wwdbdlg,
  Grids, Wwdbigrd, Wwdbgrid, ComCtrls, DBGrids, db, ppBands, ppCache,
  ppClass, ppDB, ppDBPipe, ppDBBDE, ppComm, ppRelatv, ppProd, ppReport,
  ppCtrls, ppPrnabl, ppVar, ppEndUsr, ppParameter, CARFRA001, CARFRA002,
  ImgList,DBClient;

type
  TFEnvVsCobVsPrecob_Det = class(TForm)
    pagecontrol: TPageControl;
    TabSheet3: TTabSheet;
    dbgprevioresgeneral: TwwDBGrid;
    ImageList1: TImageList;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edAnho: TEdit;
    edMes: TEdit;
    edUPro: TEdit;
    edUPago: TEdit;
    edUse: TEdit;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    lblNroRegistros: TLabel;
    Label5: TLabel;
    edTipo: TEdit;
    Image1: TImage;
    Image2: TImage;
    lblNroCoincidenciasUgel: TLabel;
    lblNroCambiosUgel: TLabel;
    DBGrid: TDBGrid;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgprevioresgeneralTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure dbgprevioresgeneralCalcTitleImage(Sender: TObject;
      Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
    procedure dbgprevioresgeneralCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
  private
    xtippla : String;
    procedure gridResumenGeneral;
    procedure DoSorting(cdsName: TClientDataset; AFieldName: String);
    procedure cargarDatos;
    function isCambioUgel: boolean;
  public
    XCOBANO:STRING;
    XCOBMES:STRING;
    XUPROID:STRING;
    XUPAGOID:STRING;
    XUSEID:STRING;
    XTIPO:STRING;
  end;

var
  FEnvVsCobVsPrecob_Det: TFEnvVsCobVsPrecob_Det;

implementation

uses CARDM1, CAR019;

{$R *.dfm}

(******************************************************************************)

procedure TFEnvVsCobVsPrecob_Det.FormActivate(Sender: TObject);
Var xSql:String;
begin
  DMPreCob.cdsQry8.Close;
  dbgprevioresgeneral.DataSource:=DMPreCob.dsQry8;
  cargarDatos();
end;

(******************************************************************************)

procedure TFEnvVsCobVsPrecob_Det.cargarDatos();
Var
xSQL: String;
xSTRMonCob:string;
xSTRMonEnv:string;
xSTRTipPla: string;
begin
   Screen.Cursor := crHourGlass;
   (*
   XSQL:='SELECT COB.COBANO,COB.COBMES, '
        +'       COB.UPROID,COB.UPAGOID,COB.USEID, '
        +'       COB304_EXISTE,PRECOB_EXISTE,PRECOB_RESULTADO, '
        +'       COB.ASOID, APO.ASOAPENOM '
        +'  FROM (SELECT COBANO,COBMES,UPROID,UPAGOID,USEID,ASOID, '
        +'        CASE WHEN SUBSTR(COB304_EXISTE, 1, 9) = ''NO_COB304'' THEN ''NO'' ELSE ''SI'' END COB304_EXISTE, '
        +'        CASE WHEN SUBSTR(PRECOB_EXISTE, 1, 9) = ''NO_PRECOB'' THEN ''NO'' ELSE ''SI'' END PRECOB_EXISTE, '
        +'        PRECOB_RESULTADO '
        +'           FROM COB_ENV_COB_PRE'
        +'          WHERE UPROID =' + QuotedStr(XUPROID)
        +'                AND UPAGOID ='+ QuotedStr(XUPAGOID)
        +'                AND USEID ='+QuotedStr(XUSEID)
        +'                AND COBANO='+QuotedStr(XCOBANO)
        +'                AND COBMES ='+QuotedStr(XCOBMES)
        +'                AND SUBSTR(COB304_EXISTE, 1, 9) = ''NO_COB304''
        +'                ) COB,'
        +'       APO201@DBPRODLEE APO'
        +' WHERE COB.ASOID = APO.ASOID ';
  *)


   XSQL:='SELECT COB.COBANO,COB.COBMES, '
        +'       COB.UPROID COB_UPROID,COB.UPAGOID COB_UPAGOID,COB.USEID COB_USEID, '
        +'       TRIM(CASE WHEN PRECOB_RESULTADO IS NULL THEN ''No descargado'' /* en TERPCRE*/ '
        +'                 WHEN UPPER(PRECOB_RESULTADO) LIKE ''%COBRADO%'' THEN ''No descargado en Planilla por Cobranzas'' '
        +'                 ELSE PRECOB_RESULTADO '
        +'             END) PRECOB_RESULTADO, '
        +'       COB.ASOID, APO.ASOAPENOM, '
        +'       APO.UPROID APO_UPROID, APO.UPAGOID APO_UPAGOID, APO.USEID APO_USEID'
        +'  FROM (SELECT COBANO,COBMES,UPROID,UPAGOID,USEID,ASOID, '
        +'                PRECOB_RESULTADO '
        +'          FROM COB_ENV_COB_PRE'
        +'         WHERE UPROID =' + QuotedStr(XUPROID)
        +'               AND UPAGOID ='+ QuotedStr(XUPAGOID)
        +'               AND USEID ='+QuotedStr(XUSEID)
        +'               AND COBANO='+QuotedStr(XCOBANO)
        +'               AND COBMES ='+QuotedStr(XCOBMES);
        if XTIPO='NO_COB304' then
         XSQL:=XSQL+'    AND SUBSTR(COB304_EXISTE, 1, 9) = ''NO_COB304'''
        else if XTIPO='NO_PRECOB_RESUL' then
         XSQL:=XSQL+'    AND SUBSTR(PRECOB_EXISTE_RESUL, 1, 9) = ''NO_PRECOB''';
   XSQL:=XSQL+'          ) COB,'
        +'       APO201';
        IF DMPreCob.DCOM1.Address='192.168.20.34' THEN XSQL:=XSQL+'@DBPRODLEE ';
   XSQL:=XSQL+' APO'
        +' WHERE COB.ASOID = APO.ASOID ';


   DMPreCob.cdsQry8.Close;
   DMPreCob.cdsQry8.DataRequest(xSql);
   DMPreCob.cdsQry8.Open;


   gridresumenGeneral;

   pagecontrol.TabIndex := 0;
   Screen.Cursor := crDefault;

   Dbgprevioresgeneral.SetFocus;
   edAnho.Text:=XCOBANO;
   edMes.Text:=XCOBMES;
   edUPro.Text:=XUPROID;
   edUPago.Text:=XUPAGOID;
   edUse.Text:=XUSEID;

   if XTIPO='NO_COB304' then
      edTipo.Text:='NO Cobrado por descargo de Planilla'
   else if XTIPO='NO_PRECOB_RESUL' then
      edTipo.Text:='NO Considerado en el descuento de la Unidad de Proceso según descargo de TERPCRE';



end;

(******************************************************************************)

procedure TFEnvVsCobVsPrecob_Det.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

(******************************************************************************)

procedure TFEnvVsCobVsPrecob_Det.BitBtn3Click(Sender: TObject);
begin
  case pagecontrol.TabIndex of
     0: begin
          DBGrid.DataSource := DMPreCob.dsQry8;
          DMPreCob.HojaExcel('Reporte', DMPreCob.dsQry8, DBGrid);
        end;
  end;

end;

(******************************************************************************)


procedure TFEnvVsCobVsPrecob_Det.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
  begin
    Key := #0;
    Perform(CM_DIALOGKEY, VK_TAB, 0);
  End;
end;


(******************************************************************************)
function TFEnvVsCobVsPrecob_Det.isCambioUgel():boolean;
begin
   with DMPreCob.cdsQry8 do
     begin
       if (FieldByName('COB_UPROID').AsString <> FieldByName('APO_UPROID').AsString)
          OR (FieldByName('COB_UPAGOID').AsString <> FieldByName('APO_UPAGOID').AsString)
          OR (FieldByName('COB_USEID').AsString <> FieldByName('APO_USEID').AsString) then
          result:=true
       else
         result:=false;
      end;
end;
(******************************************************************************)

procedure TFEnvVsCobVsPrecob_Det.gridResumenGeneral;
Var xNroRegistros:Double;
    xNroCoincidenciasUgel:integer;
    xNroCambiosUgel:integer;
begin
   xNroRegistros:=0;
   xNroCoincidenciasUgel:=0;
   xNroCambiosUgel:=0;
   if DMPreCob.cdsQry8.Active then
   begin
   DMPreCob.cdsQry8.First;
   While not DMPreCob.cdsQry8.Eof Do
   Begin
       if isCambioUgel then
         xNroCambiosUgel:=xNroCambiosUgel+1
       else
         xNroCoincidenciasUgel:=xNroCoincidenciasUgel+1;
       xNroRegistros := xNroRegistros + 1;
       DMPreCob.cdsQry8.Next;
   End;

   lblNroRegistros.Caption:=FloatToStr(xNroRegistros)+' Registros encontrados';
   lblNroCoincidenciasUgel.Caption:= IntToStr(xNroCoincidenciasUgel)+' Coincidencias de Ugel';
   lblNroCambiosUgel.Caption:= IntToStr(xNroCambiosUgel)+' Cambios de Ugel';

   dbgPrevioResGeneral.Selected.Clear;
   dbgPrevioResGeneral.Selected.Add('ASOID'#9'12'#9'ASOID');
   dbgPrevioResGeneral.Selected.Add('ASOAPENOM'#9'50'#9'Apellidos y Nombres'#9'F'#9'Maestro de Asociados');
   dbgPrevioResGeneral.Selected.Add('APO_UPROID'#9'5'#9'Und.~Pago'#9'F'#9'Maestro de Asociados');
   dbgPrevioResGeneral.Selected.Add('APO_UPAGOID'#9'5'#9'Und.~Proceso'#9'F'#9'Maestro de Asociados');
   dbgPrevioResGeneral.Selected.Add('APO_USEID'#9'5'#9'Ugel'#9'F'#9'Maestro de Asociados');

   if XTIPO='NO_COB304' then
     dbgPrevioResGeneral.Selected.Add('PRECOB_RESULTADO'#9'30'#9'Resultado');

   dbgPrevioResGeneral.ApplySelected;

   dbgPrevioResGeneral.RefreshDisplay;
   DMPreCob.cdsQry8.First;
   end;
end;

(******************************************************************************)

procedure TFEnvVsCobVsPrecob_Det.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    DMPreCob.cdsQry8.Filtered:=false;
    DMPreCob.cdsQry8.Close;
    Action:= caFree;
end;

(******************************************************************************)

procedure TFEnvVsCobVsPrecob_Det.DoSorting(cdsName:TClientDataset; AFieldName: String);
const
  NONSORTABLE: Set of TFieldType=[ftBlob,ftMemo,ftOraBlob,ftOraCLob];
begin
  try
      with cdsName do
      begin
        if IsEmpty or (FieldByName(AFieldName).DataType in NONSORTABLE) then
          Exit;

        if (IndexFieldNames=AFieldName) then
          begin
             IndexDefs.Update;
             if IndexDefs.IndexOf('w2wTempIndex')>-1  then
             begin
               DeleteIndex('w2wTempIndex');
               IndexDefs.Update;
             end;
               AddIndex('w2wTempIndex',AFieldName,[ixDescending,ixCaseInsensitive],'','',0);
               IndexName:='w2wTempIndex';
          end
        else
          begin
             IndexFieldNames := AFieldName;
          end;
      end;
  except
  end;
end;

(******************************************************************************)

procedure TFEnvVsCobVsPrecob_Det.dbgprevioresgeneralTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  DoSorting(TClientDataset((Sender as TwwDBGrid).Datasource.Dataset),AFieldName);
end;

(******************************************************************************)
procedure TFEnvVsCobVsPrecob_Det.dbgprevioresgeneralCalcTitleImage(Sender: TObject;
  Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
begin
  try
      with (Sender as TwwDBGrid) do
        if Field.FieldName=TClientDataset(Datasource.Dataset).indexfieldnames then
          begin
            TitleImageAttributes.ImageIndex := 0;
          end
        else if TClientDataset(Datasource.Dataset).indexname = 'w2wTempIndex' then
            begin
               TClientDataset(Datasource.Dataset).indexdefs.Update;
               if TClientDataset(Datasource.Dataset).indexdefs.Find('w2wTempIndex').Fields = Field.Fieldname then
                 TitleImageAttributes.ImageIndex := 1;
            end;
  except
  end;          
end;

(******************************************************************************)
procedure TFEnvVsCobVsPrecob_Det.dbgprevioresgeneralCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
   if (Field.FieldName='APO_UPROID') OR (Field.FieldName='APO_UPAGOID') OR (Field.FieldName='APO_USEID')  then
     begin
        if isCambioUgel then
           begin
              AFont.Color:=clRed;
              AFont.Style:=[fsBold];
           end
     end;

  if Highlight then
     begin
        AFont.Color := clwhite;
        ABrush.Color := clblue;
     end;
end;
(******************************************************************************)
end.


