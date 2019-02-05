unit CAR018;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Spin, Mask, StdCtrls, Buttons, ExtCtrls, wwdblook, Wwdbdlg,
  Grids, Wwdbigrd, Wwdbgrid, ComCtrls, DBGrids, db, ppBands, ppCache,
  ppClass, ppDB, ppDBPipe, ppDBBDE, ppComm, ppRelatv, ppProd, ppReport,
  ppCtrls, ppPrnabl, ppVar, ppEndUsr, ppParameter, CARFRA001, CARFRA002;

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
  private
    procedure gridResumenGeneral;
    procedure cargarOficina();
    procedure cargarUProceso();
    procedure cargarUPago();
    procedure filtrarUProceso(IOfDesId:string);
    procedure filtrarUPago(IUProId:string);
    procedure filtrarDetalle(IOfDesId:string='';IUProId:string='';IUPagoId:string='');
  public
    { Public declarations }
  end;

var
  FEnvVsRep: TFEnvVsRep;

implementation

uses CARDM1, CAR011, CAR019;

{$R *.dfm}

(******************************************************************************)

procedure TFEnvVsRep.FormActivate(Sender: TObject);
Var xSql:String;
begin
  self.dblcdOficina.Enabled:=DM1.wEsSupervisor;
  DM1.cdsQry6.Close;
  xSql := 'SELECT ASOTIPID, ASOTIPDES FROM APO107 WHERE ASOTIPID IN (''DO'',''CO'',''CE'')';
  DM1.cdsTAso.Close;
  DM1.cdsTAso.DataRequest(xSql);
  DM1.cdsTAso.Open;
  dblcdasotipid.Selected.Clear;
  dblcdasotipid.Selected.Add('ASOTIPID'#9'3'#9'Código'#9#9);
  dblcdasotipid.Selected.Add('ASOTIPDES'#9'17'#9'Descripción'#9#9);
  dblcdasotipid.SetFocus;
end;

(******************************************************************************)

procedure TFEnvVsRep.btnprocesarClick(Sender: TObject);
Var
xSQL, xColoreado, xTmpCambioColor : String;
begin
   bbtnQuitarFiltroClick(bbtnQuitarFiltro);
   if trim(self.dblcdasotipid.Text) ='' then
     begin
          showmessage('Por Favor seleccione un Tipo de Asociado Enviado');
          exit;
     end;

   Screen.Cursor := crHourGlass;

   seano.Text := DM1.StrZero(seano.Text,4);
   semes.Text := DM1.StrZero(semes.Text,2);

(*
   xSql := '  SELECT A.UPROID, A.UPAGOID, MAX(D.UPAGONOM) UPAGONOM, MAX(A.COBANO) COBANO, MAX(A.COBMES) COBMES, '
          +'       MAX(A.ASOTIPID) ASOTIPID, SUM(1) ASOCIADOS, '
          +'       SUM(A.MONCUOENV) MONCUOENV, '
          +'       (SUM(NVL(B.MONCOB, 0)) * 100) / SUM(A.MONCUOENV) EFECTIVIDAD, '
          +'       SUM(NVL(B.MONCOB, 0)) MON_COB, '
          +'       SUM(A.MONCUOENV) - SUM(NVL(B.MONCOB, 0)) MON_NCOB '
          +'  FROM COB319 A, '
          +'       (SELECT *   '
          +'           FROM COB_INF_PLA_DET '
          +'          WHERE TIPO = ''2'') B, APO103 D '
          +' WHERE (A.UPROID, A.UPAGOID) IN '
          +'       (SELECT UPROID, UPAGOID '
          +'          FROM COB319 '
          +'         WHERE COBANO = '+QuotedStr(seano.Text)
          +'               AND COBMES = '+QuotedStr(semes.Text)
          +'               AND ASOTIPID = '+QuotedStr(dblcdasotipid.Text)
          +'         GROUP BY UPROID, UPAGOID) '
          +'       AND A.COBANO = '+QuotedStr(seano.Text)
          +'       AND A.COBMES = '+QuotedStr(semes.Text)
          +'       AND A.ASOTIPID = '+QuotedStr(dblcdasotipid.Text)
          +'       AND A.ASOID = B.ASOID(+) '
          +'       AND A.COBANO = B.COBANO(+) '
          +'       AND A.COBMES = B.COBMES(+) '
          +'       AND A.UPROID = D.UPROID '
          +'       AND A.UPAGOID = D.UPAGOID '
          +' GROUP BY A.UPROID, A.UPAGOID '
          +' ORDER BY A.UPROID, A.UPAGOID ';
*)


   xSql := '  SELECT ''N'' COLOREADO, R.DPTOID, S.DPTODES, A.UPROID, A.UPAGOID, MAX(D.UPAGONOM) UPAGONOM, MAX(A.COBANO) COBANO, MAX(A.COBMES) COBMES, '
          +'       MAX(A.ASOTIPID) ASOTIPID, SUM(1) ASOCIADOS, '
          +'       SUM(A.MONCUOENV) MONCUOENV, '
          +'       (SUM(C.MONCOB) * 100) / SUM(A.MONCUOENV) EFECTIVIDAD, '
          +'       SUM(C.MONCOB) MON_COB_UTI, '
          +'       SUM(A.MONCUOENV) - SUM(C.MONCOB) MON_NCOB_UTI, '
          +'       SUM(B.MONCOB) MON_COB, '
          +'       SUM(A.MONCUOENV) - SUM(B.MONCOB) MON_NCOB, '
          +'       ABS(SUM(C.MONCOB) - SUM(B.MONCOB)) DIF_MON_COB '
          +'  FROM COB319 A, APO102 R, APO158 S, '
          +'       (SELECT *   '
          +'           FROM COB_INF_PLA_DET '
          +'          WHERE TIPO = ''2'') B, '
          +'             (SELECT * '
          +'                FROM COB_INF_PLA_DET '
          +'               WHERE TIPO = ''1'') C, '
          +'        APO103 D '
          +' WHERE (A.UPROID, A.UPAGOID) IN '

          +'       (SELECT UPROID, UPAGOID '
          +'          FROM COB319 '
          +'         WHERE COBANO = '+QuotedStr(seano.Text)
          +'               AND COBMES = '+QuotedStr(semes.Text)
          +'               AND ASOTIPID = '+QuotedStr(dblcdasotipid.Text)
          +'         GROUP BY UPROID, UPAGOID) '

          {
          +'       (SELECT UPROID, UPAGOID '
          +'          FROM (SELECT UPROID, UPAGOID '
          +'                  FROM COB319 '
          +'                 WHERE COBANO = '+QuotedStr(seano.Text)
          +'                   AND COBMES = '+QuotedStr(semes.Text)
          +'                   AND ASOTIPID = '+QuotedStr(dblcdasotipid.Text)
          +'                 GROUP BY UPROID, UPAGOID) A '
          +'         WHERE (A.UPROID, A.UPAGOID) IN '
          +'                 (SELECT UPROID, UPAGOID '
          +'                    FROM APO103 '
          +'                   WHERE (UPROID, UPAGOID) IN '
          +'                           (SELECT UPROID, UPAGOID '
          +'                              FROM APO102 '
          +'                             WHERE UPROID IN (SELECT UPROID '
          +'                                                FROM APO101 '
          +'                                               WHERE OFDESID = '+QuotedStr(DM1.xOfiId)
          +'                                               GROUP BY UPROID)))) '
          }

          +'       AND A.COBANO = '+QuotedStr(seano.Text)
          +'       AND A.COBMES = '+QuotedStr(semes.Text)
          +'       AND A.ASOTIPID = '+QuotedStr(dblcdasotipid.Text)
          +' AND A.ASOID = B.ASOID(+) AND A.COBANO = B.COBANO(+) AND A.COBMES = B.COBMES(+) '
          +' AND A.ASOID = C.ASOID(+) AND A.COBANO = C.COBANO(+) AND A.COBMES = C.COBMES(+) '
          +'       AND A.UPROID = D.UPROID '
          +'       AND A.UPAGOID = D.UPAGOID '
          +'       AND nvl(A.CREMTOCUO,0)>0 '
          +'    AND R.UPROID=A.UPROID '
          +'    AND S.DPTOID=R.DPTOID '
          +' GROUP BY A.UPROID, A.UPAGOID, R.DPTOID, S.DPTODES '
          +' ORDER BY S.DPTODES, A.UPROID, A.UPAGOID ';

   DM1.cdsQry6.Close;
   DM1.cdsQry6.DataRequest(xSql);
   DM1.cdsQry6.Open;

   DM1.cdsQry6.First;
   xColoreado := 'S';
   xTmpCambioColor      := DM1.cdsQry6.FieldByName('DPTODES').AsString;
   while not DM1.cdsQry6.EOF do
     begin
        DM1.cdsQry6.Edit;
        DM1.cdsQry6.FieldByName('COLOREADO').AsString:=xColoreado;
        DM1.cdsQry6.Post;
        DM1.cdsQry6.next;
        if DM1.cdsQry6.FieldByName('DPTODES').AsString<>xTmpCambioColor then
        begin
            if xColoreado = 'S' then xColoreado:='N' else xColoreado:='S';
            xTmpCambioColor := DM1.cdsQry6.FieldByName('DPTODES').AsString;
        end;
     end;
   DM1.cdsQry6.First;

      //excel
   DM1.cdsQry5.Close;
   DM1.cdsQry5.DataRequest(XSQL);
   DM1.cdsQry5.Open;


   gridresumenGeneral;



   cargarOficina();
   self.cargarUProceso();
   self.cargarUPago();

   self.dblcdUPro.text := '';
   self.meUPro.Text := '';

   self.filtrarUProceso('-.-');
   self.filtrarUPago('-.-');
   // ** self.filtrarDetalle('-.-','-.-');

   if not DM1.wEsSupervisor then
     If DM1.cdsOficina.Locate('OFDESID',VarArrayof([DM1.xOfiId]),[]) Then
        begin
          dblcdOficina.text := DM1.xOfiId;
          dblcdOficinaChange(dblcdOficina);
        end;
        

   self.gbFiltro.Enabled:=true;
   pagecontrol.TabIndex := 0;
   pagecontrolChange(pagecontrol);
   Screen.Cursor := crDefault;

   Dbgprevioresgeneral.SetFocus;

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
          DBGrid.DataSource := DM1.dsQry5;
          DM1.HojaExcel('Reporte', DM1.dsQry5, DBGrid);
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
      DM1.DCOM1.AppServer.EjecutaSql(xSql);
   except
      ShowMessage('No se pudo Ejecutar correctamente');
      exit;
   end;
   ShowMessage('Ok');
end;

(******************************************************************************)

procedure TFEnvVsRep.gridResumenGeneral;
Var
   xmoncuoenv2,
   xmoncuocob2,xmoncuoncob2,
   xmoncuouticob2,xmoncuoutincob2,
   xdifmoncuocob2,
   xNumAsociados : Double;
   xNroRegistros:Double;
begin
   xmoncuoenv2 := 0;
   xmoncuocob2 := 0;
   xmoncuoncob2 := 0;
   xmoncuouticob2:=0;
   xmoncuoutincob2:=0;
   xdifmoncuocob2:=0;   
   xNumAsociados := 0;
   xNroRegistros:=0;
   if DM1.cdsQry6.Active then
   begin
   DM1.cdsQry6.First;
   While not DM1.cdsQry6.Eof Do
   Begin
      xmoncuoenv2 := xmoncuoenv2 + DM1.cdsQry6.FieldByName('MONCUOENV').AsFloat;
      xmoncuocob2 := xmoncuocob2 + DM1.cdsQry6.FieldByName('MON_COB').AsFloat;
      xmoncuoncob2 := xmoncuoncob2 + DM1.cdsQry6.FieldByName('MON_NCOB').AsFloat;
      xmoncuouticob2 := xmoncuouticob2 + DM1.cdsQry6.FieldByName('MON_COB_UTI').AsFloat;
      xmoncuoutincob2 := xmoncuoutincob2 + DM1.cdsQry6.FieldByName('MON_NCOB_UTI').AsFloat;
      xdifmoncuocob2 := xdifmoncuocob2 + DM1.cdsQry6.FieldByName('DIF_MON_COB').AsFloat;
      xNumAsociados := xNumAsociados+DM1.cdsQry6.FieldByName('ASOCIADOS').AsFloat;
      xNroRegistros := xNroRegistros + 1;
      DM1.cdsQry6.Next;
   End;
   self.lblNroRegistros.Caption:=FloatToStr(xNroRegistros)+' Registros encontrados';

   dbgPrevioResGeneral.Selected.Clear;
   dbgPrevioResGeneral.Selected.Add('DPTODES'#9'10'#9'Departamento'#9);
   dbgPrevioResGeneral.Selected.Add('UPROID'#9'3'#9'U.Proceso'#9);
   dbgPrevioResGeneral.Selected.Add('UPAGOID'#9'3'#9'U.Pago'#9);
   dbgPrevioResGeneral.Selected.Add('UPAGONOM'#9'30'#9'Descripción~Unidad de pago'#9);
   dbgPrevioResGeneral.Selected.Add('ASOCIADOS'#9'10'#9'Asociados'#9);
   dbgPrevioResGeneral.Selected.Add('MONCUOENV'#9'12'#9'Monto de la~cuota enviada'#9);
   dbgPrevioResGeneral.Selected.Add('MON_NCOB_UTI'#9'12'#9'Monto~No cobrado'#9);
   dbgPrevioResGeneral.Selected.Add('EFECTIVIDAD'#9'12'#9'Efectividad'#9);
   dbgPrevioResGeneral.Selected.Add('MON_COB_UTI'#9'12'#9'Monto~cobrado'#9'F'#9'Rep.Utilidad'#9);
   dbgPrevioResGeneral.Selected.Add('MON_COB'#9'12'#9'Monto~cobrado'#9'F'#9'Rep.Resultado'#9);
   dbgPrevioResGeneral.Selected.Add('MON_NCOB'#9'12'#9'Monto~No cobrado'#9'F'#9'Rep.Resultado'#9);
   dbgPrevioResGeneral.Selected.Add('DIF_MON_COB'#9'12'#9'Diferencia~de Montos~Cobrados'#9);
   dbgPrevioResGeneral.ApplySelected;
   TNumericField(DM1.cdsQry6.FieldByName('MONCUOENV')).DisplayFormat := '###,###,##0.00';
   TNumericField(DM1.cdsQry6.FieldByName('EFECTIVIDAD')).DisplayFormat := '##0.00%';
   TNumericField(DM1.cdsQry6.FieldByName('MON_COB_UTI')).DisplayFormat := '###,###,##0.00';
   TNumericField(DM1.cdsQry6.FieldByName('MON_NCOB_UTI')).DisplayFormat := '###,###,##0.00';
   TNumericField(DM1.cdsQry6.FieldByName('MON_COB')).DisplayFormat := '###,###,##0.00';
   TNumericField(DM1.cdsQry6.FieldByName('MON_NCOB')).DisplayFormat := '###,###,##0.00';
   TNumericField(DM1.cdsQry6.FieldByName('DIF_MON_COB')).DisplayFormat := '###,###,##0.00';

   dbgPrevioResGeneral.ColumnByName('USENOM').FooterValue := 'TOTAL';
   dbgPrevioResGeneral.ColumnByName('MONCUOENV').FooterValue := FloatTostrf(xmoncuoenv2,ffnumber,15,2);
   dbgPrevioResGeneral.ColumnByName('MON_COB_UTI').FooterValue   := FloatTostrf(xmoncuouticob2,ffnumber,15,2);
   dbgPrevioResGeneral.ColumnByName('MON_NCOB_UTI').FooterValue   := FloatTostrf(xmoncuoutincob2,ffnumber,15,2);
   dbgPrevioResGeneral.ColumnByName('MON_COB').FooterValue   := FloatTostrf(xmoncuocob2,ffnumber,15,2);
   dbgPrevioResGeneral.ColumnByName('MON_NCOB').FooterValue   := FloatTostrf(xmoncuoncob2,ffnumber,15,2);
   dbgPrevioResGeneral.ColumnByName('DIF_MON_COB').FooterValue   := FloatTostrf(xdifmoncuocob2,ffnumber,15,2);
   dbgPrevioResGeneral.ColumnByName('ASOCIADOS').FooterValue := floattostr(xNumAsociados);
   dbgPrevioResGeneral.RefreshDisplay;
   DM1.cdsQry6.First;
   end;
end;

(******************************************************************************)

procedure TFEnvVsRep.dbgprevioresgeneralDblClick(Sender: TObject);

begin
  FEnvVsRepPorResultado:=TFEnvVsRepPorResultado.create(self);
  try
    FEnvVsRepPorResultado.cargarDxs(DM1.cdsQry6.FieldByName('UPROID').AsString,
                                    DM1.cdsQry6.FieldByName('UPAGOID').AsString,
                                    DM1.cdsQry6.FieldByName('COBANO').AsString,
                                    DM1.cdsQry6.FieldByName('COBMES').AsString,
                                    DM1.cdsQry6.FieldByName('ASOTIPID').AsString);
    FEnvVsRepPorResultado.showmodal;
  finally
    FEnvVsRepPorResultado.free;
  end
end;

(******************************************************************************)

procedure TFEnvVsRep.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    DM1.cdsQry5.Filtered:=false;
    DM1.cdsQry5.Close;
    DM1.cdsQry6.Filtered:=false;
    DM1.cdsQry6.Close;
    DM1.cdsUPro.Filtered:=false;
    DM1.cdsUPro.Close;
    DM1.cdsUPago.Filtered:=false;
    DM1.cdsUPago.Close;
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


      if DM1.cdsQry6.FieldByName('COLOREADO').AsString='S' then
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

procedure TFEnvVsRep.dbgprevioresgeneralTitleButtonClick(Sender: TObject;
  AFieldName: String);
var nombreIndice:string;
begin
 nombreIndice:='w2wTempIndex';
 if (DM1.cdsQry6.IndexFieldNames=AFieldName) then
    begin
       DM1.cdsQry6.IndexDefs.Update;
       if DM1.cdsQry6.IndexDefs.IndexOf(nombreIndice)>-1  then
       begin
         DM1.cdsQry6.DeleteIndex(nombreIndice);
         DM1.cdsQry6.IndexDefs.Update;
       end;
       DM1.cdsQry6.AddIndex(nombreIndice,AFieldName,[ixDescending,ixCaseInsensitive],'','',0);
       DM1.cdsQry6.IndexName:=nombreIndice;
    end
 else
    begin
      try
        DM1.cdsQry6.IndexFieldNames := AFieldName;
      except
      end;
    end;
 DM1.cdsQry6.First;

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
          +'                                               WHERE OFDESID = '+QuotedStr(DM1.xOfiId)
          +'                                               GROUP BY UPROID)))) '
          +'  order by A.UPROID ';
    *)

    
   DM1.cdsUPro.Close;
   DM1.cdsUPro.DataRequest(xSQL);
   DM1.cdsUPro.Open;

   self.dblcdUPro.LookupField:='';
   self.dblcdUPro.LookupTable:=DM1.cdsUPro;
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
   DM1.cdsUPago.Close;
   DM1.cdsUPago.DataRequest(xSQL);
   DM1.cdsUPago.Open;

   self.dblcdUPago.LookupField:='';
   self.dblcdUPago.LookupTable:=DM1.cdsUPago;
   self.dblcdUPago.LookupField:='UPAGOID';
   self.dblcdUPago.Selected.Clear;
   self.dblcdUPago.Selected.Add('UPAGOID'#9'6'#9'UPago'#9#9);
   self.dblcdUPago.Selected.Add('UPAGONOM'#9'25'#9'Nombre'#9#9);
end;

(******************************************************************************)

procedure TFEnvVsRep.filtrarUProceso(IOfDesId: string);
begin
  DM1.cdsUPro.Filtered:=false;
  DM1.cdsUPro.Filter:='OFDESID='+quotedstr(IOfDesId);
  DM1.cdsUPro.Filtered:=true;

end;

(******************************************************************************)

procedure TFEnvVsRep.filtrarUPago(IUProId: string);
begin
  DM1.cdsUPago.Filtered:=false;
  DM1.cdsUPago.Filter:='UPROID='+quotedstr(IUProId);
  DM1.cdsUPago.Filtered:=true;
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
            Bk:=DM1.cdsUPro.Bookmark;
            xCad2:='';
            DM1.cdsUPro.First;
            while not DM1.cdsUPro.Eof do
              begin
                 if xCad2<>'' then xCad2:=xCad2+',';
                 xCad2:=xCad2+quotedstr(DM1.cdsUPro.FieldByName('UPROID').AsString);
                 DM1.cdsUPro.Next;
              end;
            if xCad2<> '' then  xCad:='UPROID IN ('+xCad2+')';
            DM1.cdsUPro.Bookmark:=Bk;
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
      DM1.cdsQry6.Filtered:=false;
      DM1.cdsQry6.Filter:=xCad;
      DM1.cdsQry6.Filtered:=true;

      DM1.cdsQry5.Filtered:=false;
      DM1.cdsQry5.Filter:=xCad;
      DM1.cdsQry5.Filtered:=true;
     end
  else
     begin
      DM1.cdsQry6.Filtered:=false;
      DM1.cdsQry5.Filtered:=false;
     end;
  gridResumenGeneral;
end;

(******************************************************************************)

procedure TFEnvVsRep.dblcdasotipidChange(Sender: TObject);
begin
  If DM1.cdsTaso.Locate('ASOTIPID',dblcdasotipid.Text,[]) Then
  Begin
      measotipdes.Text := DM1.cdsTaso.FieldByName('ASOTIPDES').AsString;
  End
  Else
  Begin
    if not dblcdasotipid.Focused then dblcdasotipid.Text  := '';
    measotipdes.Text := '';
  End;
end;

(******************************************************************************)

procedure TFEnvVsRep.dblcdasotipidExit(Sender: TObject);
begin
  dblcdasotipidChange(dblcdasotipid);
end;


(******************************************************************************)

procedure TFEnvVsRep.dblcdUProChange(Sender: TObject);
begin
  If DM1.cdsUPro.Locate('UPROID',VarArrayof([self.dblcdUPro.text]),[]) Then
      self.meUPro.Text := DM1.cdsUPro.FieldByName('UPRONOM').AsString
  else
      begin
         if not dblcdUPro.Focused then dblcdUPro.Text:='';
         self.meUPro.text := '';
      end;
   self.dblcdUPago.Text:='';
   self.meUPago.Text:='';
   self.filtrarUPago(self.dblcdUPro.text);
   self.filtrarDetalle(DM1.cdsOficina.FieldByName('OFDESID').AsString,self.dblcdUPro.text);
end;

(******************************************************************************)

procedure TFEnvVsRep.dblcdUProExit(Sender: TObject);
begin
    dblcdUProChange(dblcdUPro);
end;

(******************************************************************************)

procedure TFEnvVsRep.dblcdUPagoChange(Sender: TObject);
begin
  If DM1.cdsUPago.Locate('UPAGOID',VarArrayof([self.dblcdUPago.text]),[]) Then
      begin
          self.meUPago.Text := DM1.cdsUPago.FieldByName('UPAGONOM').AsString;
          self.filtrarDetalle(DM1.cdsOficina.FieldByName('OFDESID').AsString,
                              DM1.cdsUPro.FieldByName('UPROID').AsString,
                              self.dblcdUPago.text);
      end
  else
      begin
         if not dblcdUPago.Focused then dblcdUPago.Text:='';
         self.meUPago.text := '';
         self.filtrarDetalle(DM1.cdsOficina.FieldByName('OFDESID').AsString,
                             DM1.cdsUPro.FieldByName('UPROID').AsString);
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
  if DM1.wEsSupervisor then
    begin
      self.dblcdOficina.Text:='';
      self.filtrarUProceso('-.-');
      self.filtrarDetalle();
    end
  else   // solo upro
    begin
      self.dblcdUPro.Text:='';
      self.filtrarUPago('-.-');
      if DM1.cdsOficina.Active then
        self.filtrarDetalle(DM1.cdsOficina.FieldByName('OFDESID').AsString)
      else
        self.filtrarDetalle();

    end;
end;

(******************************************************************************)

procedure TFEnvVsRep.cargarOficina;
var xSQL : String;
begin
   xSQL := 'select OFDESID,OFDESNOM from APO110 order by OFDESID ';
   DM1.cdsOficina.Close;
   DM1.cdsOficina.DataRequest(xSQL);
   DM1.cdsOficina.Open;

   dblcdOficina.LookupField:='';
   dblcdOficina.LookupTable:=DM1.cdsOficina;
   dblcdOficina.LookupField:='OFDESID';
   dblcdOficina.Selected.Clear;
   dblcdOficina.Selected.Add('OFDESID'#9'3'#9'Id~Oficina'#9#9);
   dblcdOficina.Selected.Add('OFDESNOM'#9'15'#9'Oficina'#9#9);

   dblcdOficina.Enabled:=DM1.wEsSupervisor;
end;

(******************************************************************************)

procedure TFEnvVsRep.dblcdOficinaChange(Sender: TObject);
begin
  If DM1.cdsOficina.Locate('OFDESID',VarArrayof([self.dblcdOficina.text]),[]) Then
      meofdes.Text := DM1.cdsOficina.FieldByName('OFDESNOM').AsString
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
   self.filtrarUPago(DM1.cdsUPro.FieldByName('UPROID').AsString);
   self.filtrarDetalle('',DM1.cdsUPro.FieldByName('UPROID').AsString);
      *)
end;

procedure TFEnvVsRep.dblcdOficinaExit(Sender: TObject);
begin
    dblcdOficinaChange(dblcdOficina);
end;

end.
