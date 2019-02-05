unit CAR020;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, DB,
  DBGrids,
  DBClient, ImgList;

type
  TFEnvVsRepDetallado = class(TForm)
    Panel1: TPanel;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    dbgpreviodet: TwwDBGrid;
    DBGrid: TDBGrid;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    cbfiltro: TComboBox;
    Label1: TLabel;
    edUPro: TEdit;
    edUPago: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edResultado: TEdit;
    lblNroRegistros: TLabel;
    ImageList1: TImageList;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbfiltroChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgpreviodetCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure dbgpreviodetCalcTitleImage(Sender: TObject; Field: TField;
      var TitleImageAttributes: TwwTitleImageAttributes);
    procedure dbgpreviodetTitleButtonClick(Sender: TObject;
      AFieldName: String);
  private
    procedure actcabdet();
    procedure DoSorting(cdsName: TClientDataset; AFieldName: String);
  public
    procedure cargarDxs(IUProId:string; IUPagoId:string;
                        IAnho:string; IMes:string; ITipPla:string;
                        IAsoTipId:string; IResultado : string);
  end;

var
  FEnvVsRepDetallado: TFEnvVsRepDetallado;

implementation

uses CARDM1;

{$R *.dfm}

(******************************************************************************)

procedure TFEnvVsRepDetallado.cargarDxs(IUProId:string; IUPagoId:string;
                                           IAnho:string; IMes:string;
                                           ITipPla:string;IAsoTipId:string;
                                           IResultado : string);
Var
   xSQL, xMotivo:STRING;
   xSTRMonCob :String;
   xSTRMonEnv:string;
   xSTRMonEnvCob304:string;   
   xSTRTipPla: string;
begin
   Screen.Cursor := crHourGlass;

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

(*
   xSql := 'SELECT A.ASOID, A.ASODNI, A.ASOAPENOM, '
          +'       A.UPROID, F.UPRONOM, A.UPAGOID, E.UPAGONOM, '
          +'       A.CARGO, A.ASOCODPAGO, A.'+xSTRMonEnv+' MON_ENV, '
          +'       B.'+xSTRMonCob+' MON_COB, '
          +'       C.'+xSTRMonCob+' MON_COB_UTI, '
          +'       (NVL(A.'+xSTRMonEnv+',0) - NVL(B.'+xSTRMonCob+',0)) MON_NCOB, '
          +'       /*ABS*/(NVL(C.'+xSTRMonCob+',0) - NVL(B.'+xSTRMonCob+',0)) DIF_MON_COB, '
          +'       nvl(B.RESULTADO,''No está en Resultados'') RESULTADO, '
          +'       H.DPTOID DPTO, H.DPTODES DEPARTAMENTO, I.CIUDID PROV, I.CIUDDES PROVINCIA, '
          +'       J.ZIPID DIST, J.ZIPDES DISTRITO, '
          +'       G.ASODIR, G.ASODESLAB, '
          +'       G.ASOTELF1, G.ASOTELF2 '
          +'FROM COB319 A, '
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
          +'     group by B2.COBANO, B2.COBMES, '
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
          +'    APO103 E, APO102 F, APO201 G, '
          +'    APO158 H, APO123 I, APO122 J '
          +'WHERE A.ASOID = B.ASOID(+) AND A.COBANO = B.COBANO(+) AND A.COBMES = B.COBMES(+) '
          +' AND A.ASOID = C.ASOID(+) AND A.COBANO = C.COBANO(+) AND A.COBMES = C.COBMES(+) '
          +' AND A.UPROID = E.UPROID(+) '
          +' AND A.UPAGOID = E.UPAGOID(+) '
          +' AND A.UPROID = F.UPROID(+) '
          +' AND A.ASOID = G.ASOID(+) '
          +' AND SUBSTR(G.ZIPID, 1, 2) = H.DPTOID(+) '
          +' AND SUBSTR(G.ZIPID, 1, 2) = I.DPTOID(+) '
          +' AND SUBSTR(G.ZIPID, 1, 4) = I.CIUDID(+) '
          +' AND SUBSTR(G.ZIPID, 1, 2) = J.DPTOID(+) '
          +' AND SUBSTR(G.ZIPID, 1, 4) = J.CIUDID(+) '
          +' AND G.ZIPID = J.DPTOID(+)'
          +' AND A.UPROID = '+QuotedStr(Trim(IUProId))
          +' AND A.UPAGOID = '+QuotedStr(Trim(IUPagoId))
          +' AND A.COBANO = '+QuotedStr(IAnho)
          +' AND A.COBMES = '+QuotedStr(IMes)
          +' AND A.ASOTIPID = '+QuotedStr(IAsoTipId)
          +' AND TRIM(nvl(B.RESULTADO,''No está en Resultados'')) = TRIM('+QuotedStr(IResultado)+') '
          +' AND nvl(A.CREMTOCUO,0)>0 ';
*)


   xSql := 'SELECT A.ASOID, A.ASODNI, A.ASOAPENOM, '
          +'       A.UPROID, F.UPRONOM, A.UPAGOID, E.UPAGONOM, '
          +'       A.CARGO, A.ASOCODPAGO, A.'+xSTRMonEnv+' MON_ENV, '
          +'       B.'+xSTRMonCob+' MON_COB, '
          +'       C.'+xSTRMonCob+' MON_COB_UTI, '
          +'       (NVL(A.'+xSTRMonEnv+',0) - NVL(B.'+xSTRMonCob+',0)) MON_NCOB, '
          +'       /*ABS*/(NVL(C.'+xSTRMonCob+',0) - NVL(B.'+xSTRMonCob+',0)) DIF_MON_COB, '
          +'  NVL(T.TRANSCUO,0) MONDES, ' // cobranza real
          +'  T.FECDES FECDES, ' // fecha de cobranza real
          +'  0.00 COB_UTIL_VS_REAL, '
          +'       nvl(B.RESULTADO,''No está en Resultados'') RESULTADO, '
          +'       G.ASODIR, G.ASODESLAB, '
          +'       G.ASOTELF1, G.ASOTELF2, '
          +'       G.DPTOID, G.CIUDID, G.ZIPID, '
          +'       ''                                        '' DPTODES, '
          +'       ''                                        '' PROVINDES, '
          +'       ''                                        '' DISTRIDES '
          +'FROM COB319 A, '
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
          +'     group by B2.COBANO, B2.COBMES, '
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
          +'    APO103 E, APO102 F, APO201 G, '
         +'    (SELECT ASOID,SUM(TRANSCUO) TRANSCUO,MAX(TO_CHAR(FREG,''DD/MM/YYYY'')) FECDES '
         +'       FROM COB304 '
         +'      WHERE TRANSANO='+QuotedStr(IAnho)+' AND TRANSMES='+QuotedStr(IMes)
         +'        AND NVL('+xSTRMonEnvCob304+',0)>0 GROUP BY ASOID ) T '
          +'WHERE A.ASOID = B.ASOID(+) AND A.COBANO = B.COBANO(+) AND A.COBMES = B.COBMES(+) '
          +' AND A.ASOID = C.ASOID(+) AND A.COBANO = C.COBANO(+) AND A.COBMES = C.COBMES(+) '
         +'  AND A.ASOID  = T.ASOID (+) '
          +' AND A.UPROID = E.UPROID(+) '
          +' AND A.UPAGOID = E.UPAGOID(+) '
          +' AND A.UPROID = F.UPROID(+) '
          +' AND A.ASOID = G.ASOID(+) '
          +' AND A.UPROID = '+QuotedStr(Trim(IUProId))
          +' AND A.UPAGOID = '+QuotedStr(Trim(IUPagoId))
          +' AND A.COBANO = '+QuotedStr(IAnho)
          +' AND A.COBMES = '+QuotedStr(IMes)
          +' AND A.ASOTIPID = '+QuotedStr(IAsoTipId)
          +' AND TRIM(nvl(B.RESULTADO,''No está en Resultados'')) = TRIM('+QuotedStr(IResultado)+') '
          +' AND nvl(A.'+xSTRMonEnv+',0)>0 ';


   DMPreCob.cdsReporte.Close;
   DMPreCob.cdsReporte.DataRequest(xSql);
   DMPreCob.cdsReporte.Open;

   //excel
   DMPreCob.cdsqry3.Close;
   DMPreCob.cdsqry3.DataRequest(XSQL);
   DMPreCob.cdsqry3.Open;

   DMPreCob.cdsDpto.Close;
   DMPreCob.cdsDpto.DataRequest('Select DPTOID, DPTODES from TGE158');
   DMPreCob.cdsDpto.Open;
   DMPreCob.cdsDpto.IndexFieldNames := 'DPTOID';

   DMPreCob.cdsProv.Close;
   DMPreCob.cdsProv.DataRequest('Select DPTOID, CIUDID, CIUDDES from TGE121');
   DMPreCob.cdsProv.Open;
   DMPreCob.cdsProv.IndexFieldNames := 'DPTOID;CIUDID';

   DMPreCob.cdsDist.Close;
   DMPreCob.cdsDist.DataRequest('Select DPTOID, CIUDID, ZIPID, ZIPDES from TGE122');
   DMPreCob.cdsDist.Open;
   DMPreCob.cdsDist.IndexFieldNames := 'DPTOID;CIUDID;ZIPID';

   DMPreCob.cdsqry3.First;
   while not DMPreCob.cdsqry3.EOF do
   begin
      if trimright(DMPreCob.cdsqry3.FieldByName('DPTOID').AsString)<>'' then
      begin
         DMPreCob.cdsDpto.SetKey;
         DMPreCob.cdsDpto.FieldByName('DPTOID').AsString := DMPreCob.cdsqry3.FieldByName('DPTOID').AsString;
         if DMPreCob.cdsDpto.GotoKey then
         begin
            DMPreCob.cdsqry3.Edit;
            DMPreCob.cdsqry3.FieldByName('DPTODES').AsString := DMPreCob.cdsDpto.FieldByName('DPTODES').AsString;
            DMPreCob.cdsqry3.Post;
         end;
         if trimright(DMPreCob.cdsqry3.FieldByName('CIUDID').AsString)<>'' then
         begin
            DMPreCob.cdsProv.SetKey;
            DMPreCob.cdsProv.FieldByName('DPTOID').AsString := DMPreCob.cdsqry3.FieldByName('DPTOID').AsString;
            DMPreCob.cdsProv.FieldByName('CIUDID').AsString := copy(DMPreCob.cdsqry3.FieldByName('CIUDID').AsString,3,2);
            if DMPreCob.cdsProv.GotoKey then
            begin
               DMPreCob.cdsqry3.Edit;
               DMPreCob.cdsqry3.FieldByName('PROVINDES').AsString := DMPreCob.cdsProv.FieldByName('CIUDDES').AsString;
               DMPreCob.cdsqry3.Post;
            end;
            if trimright(DMPreCob.cdsqry3.FieldByName('ZIPID').AsString)<>'' then
            begin
               DMPreCob.cdsDist.SetKey;
               DMPreCob.cdsDist.FieldByName('DPTOID').AsString := DMPreCob.cdsqry3.FieldByName('DPTOID').AsString;
               DMPreCob.cdsDist.FieldByName('CIUDID').AsString := copy(DMPreCob.cdsqry3.FieldByName('CIUDID').AsString,3,2);
               DMPreCob.cdsDist.FieldByName('ZIPID').AsString := copy(DMPreCob.cdsqry3.FieldByName('ZIPID').AsString,5,2);
               if DMPreCob.cdsDist.GotoKey then
               begin
                  DMPreCob.cdsqry3.Edit;
                  DMPreCob.cdsqry3.FieldByName('DISTRIDES').AsString := DMPreCob.cdsDist.FieldByName('ZIPDES').AsString;
                  DMPreCob.cdsqry3.Post;
               end;
            end;
         end;
      end;
      DMPreCob.cdsqry3.Next;
   end;

   Screen.Cursor := crDefault;
end;

(******************************************************************************)

procedure TFEnvVsRepDetallado.FormActivate(Sender: TObject);
begin
  self.actcabdet();
end;

(******************************************************************************)

procedure TFEnvVsRepDetallado.actcabdet();
Var
   xmonenv2,
   xmoncuocob2,xmoncuoncob2,xmoncuouticob2,
   xdifmoncuocob2,xmondes: Double;
   xNroRegistros:Double;   
begin
   xmonenv2 := 0;
   xmoncuocob2 := 0;
   xmoncuouticob2:=0;
   xmoncuoncob2 := 0;
   xdifmoncuocob2:=0;
   xNroRegistros:=0;
   DMPreCob.cdsReporte.First;
   While not DMPreCob.cdsReporte.Eof Do
   Begin
      xmondes     := xmondes     + DMPreCob.cdsReporte.FieldByName('MONDES').AsFloat;
      xmonenv2 := xmonenv2 + DMPreCob.cdsReporte.FieldByName('MON_ENV').AsFloat;
      xmoncuocob2 := xmoncuocob2 + DMPreCob.cdsReporte.FieldByName('MON_COB').AsFloat;
      xmoncuouticob2 := xmoncuouticob2 + DMPreCob.cdsReporte.FieldByName('MON_COB_UTI').AsFloat;
      xmoncuoncob2 := xmoncuoncob2 + DMPreCob.cdsReporte.FieldByName('MON_NCOB').AsFloat;
      xdifmoncuocob2 := xdifmoncuocob2 + DMPreCob.cdsReporte.FieldByName('DIF_MON_COB').AsFloat;
      DMPreCob.cdsReporte.Edit;
      DMPreCob.cdsReporte.FieldByName('COB_UTIL_VS_REAL').AsFloat:=
           DMPreCob.cdsReporte.FieldByName('MON_COB_UTI').AsFloat
          -DMPreCob.cdsReporte.FieldByName('MONDES').AsFloat;
      DMPreCob.cdsReporte.FieldByName('COB_UTIL_VS_REAL').AsFloat:=DMPreCob.FRound(DMPreCob.cdsReporte.FieldByName('COB_UTIL_VS_REAL').AsFloat,15,2);
      DMPreCob.cdsReporte.Post;

      xNroRegistros := xNroRegistros + 1;
      DMPreCob.cdsReporte.Next;
   End;

   self.lblNroRegistros.Caption:=FloatToStr(xNroRegistros)+' Registros encontrados';

   dbgpreviodet.Selected.Clear;
   dbgpreviodet.Selected.Add('ASOID'#9'10'#9'Identificación~del Asociado'#9#9);
   dbgpreviodet.Selected.Add('ASODNI'#9'8'#9'DNI~Asociado'#9#9);
   dbgpreviodet.Selected.Add('ASOCODMOD'#9'10'#9'Código~modular'#9#9);
   dbgpreviodet.Selected.Add('ASOAPENOM'#9'42'#9'Apellidos y~Nombre(s)'#9#9);
   //dbgpreviodet.Selected.Add('UPROID'#9'3'#9'Unidad de~proceso'#9#9);
   //dbgpreviodet.Selected.Add('UPRONOM'#9'3'#9'Descripción~Unidad de proceso'#9#9);
   //dbgpreviodet.Selected.Add('UPAGOID'#9'3'#9'Unidad de~pago'#9#9);
   //dbgpreviodet.Selected.Add('UPAGONOM'#9'3'#9'Descripción~Unidad de pago'#9#9);
   //dbgpreviodet.Selected.Add('USEID'#9'3'#9'Unidad de~gestión'#9#9);
   //dbgpreviodet.Selected.Add('USENOM'#9'55'#9'Descripción~Unidad de gestión'#9#9);
   dbgpreviodet.Selected.Add('CARGO'#9'6'#9'Cargo'#9#9);
   dbgpreviodet.Selected.Add('ASOCODPAGO'#9'9'#9'Código~de pago'#9#9);
   dbgpreviodet.Selected.Add('MON_ENV'#9'12'#9'Monto~enviado'#9#9);
   dbgpreviodet.Selected.Add('MON_COB_UTI'#9'12'#9'Monto~cobrado'#9'F'#9'Rep.Utilidad'#9);
   dbgpreviodet.Selected.Add('MON_COB'#9'12'#9'Monto~cobrado'#9'F'#9'Rep.Resultado'#9);
   dbgpreviodet.Selected.Add('MON_NCOB'#9'12'#9'Monto~No cobrado'#9'F'#9'Rep.Resultado'#9);
   dbgpreviodet.Selected.Add('DIF_MON_COB'#9'12'#9'Diferencia~de Montos~Cobrados'#9);
   dbgpreviodet.Selected.Add('MONDES'#9'12'#9'Cobranza~Real'#9);
   dbgpreviodet.Selected.Add('FECDES'#9'10'#9'Fecha~Cob.Real'#9);
   dbgpreviodet.Selected.Add('COB_UTIL_VS_REAL'#9'12'#9'Dif.Cob.Real~vs Rep.Utilidad'#9);

   //dbgpreviodet.Selected.Add('RESULTADO'#9'15'#9'Resultado'#9#9);
   dbgpreviodet.Selected.Add('ASODIR'#9'75'#9'Dirección~del Asociado'#9#9);
   dbgpreviodet.Selected.Add('ASODESLAB'#9'45'#9'Nombre~del Colegio'#9#9);
   dbgpreviodet.Selected.Add('ASOTELF1'#9'25'#9'Telefono 1'#9#9);
   dbgpreviodet.Selected.Add('ASOTELF2'#9'25'#9'Telefono 2'#9#9);
   dbgpreviodet.ApplySelected;

   TNumericField(DMPreCob.cdsReporte.FieldByName('MON_ENV')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsReporte.FieldByName('MON_COB_UTI')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsReporte.FieldByName('MON_COB')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsReporte.FieldByName('MON_NCOB')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsReporte.FieldByName('DIF_MON_COB')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsReporte.FieldByName('MONDES')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsReporte.FieldByName('COB_UTIL_VS_REAL')).DisplayFormat := '###,###,##0.00';


   dbgpreviodet.ColumnByName('MON_ENV').FooterValue := FloatTostrf(xmonenv2,ffnumber,15,2);
   dbgpreviodet.ColumnByName('MON_COB_UTI').FooterValue   := FloatTostrf(xmoncuouticob2,ffnumber,15,2);
   dbgpreviodet.ColumnByName('MON_COB').FooterValue   := FloatTostrf(xmoncuocob2,ffnumber,15,2);
   dbgpreviodet.ColumnByName('MON_NCOB').FooterValue   := FloatTostrf(xmoncuoncob2,ffnumber,15,2);
   dbgpreviodet.ColumnByName('DIF_MON_COB').FooterValue   := FloatTostrf(xdifmoncuocob2,ffnumber,15,2);
   dbgpreviodet.ColumnByName('MONDES').FooterValue := FloatTostrf(xMondes,ffnumber,15,2);

   dbgpreviodet.RefreshDisplay;
   DMPreCob.cdsReporte.first;
   self.edUPro.Text :=  DMPreCob.cdsReporte.fieldByName('UPROID').AsString;
   self.edUPago.Text := DMPreCob.cdsReporte.fieldByName('UPAGOID').AsString
                        + ' - ' +DMPreCob.cdsReporte.fieldByName('UPAGONOM').AsString;
   self.edResultado.Text :=  DMPreCob.cdsReporte.fieldByName('RESULTADO').AsString;

end;

(******************************************************************************)

procedure TFEnvVsRepDetallado.BitBtn1Click(Sender: TObject);
begin
  close();
end;

(******************************************************************************)

procedure TFEnvVsRepDetallado.BitBtn3Click(Sender: TObject);
begin
     DBGrid.DataSource := DMPreCob.dsqry3;
     DMPreCob.HojaExcel('REPORTE', DMPreCob.dsqry3, DBGrid)
end;

(******************************************************************************)

procedure TFEnvVsRepDetallado.cbfiltroChange(Sender: TObject);
begin
   DMPreCob.cdsReporte.Filtered := False;
   if cbfiltro.Text<>'Todos' then
   begin
      DMPreCob.cdsReporte.Filter := 'RESULTADO = '+QuotedStr(cbfiltro.Text);
      DMPreCob.cdsReporte.Filtered := True;
   end;
   actcabdet;
end;

(******************************************************************************)

procedure TFEnvVsRepDetallado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   DMPreCob.cdsqry3.close;
   DMPreCob.cdsqry3.Filter:='';
   DMPreCob.cdsqry3.Filtered:=false;
   DMPreCob.cdsReporte.Close;
   DMPreCob.cdsReporte.Filter:='';
   DMPreCob.cdsReporte.Filtered:=false;
   Action :=caFree;
end;

(******************************************************************************)
procedure TFEnvVsRepDetallado.dbgpreviodetCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
   if Field.FieldName='DIF_MON_COB' then AFont.Style:=[fsBold];

         if Field.FieldName='DIF_MON_COB' then
         if Field.Value<>0 then AFont.Color := clRed;

         (*
   AFont.Color := clBlack;
   if not Highlight then
   begin
      if Field.FieldName='EFECTIVIDAD' then
         if Field.Value<100 then AFont.Color := clRed;
      if Field.FieldName='DIF_MON_COB' then
         if Field.Value<>0 then AFont.Color := clRed;
   end
   else
   begin
      AFont.Color := clwhite;
      ABrush.Color := clblue;
   end;
   *)
end;

(******************************************************************************)

procedure TFEnvVsRepDetallado.dbgpreviodetCalcTitleImage(Sender: TObject;
  Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
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

procedure TFEnvVsRepDetallado.DoSorting(cdsName:TClientDataset; AFieldName: String);
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

procedure TFEnvVsRepDetallado.dbgpreviodetTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  DoSorting(TClientDataset((Sender as TwwDBGrid).Datasource.Dataset),AFieldName);
end;

end.
