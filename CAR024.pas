UNIT CAR024;

INTERFACE

USES
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, DB,
   DBClient, DBTables, Wwdatsrc, Wwtable, DBLists, Wwquery,
   DBGrids, IBCustomDataSet,
   FMTBcd, SqlExpr, Spin;    //HPP_200902_PRCB

TYPE
   TFImpDBF = CLASS(TForm)
      //HPP_200902_PRCB
      tFuente: TTable;
      cdsPrincipal: TClientDataSet;
      dsPrincipal: TDataSource;
      cdsRespaldo: TClientDataSet;
      GroupBox2: TGroupBox;
      edRenombrarOriginal: TEdit;
      GroupBox3: TGroupBox;
      btnUnirAnt: TButton;
      btnUnirSig: TButton;
      rgTipoSep: TRadioGroup;
      edSepUnionCol: TEdit;
      GroupBox4: TGroupBox;
      edRenombrarModificado: TEdit;
      btnRenombrarColumna: TButton;
      Label2: TLabel;
      MTxt: TMemo;
      btnprocesar: TBitBtn;
      btnSalir: TBitBtn;
      GroupBox1: TGroupBox;
      btnCargarDxs: TButton;
      odLeer: TOpenDialog;
      GroupBox5: TGroupBox;
      btnEliminarColumna: TButton;
      GroupBox6: TGroupBox;
      btnMoverIzda: TButton;
      btnMoverDrch: TButton;
      bbtnVerPrevio: TBitBtn;
      GroupBox7: TGroupBox;
      btnAplicarAnchoColumna: TButton;
      seAnchoColumna: TSpinEdit;
      dbgPrincipal: TwwDBGrid;
      GroupBox8: TGroupBox;
      btnCompletarData: TButton;
      btnExportar: TBitBtn;
      DBGrid: TDBGrid;
      lblFallosCompletarData: TLabel;
      PROCEDURE btnRenombrarColumnaClick(Sender: TObject);
      PROCEDURE btnUnirSigClick(Sender: TObject);
      PROCEDURE btnUnirAntClick(Sender: TObject);
      PROCEDURE btnEliminarColumnaClick(Sender: TObject);
      PROCEDURE dbgPrincipalTitleButtonClick(Sender: TObject;
         AFieldName: STRING);
      PROCEDURE rgTipoSepClick(Sender: TObject);
      PROCEDURE btnprocesarClick(Sender: TObject);
      PROCEDURE btnSalirClick(Sender: TObject);
      PROCEDURE FormShow(Sender: TObject);
      PROCEDURE btnCargarDxsClick(Sender: TObject);
      PROCEDURE dbgPrincipalCalcTitleAttributes(Sender: TObject;
         AFieldName: STRING; AFont: TFont; ABrush: TBrush;
         VAR ATitleAlignment: TAlignment);
      PROCEDURE bbtnVerPrevioClick(Sender: TObject);
      PROCEDURE btnAplicarAnchoColumnaClick(Sender: TObject);
      PROCEDURE btnMoverIzdaClick(Sender: TObject);
      PROCEDURE btnMoverDrchClick(Sender: TObject);
      PROCEDURE dbgPrincipalColumnMoved(Sender: TObject; FromIndex,
         ToIndex: Integer);
      PROCEDURE btnCompletarDataClick(Sender: TObject);
      PROCEDURE btnExportarClick(Sender: TObject);
   Private
      xColumnaActiva: STRING;
      xFileRespaldo: STRING;
      PROCEDURE cargarDatos(iArchivo: STRING);
      FUNCTION obtenerSepUnionColumnas: STRING;
      PROCEDURE recargarDxsPrincipal;
      PROCEDURE seleccionarColumna(iColum: STRING = '');
      PROCEDURE unirColumnas(iPriColumna, iSegColumna, iSeparador: STRING);
      FUNCTION isCargoPrevio(IMTxt: TMemo; IIsProcesar: boolean = true): boolean;
      PROCEDURE moverColumnas(iPriColumna, iSegColumna: STRING);

   Public
      xArchivoGenerarTxt: STRING;
      xArchivoDBF: STRING;
   END;

VAR
   FImpDBF: TFImpDBF;

IMPLEMENTATION

USES CARDM1, CAR026; //HPP_200902_PRCB

{$R *.dfm}

(******************************************************************************)

PROCEDURE TFImpDBF.FormShow(Sender: TObject);
BEGIN
   cargarDatos(xArchivoDBF);
END;
(******************************************************************************)

PROCEDURE TFImpDBF.btnCargarDxsClick(Sender: TObject);
BEGIN
   odLeer.Title := 'Leer DBF para Vista Previa';
   odLeer.DefaultExt := '*.DBF';
   odLeer.Filter := 'Archivos DBFs|*.DBF';
   odLeer.FileName := '';

   //Inicio: HPP_200902_PRCB
   IF NOT odLeer.Execute THEN Exit;
   cargarDatos(odLeer.FileName);
   xArchivoGenerarTxt := 'c:\tmpTxt.txt';
   //Fin: HPP_200902_PRCB
END;

(******************************************************************************)

PROCEDURE TFImpDBF.cargarDatos(iArchivo: STRING);

   PROCEDURE crearCabeceraPrincipal();
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      WITH cdsPrincipal DO
      BEGIN
         close;
         FieldDefs.Clear;
         xFieldDefList := tFuente.FieldDefList;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
         BEGIN
            WITH FieldDefs.AddFieldDef DO
            BEGIN
               DataType := xFieldDefList.FieldDefs[i].DataType;
               Size := xFieldDefList.FieldDefs[i].Size;
               Name := xFieldDefList.FieldDefs[i].Name;
            END;
         END;
         CreateDataSet;
      END;
   END;

   PROCEDURE cargarDxs();
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      xFieldDefList := tFuente.FieldDefList;
      tFuente.First;
      WHILE NOT tFuente.Eof DO
      BEGIN
         cdsPrincipal.Append;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
            cdsPrincipal.FieldByName(xFieldDefList[i].Name).Value := tFuente.FieldByName(xFieldDefList[i].Name).value;
         cdsPrincipal.Post;
         tFuente.Next;
      END;
   END;
BEGIN
   xFileRespaldo := 'c:\tmpPrecobRespaldo.xml';
   deleteFile(xFileRespaldo);
   TRY
      tFuente.Close;
      tFuente.TableName := iArchivo;
      tFuente.Open;
   EXCEPT
      showmessage('Por favor verifique que el archivo no este dañado');
      exit;
   END;
   crearCabeceraPrincipal();
   cargarDxs();
   seleccionarColumna();
END;

(******************************************************************************)

PROCEDURE TFImpDBF.dbgPrincipalTitleButtonClick(Sender: TObject;
   AFieldName: STRING);
BEGIN
   seleccionarColumna(AFieldName);
END;

(******************************************************************************)

PROCEDURE TFImpDBF.seleccionarColumna(iColum: STRING);

   PROCEDURE activarCtrls(INombre: STRING);
   BEGIN
      xColumnaActiva := INombre; // variable global
      btnEliminarColumna.Enabled := cdsPrincipal.FieldDefs.Count > 1;
      btnRenombrarColumna.Enabled := true;
      edRenombrarOriginal.Text := cdsPrincipal.FieldDefs.Find(xColumnaActiva).name;
      edRenombrarModificado.Text := '';
      btnUnirSig.Enabled := cdsPrincipal.FieldDefs.Find(xColumnaActiva).Index < cdsPrincipal.FieldDefs.Count - 1;
      btnUnirAnt.Enabled := cdsPrincipal.FieldDefs.Find(xColumnaActiva).Index > 0;
      btnMoverIzda.Enabled := btnUnirAnt.Enabled;
      btnMoverDrch.Enabled := btnUnirSig.Enabled;
      IF cdsPrincipal.FieldDefs.Find(xColumnaActiva).DataType = ftString THEN
      BEGIN
         seAnchoColumna.MaxValue := cdsPrincipal.FieldDefs.Find(xColumnaActiva).Size;
         seAnchoColumna.MinValue := 1;
         seAnchoColumna.Value := seAnchoColumna.MaxValue;
         seAnchoColumna.Enabled := true;
      END
      ELSE
      BEGIN
         seAnchoColumna.Value := 0;
         seAnchoColumna.Enabled := false;
      END;
      btnAplicarAnchoColumna.Enabled := seAnchoColumna.Enabled;
   END;
BEGIN
   IF iColum <> '' THEN
      activarCtrls(iColum)
   ELSE
   BEGIN
      IF cdsPrincipal.FieldDefs.Count > 0 THEN
         activarCtrls(cdsPrincipal.FieldDefs[0].name)
      ELSE
      BEGIN
         xColumnaActiva := '';
         btnEliminarColumna.Enabled := false;
         btnRenombrarColumna.Enabled := false;
         edRenombrarOriginal.Text := '';
         edRenombrarModificado.Text := '';
         btnUnirSig.Enabled := false;
         btnUnirAnt.Enabled := false;
         seAnchoColumna.Enabled := false;
         btnAplicarAnchoColumna.Enabled := false;
         btnMoverIzda.Enabled := false;
         btnMoverDrch.Enabled := false;

      END;
   END;
END;

(******************************************************************************)

PROCEDURE TFImpDBF.recargarDxsPrincipal();
BEGIN
   deleteFile(xFileRespaldo);
   cdsRespaldo.SaveToFile(xFileRespaldo);
   cdsPrincipal.Close;
   cdsPrincipal.LoadFromFile(xFileRespaldo);
   cdsPrincipal.Open;
END;

(******************************************************************************)

PROCEDURE TFImpDBF.btnRenombrarColumnaClick(Sender: TObject);

   PROCEDURE copiarCabecera(ICampoRenombrar: STRING);
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      WITH cdsRespaldo DO
      BEGIN
         close;
         FieldDefs.Clear;
         xFieldDefList := cdsPrincipal.FieldDefList;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
         BEGIN
            WITH FieldDefs.AddFieldDef DO
            BEGIN
               DataType := xFieldDefList.FieldDefs[i].DataType;
               Size := xFieldDefList.FieldDefs[i].Size;
               IF xFieldDefList.FieldDefs[i].Name = xColumnaActiva THEN
                  Name := ICampoRenombrar
               ELSE
                  Name := xFieldDefList.FieldDefs[i].Name;
            END;
         END;
         CreateDataSet;
      END;
   END;

   PROCEDURE copiarDxs(ICampoRenombrar: STRING);
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      xFieldDefList := cdsPrincipal.FieldDefList;
      cdsPrincipal.First;
      WHILE NOT cdsPrincipal.Eof DO
      BEGIN
         cdsRespaldo.Append;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
         BEGIN
            IF xFieldDefList.FieldDefs[i].Name = xColumnaActiva THEN
               cdsRespaldo.FieldByName(ICampoRenombrar).Value := cdsPrincipal.FieldByName(xFieldDefList[i].Name).Value
            ELSE
               cdsRespaldo.FieldByName(xFieldDefList[i].Name).Value := cdsPrincipal.FieldByName(xFieldDefList[i].Name).Value;
         END;
         cdsRespaldo.Post;
         cdsPrincipal.Next;
      END;
   END;

BEGIN
   IF trim(edRenombrarModificado.Text) <> '' THEN
   BEGIN
      Screen.Cursor := crHourGlass;
      copiarCabecera(edRenombrarModificado.Text);
      copiarDxs(edRenombrarModificado.Text);
      recargarDxsPrincipal();
      seleccionarColumna(edRenombrarModificado.Text);
      Screen.Cursor := crDefault;
   END
   ELSE
      showmessage('Por favor ingres un Nombre para la Columna');
END;

(******************************************************************************)

PROCEDURE TFImpDBF.rgTipoSepClick(Sender: TObject);
BEGIN
   edSepUnionCol.Enabled := rgTipoSep.ItemIndex = 2;
   IF edSepUnionCol.Enabled THEN
      edSepUnionCol.Focused;
END;

(******************************************************************************)

PROCEDURE TFImpDBF.unirColumnas(iPriColumna, iSegColumna, iSeparador: STRING);

   PROCEDURE copiarCabecera(ICampoFinal, ICampoOmitir, ISep: STRING);
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      WITH cdsRespaldo DO
      BEGIN
         close;
         FieldDefs.Clear;
         xFieldDefList := cdsPrincipal.FieldDefList;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
         BEGIN
            IF xFieldDefList.FieldDefs[i].Name = ICampoFinal THEN
            BEGIN
               WITH FieldDefs.AddFieldDef DO
               BEGIN
                  DataType := ftString; // Todo a string
                  IF xFieldDefList.FieldDefs[i].DataType = ftString THEN
                     Size := xFieldDefList.FieldDefs[i].Size
                  ELSE
                     Size := 10;
                  Size := Size + length(ISep);
                  IF xFieldDefList.FieldDefs[xFieldDefList.Find(ICampoOmitir).Index].DataType = ftString THEN
                     Size := Size + xFieldDefList.FieldDefs[xFieldDefList.Find(ICampoOmitir).Index].Size
                  ELSE
                     Size := Size + 10;
                  Name := xFieldDefList.FieldDefs[i].Name;
               END;
            END
            ELSE
               IF xFieldDefList.FieldDefs[i].Name <> ICampoOmitir THEN
               BEGIN
                  WITH FieldDefs.AddFieldDef DO
                  BEGIN
                     DataType := xFieldDefList.FieldDefs[i].DataType; // los demas conservan su tipo de dato
                     Size := xFieldDefList.FieldDefs[i].Size;
                     Name := xFieldDefList.FieldDefs[i].Name;
                  END;
               END;
         END;
         CreateDataSet;
      END;
   END;

   PROCEDURE copiarDxs(ICampoFinal, ICampoOmitir, ISep: STRING);
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      xFieldDefList := cdsPrincipal.FieldDefList;
      cdsPrincipal.First;
      WHILE NOT cdsPrincipal.Eof DO
      BEGIN
         cdsRespaldo.Append;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
         BEGIN
            IF xFieldDefList.FieldDefs[i].Name = ICampoFinal THEN
               cdsRespaldo.FieldByName(xFieldDefList[i].Name).Value :=
                  cdsPrincipal.FieldByName(xFieldDefList[i].Name).AsString + STRING(ISep) + cdsPrincipal.FieldByName(ICampoOmitir).AsString
            ELSE
               IF xFieldDefList.FieldDefs[i].Name <> ICampoOmitir THEN
                  cdsRespaldo.FieldByName(xFieldDefList[i].Name).Value :=
                     cdsPrincipal.FieldByName(xFieldDefList[i].Name).value;

         END;
         cdsRespaldo.Post;
         cdsPrincipal.Next;
      END;
   END;

BEGIN
   copiarCabecera(iPriColumna, iSegColumna, iSeparador);
   copiarDxs(iPriColumna, iSegColumna, iSeparador);
   recargarDxsPrincipal();
   seleccionarColumna(iPriColumna);
END;
(******************************************************************************)

FUNCTION TFImpDBF.obtenerSepUnionColumnas(): STRING;
VAR
   xSeparador: STRING;
BEGIN
   CASE rgTipoSep.ItemIndex OF
      0: xSeparador := '';
      1: xSeparador := ' ';
      2: xSeparador := edSepUnionCol.Text;
   END;

   result := xSeparador;
END;
(******************************************************************************)

PROCEDURE TFImpDBF.btnUnirAntClick(Sender: TObject);
VAR
   xNroAntColumna: integer;
BEGIN
   //Inicio: HPP_200902_PRCB
   Screen.Cursor := crHourGlass;
   xNroAntColumna := cdsPrincipal.FieldDefs.Find(xColumnaActiva).Index - 1; // siempre es 1 mas
   unirColumnas(cdsPrincipal.FieldDefs[xNroAntColumna].Name, xColumnaActiva, obtenerSepUnionColumnas);
   Screen.Cursor := crDefault;
   //Fin: HPP_200902_PRCB
END;
(******************************************************************************)

PROCEDURE TFImpDBF.btnUnirSigClick(Sender: TObject);
VAR
   xNroSigColumna: integer;
   xSigColumna: STRING;
BEGIN
   //Inicio: HPP_200902_PRCB
   Screen.Cursor := crHourGlass;
   xNroSigColumna := cdsPrincipal.FieldDefs.Find(xColumnaActiva).Index + 1; // siempre es 1 mas
   unirColumnas(xColumnaActiva, cdsPrincipal.FieldDefs[xNroSigColumna].Name, obtenerSepUnionColumnas);
   Screen.Cursor := crDefault;
   //Fin: HPP_200902_PRCB
END;
(******************************************************************************)

PROCEDURE TFImpDBF.btnEliminarColumnaClick(Sender: TObject);

   PROCEDURE copiarCabecera();
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      WITH cdsRespaldo DO
      BEGIN
         close;
         FieldDefs.Clear;
         xFieldDefList := cdsPrincipal.FieldDefList;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
            IF xFieldDefList.FieldDefs[i].Name <> xColumnaActiva THEN
               WITH FieldDefs.AddFieldDef DO
               BEGIN
                  DataType := xFieldDefList.FieldDefs[i].DataType;
                  Size := xFieldDefList.FieldDefs[i].Size;
                  Name := xFieldDefList.FieldDefs[i].Name;
               END;
         CreateDataSet;
      END;
   END;

   PROCEDURE copiarDxs();
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      xFieldDefList := cdsPrincipal.FieldDefList;
      cdsPrincipal.First;
      WHILE NOT cdsPrincipal.Eof DO
      BEGIN
         cdsRespaldo.Append;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
            IF xFieldDefList.FieldDefs[i].Name <> xColumnaActiva THEN
               cdsRespaldo.FieldByName(xFieldDefList[i].Name).Value := cdsPrincipal.FieldByName(xFieldDefList[i].Name).Value;
         cdsRespaldo.Post;
         cdsPrincipal.Next;
      END;
   END;

BEGIN
   Screen.Cursor := crHourGlass;
   copiarCabecera();
   copiarDxs();
   recargarDxsPrincipal();
   seleccionarColumna();
   Screen.Cursor := crDefault;
END;

(******************************************************************************)

FUNCTION TFImpDBF.isCargoPrevio(IMTxt: TMemo; IIsProcesar: boolean = true): boolean;
VAR
   i: integer;
   xLine: STRING;
   xFormato: STRING;
   xSw: boolean;
BEGIN
   xSw := true;
   IMTxt.Font.Name := 'Courier New'; // para que salga alineado
   IMTxt.Lines.Clear;
   cdsPrincipal.First;
   WHILE NOT cdsPrincipal.Eof DO
   BEGIN
      xline := '';
      FOR I := 0 TO cdsPrincipal.FieldDefs.Count - 1 DO
      BEGIN
         IF cdsPrincipal.FieldDefs[i].DataType = ftString THEN
            xFormato := '%-' + inttostr(cdsPrincipal.FieldDefs[i].Size + 1) + '.' + inttostr(cdsPrincipal.FieldDefs[i].Size + 1) + 'S'
         ELSE
            xFormato := '%11.11S';
         xline := xline + format(xFormato, [cdsPrincipal.FieldByName(cdsPrincipal.FieldDefs[i].Name).AsString + ' ']);
      END;
      IF (length(xline) > 115) AND xSw THEN // 250
      BEGIN
         xSw := false;
         showmessage('Las lineas no pueden Exceder de 115 caracteres, Redusca el ancho de las columnas!');
         IF IIsProcesar THEN
         BEGIN
            result := false;
            exit;
         END;
      END;
      IMTxt.Lines.Add(xline);
      cdsPrincipal.Next;
   END;
   result := true;
END;
(******************************************************************************)

PROCEDURE TFImpDBF.btnprocesarClick(Sender: TObject);
BEGIN
   Screen.Cursor := crHourGlass;
   IF isCargoPrevio(MTxt, true) THEN
   BEGIN
      deleteFile(xArchivoGenerarTxt);
      MTxt.Lines.SaveToFile(xArchivoGenerarTxt);
      ModalResult := mrOk;
   END;
   Screen.Cursor := crDefault;
END;

(******************************************************************************)

PROCEDURE TFImpDBF.dbgPrincipalCalcTitleAttributes(Sender: TObject;
   AFieldName: STRING; AFont: TFont; ABrush: TBrush;
   VAR ATitleAlignment: TAlignment);
BEGIN
   IF uppercase(AFieldName) = cdsPrincipal.FieldDefs.Find(xColumnaActiva).Name THEN
      AFont.Color := clRed
   ELSE
      AFont.Color := clBlack //clWhite;
END;

(******************************************************************************)

PROCEDURE TFImpDBF.bbtnVerPrevioClick(Sender: TObject);
BEGIN
   Screen.Cursor := crHourGlass;
   FVistaPreviaTXT := TFVistaPreviaTXT.create(self);
   TRY
      IF isCargoPrevio(FVistaPreviaTXT.MTxt, false) THEN
         FVistaPreviaTXT.showmodal;
   FINALLY
      FVistaPreviaTXT.Free;
   END;
   Screen.Cursor := crDefault;
END;

(******************************************************************************)

PROCEDURE TFImpDBF.btnSalirClick(Sender: TObject);
BEGIN
   close;
END;

(******************************************************************************)

PROCEDURE TFImpDBF.btnAplicarAnchoColumnaClick(Sender: TObject);

   PROCEDURE copiarCabecera();
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      WITH cdsRespaldo DO
      BEGIN
         close;
         FieldDefs.Clear;
         xFieldDefList := cdsPrincipal.FieldDefList;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
         BEGIN
            WITH FieldDefs.AddFieldDef DO
            BEGIN
               DataType := xFieldDefList.FieldDefs[i].DataType;
               IF xFieldDefList.FieldDefs[i].Name = xColumnaActiva THEN
                  Size := seAnchoColumna.Value
               ELSE
                  Size := xFieldDefList.FieldDefs[i].Size;
               Name := xFieldDefList.FieldDefs[i].Name;
            END;
         END;
         CreateDataSet;
      END;
   END;

   PROCEDURE copiarDxs();
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      xFieldDefList := cdsPrincipal.FieldDefList;
      cdsPrincipal.First;
      WHILE NOT cdsPrincipal.Eof DO
      BEGIN
         cdsRespaldo.Append;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
            cdsRespaldo.FieldByName(xFieldDefList[i].Name).Value := cdsPrincipal.FieldByName(xFieldDefList[i].Name).Value;
         cdsRespaldo.Post;
         cdsPrincipal.Next;
      END;
   END;
BEGIN
   Screen.Cursor := crHourGlass;
   copiarCabecera();
   copiarDxs();
   recargarDxsPrincipal();
   seleccionarColumna(xColumnaActiva);
   Screen.Cursor := crDefault;
END;

(******************************************************************************)

PROCEDURE TFImpDBF.moverColumnas(iPriColumna, iSegColumna: STRING);

   PROCEDURE copiarCabecera(iPri, iSeg: STRING);
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      WITH cdsRespaldo DO
      BEGIN
         close;
         FieldDefs.Clear;
         xFieldDefList := cdsPrincipal.FieldDefList;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
         BEGIN
            WITH FieldDefs.AddFieldDef DO
            BEGIN
               IF xFieldDefList.FieldDefs[i].Name = iPri THEN
               BEGIN
                  DataType := xFieldDefList.Find(iSeg).DataType;
                  Size := xFieldDefList.Find(iSeg).Size;
                  Name := xFieldDefList.Find(iSeg).Name;
               END
               ELSE
                  IF xFieldDefList.FieldDefs[i].Name = iSeg THEN
                  BEGIN
                     DataType := xFieldDefList.Find(iPri).DataType;
                     Size := xFieldDefList.Find(iPri).Size;
                     Name := xFieldDefList.Find(iPri).Name;
                  END
                  ELSE
                  BEGIN
                     DataType := xFieldDefList.FieldDefs[i].DataType; // los demas conservan su tipo de dato
                     Size := xFieldDefList.FieldDefs[i].Size;
                     Name := xFieldDefList.FieldDefs[i].Name;
                  END;
            END;
         END;
         CreateDataSet;
      END;
   END;

   PROCEDURE copiarDxs(iPri, iSeg: STRING);
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      xFieldDefList := cdsPrincipal.FieldDefList;
      cdsPrincipal.First;
      WHILE NOT cdsPrincipal.Eof DO
      BEGIN
         cdsRespaldo.Append;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
            cdsRespaldo.FieldByName(xFieldDefList[i].Name).Value := cdsPrincipal.FieldByName(xFieldDefList[i].Name).value;
         cdsRespaldo.Post;
         cdsPrincipal.Next;
      END;
   END;

BEGIN
   copiarCabecera(iPriColumna, iSegColumna);
   copiarDxs(iPriColumna, iSegColumna);
   recargarDxsPrincipal();
   seleccionarColumna(xColumnaActiva);
END;

(******************************************************************************)

PROCEDURE TFImpDBF.btnMoverIzdaClick(Sender: TObject);
VAR
   xNroAntColumna: integer;
BEGIN
   Screen.Cursor := crHourGlass;
   xNroAntColumna := cdsPrincipal.FieldDefs.Find(xColumnaActiva).Index - 1; // siempre es 1 mas
   moverColumnas(cdsPrincipal.FieldDefs[xNroAntColumna].Name, xColumnaActiva);
   Screen.Cursor := crDefault;
END;

(******************************************************************************)

PROCEDURE TFImpDBF.btnMoverDrchClick(Sender: TObject);
VAR
   xNroSigColumna: integer;
   xSigColumna: STRING;
BEGIN
   Screen.Cursor := crHourGlass;
   xNroSigColumna := cdsPrincipal.FieldDefs.Find(xColumnaActiva).Index + 1; // siempre es 1 mas
   moverColumnas(xColumnaActiva, cdsPrincipal.FieldDefs[xNroSigColumna].Name);
   Screen.Cursor := crDefault;
END;

(******************************************************************************)

PROCEDURE TFImpDBF.dbgPrincipalColumnMoved(Sender: TObject; FromIndex,
   ToIndex: Integer);
VAR
   xPri: Integer;
   xSeg: Integer;
BEGIN
(* // no esta funcionando bien
   IF ToIndex = 0 THEN
      xPri := 0
   ELSE
      IF ToIndex = cdsPrincipal.FieldDefs.Count - 1 THEN
         xPri := cdsPrincipal.FieldDefs.Count - 2
      ELSE
         xPri := ToIndex;

   moverColumnas(cdsPrincipal.FieldDefs[xPri].Name, cdsPrincipal.FieldDefs[FromIndex].Name);
*)
END;

(******************************************************************************)

PROCEDURE TFImpDBF.btnCompletarDataClick(Sender: TObject);
VAR
   xSQL: STRING;
   xCantFallo: integer;

   PROCEDURE copiarCabecera();
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      WITH cdsRespaldo DO
      BEGIN
         close;
         FieldDefs.Clear;
         xFieldDefList := cdsPrincipal.FieldDefList;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
         BEGIN
            WITH FieldDefs.AddFieldDef DO
            BEGIN
               DataType := xFieldDefList.FieldDefs[i].DataType;
               Size := xFieldDefList.FieldDefs[i].Size;
               Name := xFieldDefList.FieldDefs[i].Name;
            END;
            IF xFieldDefList.FieldDefs[i].Name = xColumnaActiva THEN
            BEGIN
               WITH FieldDefs.AddFieldDef DO
               BEGIN
                  DataType := ftString;
                  Size := 10;
                  Name := 'ASOCODMOD';
               END;
               WITH FieldDefs.AddFieldDef DO
               BEGIN
                  DataType := ftString;
                  Size := 25;
                  Name := 'ASOCODPAGO';
               END;
               WITH FieldDefs.AddFieldDef DO
               BEGIN
                  DataType := ftString;
                  Size := 6;
                  Name := 'CARGO';
               END;
            END;
         END;
         CreateDataSet;
      END;
   END;

   PROCEDURE copiarDxs();
   VAR
      xFieldDefList: TFieldDefList;
      i: integer;
   BEGIN
      xFieldDefList := cdsPrincipal.FieldDefList;
      cdsPrincipal.First;
      WHILE NOT cdsPrincipal.Eof DO
      BEGIN
         cdsRespaldo.Append;
         FOR i := 0 TO xFieldDefList.Count - 1 DO
            cdsRespaldo.FieldByName(xFieldDefList[i].Name).Value := cdsPrincipal.FieldByName(xFieldDefList[i].Name).Value;
         cdsRespaldo.Post;
         cdsPrincipal.Next;
      END;
   END;
BEGIN
   IF MessageDlg('Confirma que la columna "' + xColumnaActiva + '" corresponde al D.N.I. del Asociado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes THEN
   BEGIN
      Screen.Cursor := crHourGlass;
      copiarCabecera();
      copiarDxs();
      recargarDxsPrincipal();
      seleccionarColumna(xColumnaActiva);
      xCantFallo := 0;
      cdsPrincipal.First;
      WHILE NOT cdsPrincipal.Eof DO
      BEGIN
         xSQL := 'SELECT ASOCODMOD, ASOCODPAGO,ASODNI,CARGO FROM APO201 WHERE ASODNI = LPAD(' + QuotedStr(cdsPrincipal.fieldbyname(xColumnaActiva).AsString) + ',8,0)';
         DMPreCob.cdsQry10.Close;
         DMPreCob.cdsQry10.DataRequest(xSQL);
         DMPreCob.cdsQry10.Open;
         IF DMPreCob.cdsQry10.RecordCount = 1 THEN // si son mas de uno mejor no hacer nada
         BEGIN
            cdsPrincipal.Edit;
            cdsPrincipal.FieldByName(xColumnaActiva).AsString := DMPreCob.cdsQry10.fieldbyname('ASODNI').asstring; // se vuelve a ingresar, xq se pudo haber completado con ceros a la izda
            cdsPrincipal.FieldByName('ASOCODMOD').AsString := DMPreCob.cdsQry10.fieldbyname('ASOCODMOD').asstring;
            cdsPrincipal.FieldByName('ASOCODPAGO').AsString := DMPreCob.cdsQry10.fieldbyname('ASOCODPAGO').asstring;
            cdsPrincipal.FieldByName('CARGO').AsString := DMPreCob.cdsQry10.fieldbyname('CARGO').asstring;            
            cdsPrincipal.Post;
         END
         ELSE
            xCantFallo := xCantFallo + 1;
         cdsPrincipal.Next;
      END;
      lblFallosCompletarData.Visible := true;
      IF xCantFallo > 0 THEN
         lblFallosCompletarData.Caption := inttostr(xCantFallo) + ' Asociados no encontrados.'
      ELSE
         lblFallosCompletarData.Caption := '';
      showmessage('Se completó la Data');
      Screen.Cursor := crDefault;
   END;
END;

(******************************************************************************)

PROCEDURE TFImpDBF.btnExportarClick(Sender: TObject);
BEGIN
   Screen.Cursor := crHourGlass;
   DBGrid.DataSource := dsPrincipal;
   DMPreCob.HojaExcel('Reporte', dsPrincipal, DBGrid);
   Screen.Cursor := crDefault;
END;

(******************************************************************************)

END.

