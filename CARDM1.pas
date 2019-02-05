unit CARDM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBClient, MConnect, Wwdatsrc, wwclient, Provider,comctrls,
  StdCtrls, wwdblook, ExtCtrls, Mask, wwdbedit, IniFiles, Buttons, Wwdbdlg,
  wwdbdatetimepicker, DBCtrls, wwSpeedButton, wwDBNavigator, Grids,
  Wwdbigrd, Wwdbgrid, dbiProcs, Wwdotdot, Wwdbcomb,
  variants,  RecError, Menus, Math, Excel2000, OleServer, DBGrids,
  ExcelXP, SConnect,  winsock;

type
  TDMPreCob = class(TDataModule)
    cdsUsuarios: TwwClientDataSet;
    dsUsuarios: TwwDataSource;
    cdsGrupos: TwwClientDataSet;
    dsGrupos: TwwDataSource;
    cdsMGrupo: TwwClientDataSet;
    dsMGrupo: TwwDataSource;
    cdsAcceso: TwwClientDataSet;
    dsAcceso: TwwDataSource;
    cdsAso: TwwClientDataSet;
    dsAso: TwwDataSource;
    cdsUSES: TwwClientDataSet;
    dsUSES: TwwDataSource;
    cdsUPro: TwwClientDataSet;
    dsUPro: TwwDataSource;
    cdsUPago: TwwClientDataSet;
    dsUPago: TwwDataSource;
    cdsSAso: TwwClientDataSet;
    dsSAso: TwwDataSource;
    cdsCAso: TwwClientDataSet;
    dsCAso: TwwDataSource;
    cdsOfDes: TwwClientDataSet;
    dsOfDes: TwwDataSource;
    cdsQry: TwwClientDataSet;
    dsQry: TwwDataSource;
    cdsDpto: TwwClientDataSet;
    dsDpto: TwwDataSource;
    cdsModelo: TwwClientDataSet;
    cdsPlantilla: TwwClientDataSet;
    dsModelo: TwwDataSource;
    dsPlantilla: TwwDataSource;
    cdsCuotas: TwwClientDataSet;
    dsCuotas: TwwDataSource;
    cdsCredito: TwwClientDataSet;
    dsCredito: TwwDataSource;
    cdsReporte: TwwClientDataSet;
    dsReporte: TwwDataSource;
    cdsQry2: TwwClientDataSet;
    cdsAutdisk: TwwClientDataSet;
    cdsQry3: TwwClientDataSet;
    cdsQry4: TwwClientDataSet;
    dsQry3: TwwDataSource;
    dsQry4: TwwDataSource;
    cdsQry1: TwwClientDataSet;
    cdsSolicitud: TwwClientDataSet;
    cdsProvCta: TwwClientDataSet;
    dsProvCta: TwwDataSource;
    dsQry1: TwwDataSource;
    dsQry2: TwwDataSource;
    dsSolicitud: TwwDataSource;
    dsAutdisk: TwwDataSource;
    ExcelApp: TExcelApplication;
    ExcelBook: TExcelWorkbook;
    WS: TExcelWorksheet;
    cdsQry6: TwwClientDataSet;
    dsQry6: TwwDataSource;
    cdsEjecuta: TwwClientDataSet;
    dsEjecuta: TwwDataSource;
    cdsQry5: TwwClientDataSet;
    dsqry5: TwwDataSource;
    cdsUser: TwwClientDataSet;
    dsUser: TwwDataSource;
    cdsTaso: TwwClientDataSet;
    dsTaso: TwwDataSource;
    cdsReporteest: TwwClientDataSet;
    dsReporteest: TwwDataSource;
    cdsOficina: TwwClientDataSet;
    dsOficina: TwwDataSource;
    cdsUse: TwwClientDataSet;
    dsUse: TwwDataSource;
    dsQry7: TwwDataSource;
    cdsQry7: TwwClientDataSet;
    cdsProv: TwwClientDataSet;
    dsProv: TwwDataSource;
    cdsDist: TwwClientDataSet;
    dsDist: TwwDataSource;
    DCOM1: TSocketConnection;
    dsQry8: TwwDataSource;
    cdsQry8: TwwClientDataSet;
    cdsQry9: TwwClientDataSet;
    dsQry9: TwwDataSource;
    dsQry10: TwwDataSource;
    cdsQry10: TwwClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsEjecutaReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);

  private
    { Private declarations }
		SeprDec: string;
		FormatCel: array of OleVariant;

  public
    { Public declarations }
    wObjetoDescr : String;
    wCodigoError : Integer;
    wObjetoForma : String;
    wObjetoNombr : String;
    wObjetoDesPr : String;
    wGrupoTmp    : String;
    wAdmin, wRepFecServ : String;
    wAreaPersonal : String; // variable que toma el nombre de departamento
    wciades       : String; // variable que toma el nombre de Compañia
    wComponente   : TControl;
 	  wTipoCambioUsar, sClose, wSRV,wTDatos, wModulo, wUsuario,wGrupo :string;
    wEsSupervisor : boolean;
    wMonedaNac,wMonedaExt, wModo :string;
		wTMonExt, wTMonLoc : String;
    wTCCompra,wTCVenta : String;
    xNumero            : String;
    xArea,xCnd,xSal,xGrabaExc, xNivelUsu,xOfiNombre:String;
    xCaptionPrincipal  : string;
    wBD, cIP, wOfiId, widepc, ideconex, fechorcon :String;
    function isAlfanumerico(ICad: string): boolean;
    Procedure AccesosUsuarios(xxModulo,xxUsuario,xxTipo,xxForma:String);
    function  BuscaObjeto( Const xNombre:String; xForm:TForm):TControl;
    function  DisplayDescrip(wPrv,wTabla,wCampos,wWhere,wResult:string):string;
    function  StrZero(wNumero:String;wLargo:Integer):string;
    procedure AccesosUsuariosR(xxModulo,xxUsuario,xxTipo:String; xxForma:TForm);
    function  FRound(xReal:double;xEnteros,xDecimal:Integer):double;
    procedure RecUltTipoCambio(var xFecha: string);
    function  NombreMes(wwMes:String):String;
    function  UltimoNum(wPrv,wTabla,wCampo,wWhere:string):string;
    function  RecuperarTipoCambio(xFecha : TDateTime ) : String;
    Function  DisplayDescripLocal(cds : TwwClientdataset; xCodigo,xDato,xMostrar : String) : String;
    function  NumeroNoNulo(xCampo : TField ) : double;
    procedure LimpiaClientDataset(cds : TwwClientDataset);
    procedure LimpiaDatos();
    function  FechaSys(): tDateTime;
    function  HoraSys: String;
    function  FechasOutPut(xFInput : tDateTime): tDateTime;
    function  CrgDescrip(xCondicion, xTabla, xCampo :String):String;
    function  CalSalPag(xAsoid, xCreDid, xFecCalCulo, xCreCuota, xCnd, xFrmPag :String ):Currency;
    function  CalSalPag_AR(xAsoid, xCreDid, xFecCalCulo, xCreCuota, xCnd, xFrmPag :String ):Currency;
    function  CrgArea(xUsuario:String ):String;
    function  Valores(Texto:String):Currency;
    function  xIntToLletras(Numero:LongInt;Dec:Real):String;
    function  DesMes(xMes:Integer; xAbr:Char):String;
    Function  StrSpace(wNumero:String;wLargo:Integer):string;
    function  RecuperaDatos(xTabla, xCampo, xVariable , xRecupera : String): String;
    function  UltimoDia(xMes:Integer; xAno:Integer):String;
    function  CalculaCuota(xTas_Int , xTas_Flt ,xMonOto: Real ; xNumCuo : Integer):Currency;
    function  IniFinCrono(xFec_Pre:tDateTime ; xNum_Cuo: Integer; xPrdGra,xTipPre:String):String;
 		procedure HojaExcel(Tit: string; TDs: TDataSource; TDb: TDBGrid);
		procedure FormatosCeldas(N: Integer ; TDs: TDataSource);
    function  CountReg(xSQL:String):Integer;
    function  FormatoNumeros(xTexto:String):String;
    function  ComputerName: string;
    function  ObtenerIpdeNetbios(Host: string): string;
  end;

var
  DMPreCob: TDMPreCob;
  SRV_E, SRV_D, SRV_V : String;
  xBorrar : String;
  xLogAsoid, xLogCodMo : Integer;
  wCiaDef, wTipoCambio : String;
  wRptCia, wRutaRpt, wUrqCia : String;
  xFec_Sis, xHor_Sis, wRutaFTP, wFormatFecha, wFormatHoras,  wReplacCeros, wRepFecServi, wRepTimeServi, wRepFuncDate, wRepFuncChar : String;
  xasocodmod, xasodni, xasoapenom:String;

implementation

{$R *.DFM}

uses MsgDlgs;

procedure TDMPreCob.DataModuleCreate(Sender: TObject);
var
   IniFile : TIniFile;
   xIpServer : string;
   xPortServer:string;
begin
// obtiene la direccion IP del servidor
   IniFile:=TIniFile.Create('C:\SOLExes\DemaConf.ini');
   xIpServer := IniFile.ReadString('TCPIP','ADDRESS','');
   xPortServer:= IniFile.ReadString('TCPIP','PORT','');
   if (Length(Trim(xIpServer))=0)or(Length(Trim(xPortServer))=0) Then
   begin
      Showmessage('No tiene la Direccion de IP/PUERTO del Servidor.');
      Application.Terminate;
   end;
// coloca el ip del servidor
   DMPreCob.DCOM1.Address:=xIpServer;
   DMPreCob.DCOM1.Port:=StrToInt(xPortServer);

   Try
      DCOM1.Connected := true;
   Except
      Showmessage('No hay comunicación con el Servidor de Aplicaciones');
      Application.Terminate;      
   End;
end;

Procedure TDMPreCob.AccesosUsuarios(xxModulo,xxUsuario,xxTipo,xxForma:String);
begin
  if Trim(cdsUsuarios.FieldByName('GRUPOID').AsString) = '' then
  begin
    cdsUsuarios.SetKey;
    cdsUsuarios.FieldByName('USERID').AsString := xxUsuario;
    If not cdsUsuarios.GotoKey then Exit;
  end;

  cdsGrupos.Filter := '';
  If xxTipo='1' then
  begin
    cdsGrupos.Filter:='GRUPOID='+''''+cdsUsuarios.FieldByName('GRUPOID').AsString+''''+' AND '
                     +'MODULOID='+''''+xxModulo+''''+' AND '
                     +'TIPO='+''''+xxTipo+'''';
    cdsGrupos.Filtered := True;
    cdsGrupos.First;
    While not cdsGrupos.Eof do
    begin
      wComponente := BuscaObjeto( cdsGrupos.FieldByName('OBJETO').AsString, Screen.ActiveForm);
      wComponente.Enabled := False;
      cdsGrupos.Next;
    end;
  end;

  If xxTipo='2' then
  begin
    cdsGrupos.Filter:='GRUPOID=' +''''+cdsUsuarios.FieldByName('GRUPOID').AsString+''''+' AND '
                     +'MODULOID='+''''+xxModulo+''''+' AND '
                     +'FORMA='   +''''+xxForma +''''+' AND '
                     +'TIPO='    +''''+xxTipo  +'''';
    cdsGrupos.Filtered := True;
    cdsGrupos.First;
    While not cdsGrupos.Eof do
    begin
      wComponente := BuscaObjeto(cdsGrupos.FieldByName('OBJETO').AsString, Screen.ActiveForm );
      If (wComponente.Name='Z2bbtnModifica') or
         (wComponente.Name='Z2bbtnConsulta') then
        wComponente.Enabled := False
      else
      begin
        wComponente.Visible := False;
      end;
      cdsGrupos.Next;
    end;
  end;
end;

function TDMPreCob.BuscaObjeto( Const xNombre:String; xForm:TForm):TControl;
var
  ic : Integer;
begin
  ic := xForm.ComponentCount-1;
  while (xForm.Components[ic].Name<>xNombre) and (ic>-1) do
  begin
    Dec(ic);
  end;
  If xForm.Components[ic].Name=xNombre then
    Result := TControl( xForm.Components[ic])
  else
    Result:=Nil;
end;

function TDMPreCob.DisplayDescrip(wPrv,wTabla,wCampos,wWhere,wResult:string):string;
var
  xSQL : string;
begin
  xSQL := '';
  xSQL := 'SELECT '+wCampos+' FROM '+wTabla;
  if length(wWhere)>0 then xSQL:=xSQL+' WHERE '+wWhere;
  cdsQry.Close;
  cdsQry.IndexFieldNames:='';
  cdsQry.DataRequest(xSQL);
  cdsQry.Open;
  result:=cdsQry.FieldByName(wResult).Asstring;
end;

function TDMPreCob.StrZero(wNumero:String;wLargo:Integer):string;
var
  i : integer;
  s, xTemp : string;
begin
  s := '';
  for i:=1 to wLargo do
  	s := s+'0';
  s := s+trim(wNumero);
  xTemp := copy(s,length(s)-(wLargo-1),wLargo);
	result := xTemp;
end;

procedure TDMPreCob.AccesosUsuariosR(xxModulo,xxUsuario,xxTipo:String; xxForma:TForm);
begin
  if Trim(cdsUsuarios.FieldByname('GRUPOID').AsString)='' then
  begin
    cdsUsuarios.SetKey;
    cdsUsuarios.FieldByname('USERID').AsString := xxUsuario;
    if not cdsUsuarios.GotoKey then
      Exit;
  end;

  cdsGrupos.Filter := '';
  If xxTipo = '1' then
  begin
    cdsGrupos.Filter:='GRUPOID='+''''+cdsUsuarios.FieldByname('GRUPOID').AsString+''''+' AND '
                     +'MODULOID='+''''+xxModulo+''''+' AND '
                     +'TIPO='+''''+xxTipo+'''';
    cdsGrupos.Filtered := True;
    if (wAdmin='S') or (wAdmin='P') then
      Exit;
    cdsGrupos.First;
    While not cdsGrupos.Eof do
    begin
      wComponente := BuscaObjeto( cdsGrupos.FieldByName('OBJETO').AsString, xxForma );
      wComponente.Enabled := False;
      cdsGrupos.Next;
    end;
  end;

  If xxTipo='2' then
  begin
    cdsGrupos.Filter:='GRUPOID=' +''''+cdsUsuarios.FieldByname('GRUPOID').AsString+''''+' AND '
                     +'MODULOID='+''''+xxModulo                +''''+' AND '
                     +'FORMA='   +''''+xxForma.Name            +''''+' AND '
                     +'TIPO='    +''''+xxTipo                  +'''';
    cdsGrupos.Filtered := True;

    if (wAdmin='S') or (wAdmin='P') then Exit;

    cdsGrupos.First;
    While not cdsGrupos.Eof do
    begin
      wComponente := BuscaObjeto(cdsGrupos.FieldByName('OBJETO').AsString, xxForma );
      If (wComponente.Name='Z2bbtnModifica') or
         (wComponente.Name='Z2bbtnConsulta') then
        wComponente.Enabled := False
      else
      begin
        wComponente.Visible := False;
      end;
      cdsGrupos.Next;
    end;
  end;
end;

function TDMPreCob.FRound(xReal: double; xEnteros, xDecimal: Integer): double;
Var
  xParteDec,xflgneg   : String;
  xDec: Integer;
  xMultiplo10, xUltdec, xNReal, xPDec : Double;
begin
  Result:=0;
  xflgneg:='0';
  xMultiplo10:=0;

  if xReal<0 then
  begin
  xflgneg:='1';
  xReal:=xReal*-1;
  end;
  xReal := strtofloat(floattostr(xReal));

  if xReal=0 then exit;
	// primer redondeo a un decimal + de lo indicado en los parámetros
  xDec := xDecimal+1;
  if xDec=0 then xMultiplo10:=1;
  if xDec=1 then xMultiplo10:=10;
  if xDec=2 then xMultiplo10:=100;
  if xDec=3 then xMultiplo10:=1000;
  if xDec=4 then xMultiplo10:=10000;
  if xDec=5 then xMultiplo10:=100000;
  if xDec=6 then xMultiplo10:=1000000;
  if xDec=7 then xMultiplo10:=10000000;

  xNreal := strtofloat(floattostr(xReal*xMultiplo10));
  xPdec  := int(strtofloat(floattostr(xReal)))*xMultiplo10;
  xPdec  := xNReal - xPDec;

  xPDec  := int(xPDec);
  xParteDec := floattostr(xPDec);
  if length(xParteDec)<xDec then
     xParteDec:=strZero(xParteDec,xDec);


  if length(xParteDec)>=xDec then
     xultdec:=  strtofloat(copy(xParteDec,xDec,1))
  else begin
     xUltDec := 0;
  end;
  xNReal := strtofloat(floattostr(xReal*xMultiplo10/10));
  xNReal := int(xNReal);
  if xultdec>=5 then xNReal := xNReal+1;

  if xflgneg='1' then
  begin
  Result := (xNReal/(xMultiplo10/10))*-1;
  end
  else
  begin
  Result := xNReal/(xMultiplo10/10);
  end;
end;


procedure TDMPreCob.RecUltTipoCambio(var xFecha: string);
var
  xSQL : String ;
begin
  xSQL :='SELECT * FROM TGE107 '+
         'WHERE FECHA=(SELECT MAX(FECHA) '+
         'FROM TGE107 '+
         'WHERE FECHA<='+wRepFuncDate+quotedstr(copy(xFecha,1,10))+')) '+
         'AND TMONID='''+ wTmonExt + ''''             ;
  cdsQry.close;
  cdsQry.dataRequest(xSQL);
  cdsQry.Open;
end;

function TDMPreCob.NombreMes(wwMes: String): String;
begin
   If StrToInt(wwMes) = 1 Then Result := 'Enero';
   If StrToInt(wwMes) = 2 Then Result := 'Febrero';
   If StrToInt(wwMes) = 3 Then Result := 'Marzo';
   If StrToInt(wwMes) = 4 Then Result := 'Abril';
   If StrToInt(wwMes) = 5 Then Result := 'Mayo';
   If StrToInt(wwMes) = 6 Then Result := 'Junio';
   If StrToInt(wwMes) = 7 Then Result := 'Julio';
   If StrToInt(wwMes) = 8 Then Result := 'Agosto';
   If StrToInt(wwMes) = 9 Then Result := 'Setiembre';
   If StrToInt(wwMes) = 10 Then Result := 'Octubre';
   If StrToInt(wwMes) = 11 Then Result := 'Noviembre';
   If StrToInt(wwMes) = 12 Then Result := 'Diciembre';
end;



function TDMPreCob.UltimoNum(wPrv, wTabla, wCampo, wWhere: string): string;
var
  xSQL : string;
begin
  xSQL := 'SELECT MAX('+wCampo+') ULTNUM FROM '+wTabla;
  if length(wWhere)>0 then xSQL:=xSQL+' WHERE '+wWhere;
  cdsQry.Close;
  //cdsQry.ProviderName:=wPrv;
  cdsQry.DataRequest(xSQL);
  cdsQry.Open;
  If (cdsQry.FieldbyName('ULTNUM').value = null) or (cdsQry.FieldbyName('ULTNUM').AsString = '') then
    result:='1'
  else
    result:=inttostr(cdsQry.FieldbyName('ULTNUM').asInteger+1);
end;

function TDMPreCob.RecuperarTipoCambio(xFecha: TDateTime): String;
var
  xFechaFormato : string ;
begin
  xFechaFormato := Formatdatetime(wFormatFecha,xFecha) ;
  RecUltTipoCambio(xFechaFormato);
  //cdsRec.active := False ;
  //cdsRec.active := True ;
  if cdsQry.RecordCount <> 0 then
  begin
    if not cdsQry.FieldByName(wTipoCambioUsar).isnull then
      Result := cdsQry.FieldByName(wTipoCambioUsar).AsString
    else
      Result := '0.00' ;
  end
  else
  begin
    Result := '0.00' ;
  end ;
end;

function TDMPreCob.DisplayDescripLocal(cds: TwwClientdataset; xCodigo, xDato, xMostrar: String): String;
begin
  if cds.Locate(xcodigo,VarArrayOf([xDato]),[]) then
    Result := cds.fieldbyname(xMostrar).AsString
  else
    Result := '' ;
end;

function TDMPreCob.NumeroNoNulo(xCampo: TField): double;
begin
  if not xCampo.IsNull then
    Result := xCampo.asFloat
  else
    Result := 0;
end;


procedure TDMPreCob.cdsEjecutaReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  Action := HandleReconcileError(DataSet, UpdateKind, E);
end;

procedure TDMPreCob.LimpiaClientDataset(cds: TwwClientDataset);
begin
   with cds do
   begin
     IndexFieldNames := '' ;
     Filter := '' ;
     Filtered := False ;
     if active then
       Close ;
   end ;
end;

//Eduardo Alva Aliaga
//Inicio
function TDMPreCob.CrgDescrip(xCondicion, xTabla, xCampo : String): String;
begin
cdsQry.Close;
cdsQry.DataRequest('Select * From '+xTabla+' Where '+xCondicion);
cdsQry.Open;
If cdsQry.RecordCount=1 Then
   Result:=cdsQry.fieldbyname(xCampo).AsString
Else
   Result:='';

cdsQry.Close;

end;


procedure TDMPreCob.LimpiaDatos;
begin

end;



function TDMPreCob.FechaSys: tDateTime;
var
   FormatoFecha: PChar;
begin
FormatoFecha:='dd/MM/yyyy';
SetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_SSHORTDATE,FormatoFecha);
cdsQry.Close;
cdsQry.DataRequest('SELECT TO_CHAR(SYSDATE,''dd/mm/yyyy'') AS FECHA FROM DUAL');
cdsQry.Open;
If cdsQry.RecordCount > 0 Then
    Result:=FechasOutPut(cdsQry.fieldbyname('FECHA').AsDateTime)
Else
    Result:=FechasOutPut(Date);
cdsQry.Close;
end;

function TDMPreCob.FechasOutPut(xFInput: tDateTime): tDateTime;
begin
   Result:=StrToDate(Copy(DateToStr(xFInput),1,10));
end;

function TDMPreCob.CalSalPag(xAsoid, xCreDid, xFecCalCulo, xCrecuota, xCnd, xFrmPag: String):Currency;
Var xfVenc,xSql,xOfiId,xEstado:String;
    xSaldo:Currency ;
begin
     cdsEjecuta.Close;
     If xCnd='0' Then
        cdsEjecuta.DataRequest('SELECT TIPCREID,CREANO,CREMES,CREMTOCOB,CREMTO,CREAMORT,CREFLAT,CREESTID FROM CRE302 Where ASOID ='+QuotedStr(Trim(xAsoId))+' And CREDID='+QuotedStr(Trim(xCreDid))+' AND CRECUOTA='+xCreCuota+' AND CREESTID IN (''02'',''11'',''27'') Order By CREDID,CRECUOTA')
     Else If xCnd='1' Then
        cdsEjecuta.DataRequest('SELECT TIPCREID,CREANO,CREMES,CREMTOCOB,CREMTO,CREAMORT,CREFLAT,CREESTID FROM CRE302 Where ASOID ='+QuotedStr(Trim(xAsoId))+' And CREDID='+QuotedStr(Trim(xCreDid))+' AND CRECUOTA>='+xCreCuota+' AND CREESTID IN (''02'',''11'',''27'') Order By CREDID,CRECUOTA')
     Else
        cdsEjecuta.DataRequest('SELECT TIPCREID,CREANO,CREMES,CREMTOCOB,CREMTO,CREAMORT,CREFLAT,FLAGVAR,CREESTID FROM CRE302 Where ASOID ='+QuotedStr(Trim(xAsoId))+' And CREDID='+QuotedStr(Trim(xCreDid))+' AND FLAGVAR=''S'' AND CREESTID IN (''02'',''11'',''27'') Order By CREDID,CRECUOTA');

     cdsEjecuta.Open;
     cdsEjecuta.First;
     xSaldo:=0;
     While Not cdsEjecuta.Eof do
     Begin
        xfVenc:= Trim(cdsEjecuta.fieldbyname('CREANO').AsString + cdsEjecuta.fieldbyname('CREMES').AsString); xEstado:=cdsEjecuta.fieldbyname('CREESTID').AsString;
        If xfVenc > xFecCalCulo Then
           Begin
             If  xCnd='0' Then
                 xSaldo := xSaldo + (cdsEjecuta.fieldbyname('CREMTO').AsCurrency - cdsEjecuta.fieldbyname('CREMTOCOB').AsCurrency)

             Else
                If cdsEjecuta.fieldbyname('CREMTOCOB').AsCurrency > 0 Then
                   xSaldo := xSaldo + (cdsEjecuta.fieldbyname('CREAMORT').AsCurrency + cdsEjecuta.fieldbyname('CREFLAT').AsCurrency)-cdsEjecuta.fieldbyname('CREMTOCOB').AsCurrency
                Else
                   xSaldo := xSaldo + (cdsEjecuta.fieldbyname('CREAMORT').AsCurrency + cdsEjecuta.fieldbyname('CREFLAT').AsCurrency);


           End
        Else
            Begin
                xSaldo := xSaldo + (cdsEjecuta.fieldbyname('CREMTO').AsCurrency - cdsEjecuta.fieldbyname('CREMTOCOB').AsCurrency);
            End;
     cdsEjecuta.Next;
     End;
     cdsEjecuta.Close;
     Result:=xSaldo;

end;


function TDMPreCob.CrgArea(xUsuario: String): String;
begin
cdsUser.Close;
cdsUser.DataRequest('SELECT USERID,USERNOM,AREA,ORIGEN,NIVEL FROM USERTABLE WHERE USERID='+QuotedStr(Trim(xUsuario)));
cdsUser.Open;
If cdsUser.RecordCount=1 Then
   Result:=cdsUser.fieldByname('AREA').AsString+cdsUser.fieldByname('ORIGEN').AsString+cdsUser.fieldByname('NIVEL').AsString
Else
   Result:='';
cdsUser.Close
end;

function TDMPreCob.Valores(Texto: String): Currency;
var xMont,xValor:String;
    I:Integer;
begin
   For I := 1 To Length(Trim(Texto)) Do
   Begin
       xMont:=Copy(Texto,I,1);
       If xMont <> ',' Then
          xValor := Trim(xValor)+Trim(xMont);
   End;
   Result:=StrToFloat(xValor);
end;







function TDMPreCob.xIntToLletras(Numero: Integer; Dec: Real): String;
  function xxIntToLletras(Valor:LongInt):String;
  const
   aUnidad : array[1..15] of string =
     ('UN','DOS','TRES','CUATRO','CINCO','SEIS',
      'SIETE','OCHO','NUEVE','DIEZ','ONCE','DOCE',
      'TRECE','CATORCE','QUINCE');
   aCentena: array[1..9]  of string =
     ('CIENTO','DOSCIENTOS','TRESCIENTOS',
      'CUATROCIENTOS','QUINIENTOS','SEISCIENTOS',
      'SETECIENTOS','OCHOCIENTOS','NOVECIENTOS');
   aDecena : array[1..9]  of string =
    ('DIECI','VEINTI','TREINTA','CUARENTA','CINCUENTA',
     'SESENTA','SETENTA','OCHENTA','NOVENTA');
  var
   Centena, Decena, Unidad, Doble: LongInt;
   Linea: String;
  begin
   if valor=100 then Linea:=' CIEN '
   else begin
     Linea:='';
     Centena := Valor div 100;
     Doble   := Valor - (Centena*100);
     Decena  := (Valor div 10) - (Centena*10);
     Unidad  := Valor - (Decena*10) - (Centena*100);

     if Centena>0 then Linea := Linea + Acentena[centena]+' ';

     if Doble>0 then begin
       if Doble=20 then Linea := Linea +' VEINTE '
         else begin
          if doble<16 then Linea := Linea + aUnidad[Doble]
            else begin
                 Linea := Linea +' '+ Adecena[Decena];
                 if (Decena>2) and (Unidad<>0) then Linea := Linea+' Y ';
                 if Unidad>0 then Linea := Linea + aUnidad[Unidad];
            end;
         end;
     end;
   end;
   Result := Linea;
  end;


//----Inicio---///
var
   Millones,Miles,Unidades: LongInt;
   Linea : String;
   xnum,xdec:Real;


begin
  {Inicializamos el string que contendrá las letras según el valor
  numérico}

  xnum:=Int(Numero);
  xdec:= (dec-xnum)*100;

  if numero=0 then Linea := 'CERO'
  else if numero<0 then Linea := 'MENOS '
       else if numero=1 then
            begin
              Linea := 'UN';
              xIntToLletras := Linea;
              exit
            end
            else if numero>1 then Linea := '';

  {Determinamos el Nº de millones, miles y unidades de numero en
  positivo}
  Numero   := Abs(Numero);
  Millones := numero div 1000000;
  Miles     := (numero - (Millones*1000000)) div 1000;
  Unidades  := numero - ((Millones*1000000)+(Miles*1000));

  {Vamos poniendo en el string las cadenas de los números(llamando
  a subfuncion)}
  if Millones=1 then Linea:= Linea + ' UN MILLON '
  else if Millones>1 then Linea := Linea + xxIntToLletras(Millones)
                                   + ' MILLONES ';

  if Miles =1 then Linea:= Linea + ' MIL '
  else if Miles>1 then Linea := Linea + xxIntToLletras(Miles)+
                                ' MIL ';

  if Unidades >0 then Linea := Linea + xxIntToLletras(Unidades);
   xIntToLletras := Linea+' y '+ Format( '%.2d',[round(xdec)])+ '/100 Nuevos Soles';

end;


function TDMPreCob.DesMes(xMes: Integer; xAbr: Char): String;
Const
    NomMes: Array [1..12] of String = ('ENERO','FEBRERO','MARZO','ABRIL','MAYO','JUNIO','JULIO','AGOSTO','SETIEMBRE','OCTUBRE','NOVIEMBRE','DICIEMBRE');
begin
  If xAbr='S' Then
     Result:=Copy(NomMes[xMes],1,3)
  Else Result:=NomMes[xMes];
end;

function TDMPreCob.StrSpace(wNumero: String; wLargo: Integer): string;
var
  i : integer;
  s, xTemp : string;
begin
  s := '';
  for i:=1 to wLargo do
  	s := s+' ';
  s := s+trim(wNumero);
  xTemp := copy(s,length(s)-(wLargo-1),wLargo);
	result := xTemp;
end;


function TDMPreCob.RecuperaDatos(xTabla, xCampo, xVariable,  xRecupera: String): String;
begin
  cdsQry2.Close;
  cdsQry2.DataRequest('Select * From '+xTabla+' WHERE '+xCampo+'='+ QuotedStr(Trim(xVariable)));
  cdsQry2.Open;
  If cdsQry2.RecordCount = 1 Then
     Result:=cdsQry2.fieldbyname(xRecupera).AsString
  Else
     Result:='';
     cdsQry2.Close;


end;

function TDMPreCob.UltimoDia(xMes, xAno: Integer): String;
var xDia:String;
Const
   FinDia: Array [1..13] of String = ('31','28','31','30','31','30','31','31','30','31','30','31','29');
Begin
   If xAno Mod 4 = 0 Then
      Begin
         If xMes=2 Then
            xMes:=13;
      End ; Result:=FinDia[xMes];




end;



function TDMPreCob.CalculaCuota(xTas_Int, xTas_Flt, xMonOto: Real;  xNumCuo: Integer): Currency;
var xMon_Cuo,sFlt_Pag,cNumer,cDenom:Real;
begin
sFlt_Pag:=0;
If xTas_Int <> 0 Then
   Begin
     xTas_Int:= StrToFloat(FloatToStrF(xTas_Int/100,ffFixed,15,4));
     xTas_Flt:= StrToFloat(FloatToStrF(xTas_Flt/100,ffFixed,15,4));
     cNumer  := xTas_Int * Power((1+xTas_Int),xNumCuo);
     cDenom  := Power((1+xTas_Int),xNumCuo)-1 ;
     xMon_Cuo:= StrToFloat(FloatToStrF(xMonOto * (cNumer/cDenom),ffFixed,15,2));
     sFlt_Pag:= StrToFloat(FloatToStrF(xMonOto * xTas_Flt / xNumCuo,ffFixed,15,2)) ;
   End
Else
   Begin
     xMon_Cuo:=xMonOto / xNumCuo;
     xMon_Cuo:= StrToFloat(FloatToStrF(xMon_Cuo,ffFixed,15,2));
   End;
   Result:= xMon_Cuo+sFlt_Pag;


end;

function TDMPreCob.IniFinCrono(xFec_Pre: tDateTime; xNum_Cuo: Integer; xPrdGra,  xTipPre: String): String;
var
    i,j:Integer;
    xPeriodo,xDia,tDia:String;
    xFecIni,xFecFin,xFec_Ven:tDateTime;
    tMes,tAno,xMes,xAno:Integer;

begin
    If xPrdGra='S' Then
       Begin
         xPeriodo:=Trim(RecuperaDatos('CRE110','TIPCREID',Trim(xTipPre),'PER_GRA'));
         If xPeriodo>'0' Then
         Begin
           For j:= 1 to StrToInt(xPeriodo) Do
           Begin
              tDia:=Copy(DateToStr(xFec_Pre),1,2);
              tMes:=StrToInt(Copy(DateToStr(xFec_Pre),4,2)) + 1;
              tAno:=StrToInt(Copy(DateToStr(xFec_Pre),7,4));
              If tMes > 12 Then
                 Begin
                  tMes := 1;
                  tAno := tAno + 1 ;
                 End;
             xFec_Pre:=StrToDate(tDia+'/'+Format('%.2d',[tMes])+'/'+ Trim(IntToStr(tAno)));
           End;
         End;
       End;

    For i:= 1 to xNum_Cuo Do
    Begin
      xMes:=StrToInt(Copy(DateToStr(xFec_Pre),4,2)) + 1;
      xAno:=StrToInt(Copy(DateToStr(xFec_Pre),7,4));
      If xMes > 12 Then
         Begin
           xMes := 1;
           xAno := xAno + 1 ;
         End;
      xDia:=UltimoDia(xMes,xAno);
      xFec_Ven := StrToDate(xDia+'/'+Format('%.2d',[xMes])+'/'+ Trim(IntToStr(xAno)));
      If i=1 Then  xFecIni:=xFec_Ven;
      If i=xNum_Cuo Then xFecFin:=xFec_Ven;

       xFec_Pre:=xFec_Ven;
    End;
    Result:= Copy(DateToStr(xFecIni),7,4)+Copy(DateToStr(xFecIni),4,2)+Copy(DateToStr(xFecIni),1,2)+Copy(DateToStr(xFecFin),7,4)+Copy(DateToStr(xFecFin),4,2)+Copy(DateToStr(xFecFin),1,2) ;

end;

function TDMPreCob.CalSalPag_AR(xAsoid, xCreDid, xFecCalCulo, xCreCuota, xCnd,  xFrmPag: String): Currency;
Var xfVenc,xSql,xOfiId,xEstado:String;
    xSaldo:Currency ;
begin
     cdsEjecuta.Close;
     If xCnd='0' Then
        cdsEjecuta.DataRequest('SELECT TIPCREID,CREANO,CREMES,CREMTOCOB,CREMTO,CREAMORT,CRECAPITAL,CREFLAT,CREESTID FROM CRE302 Where ASOID ='+QuotedStr(Trim(xAsoId))+' And CREDID='+QuotedStr(Trim(xCreDid))+' AND CRECUOTA='+xCreCuota+' AND CREESTID IN (''02'',''11'',''27'') Order By CREDID,CRECUOTA')
     Else If xCnd='1' Then
        cdsEjecuta.DataRequest('SELECT TIPCREID,CREANO,CREMES,CREMTOCOB,CREMTO,CREAMORT,CRECAPITAL,CREFLAT,CREESTID FROM CRE302 Where ASOID ='+QuotedStr(Trim(xAsoId))+' And CREDID='+QuotedStr(Trim(xCreDid))+' AND CRECUOTA>='+xCreCuota+' AND CREESTID IN (''02'',''11'',''27'') Order By CREDID,CRECUOTA')
     Else
        cdsEjecuta.DataRequest('SELECT TIPCREID,CREANO,CREMES,CREMTOCOB,CREMTO,CREAMORT,CRECAPITAL,CREFLAT,FLAGVAR,CREESTID FROM CRE302 Where ASOID ='+QuotedStr(Trim(xAsoId))+' And CREDID='+QuotedStr(Trim(xCreDid))+' AND FLAGVAR=''S'' AND CREESTID IN (''02'',''11'',''27'') Order By CREDID,CRECUOTA');

     cdsEjecuta.Open;
     cdsEjecuta.First;
     xSaldo:=0;
     While Not cdsEjecuta.Eof do
     Begin
        xfVenc:= Trim(cdsEjecuta.fieldbyname('CREANO').AsString + cdsEjecuta.fieldbyname('CREMES').AsString); xEstado:=cdsEjecuta.fieldbyname('CREESTID').AsString;
        If xfVenc > xFecCalCulo Then
           Begin
             If  xCnd='0' Then
                 xSaldo := xSaldo + (cdsEjecuta.fieldbyname('CREMTO').AsCurrency - cdsEjecuta.fieldbyname('CREMTOCOB').AsCurrency)

             Else
                If cdsEjecuta.fieldbyname('CREMTOCOB').AsCurrency > 0 Then
                   Begin
                      xSaldo := xSaldo + (cdsEjecuta.fieldbyname('CREAMORT').AsCurrency-cdsEjecuta.fieldbyname('CREMTOCOB').AsCurrency);
                      If xSaldo<0 Then xSaldo:=0 ; 
                   End
                Else
                   xSaldo := xSaldo + cdsEjecuta.fieldbyname('CREAMORT').AsCurrency ;


           End
        Else  
            Begin
                xSaldo := xSaldo + (cdsEjecuta.fieldbyname('CREMTO').AsCurrency - cdsEjecuta.fieldbyname('CREMTOCOB').AsCurrency);
            End;
     cdsEjecuta.Next;
     End;
     cdsEjecuta.Close;
     Result:=xSaldo;
end;


procedure TDMPreCob.HojaExcel(Tit: string; TDs: TDataSource; TDb: TDBGrid);
var Lcid, C, CH, CH1, I, W, X, Y, TotHoja: Integer; Bk: TBookmarkStr;
    Tabla: Variant; L, A: OleVariant; HH: Extended;
begin
	if not TDs.DataSet.Active then Exit;
	if TDs.DataSet.RecordCount = 0 then Exit;

	Lcid:= GetUserDefaultLCID;
	C:= TDb.Columns.Count;
	CH:= 1;
	if TDs.DataSet.RecordCount > 15100 then
		begin
			HH:= TDs.DataSet.RecordCount / 15100;
			CH:= Trunc(HH);
			if Frac(HH) > 0 then CH:= CH + 1;
		end;

	ExcelApp.Visible[Lcid]:= True;
	ExcelApp.Caption:= 'Consultas en EXCEL';
	ExcelBook.ConnectTo(ExcelApp.Workbooks.Add(1, Lcid));
	if CH > 1 then
		begin
			ExcelBook.Worksheets.Add(NULL, NULL, (CH - 1), NULL, Lcid);
			for I:= 1 to CH do
				begin
					WS.ConnectTo(ExcelBook.Worksheets[I] as _Worksheet);
					WS.Name:= Tit + '_' + IntToStr(I);
				end;
		end;

	WS.ConnectTo(ExcelBook.Worksheets[1] as _Worksheet);
	WS.Activate(Lcid);
	if CH = 1 then WS.Name:= Tit;
	ExcelApp.ScreenUpdating[Lcid]:= False;
	for X:= 1 to CH do
		begin
			WS.ConnectTo(ExcelBook.Worksheets[X] as _Worksheet);
			WS.Activate(Lcid);
			for I:= 0 to (C - 1) do
				begin
					L:= WS.Cells.Item[1, I + 1];
					WS.Range[L, L].Value2:= TDb.Columns[I].Title.Caption;
				end;
		end;

	WS.ConnectTo(ExcelBook.Worksheets[1] as _Worksheet);
	WS.Activate(Lcid);

	CH1:= 1;
	W:= 2;
	I:= 1;
	Y:= 1;
	TotHoja:= 0;
	TDs.DataSet.DisableControls;
	Bk:= TDs.DataSet.Bookmark;

	Tabla:= VarArrayCreate([1, 5000, 0, C], varVariant);
	TDs.DataSet.First;
	while not TDs.DataSet.Eof do
		begin
			for X:= 0 to (C - 1) do Tabla[Y, X]:= TDs.DataSet.Fields[X].AsString;
			if Y = 5000 then
				begin
					L:= 'A' + IntToStr(W);
					WS.Range[L, WS.Cells.Item[I + 1, C]].Value2:= Tabla;
					try
						Tabla:= Unassigned;
					finally
						Tabla:= VarArrayCreate([1, 5000, 0, C], varVariant);
					end;

					Y:= 0;
					W:= I + 2;
				end;
			Inc(Y, 1);
			Inc(I, 1);
			Inc(TotHoja, 1);
			if TotHoja = 15100 then
				begin
					L:= 'A' + IntToStr(W);
					WS.Range[L, WS.Cells.Item[I, C]].Value2:= Tabla;

					try
						Tabla:= Unassigned;
					finally
						Tabla:= VarArrayCreate([1, 5000, 0, C], varVariant);
					end;

					CH1:= CH1 + 1;
					WS.ConnectTo(ExcelBook.Worksheets[CH1] as _Worksheet);
					WS.Activate(Lcid);

					Y:= 1;
					W:= 2;
					I:= 1;
					TotHoja:= 0;
				end;
			Application.ProcessMessages;
			TDs.DataSet.Next;
		end;
	CH1:= I;
	try
	   WS.Range['A' + IntToStr(W), WS.Cells.Item[CH1, C]].Value2:= Tabla;
	finally
		Tabla:= Unassigned;
	end;

	for X:= 1 to CH do
		begin
			WS.ConnectTo(ExcelBook.Worksheets[X] as _Worksheet);
			WS.Activate(Lcid);

			SetLength(FormatCel, C + 1);
			FormatosCeldas(C,TDs);
			for I:= 1 to C do
				begin
					L:= WS.Cells.Item[1, I];
					WS.Range[L, L].EntireColumn.NumberFormat:= FormatCel[I];
				end;

			for I:= 0 to (C - 1) do
				begin
					L:= WS.Cells.Item[1, I + 1];
					Y:= TDs.DataSet.Fields[I].DisplayWidth;
					if Length(TDb.Columns[I].Title.Caption) > Y then
						Y:= Length(TDb.Columns[I].Title.Caption);
					  WS.Range[L, L].EntireColumn.ColumnWidth:= Y + 2;
					if TDb.Columns[I].Alignment = taLeftJustify then A:= 2;
					if TDb.Columns[I].Alignment = taCenter then A:= 3;
					if TDb.Columns[I].Alignment = taRightJustify then A:= 4;
					WS.Range[L, L].EntireColumn.HorizontalAlignment:= A;
				end;

			L:= WS.Cells.Item[1, C];
			WS.Range['A1', L].HorizontalAlignment:= 3;
			WS.Range['A1', L].Interior.Color:= clMaroon;
			WS.Range['A1', L].Font.Color:= clWhite;
			WS.Range['A1', L].Font.Bold:= True;

			if CH = 1 then W:= TDs.DataSet.RecordCount + 1
			else if (CH > 1) and (X < CH) then W:= 15101
			else if (CH > 1) and (X = CH) then W:= CH1;

			WS.PageSetup.PrintGridlines:= True;
			WS.PageSetup.PrintTitleRows:= '1:1';

			WS.DefaultInterface.Set_DisplayAutomaticPageBreaks(Lcid, True);
		end;

	WS.ConnectTo(ExcelBook.Worksheets[1] as _Worksheet);
	WS.Activate(Lcid);

	ExcelApp.ScreenUpdating[Lcid]:= True;

	TDs.DataSet.EnableControls;
	TDs.DataSet.Bookmark:= Bk;
end;






procedure TDMPreCob.FormatosCeldas(N: Integer; TDs: TDataSource);
var I: Integer; F: TFieldDef;
begin
    for I:= 1 to N do
    Begin
          F := TDs.DataSet.FieldDefs.Items[I-1];
          Case F.DataType of
               ftString: FormatCel[I]:= StrZero('0',Length(TDs.DataSet.Fields[I-1].AsString));
               ftDate: FormatCel[I]:= 'dd/mm/yyyy';
               ftDateTime: FormatCel[I]:= 'dd/mm/yyyy';
               ftUnknown: FormatCel[I]:= StrZero('0',Length(TDs.DataSet.Fields[I-1].AsString));
          Else
               FormatCel[I]:= Null;
          End;
     End;

end;



function TDMPreCob.CountReg(xSQL: String): Integer;
Var xCount:Integer;
begin
  cdsQry.Close;
  cdsQry.DataRequest(xSQL);
  cdsQry.Open;
  xCount:=cdsQry.RecordCount;
  cdsQry.Close;
  Result:=xCount;

end;

function TDMPreCob.FormatoNumeros(xTexto: String): String;
begin
   Try
      Result:=FormatFloat('###,###.#0',Valores(xTexto));
   Except
   End;

end;

function TDMPreCob.HoraSys: String;
begin
cdsEjecuta.Close;
cdsEjecuta.DataRequest('SELECT TO_CHAR(SYSDATE,''HH24:MI:SS'') AS HORA FROM DUAL');
cdsEjecuta.Open;
If cdsEjecuta.RecordCount > 0 Then
    Result:=cdsEjecuta.fieldbyname('HORA').AsString
Else
    Result:='';
    //TimeToStr(Time);

cdsEjecuta.Close;


end;





function TDMPreCob.ComputerName: string;
var
  Buffer: array[ 0..100 ] of Char;
  MaxSize: Cardinal ;
begin
  MaxSize := SizeOf( Buffer );
  if not GetComputerName( @Buffer, MaxSize ) then
    raise Exception.Create( 'No puedo determinar el nombre de la máquina' );
  Result := StrPas( @Buffer );
end;

function TDMPreCob.ObtenerIpdeNetbios(Host: string): string;
var
  WSAData: TWSADATA;
  HostEnt: phostent;
begin
  Result:= '';
  if WSAStartup(MAKEWORD(1, 1), WSADATA) = 0 then
  begin
    HostEnt:= gethostbyname(PChar(Host));
    if HostEnt <> nil then
      Result:= String(inet_ntoa(PInAddr(HostEnt.h_addr_list^)^));
    WSACleanup;
  end;
end;

function TDMPreCob.isAlfanumerico(ICad : string): boolean;
var
 i : integer;
 valor : char;
begin
 for i := 1 to Length(ICad) do
    begin
      valor := ICad[i];
      if not((valor in ['A'..'Z'])
             or (valor in ['a'..'z'])
             or (valor in ['0'..'9'])) then
         begin
            Result := False;
            exit;
         end;
    end;
end;

end.
