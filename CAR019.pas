unit CAR019;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBGrids, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls,
  DB, ppParameter, ppCtrls, ppBands, ppClass, ppVar, ppPrnabl, ppCache,
  ppProd, ppReport, ppRelatv, ppDB, ppDBPipe, ppDBBDE, ppComm, ppEndUsr,
  DBClient, ImgList;

type
  TFEnvVsRepPorResultado = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    dbgpreviores: TwwDBGrid;
    DBGrid: TDBGrid;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    btnDetallar: TBitBtn;
    ppDesigner1: TppDesigner;
    ppbderepres: TppBDEPipeline;
    pprrepres: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppSystemVariable3: TppSystemVariable;
    ppLabel13: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText4: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppDBText3: TppDBText;
    ppShape1: TppShape;
    ppLabel1: TppLabel;
    ppShape2: TppShape;
    ppLabel2: TppLabel;
    ppShape3: TppShape;
    ppLabel3: TppLabel;
    ppShape4: TppShape;
    ppLabel5: TppLabel;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppLabel4: TppLabel;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppParameterList1: TppParameterList;
    BitBtn2: TBitBtn;
    edUPro: TEdit;
    edUPago: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ImageList1: TImageList;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnDetallarClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgprevioresDblClick(Sender: TObject);
    procedure dbgprevioresCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure dbgprevioresCalcTitleImage(Sender: TObject; Field: TField;
      var TitleImageAttributes: TwwTitleImageAttributes);
    procedure dbgprevioresTitleButtonClick(Sender: TObject;
      AFieldName: String);
  private
    UPROID:string;
    UPAGOID:string;
    COBANO:string;
    COBMES:string;
    ASOTIPID:string;
    TIPPLA:string;
    procedure gridresumen();
    procedure DoSorting(cdsName: TClientDataset; AFieldName: String);
  public
    procedure cargarDxs(IUProId:string; IUPagoId:string;
                        IAnho:string; IMes:string;ITipPla:string;IAsoTipId:string);
  end;

var
  FEnvVsRepPorResultado: TFEnvVsRepPorResultado;

implementation

uses CARDM1, CAR020;

{$R *.dfm}

(******************************************************************************)

procedure TFEnvVsRepPorResultado.BitBtn1Click(Sender: TObject);
begin
  close();
end;

(******************************************************************************)

procedure TFEnvVsRepPorResultado.BitBtn3Click(Sender: TObject);
begin
    DBGrid.DataSource := DMPreCob.dsqry4;
    DMPreCob.HojaExcel('REPORTE', DMPreCob.dsqry4, DBGrid);
end;

(******************************************************************************)

procedure TFEnvVsRepPorResultado.cargarDxs(IUProId:string; IUPagoId:string;
                                           IAnho:string; IMes:string;ITipPla:string;
                                           IAsoTipId:string);
Var
   xSQL:String;
   xSTRMonCob:string;
   xSTRMonEnv:string;
   xSTRMonEnvCob304:string;   
   xSTRTipPla: string;
begin
   Screen.Cursor := crHourGlass;
   self.UPROID:=IUProId;
   self.UPAGOID:=IUPagoId;
   self.COBANO:=IAnho;
   self.COBMES:=IMes;
   self.ASOTIPID:=IAsoTipId;
   self.TIPPLA:=ITipPla;

   (*
   xSql := 'SELECT 1 ORDEN, A.UPROID, A.UPAGOID, D.UPAGONOM, '
          +'       nvl(B.RESULTADO,''No está en Resultados'') RESULTADO, '
          +'       sum(1) ASOCIADOS, '
          +'       SUM(A.MONCUOENV) MONCUOENV, '
          +'        SUM(B.MONCOB) MON_COB, '
          +'        SUM(C.MONCOB) MON_COB_UTI, '
          +'        SUM(A.MONCUOENV) - SUM(B.MONCOB) MON_NCOB, '
          +'       ABS(SUM(C.MONCOB) - SUM(B.MONCOB)) DIF_MON_COB '
          +'FROM COB319 A,'
         +'    (SELECT B2.* '
         +'       FROM COB_INF_PLA_CAB B1, COB_INF_PLA_DET B2 '
         +'      WHERE B1.TIPPLA = '+QuotedStr(ITipPla)
         +'        AND B1.NUMERO = B2.NUMERO '
         +'        AND B2.TIPO = ''2'') B,'
         +'    (SELECT C2.* '
         +'       FROM COB_INF_PLA_CAB C1, COB_INF_PLA_DET C2 '
         +'      WHERE C1.TIPPLA = '+QuotedStr(ITipPla)
         +'        AND C1.NUMERO = C2.NUMERO '
         +'        AND C2.TIPO = ''1'') C,'
          +'     APO103 D '
          +'WHERE A.UPROID = '+QuotedStr(Trim(IUProId))
          +'  AND A.UPAGOID = '+QuotedStr(Trim(IUPagoId))
          +'  AND A.COBANO = '+QuotedStr(IAnho)
          +'  AND A.COBMES = '+QuotedStr(IMes)
          +'  AND A.ASOTIPID = '+QuotedStr(IAsoTipId)
          +'  AND A.ASOID = B.ASOID(+) AND A.COBANO = B.COBANO(+) AND A.COBMES = B.COBMES(+) '
          +'  AND A.ASOID = C.ASOID(+) AND A.COBANO = C.COBANO(+) AND A.COBMES = C.COBMES(+) '
          +'  AND A.UPROID = D.UPROID '
          +'  AND A.UPAGOID = D.UPAGOID '
          +'  AND nvl(A.CREMTOCUO,0)>0 '
          +'GROUP BY A.UPROID, A.UPAGOID, D.UPAGONOM, nvl(B.RESULTADO,''No está en Resultados'') '
          +'ORDER BY A.UPROID, A.UPAGOID';

   *)

   if ITipPla='2' then
     begin
        xSTRMonCob:= 'MONCUO';
        xSTRMonEnv:= 'MONCUOENV';
        xSTRMonEnvCob304:='TRANSCUO';
        xSTRTipPla:= '''1'',''2''';
     end
   else if ITipPla='3' then
       begin
         xSTRMonCob:= 'MONAPO';
         xSTRMonEnv:= 'MONAPOENV';
        xSTRMonEnvCob304:='TRANSAPO';
         xSTRTipPla:= '''1'',''3''';
       end;

   xSql := 'SELECT 1 ORDEN, A.UPROID, A.UPAGOID, D.UPAGONOM, '
          +'       nvl(B.RESULTADO,''No está en Resultados'') RESULTADO, '
          +'       sum(1) ASOCIADOS, '
          +'       SUM(A.'+xSTRMonEnv+') MON_ENV, '
          +'       SUM(B.'+xSTRMonCob+') MON_COB, '
          +'       SUM(C.'+xSTRMonCob+') MON_COB_UTI, '
          +'       SUM(NVL(A.'+xSTRMonEnv+',0)) - SUM(NVL(B.'+xSTRMonCob+',0)) MON_NCOB, '
          +'       /*ABS*/(SUM(NVL(C.'+xSTRMonCob+',0)) - SUM(NVL(B.'+xSTRMonCob+',0))) DIF_MON_COB, '
         +'  SUM(NVL(T.TRANSCUO,0)) MONDES, ' // cobranza real
         +'  MAX(T.FECDES) FECDES, ' // fecha de cobranza real
         +'  0.00 COB_UTIL_VS_REAL '
          +'FROM COB319 A,'
          +'    (SELECT B2.COBANO, B2.COBMES, '
          +'            NVL(B2.RESULTADO, ''No está en Resultados'') RESULTADO, '
          +'            B2.ASOID, B2.ASOTIPID, '
          +'            sum(nvl(B2.MONCUO,0)) MONCUO, sum(nvl(B2.MONAPO,0)) MONAPO '
          +'       FROM COB_INF_PLA_CAB B1, COB_INF_PLA_DET B2 '
          +'      WHERE B1.NUMERO = B2.NUMERO '
          +'        AND B1.ANOMES = '+QuotedStr(IAnho+IMes)
          +'        AND B1.TIPPLA IN ('+xSTRTipPla+') '
          +'        AND B2.COBANO = '+QuotedStr(IAnho)
          +'        AND B2.COBMES = '+QuotedStr(IMes)
          +'        AND B2.TIPO = ''2'' '
          +'      group by B2.COBANO, B2.COBMES, '
          +'              NVL(B2.RESULTADO, ''No está en Resultados''),'
          +'              B2.ASOID, B2.ASOTIPID) B, '
          +'    (SELECT C2.COBANO, C2.COBMES, '
          +'            NVL(C2.RESULTADO, ''No está en Resultados'') RESULTADO, '
          +'            C2.ASOID, C2.ASOTIPID, '
          +'            sum(nvl(C2.MONCUO,0)) MONCUO, sum(nvl(C2.MONAPO,0)) MONAPO '
          +'       FROM COB_INF_PLA_CAB C1, COB_INF_PLA_DET C2 '
          +'      WHERE C1.NUMERO = C2.NUMERO '
          +'        AND C1.ANOMES = '+QuotedStr(IAnho+IMes)
          +'        AND C1.TIPPLA IN ('+xSTRTipPla+') '
          +'        AND C2.COBANO = '+QuotedStr(IAnho)
          +'        AND C2.COBMES = '+QuotedStr(IMes)
          +'        AND C2.TIPO = ''1'' '
          +'     group by C2.COBANO, C2.COBMES, '
          +'              NVL(C2.RESULTADO, ''No está en Resultados''),'
          +'              C2.ASOID, C2.ASOTIPID) C, '
          +'     APO103 D, '
         +'    (SELECT ASOID,SUM(TRANSCUO) TRANSCUO,MAX(TO_CHAR(FREG,''DD/MM/YYYY'')) FECDES '
         +'       FROM COB304 '
         +'      WHERE TRANSANO='+QuotedStr(IAnho)+' AND TRANSMES='+QuotedStr(IMes)
         +'        AND NVL('+xSTRMonEnvCob304+',0)>0 GROUP BY ASOID ) T '
          +'WHERE A.ASOID = B.ASOID(+) AND A.COBANO = B.COBANO(+) AND A.COBMES = B.COBMES(+) '
          +'  AND A.ASOID = C.ASOID(+) AND A.COBANO = C.COBANO(+) AND A.COBMES = C.COBMES(+) '
          +'  AND A.ASOID  = T.ASOID (+) '          
          +'  AND A.UPROID = D.UPROID(+) '
          +'  AND A.UPAGOID = D.UPAGOID(+) '
          +'  AND A.UPROID = '+QuotedStr(Trim(IUProId))
          +'  AND A.UPAGOID = '+QuotedStr(Trim(IUPagoId))
          +'  AND A.COBANO = '+QuotedStr(IAnho)
          +'  AND A.COBMES = '+QuotedStr(IMes)
          +'  AND A.ASOTIPID = '+QuotedStr(IAsoTipId)
          +'  AND nvl(A.'+xSTRMonEnv+',0)>0 '
          +'GROUP BY A.UPROID, A.UPAGOID, D.UPAGONOM, nvl(B.RESULTADO,''No está en Resultados'') '
          +'ORDER BY A.UPROID, A.UPAGOID';

   DMPreCob.cdsReporteest.Close;
   DMPreCob.cdsReporteest.DataRequest(xSql);
   DMPreCob.cdsReporteest.Open;

   DMPreCob.cdsReporteest.First;
   while not DMPreCob.cdsReporteest.EOF do
     begin
        if TRIM(DMPreCob.cdsReporteest.FieldByName('RESULTADO').AsString)='Registro Cobrado' then
          begin
            DMPreCob.cdsReporteest.Edit;
            DMPreCob.cdsReporteest.FieldByName('ORDEN').Value:=1000;
            DMPreCob.cdsReporteest.Post;
          end;
        DMPreCob.cdsReporteest.next;
     end;
   DMPreCob.cdsReporteest.IndexFieldNames:='ORDEN';
   DMPreCob.cdsReporteest.First;


      //excel
   DMPreCob.cdsqry4.Close;
   DMPreCob.cdsqry4.DataRequest(XSQL);
   DMPreCob.cdsqry4.Open;


//   DMPreCob.cdsReporteest.IndexFieldNames:='RESULTADO';
   Screen.Cursor := crDefault;
end;

(******************************************************************************)

procedure TFEnvVsRepPorResultado.FormActivate(Sender: TObject);
begin
   self.gridresumen();
end;

(******************************************************************************)

procedure TFEnvVsRepPorResultado.gridresumen;
Var
   xmonenv2,
   xmoncuocob2,xmoncuoncob2,xmoncuouticob2,
   xdifmoncuocob2,xmondes,
   xNumAsociados : Double;
begin
   xmonenv2 := 0;
   xmoncuocob2 := 0;
   xmoncuouticob2:=0;
   xmoncuoncob2 := 0;
   xdifmoncuocob2:=0;
   xNumAsociados := 0;
   DMPreCob.cdsReporteest.First;
   While not DMPreCob.cdsReporteest.Eof Do
   Begin
      xmondes     := xmondes     + DMPreCob.cdsReporteest.FieldByName('MONDES').AsFloat;
      xmonenv2 := xmonenv2 + DMPreCob.cdsReporteest.FieldByName('MON_ENV').AsFloat;
      xmoncuocob2 := xmoncuocob2 + DMPreCob.cdsReporteest.FieldByName('MON_COB').AsFloat;
      xmoncuouticob2 := xmoncuouticob2 + DMPreCob.cdsReporteest.FieldByName('MON_COB_UTI').AsFloat;
      xmoncuoncob2 := xmoncuoncob2 + DMPreCob.cdsReporteest.FieldByName('MON_NCOB').AsFloat;
      xdifmoncuocob2 := xdifmoncuocob2 + DMPreCob.cdsReporteest.FieldByName('DIF_MON_COB').AsFloat;
      xNumAsociados := xNumAsociados+DMPreCob.cdsReporteest.FieldByName('ASOCIADOS').AsFloat;
      DMPreCob.cdsReporteest.Edit;
      DMPreCob.cdsReporteest.FieldByName('COB_UTIL_VS_REAL').AsFloat:=
           DMPreCob.cdsReporteest.FieldByName('MON_COB_UTI').AsFloat
          -DMPreCob.cdsReporteest.FieldByName('MONDES').AsFloat;
      DMPreCob.cdsReporteest.FieldByName('COB_UTIL_VS_REAL').AsFloat:=DMPreCob.FRound(DMPreCob.cdsReporteest.FieldByName('COB_UTIL_VS_REAL').AsFloat,15,2);
      DMPreCob.cdsReporteest.Post;


      DMPreCob.cdsReporteest.Next;
   End;

   dbgpreviores.Selected.Clear;
   //dbgpreviores.Selected.Add('UPROID'#9'3'#9'U.Proc'#9#9);
   //dbgpreviores.Selected.Add('UPRONOM'#9'3'#9'Descripción~Unidad de proceso'#9#9);
   //dbgpreviores.Selected.Add('UPAGOID'#9'3'#9'U.Pago'#9#9);
   //dbgpreviores.Selected.Add('UPAGONOM'#9'55'#9'Descripción~Unidad de pago'#9#9);
   //dbgpreviores.Selected.Add('USEID'#9'3'#9'UGEL'#9#9);
   //dbgpreviores.Selected.Add('USENOM'#9'55'#9'Descripción~Unidad de gestión'#9#9);
 
   dbgpreviores.Selected.Add('RESULTADO'#9'20'#9'Motivo'#9#9);
   dbgpreviores.Selected.Add('MON_ENV'#9'12'#9'Monto~enviado'#9#9);
   dbgpreviores.Selected.Add('ASOCIADOS'#9'8'#9'Numero de~Asociados'#9#9);
   dbgpreviores.Selected.Add('MON_COB_UTI'#9'12'#9'Monto~cobrado'#9'F'#9'Rep.Utilidad'#9);
   dbgpreviores.Selected.Add('MON_COB'#9'12'#9'Monto~cobrado'#9'F'#9'Rep.Resultado'#9);
   dbgpreviores.Selected.Add('MON_NCOB'#9'12'#9'Monto~No cobrado'#9'F'#9'Rep.Resultado'#9);
   dbgpreviores.Selected.Add('DIF_MON_COB'#9'12'#9'Diferencia~de Montos~Cobrados'#9);
   dbgpreviores.Selected.Add('MONDES'#9'12'#9'Cobranza~Real'#9);
   dbgpreviores.Selected.Add('FECDES'#9'10'#9'Fecha~Cob.Real'#9);
   dbgpreviores.Selected.Add('COB_UTIL_VS_REAL'#9'12'#9'Dif.Cob.Real~vs Rep.Utilidad'#9);

   dbgpreviores.ApplySelected;
   TNumericField(DMPreCob.cdsReporteest.FieldByName('MON_ENV')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsReporteest.FieldByName('MON_COB_UTI')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsReporteest.FieldByName('MON_COB')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsReporteest.FieldByName('MON_NCOB')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsReporteest.FieldByName('DIF_MON_COB')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsReporteest.FieldByName('MONDES')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsReporteest.FieldByName('COB_UTIL_VS_REAL')).DisplayFormat := '###,###,##0.00';


   dbgpreviores.ColumnByName('USENOM').FooterValue := 'TOTAL';
   dbgpreviores.ColumnByName('MON_ENV').FooterValue := FloatTostrf(xmonenv2,ffnumber,15,2);
   dbgpreviores.ColumnByName('MON_COB_UTI').FooterValue   := FloatTostrf(xmoncuouticob2,ffnumber,15,2);
   dbgpreviores.ColumnByName('MON_COB').FooterValue   := FloatTostrf(xmoncuocob2,ffnumber,15,2);
   dbgpreviores.ColumnByName('MON_NCOB').FooterValue   := FloatTostrf(xmoncuoncob2,ffnumber,15,2);
   dbgpreviores.ColumnByName('DIF_MON_COB').FooterValue   := FloatTostrf(xdifmoncuocob2,ffnumber,15,2);
   dbgpreviores.ColumnByName('ASOCIADOS').FooterValue := floattostr(xNumAsociados);
   dbgpreviores.ColumnByName('MONDES').FooterValue := FloatTostrf(xMondes,ffnumber,15,2);

   dbgpreviores.RefreshDisplay;
   DMPreCob.cdsReporteest.first;
   self.edUPro.Text :=  DMPreCob.cdsReporteest.fieldByName('UPROID').AsString;
   self.edUPago.Text := DMPreCob.cdsReporteest.fieldByName('UPAGOID').AsString
                        + ' - ' +DMPreCob.cdsReporteest.fieldByName('UPAGONOM').AsString
end;

(******************************************************************************)

procedure TFEnvVsRepPorResultado.btnDetallarClick(Sender: TObject);
begin
   (*
  FEnvVsRepDetallado:=TFEnvVsRepDetallado.create(self);
  try
    FEnvVsRepDetallado.cargarDxs(self.UPROID, self.UPAGOID,
                                 self.COBANO, self.COBMES, self.ASOTIPID);
    FEnvVsRepDetallado.showmodal;
  finally
    FEnvVsRepDetallado.free;
  end
  *)
end;

(******************************************************************************)

procedure TFEnvVsRepPorResultado.BitBtn2Click(Sender: TObject);
begin
   pprrepres.Print;
end;

(******************************************************************************)

procedure TFEnvVsRepPorResultado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    DMPreCob.cdsReporteest.close;
    DMPreCob.cdsReporteest.Filtered:=false;
    DMPreCob.cdsReporteest.Filter:='';
    DMPreCob.cdsqry4.close;
    DMPreCob.cdsqry4.Filtered:=false;
    DMPreCob.cdsqry4.Filter:='';
    Action := caFree
end;

procedure TFEnvVsRepPorResultado.dbgprevioresDblClick(Sender: TObject);
begin
  FEnvVsRepDetallado:=TFEnvVsRepDetallado.create(self);
  try
    FEnvVsRepDetallado.cargarDxs(self.UPROID, self.UPAGOID,
                                 self.COBANO, self.COBMES, self.TIPPLA,self.ASOTIPID,
                                 DMPreCob.cdsReporteest.FieldByName('RESULTADO').asString);
    FEnvVsRepDetallado.showmodal;
  finally
    FEnvVsRepDetallado.free;
  end
end;

(******************************************************************************)
procedure TFEnvVsRepPorResultado.dbgprevioresCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
   if Field.FieldName='DIF_MON_COB' then AFont.Style:=[fsBold];
   AFont.Color := clBlack;
   if not Highlight then
     begin
         if Field.FieldName='DIF_MON_COB' then
            if Field.Value<>0 then AFont.Color := clRed;

         if DMPreCob.cdsReporteest.FieldByName('ORDEN').Value>1 then
            ABrush.Color := clMoneyGreen//clInfoBk //$0084FF84 // $00DFFFDF
         else
            ABrush.Color := clwhite;
     end
   else
     begin
      AFont.Color := clwhite;
      ABrush.Color := clblue;
     end;
end;

(******************************************************************************)
procedure TFEnvVsRepPorResultado.dbgprevioresCalcTitleImage(
  Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
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
end;

(******************************************************************************)

procedure TFEnvVsRepPorResultado.DoSorting(cdsName:TClientDataset; AFieldName: String);
const
  NONSORTABLE: Set of TFieldType=[ftBlob,ftMemo,ftOraBlob,ftOraCLob];
begin
  TRY
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
  FINALLY
  END;
end;

procedure TFEnvVsRepPorResultado.dbgprevioresTitleButtonClick(
  Sender: TObject; AFieldName: String);
begin
  DoSorting(TClientDataset((Sender as TwwDBGrid).Datasource.Dataset),AFieldName);
end;

end.
