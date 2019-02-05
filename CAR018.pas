unit CAR018;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Spin, Mask, StdCtrls, Buttons, ExtCtrls, wwdblook, Wwdbdlg,
  Grids, Wwdbigrd, Wwdbgrid, ComCtrls, DBGrids, db, ppBands, ppCache,
  ppClass, ppDB, ppDBPipe, ppDBBDE, ppComm, ppRelatv, ppProd, ppReport,
  ppCtrls, ppPrnabl, ppVar, ppEndUsr, ppParameter, CARFRA001, CARFRA002,
  ImgList,DBClient;

type
  TFEnvVsRep = class(TForm)
    GroupBox1: TGroupBox;
    btnprocesar: TBitBtn;
    seano: TSpinEdit;
    semes: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    dblcdasotipid: TwwDBLookupComboDlg;
    BitBtn3: TBitBtn;
    pagecontrol: TPageControl;
    DBGrid: TDBGrid;
    Memo1: TMemo;
    Button1: TButton;
    TabSheet3: TTabSheet;
    dbgprevioresgeneral: TwwDBGrid;
    measotipdes: TMaskEdit;
    lblNroRegistros: TLabel;
    gbFiltro: TGroupBox;
    Label1: TLabel;
    dblcdUPro: TwwDBLookupComboDlg;
    meUPro: TMaskEdit;
    meUPago: TMaskEdit;
    dblcdUPago: TwwDBLookupComboDlg;
    Label5: TLabel;
    bbtnQuitarFiltro: TBitBtn;
    dblcdOficina: TwwDBLookupComboDlg;
    meofdes: TMaskEdit;
    Label6: TLabel;
    gbTipoPlanilla: TGroupBox;
    rbCuotas: TRadioButton;
    rbAportes: TRadioButton;
    ImageList1: TImageList;
    procedure FormActivate(Sender: TObject);
    procedure btnprocesarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure pagecontrolChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dblcdasotipidExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure dbgprevioresgeneralDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgprevioresgeneralCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure dbgprevioresgeneralTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure dblcdUProChange(Sender: TObject);
    procedure dblcdUPagoChange(Sender: TObject);
    procedure dblcdasotipidChange(Sender: TObject);
    procedure dblcdUProExit(Sender: TObject);
    procedure dblcdUPagoExit(Sender: TObject);
    procedure bbtnQuitarFiltroClick(Sender: TObject);
    procedure dblcdOficinaChange(Sender: TObject);
    procedure dblcdOficinaExit(Sender: TObject);
    procedure dbgprevioresgeneralCalcTitleImage(Sender: TObject;
      Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
    procedure dbgprevioresgeneralCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
  private
    xtippla : String;  
    procedure gridResumenGeneral;
    procedure cargarOficina();
    procedure cargarUProceso();
    procedure cargarUPago();
    procedure filtrarUProceso(IOfDesId:string);
    procedure filtrarUPago(IUProId:string);
    procedure filtrarDetalle(IOfDesId:string='';IUProId:string='';IUPagoId:string='');
    procedure DoSorting(cdsName: TClientDataset; AFieldName: String);
    procedure asignarColorFilas;
  public
    { Public declarations }
  end;

var
  FEnvVsRep: TFEnvVsRep;

implementation

uses CARDM1, CAR019;

{$R *.dfm}

(******************************************************************************)

procedure TFEnvVsRep.FormActivate(Sender: TObject);
Var xSql:String;
begin
  self.dblcdOficina.Enabled:=DMPreCob.wEsSupervisor;
  DMPreCob.cdsQry7.Close;
  dblcdasotipid.LookupTable:=DMPreCob.cdsTAso;
  dbgprevioresgeneral.DataSource:=DMPreCob.dsQry7;

  xSql := 'SELECT ASOTIPID, ASOTIPDES FROM APO107 WHERE ASOTIPID IN (''DO'',''CO'',''CE'')';
  DMPreCob.cdsTAso.Close;
  DMPreCob.cdsTAso.DataRequest(xSql);
  DMPreCob.cdsTAso.Open;
  dblcdasotipid.Selected.Clear;
  dblcdasotipid.Selected.Add('ASOTIPID'#9'3'#9'Código'#9#9);
  dblcdasotipid.Selected.Add('ASOTIPDES'#9'17'#9'Descripción'#9#9);
  dblcdasotipid.SetFocus;
end;

(******************************************************************************)

procedure TFEnvVsRep.btnprocesarClick(Sender: TObject);
Var
xSQL: String;
xSTRMonCob:string;
xSTRMonEnv:string;
xSTRMonEnvCob304:string;
xSTRTipPla: string;

  {----------------------------------------------------}
  procedure agrupar(Sender: TObject;IField:string);
    begin
      (Sender as TwwDBGrid).GroupFieldName:= IField;
      (Sender as TwwDBGrid).Datasource.Dataset.FieldByName(IField).Index := 0;
      DoSorting(TClientDataset((Sender as TwwDBGrid).Datasource.Dataset), IField);
      (Sender as TwwDBGrid).Invalidate;
    end;
  {----------------------------------------------------}
begin
   bbtnQuitarFiltroClick(bbtnQuitarFiltro);
   if trim(self.dblcdasotipid.Text) ='' then
     begin
          showmessage('Por Favor seleccione un Tipo de Asociado Enviado');
          exit;
     end;

   Screen.Cursor := crHourGlass;

   seano.Text := DMPreCob.StrZero(seano.Text,4);
   semes.Text := DMPreCob.StrZero(semes.Text,2);

   (* YA NO EXISTE ESTE TIPO
   if rbCuotasAportes.Checked then
      xtippla:='1'
   else
   *)
   if rbCuotas.Checked then
      begin
        xSTRMonCob:= 'MONCUO';
        xSTRMonEnv:= 'MONCUOENV';
        xSTRMonEnvCob304:='TRANSCUO';
        xSTRTipPla:= '''1'',''2''';
        xtippla:='2';
      end
   else if rbAportes.Checked then
      begin
        xSTRMonCob:= 'MONAPO';
        xSTRMonEnv:= 'MONAPOENV';
        xSTRMonEnvCob304:='TRANSAPO';
        xSTRTipPla:= '''1'',''3''';
        xtippla:='3';
      end;

    XSQL:='SELECT ''N'' COLOREADO, R.DPTOID, S.DPTODES, A.UPROID, A.UPAGOID, '
         +'  MAX(D.UPAGONOM) UPAGONOM, MAX(A.COBANO) COBANO, MAX(A.COBMES) COBMES, '+QuotedStr(xtippla)+' TIPPLA, '
         +'  MAX(A.ASOTIPID) ASOTIPID, SUM(1) ASOCIADOS, '
         +'  SUM(A.'+xSTRMonEnv+') MON_ENV, ' // Monto de la~cuota enviada
         +'  ROUND((SUM(C.'+xSTRMonCob+') * 100) / SUM(A.'+xSTRMonEnv+'),2) EFECTIVIDAD, ' // Efectividad
         +'  SUM(C.'+xSTRMonCob+') MON_COB_UTI, '
         +'  SUM(A.'+xSTRMonEnv+') - SUM(C.'+xSTRMonCob+') MON_NCOB_UTI,' // Monto cobrado Reporte de Utilidad
         +'  SUM(B.'+xSTRMonCob+') MON_COB, ' // Monto cobrado Reporte Resultado
         +'  SUM(A.'+xSTRMonEnv+') - SUM(B.'+xSTRMonCob+') MON_NCOB, '
         +'  /*ABS*/ (SUM(C.'+xSTRMonCob+') - SUM(B.'+xSTRMonCob+')) DIF_MON_COB,' // Dif.Cob.Utilidad~vs Cob.Resultados
         +'  SUM(NVL(T.TRANSCUO,0)) MONDES, ' // cobranza real
         +'  MAX(T.FECDES) FECDES, ' // fecha de cobranza real
         +'  0.00 COB_UTIL_VS_REAL '
         +'FROM COB319 A, '
         +'    (SELECT B2.COBANO, B2.COBMES, B2.ASOID, B2.ASOTIPID, '
         +'            sum(nvl(B2.MONCUO,0)) MONCUO, sum(nvl(B2.MONAPO,0)) MONAPO '
         +'       FROM COB_INF_PLA_CAB B1, COB_INF_PLA_DET B2 '
         +'      WHERE B1.NUMERO = B2.NUMERO '
         +'        AND B1.ANOMES = '+QuotedStr(seano.Text+semes.Text)
         +'        AND B1.TIPPLA IN ('+xSTRTipPla+') '
         +'        AND B2.COBANO = '+QuotedStr(seano.Text)
         +'        AND B2.COBMES = '+QuotedStr(semes.Text)
         +'        AND B2.TIPO = ''2'' '
         +'      group by B2.COBANO, B2.COBMES, B2.ASOID, B2.ASOTIPID) B, '
         +'    (SELECT C2.COBANO, C2.COBMES, C2.ASOID, C2.ASOTIPID, '
         +'            sum(nvl(C2.MONCUO,0)) MONCUO, sum(nvl(C2.MONAPO,0)) MONAPO '
         +'       FROM COB_INF_PLA_CAB C1, COB_INF_PLA_DET C2 '
         +'      WHERE C1.NUMERO = C2.NUMERO '
         +'        AND C1.ANOMES = '+QuotedStr(seano.Text+semes.Text)
         +'        AND C1.TIPPLA IN ('+xSTRTipPla+') '
         +'        AND C2.COBANO = '+QuotedStr(seano.Text)
         +'        AND C2.COBMES = '+QuotedStr(semes.Text)
         +'        AND C2.TIPO = ''1'' '
         +'      group by C2.COBANO, C2.COBMES, C2.ASOID, C2.ASOTIPID) C, '
         +'    APO103 D ,APO102 R, APO158 S,'
         +'    (SELECT ASOID,SUM(TRANSCUO) TRANSCUO,MAX(TO_CHAR(FREG,''DD/MM/YYYY'')) FECDES '
         +'       FROM COB304 '
         +'      WHERE TRANSANO='+QuotedStr(seano.Text)+' AND TRANSMES='+QuotedStr(semes.Text)
         +'        AND NVL('+xSTRMonEnvCob304+',0)>0 GROUP BY ASOID ) T '
         +'WHERE A.COBANO = B.COBANO(+) AND A.COBMES=B.COBMES(+) AND A.ASOID = B.ASOID(+) '
         +'  AND A.COBANO = C.COBANO(+) AND A.COBMES=C.COBMES(+) AND A.ASOID = C.ASOID(+) '
         +'  AND A.ASOID  = T.ASOID (+) '
         +'  AND A.UPROID = D.UPROID(+) AND A.UPAGOID = D.UPAGOID(+) '
         +'  AND A.UPROID = R.UPROID(+) AND R.DPTOID =S.DPTOID(+) '
         +'  AND A.COBANO = '+QuotedStr(seano.Text)
         +'  AND A.COBMES = '+QuotedStr(semes.Text)
         +'  AND A.ASOTIPID = '+QuotedStr(dblcdasotipid.Text)
//         +'  AND nvl(A.CREMTOCUO,0)>0 '
         +'  AND nvl(A.'+xSTRMonEnv+',0)>0 '
         +'GROUP BY A.UPROID, A.UPAGOID, R.DPTOID, S.DPTODES '
         +'ORDER BY S.DPTODES, A.UPROID, A.UPAGOID ';

   DMPreCob.cdsQry7.Close;
   DMPreCob.cdsQry7.DataRequest(xSql);
   DMPreCob.cdsQry7.Open;


   asignarColorFilas();

    //excel
   DMPreCob.cdsQry5.Close;
   DMPreCob.cdsQry5.DataRequest(XSQL);
   DMPreCob.cdsQry5.Open;


   gridresumenGeneral;
   agrupar(dbgprevioresgeneral,'DPTODES');

   cargarOficina();
   self.cargarUProceso();
   self.cargarUPago();

   self.dblcdUPro.text := '';
   self.meUPro.Text := '';

   self.filtrarUProceso('-.-');
   self.filtrarUPago('-.-');
   // ** self.filtrarDetalle('-.-','-.-');

   if not DMPreCob.wEsSupervisor then
     If DMPreCob.cdsOficina.Locate('OFDESID',VarArrayof([DMPreCob.wOfiId]),[]) Then
        begin
          dblcdOficina.text := DMPreCob.wOfiId;
          dblcdOficinaChange(dblcdOficina);
        end;


   self.gbFiltro.Enabled:=true;
   pagecontrol.TabIndex := 0;
   pagecontrolChange(pagecontrol);
   Screen.Cursor := crDefault;

   Dbgprevioresgeneral.SetFocus;

end;

(******************************************************************************)

procedure TFEnvVsRep.asignarColorFilas();
var xColoreado, xTmpCambioColor : String;
begin
   DMPreCob.cdsQry7.First;
   xColoreado := 'S';
   xTmpCambioColor      := DMPreCob.cdsQry7.FieldByName('DPTODES').AsString;
   while not DMPreCob.cdsQry7.EOF do
     begin
        DMPreCob.cdsQry7.Edit;
        DMPreCob.cdsQry7.FieldByName('COLOREADO').AsString:=xColoreado;
        DMPreCob.cdsQry7.Post;
        DMPreCob.cdsQry7.next;
        if DMPreCob.cdsQry7.FieldByName('DPTODES').AsString<>xTmpCambioColor then
        begin
            if xColoreado = 'S' then xColoreado:='N' else xColoreado:='S';
            xTmpCambioColor := DMPreCob.cdsQry7.FieldByName('DPTODES').AsString;
        end;
     end;
   DMPreCob.cdsQry7.First;


end;
(******************************************************************************)

procedure TFEnvVsRep.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

(******************************************************************************)

procedure TFEnvVsRep.BitBtn3Click(Sender: TObject);
begin
  case pagecontrol.TabIndex of
     0: begin
          DBGrid.DataSource := DMPreCob.dsQry5;
          DMPreCob.HojaExcel('Reporte', DMPreCob.dsQry5, DBGrid);
        end;
  end;

end;

(******************************************************************************)

procedure TFEnvVsRep.pagecontrolChange(Sender: TObject);
begin
  case pagecontrol.TabIndex of
     0: begin
          gridresumengeneral;
        end;
  end;
end;

(******************************************************************************)

procedure TFEnvVsRep.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
  begin
    Key := #0;
    Perform(CM_DIALOGKEY, VK_TAB, 0);
  End;
end;


(*******************************************************************************)

procedure TFEnvVsRep.Button1Click(Sender: TObject);
var
   xSQL : String;
begin
   xSQL := copy(Memo1.Text,1,pos(';',Memo1.Text)-1);
   try
      DMPreCob.DCOM1.AppServer.EjecutaSql(xSql);
   except
      ShowMessage('No se pudo Ejecutar correctamente');
      exit;
   end;
   ShowMessage('Ok');
end;

(******************************************************************************)

procedure TFEnvVsRep.gridResumenGeneral;
Var
   xmonenv2,
   xmoncuocob2,xmoncuoncob2,
   xmoncuouticob2,xmoncuoutincob2,
   xdifmoncuocob2,
   xNumAsociados,xmondes : Double;
   xNroRegistros:Double;
begin
   xmonenv2 := 0;
   xmoncuocob2 := 0;
   xmoncuoncob2 := 0;
   xmoncuouticob2:=0;
   xmoncuoutincob2:=0;
   xdifmoncuocob2:=0;   
   xNumAsociados := 0;
   xNroRegistros:=0;
   xmondes:=0;
   if DMPreCob.cdsQry7.Active then
   begin
   DMPreCob.cdsQry7.First;
   While not DMPreCob.cdsQry7.Eof Do
   Begin
      xmondes     := xmondes     + DMPreCob.cdsQry7.FieldByName('MONDES').AsFloat;
      xmonenv2 := xmonenv2 + DMPreCob.cdsQry7.FieldByName('MON_ENV').AsFloat;
      xmoncuocob2 := xmoncuocob2 + DMPreCob.cdsQry7.FieldByName('MON_COB').AsFloat;
      xmoncuoncob2 := xmoncuoncob2 + DMPreCob.cdsQry7.FieldByName('MON_NCOB').AsFloat;
      xmoncuouticob2 := xmoncuouticob2 + DMPreCob.cdsQry7.FieldByName('MON_COB_UTI').AsFloat;
      xmoncuoutincob2 := xmoncuoutincob2 + DMPreCob.cdsQry7.FieldByName('MON_NCOB_UTI').AsFloat;
      xdifmoncuocob2 := xdifmoncuocob2 + DMPreCob.cdsQry7.FieldByName('DIF_MON_COB').AsFloat;
      xNumAsociados := xNumAsociados+DMPreCob.cdsQry7.FieldByName('ASOCIADOS').AsFloat;
      xNroRegistros := xNroRegistros + 1;
      DMPreCob.cdsQry7.Edit;
      DMPreCob.cdsQry7.FieldByName('COB_UTIL_VS_REAL').AsFloat:=
           DMPreCob.cdsQry7.FieldByName('MON_COB_UTI').AsFloat
          -DMPreCob.cdsQry7.FieldByName('MONDES').AsFloat;
      DMPreCob.cdsQry7.FieldByName('COB_UTIL_VS_REAL').AsFloat:=DMPreCob.FRound(DMPreCob.cdsQry7.FieldByName('COB_UTIL_VS_REAL').AsFloat,15,2);
      DMPreCob.cdsQry7.Post;
      DMPreCob.cdsQry7.Next;
   End;
   self.lblNroRegistros.Caption:=FloatToStr(xNroRegistros)+' Registros encontrados';

   dbgPrevioResGeneral.Selected.Clear;
   dbgPrevioResGeneral.Selected.Add('DPTODES'#9'10'#9'Departamento'#9);
   dbgPrevioResGeneral.Selected.Add('UPROID'#9'3'#9'Und~Proceso'#9);
   dbgPrevioResGeneral.Selected.Add('UPAGOID'#9'3'#9'Und~Pago'#9);
   dbgPrevioResGeneral.Selected.Add('UPAGONOM'#9'26'#9'Descripción~Unidad de pago'#9);
   dbgPrevioResGeneral.Selected.Add('ASOCIADOS'#9'8'#9'Asociados'#9);
   dbgPrevioResGeneral.Selected.Add('MON_ENV'#9'12'#9'Monto~enviado'#9);
   dbgPrevioResGeneral.Selected.Add('MON_COB_UTI'#9'12'#9'Monto~cobrado'#9'F'#9'Rep.Utilidad'#9);
   dbgPrevioResGeneral.Selected.Add('MON_NCOB_UTI'#9'12'#9'Monto~No cobrado'#9'F'#9'Rep.Utilidad'#9);
   dbgPrevioResGeneral.Selected.Add('EFECTIVIDAD'#9'10'#9'Efectividad~(cobrado uti~vs enviado)'#9);
   dbgPrevioResGeneral.Selected.Add('MON_COB'#9'12'#9'Monto~cobrado'#9'F'#9'Rep.Resultado'#9);
   dbgPrevioResGeneral.Selected.Add('MON_NCOB'#9'12'#9'Monto~No cobrado'#9'F'#9'Rep.Resultado'#9);
   dbgPrevioResGeneral.Selected.Add('DIF_MON_COB'#9'12'#9'Dif.Cob.Utilidad~vs Cob.Resultados'#9);
   dbgPrevioResGeneral.Selected.Add('MONDES'#9'12'#9'Cobranza~Real'#9);
   dbgPrevioResGeneral.Selected.Add('FECDES'#9'10'#9'Fecha~Cob.Real'#9);
   dbgPrevioResGeneral.Selected.Add('COB_UTIL_VS_REAL'#9'12'#9'Dif.Cob.Real~vs Rep.Utilidad'#9);

   dbgPrevioResGeneral.ApplySelected;
   TNumericField(DMPreCob.cdsQry7.FieldByName('MON_ENV')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsQry7.FieldByName('EFECTIVIDAD')).DisplayFormat := '##0.00%';
   TNumericField(DMPreCob.cdsQry7.FieldByName('MON_COB_UTI')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsQry7.FieldByName('MON_NCOB_UTI')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsQry7.FieldByName('MON_COB')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsQry7.FieldByName('MON_NCOB')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsQry7.FieldByName('DIF_MON_COB')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsQry7.FieldByName('MONDES')).DisplayFormat := '###,###,##0.00';
   TNumericField(DMPreCob.cdsQry7.FieldByName('COB_UTIL_VS_REAL')).DisplayFormat := '###,###,##0.00';


   dbgPrevioResGeneral.ColumnByName('USENOM').FooterValue := 'TOTAL';
   dbgPrevioResGeneral.ColumnByName('MON_ENV').FooterValue := FloatTostrf(xmonenv2,ffnumber,15,2);
   dbgPrevioResGeneral.ColumnByName('MON_COB_UTI').FooterValue   := FloatTostrf(xmoncuouticob2,ffnumber,15,2);
   dbgPrevioResGeneral.ColumnByName('MON_NCOB_UTI').FooterValue   := FloatTostrf(xmoncuoutincob2,ffnumber,15,2);
   dbgPrevioResGeneral.ColumnByName('MON_COB').FooterValue   := FloatTostrf(xmoncuocob2,ffnumber,15,2);
   dbgPrevioResGeneral.ColumnByName('MON_NCOB').FooterValue   := FloatTostrf(xmoncuoncob2,ffnumber,15,2);
   dbgPrevioResGeneral.ColumnByName('DIF_MON_COB').FooterValue   := FloatTostrf(xdifmoncuocob2,ffnumber,15,2);
   dbgPrevioResGeneral.ColumnByName('ASOCIADOS').FooterValue := floattostr(xNumAsociados);
   dbgPrevioResGeneral.ColumnByName('MONDES').FooterValue := FloatTostrf(xMondes,ffnumber,15,2);
   dbgPrevioResGeneral.RefreshDisplay;
   DMPreCob.cdsQry7.First;
   end;
end;

(******************************************************************************)

procedure TFEnvVsRep.dbgprevioresgeneralDblClick(Sender: TObject);

begin
  FEnvVsRepPorResultado:=TFEnvVsRepPorResultado.create(self);
  try
    FEnvVsRepPorResultado.cargarDxs(DMPreCob.cdsQry7.FieldByName('UPROID').AsString,
                                    DMPreCob.cdsQry7.FieldByName('UPAGOID').AsString,
                                    DMPreCob.cdsQry7.FieldByName('COBANO').AsString,
                                    DMPreCob.cdsQry7.FieldByName('COBMES').AsString,
                                    DMPreCob.cdsQry7.FieldByName('TIPPLA').AsString,
                                    DMPreCob.cdsQry7.FieldByName('ASOTIPID').AsString);
    FEnvVsRepPorResultado.showmodal;
  finally
    FEnvVsRepPorResultado.free;
  end
end;

(******************************************************************************)

procedure TFEnvVsRep.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    DMPreCob.cdsQry5.Filtered:=false;
    DMPreCob.cdsQry5.Close;
    DMPreCob.cdsUPro.Filtered:=false;
    DMPreCob.cdsUPro.Close;
    DMPreCob.cdsUPago.Filtered:=false;
    DMPreCob.cdsUPago.Close;
    try
      if DMPreCob.cdsQry7.IndexDefs.Count>0 then
        begin
          DMPreCob.cdsQry7.DeleteIndex('w2wTempIndex');
          DMPreCob.cdsQry7.IndexDefs.Update;
        end;  
    except
    end;  
    DMPreCob.cdsQry7.Filtered:=false;
    DMPreCob.cdsQry7.Close;

    Action:= caFree;
end;

(******************************************************************************)

procedure TFEnvVsRep.dbgprevioresgeneralCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
   if (Field.FieldName='EFECTIVIDAD') or (Field.FieldName='DIF_MON_COB') then AFont.Style:=[fsBold];
   AFont.Color := clBlack;
   if not Highlight then
   begin
      if Field.FieldName='EFECTIVIDAD' then
         if Field.Value<100 then AFont.Color := clRed;
      if Field.FieldName='DIF_MON_COB' then
         if Field.Value<>0 then AFont.Color := clRed;

      if DMPreCob.cdsQry7.FieldByName('COLOREADO').AsString='S' then
         ABrush.Color := clMoneyGreen  //clInfoBk //$0084FF84 // $00DFFFDF
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

procedure TFEnvVsRep.DoSorting(cdsName:TClientDataset; AFieldName: String);
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

(******************************************************************************)

procedure TFEnvVsRep.dbgprevioresgeneralTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  DoSorting(TClientDataset((Sender as TwwDBGrid).Datasource.Dataset),AFieldName);
  asignarColorFilas();
end;

(******************************************************************************)

procedure TFEnvVsRep.cargarUProceso();
var xSQL : String;
begin
   self.dblcdUPro.Text:='';
   self.meUPro.Text:='';


   xSQL := 'SELECT DISTINCT A.* '
          +'  FROM (SELECT DISTINCT A.UPROID, A.UPRONOM, C.OFDESID '
          +'           FROM APO102 A, APO103 B, APO101 C '
          +'          WHERE A.UPROID = B.UPROID '
          +'                AND B.UPROID = C.UPROID '
          +'                AND B.UPAGOID = C.UPAGOID) A '
          +' WHERE A.UPROID IN (SELECT UPROID '
          +'                      FROM COB319 '
          +'                     WHERE COBANO = '+QuotedStr(seano.Text)
          +'                       AND COBMES = '+QuotedStr(semes.Text)
          +'                       AND ASOTIPID = '+QuotedStr(dblcdasotipid.Text)
          +'                     GROUP BY UPROID) '
          +' ORDER BY A.UPROID ';



   (*
   xSQL := 'select A.* '
          +'  from APO102 A '
          +' where (A.UPROID) IN '
          +'       (SELECT UPROID '
          +'          FROM COB319 '
          +'         WHERE COBANO = '+QuotedStr(seano.Text)
          +'           AND COBMES = '+QuotedStr(semes.Text)
          +'           AND ASOTIPID = '+QuotedStr(dblcdasotipid.Text)
          +'         GROUP BY UPROID) '
          +'  order by A.UPROID ';


          *)
  (*
  // se puede tomar desde el apo101 pero mejos sigo la secuencia de la consulta gral

          +'       (SELECT UPROID '
          +'          FROM (SELECT UPROID '
          +'                  FROM COB319 '
          +'                 WHERE COBANO = '+QuotedStr(seano.Text)
          +'                   AND COBMES = '+QuotedStr(semes.Text)
          +'                   AND ASOTIPID = '+QuotedStr(dblcdasotipid.Text)
          +'                 GROUP BY UPROID) A '
          +'         WHERE (A.UPROID) IN '
          +'                 (SELECT UPROID '
          +'                    FROM APO103 '
          +'                   WHERE (UPROID) IN '
          +'                           (SELECT UPROID '
          +'                              FROM APO102 '
          +'                             WHERE UPROID IN (SELECT UPROID '
          +'                                                FROM APO101 '
          +'                                               WHERE OFDESID = '+QuotedStr(DMPreCob.xOfiId)
          +'                                               GROUP BY UPROID)))) '
          +'  order by A.UPROID ';
    *)

    
   DMPreCob.cdsUPro.Close;
   DMPreCob.cdsUPro.DataRequest(xSQL);
   DMPreCob.cdsUPro.Open;

   self.dblcdUPro.LookupField:='';
   self.dblcdUPro.LookupTable:=DMPreCob.cdsUPro;
   self.dblcdUPro.LookupField:='UPROID';
   self.dblcdUPro.Selected.Clear;
   self.dblcdUPro.Selected.Add('UPROID'#9'6'#9'UPro'#9#9);
   self.dblcdUPro.Selected.Add('UPRONOM'#9'25'#9'Nombre'#9#9);
end;

(******************************************************************************)

procedure TFEnvVsRep.cargarUPago();
var xSQL : String;
begin
   self.dblcdUPago.Text:='';
   self.meUPago.Text:='';
   xSQL := 'select A.* '
          +'  from APO103 A'
          +' where (A.UPROID, A.UPAGOID) IN '
          +'       (SELECT UPROID, UPAGOID '
          +'          FROM COB319 '
          +'         WHERE COBANO = '+QuotedStr(seano.Text)
          +'           AND COBMES = '+QuotedStr(semes.Text)
          +'           AND ASOTIPID = '+QuotedStr(dblcdasotipid.Text)
          +'         GROUP BY UPROID, UPAGOID) '
          +' order by A.UPAGOID ';
   DMPreCob.cdsUPago.Close;
   DMPreCob.cdsUPago.DataRequest(xSQL);
   DMPreCob.cdsUPago.Open;

   self.dblcdUPago.LookupField:='';
   self.dblcdUPago.LookupTable:=DMPreCob.cdsUPago;
   self.dblcdUPago.LookupField:='UPAGOID';
   self.dblcdUPago.Selected.Clear;
   self.dblcdUPago.Selected.Add('UPAGOID'#9'6'#9'UPago'#9#9);
   self.dblcdUPago.Selected.Add('UPAGONOM'#9'25'#9'Nombre'#9#9);
end;

(******************************************************************************)

procedure TFEnvVsRep.filtrarUProceso(IOfDesId: string);
begin
  DMPreCob.cdsUPro.Filtered:=false;
  DMPreCob.cdsUPro.Filter:='OFDESID='+quotedstr(IOfDesId);
  DMPreCob.cdsUPro.Filtered:=true;

end;

(******************************************************************************)

procedure TFEnvVsRep.filtrarUPago(IUProId: string);
begin
  DMPreCob.cdsUPago.Filtered:=false;
  DMPreCob.cdsUPago.Filter:='UPROID='+quotedstr(IUProId);
  DMPreCob.cdsUPago.Filtered:=true;
end;

(******************************************************************************)

procedure TFEnvVsRep.filtrarDetalle(IOfDesId,IUProId, IUPagoId: string );
var xCad,xCad2:string;
      Bk: TBookmarkStr;
begin
  if IOfDesId<>'' then
    begin
        if IUProId='' then
          begin
            Bk:=DMPreCob.cdsUPro.Bookmark;
            xCad2:='';
            DMPreCob.cdsUPro.First;
            while not DMPreCob.cdsUPro.Eof do
              begin
                 if xCad2<>'' then xCad2:=xCad2+',';
                 xCad2:=xCad2+quotedstr(DMPreCob.cdsUPro.FieldByName('UPROID').AsString);
                 DMPreCob.cdsUPro.Next;
              end;
            if xCad2<> '' then  xCad:='UPROID IN ('+xCad2+')';
            DMPreCob.cdsUPro.Bookmark:=Bk;
          end
        else
          begin
            xCad:='UPROID='+quotedstr(IUProId);
            if IUPagoId<>'' then  xCad:=xCad+' AND UPAGOID='+quotedstr(IUPagoId);
          end;
    end;
    (*
  else
    begin
      if IUProId<>'' then
        begin
          xCad:='UPROID='+quotedstr(IUProId);
          if IUPagoId<>'' then  xCad:=xCad+' AND UPAGOID='+quotedstr(IUPagoId);
        end;
    end;
      *)

  if xCad<>'' then
    begin
      DMPreCob.cdsQry7.Filtered:=false;
      DMPreCob.cdsQry7.Filter:=xCad;
      DMPreCob.cdsQry7.Filtered:=true;

      DMPreCob.cdsQry5.Filtered:=false;
      DMPreCob.cdsQry5.Filter:=xCad;
      DMPreCob.cdsQry5.Filtered:=true;
     end
  else
     begin
      DMPreCob.cdsQry7.Filtered:=false;
      DMPreCob.cdsQry5.Filtered:=false;
     end;
  gridResumenGeneral;
end;

(******************************************************************************)

procedure TFEnvVsRep.dblcdasotipidChange(Sender: TObject);
begin
  If DMPreCob.cdsTaso.Locate('ASOTIPID',dblcdasotipid.Text,[]) Then
  Begin
      measotipdes.Text := DMPreCob.cdsTaso.FieldByName('ASOTIPDES').AsString;
  End
  Else
    Begin
      if not dblcdasotipid.Focused then dblcdasotipid.Text  := '';
      measotipdes.Text := '';
    End;
  rbAportes.Enabled:=not((dblcdasotipid.Text= 'CE') or (dblcdasotipid.Text= 'CO'));
  rbAportes.Checked := false; //(dblcdasotipid.Text= 'DO'); // para q  se selecciones por defecto;
  rbCuotas.Checked := true; //((dblcdasotipid.Text= 'CE') or (dblcdasotipid.Text= 'CO')); // para q  se selecciones por defecto;
end;

(******************************************************************************)

procedure TFEnvVsRep.dblcdasotipidExit(Sender: TObject);
begin
  dblcdasotipidChange(dblcdasotipid);
end;


(******************************************************************************)

procedure TFEnvVsRep.dblcdUProChange(Sender: TObject);
begin
  If DMPreCob.cdsUPro.Locate('UPROID',VarArrayof([self.dblcdUPro.text]),[]) Then
      self.meUPro.Text := DMPreCob.cdsUPro.FieldByName('UPRONOM').AsString
  else
      begin
         if not dblcdUPro.Focused then dblcdUPro.Text:='';
         self.meUPro.text := '';
      end;
   self.dblcdUPago.Text:='';
   self.meUPago.Text:='';
   self.filtrarUPago(self.dblcdUPro.text);
   self.filtrarDetalle(DMPreCob.cdsOficina.FieldByName('OFDESID').AsString,self.dblcdUPro.text);
end;

(******************************************************************************)

procedure TFEnvVsRep.dblcdUProExit(Sender: TObject);
begin
    dblcdUProChange(dblcdUPro);
end;

(******************************************************************************)

procedure TFEnvVsRep.dblcdUPagoChange(Sender: TObject);
begin
  If DMPreCob.cdsUPago.Locate('UPAGOID',VarArrayof([self.dblcdUPago.text]),[]) Then
      begin
          self.meUPago.Text := DMPreCob.cdsUPago.FieldByName('UPAGONOM').AsString;
          self.filtrarDetalle(DMPreCob.cdsOficina.FieldByName('OFDESID').AsString,
                              DMPreCob.cdsUPro.FieldByName('UPROID').AsString,
                              self.dblcdUPago.text);
      end
  else
      begin
         if not dblcdUPago.Focused then dblcdUPago.Text:='';
         self.meUPago.text := '';
         self.filtrarDetalle(DMPreCob.cdsOficina.FieldByName('OFDESID').AsString,
                             DMPreCob.cdsUPro.FieldByName('UPROID').AsString);
      end;
end;

(******************************************************************************)

procedure TFEnvVsRep.dblcdUPagoExit(Sender: TObject);
begin
   dblcdUPagoChange(dblcdUPago);
end;

(******************************************************************************)

procedure TFEnvVsRep.bbtnQuitarFiltroClick(Sender: TObject);
begin
  if DMPreCob.wEsSupervisor then
    begin
      self.dblcdOficina.Text:='';
      self.filtrarUProceso('-.-');
      self.filtrarDetalle();
    end
  else   // solo upro
    begin
      self.dblcdUPro.Text:='';
      self.filtrarUPago('-.-');
      if DMPreCob.cdsOficina.Active then
        self.filtrarDetalle(DMPreCob.cdsOficina.FieldByName('OFDESID').AsString)
      else
        self.filtrarDetalle();

    end;
end;

(******************************************************************************)

procedure TFEnvVsRep.cargarOficina;
var xSQL : String;
begin
   xSQL := 'select OFDESID,OFDESNOM from APO110 order by OFDESID ';
   DMPreCob.cdsOficina.Close;
   DMPreCob.cdsOficina.DataRequest(xSQL);
   DMPreCob.cdsOficina.Open;

   dblcdOficina.LookupField:='';
   dblcdOficina.LookupTable:=DMPreCob.cdsOficina;
   dblcdOficina.LookupField:='OFDESID';
   dblcdOficina.Selected.Clear;
   dblcdOficina.Selected.Add('OFDESID'#9'3'#9'Id~Oficina'#9#9);
   dblcdOficina.Selected.Add('OFDESNOM'#9'15'#9'Oficina'#9#9);

   dblcdOficina.Enabled:=DMPreCob.wEsSupervisor;
end;

(******************************************************************************)

procedure TFEnvVsRep.dblcdOficinaChange(Sender: TObject);
begin
  If DMPreCob.cdsOficina.Locate('OFDESID',VarArrayof([self.dblcdOficina.text]),[]) Then
      meofdes.Text := DMPreCob.cdsOficina.FieldByName('OFDESNOM').AsString
  else
      begin
         if not self.dblcdOficina.Focused then self.dblcdOficina.text:='';
         self.meofdes.Text := '';
      end;
   self.dblcdUPro.Text:='';
   self.meUPro.Text:='';
   self.filtrarUProceso(self.dblcdOficina.text);
   self.filtrarDetalle(self.dblcdOficina.text,'','');

   (*
   self.dblcdUPago.Text:='';
   self.meUPago.Text:='';
   self.filtrarUPago(DMPreCob.cdsUPro.FieldByName('UPROID').AsString);
   self.filtrarDetalle('',DMPreCob.cdsUPro.FieldByName('UPROID').AsString);
      *)
end;

procedure TFEnvVsRep.dblcdOficinaExit(Sender: TObject);
begin
    dblcdOficinaChange(dblcdOficina);
end;

procedure TFEnvVsRep.dbgprevioresgeneralCalcTitleImage(Sender: TObject;
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

procedure TFEnvVsRep.dbgprevioresgeneralCalcTitleAttributes(
  Sender: TObject; AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
   if uppercase(AFieldName)='REP.UTILIDAD' then Abrush.Color:=clWhite;
   if AFieldName='MON_ENV' then Abrush.Color:=clWhite;
   if AFieldName='MON_COB_UTI' then Abrush.Color:=clWhite;
   if AFieldName='MON_NCOB_UTI' then Abrush.Color:=clWhite;
   if AFieldName='EFECTIVIDAD' then Abrush.Color:=clWhite;

   if uppercase(AFieldName)='REP.RESULTADO' then Abrush.Color:=$0093FFFF;
   if uppercase(AFieldName)='MON_COB' then Abrush.Color:=$0093FFFF;
   if uppercase(AFieldName)='MON_NCOB' then Abrush.Color:=$0093FFFF;
   if uppercase(AFieldName)='DIF_MON_COB' then Abrush.Color:=$0093FFFF;

{
   dbgPrevioResGeneral.Selected.Add('MONDES'#9'12'#9'Cobranza~Real'#9);
   dbgPrevioResGeneral.Selected.Add('FECDES'#9'10'#9'Fecha~Cob.Real'#9);
   dbgPrevioResGeneral.Selected.Add('COB_UTIL_VS_REAL'#9'12'#9'Dif.Cob.Real~vs Rep.Utilidad'#9);
}
end;

end.


