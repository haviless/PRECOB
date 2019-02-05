Unit UDEMO;

Interface

Uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Grids, ExtCtrls, DBGrids, DB,
    DBClient, DBTables, Wwdbigrd, Wwdbgrid, wwclient, SimpleDS; //HPP_200902_PRCB

Type
    TForm1 = Class(TForm)
        dsPrincipal: TDataSource;
        cdsPrincipal: TClientDataSet;
        odLeer: TOpenDialog;
        cdsRespaldo: TClientDataSet;
        tFuente: TTable;
        GroupBox1: TGroupBox;
        btnCargarDxs: TButton;
        GroupBox2: TGroupBox;
        edRenombrarOriginal: TEdit;
        btnRenombrarColumna: TButton;
        edRenombrarModificado: TEdit;
        dbgPrincipal: TwwDBGrid;
        GroupBox3: TGroupBox;
        btnUnirAnt: TButton;
        btnUnirSig: TButton;
        Label1: TLabel;
        rgTipoSep: TRadioGroup;
        edSepUnionCol: TEdit;
    btnEliminarColumna: TButton;
    wwDBGrid1: TwwDBGrid;
    DataSource1: TDataSource;
    SimpleDataSet1: TSimpleDataSet;
        Procedure btnCargarDxsClick(Sender: TObject);
        Procedure dbgPrincipalTitleButtonClick(Sender: TObject;
            AFieldName: String);
        Procedure btnRenombrarColumnaClick(Sender: TObject);
        Procedure rgTipoSepClick(Sender: TObject);
        Procedure btnUnirAntClick(Sender: TObject);
        Procedure btnUnirSigClick(Sender: TObject);
        Procedure btnEliminarColumnaClick(Sender: TObject);
    Private
        xColumnaActiva: String;
        xFileRespaldo: String;
        Procedure cargarDatos(iArchivo: String);
        Procedure seleccionarColumna(iColum: String = '');
        Procedure recargarDxsPrincipal;
        Procedure unirColumnas(iPriColumna, iSegColumna, iSeparador: String);
        Function obtenerSepUnionColumnas: String;
    { Private declarations }
    Public
    { Public declarations }
    End;

Var
    Form1: TForm1;

Implementation
Uses CARDM1;
{$R *.dfm}

(******************************************************************************)

Procedure TForm1.btnCargarDxsClick(Sender: TObject);
Begin
    odLeer.Title := 'Leer DBF para Vista Previa';
    odLeer.DefaultExt := '*.DBF';
    odLeer.Filter := 'Archivos DBFs|*.DBF';
    odLeer.FileName := '';

    If Not odLeer.Execute Then Exit;
    cargarDatos(odLeer.FileName);

End;

(******************************************************************************)

Procedure TForm1.cargarDatos(iArchivo: String);

    Procedure crearCabeceraPrincipal();
    Var
        xFieldDefList: TFieldDefList;
        i: integer;
    Begin
        With cdsPrincipal Do
        Begin
            close;
            FieldDefs.Clear;
            xFieldDefList := tFuente.FieldDefList;
            For i := 0 To xFieldDefList.Count - 1 Do
            Begin
                With FieldDefs.AddFieldDef Do
                Begin
                    DataType := ftString;
                    If xFieldDefList.FieldDefs[i].DataType = ftString Then
                        Size := xFieldDefList.FieldDefs[i].Size
                    Else
                    Begin
                        If (xFieldDefList.FieldDefs[i].DataType = ftFloat)
                            Or (xFieldDefList.FieldDefs[i].DataType = ftInteger)
                            Or (xFieldDefList.FieldDefs[i].DataType = ftDate)
                            Or (xFieldDefList.FieldDefs[i].DataType = ftSmallint) Then
                            Size := 15
                        Else
                            Size := 100;
                    End;
                    Name := xFieldDefList.FieldDefs[i].Name;
                End;
            End;
            CreateDataSet;
        End;
    End;

    Procedure cargarDxs();
    Var
        xFieldDefList: TFieldDefList;
        i: integer;
    Begin
        xFieldDefList := tFuente.FieldDefList;
        tFuente.First;
        While Not tFuente.Eof Do
        Begin
            cdsPrincipal.Append;
            For i := 0 To xFieldDefList.Count - 1 Do
                cdsPrincipal.FieldByName(xFieldDefList[i].Name).Value := tFuente.FieldByName(xFieldDefList[i].Name).AsString;
            cdsPrincipal.Post;
            tFuente.Next;
        End;
    End;
Begin
    xFileRespaldo := 'c:\tmpPrecobRespaldo.xml';
    deleteFile(xFileRespaldo);
    Try
        tFuente.Close;
        tFuente.TableName := iArchivo;
        tFuente.Open;
    Except
        showmessage('Por favor verifique que el archivo no este dañado');
        exit;
    End;
    crearCabeceraPrincipal();
    cargarDxs();
    seleccionarColumna();
End;

(******************************************************************************)

Procedure TForm1.dbgPrincipalTitleButtonClick(Sender: TObject;
    AFieldName: String);
Begin
    seleccionarColumna(AFieldName);
End;

(******************************************************************************)

Procedure TForm1.seleccionarColumna(iColum: String);
    Procedure activarCtrls(INombre: String);
    Begin
        xColumnaActiva := INombre; // variable global
        btnEliminarColumna.Enabled := cdsPrincipal.FieldDefs.Count>1;
        btnRenombrarColumna.Enabled := true;
        edRenombrarOriginal.Text := cdsPrincipal.FieldDefs.Find(xColumnaActiva).name;
        edRenombrarModificado.Text := '';

        btnUnirSig.Enabled := cdsPrincipal.FieldDefs.Find(xColumnaActiva).Index < cdsPrincipal.FieldDefs.Count - 1;
        btnUnirAnt.Enabled := cdsPrincipal.FieldDefs.Find(xColumnaActiva).Index > 0;

    End;
Begin
    If iColum <> '' Then
        activarCtrls(iColum)
    Else
    Begin
        If cdsPrincipal.FieldDefs.Count > 0 Then
            activarCtrls(cdsPrincipal.FieldDefs[0].name)
        Else
        Begin
            xColumnaActiva := '';
            btnEliminarColumna.Enabled := false;
            btnRenombrarColumna.Enabled := false;
            edRenombrarOriginal.Text := '';
            edRenombrarModificado.Text := '';
            btnUnirSig.Enabled := false;
            btnUnirAnt.Enabled := false;
        End;
    End;
End;

(******************************************************************************)

Procedure TForm1.recargarDxsPrincipal();
Begin
    deleteFile(xFileRespaldo);
    cdsRespaldo.SaveToFile(xFileRespaldo);
    cdsPrincipal.Close;
    cdsPrincipal.LoadFromFile(xFileRespaldo);
    cdsPrincipal.Open;
End;

(******************************************************************************)

Procedure TForm1.btnRenombrarColumnaClick(Sender: TObject);
    Procedure copiarCabecera(ICampoRenombrar: String);
    Var
        xFieldDefList: TFieldDefList;
        i: integer;
    Begin
        With cdsRespaldo Do
        Begin
            close;
            FieldDefs.Clear;
            xFieldDefList := cdsPrincipal.FieldDefList;
            For i := 0 To xFieldDefList.Count - 1 Do
            Begin
                With FieldDefs.AddFieldDef Do
                Begin
                    DataType := ftString;
                    Size := xFieldDefList.FieldDefs[i].Size;
                    If xFieldDefList.FieldDefs[i].Name = xColumnaActiva Then
                        Name := ICampoRenombrar
                    Else
                        Name := xFieldDefList.FieldDefs[i].Name;
                End;
            End;
            CreateDataSet;
        End;
    End;

    Procedure copiarDxs(ICampoRenombrar: String);
    Var
        xFieldDefList: TFieldDefList;
        i: integer;
    Begin
        xFieldDefList := cdsPrincipal.FieldDefList;
        cdsPrincipal.First;
        While Not cdsPrincipal.Eof Do
        Begin
            cdsRespaldo.Append;
            For i := 0 To xFieldDefList.Count - 1 Do
            Begin
                If xFieldDefList.FieldDefs[i].Name = xColumnaActiva Then
                    cdsRespaldo.FieldByName(ICampoRenombrar).Value := cdsPrincipal.FieldByName(xFieldDefList[i].Name).AsString
                Else
                    cdsRespaldo.FieldByName(xFieldDefList[i].Name).Value := cdsPrincipal.FieldByName(xFieldDefList[i].Name).AsString;

            End;
            cdsRespaldo.Post;
            cdsPrincipal.Next;
        End;
    End;

Begin
    If trim(edRenombrarModificado.Text) <> '' Then
    Begin
        copiarCabecera(edRenombrarModificado.Text);
        copiarDxs(edRenombrarModificado.Text);
        recargarDxsPrincipal();
        seleccionarColumna(edRenombrarModificado.Text);
    End
    Else
        showmessage('Por favor ingres un Nombre para la Columna');
End;

(******************************************************************************)

Procedure TForm1.rgTipoSepClick(Sender: TObject);
Begin
    edSepUnionCol.Enabled := rgTipoSep.ItemIndex = 2;
    If edSepUnionCol.Enabled Then edSepUnionCol.Focused;
End;

(******************************************************************************)

Procedure TForm1.unirColumnas(iPriColumna, iSegColumna, iSeparador: String);
Var
    bmk: TBookmark;

    Procedure copiarCabecera(ICampoFinal, ICampoOmitir, ISep: String);
    Var
        xFieldDefList: TFieldDefList;
        i: integer;
    Begin
        With cdsRespaldo Do
        Begin
            close;
            FieldDefs.Clear;
            xFieldDefList := cdsPrincipal.FieldDefList;
            For i := 0 To xFieldDefList.Count - 1 Do
            Begin
                If xFieldDefList.FieldDefs[i].Name = ICampoFinal Then
                Begin
                    With FieldDefs.AddFieldDef Do
                    Begin
                        DataType := ftString;
                        Size := xFieldDefList.FieldDefs[i].Size + length(ISep) + xFieldDefList.FieldDefs[xFieldDefList.Find(ICampoOmitir).Index].Size;
                        Name := xFieldDefList.FieldDefs[i].Name;
                    End;
                End
                Else
                    If xFieldDefList.FieldDefs[i].Name <> ICampoOmitir Then
                    Begin
                        With FieldDefs.AddFieldDef Do
                        Begin
                            DataType := ftString;
                            Size := xFieldDefList.FieldDefs[i].Size;
                            Name := xFieldDefList.FieldDefs[i].Name;
                        End;
                    End;
            End;
            CreateDataSet;
        End;
    End;

    Procedure copiarDxs(ICampoFinal, ICampoOmitir, ISep: String);
    Var
        xFieldDefList: TFieldDefList;
        i: integer;
    Begin
        xFieldDefList := cdsPrincipal.FieldDefList;
        cdsPrincipal.First;
        While Not cdsPrincipal.Eof Do
        Begin
            cdsRespaldo.Append;
            For i := 0 To xFieldDefList.Count - 1 Do
            Begin
                If xFieldDefList.FieldDefs[i].Name = ICampoFinal Then
                    cdsRespaldo.FieldByName(xFieldDefList[i].Name).Value :=
                        cdsPrincipal.FieldByName(xFieldDefList[i].Name).AsString + ISep + cdsPrincipal.FieldByName(ICampoOmitir).AsString
                Else
                    If xFieldDefList.FieldDefs[i].Name <> ICampoOmitir Then
                        cdsRespaldo.FieldByName(xFieldDefList[i].Name).Value :=
                            cdsPrincipal.FieldByName(xFieldDefList[i].Name).AsString;

            End;
            cdsRespaldo.Post;
            cdsPrincipal.Next;
        End;
    End;

Begin
    bmk := cdsPrincipal.GetBookmark;
    copiarCabecera(iPriColumna, iSegColumna, iSeparador);
    copiarDxs(iPriColumna, iSegColumna, iSeparador);
    recargarDxsPrincipal();
    cdsPrincipal.GotoBookmark(bmk);
    cdsPrincipal.FreeBookmark(bmk);
    seleccionarColumna(iPriColumna);
End;
(******************************************************************************)
Function TForm1.obtenerSepUnionColumnas(): String;
Var
    xSeparador: String;
Begin
    Case rgTipoSep.ItemIndex Of
        0: xSeparador := '';
        1: xSeparador := ' ';
        2: xSeparador := edSepUnionCol.Text;
    End;

    result := xSeparador;
End;
(******************************************************************************)
Procedure TForm1.btnUnirAntClick(Sender: TObject);
Var
    xNroAntColumna: integer;
Begin
    xNroAntColumna := cdsPrincipal.FieldDefs.Find(xColumnaActiva).Index - 1; // siempre es 1 mas
    unirColumnas(cdsPrincipal.FieldDefs[xNroAntColumna].Name, xColumnaActiva, obtenerSepUnionColumnas);

End;
(******************************************************************************)
Procedure TForm1.btnUnirSigClick(Sender: TObject);
Var
    xNroSigColumna: integer;
    xSigColumna: String;
Begin
    xNroSigColumna := cdsPrincipal.FieldDefs.Find(xColumnaActiva).Index + 1; // siempre es 1 mas
    unirColumnas(xColumnaActiva, cdsPrincipal.FieldDefs[xNroSigColumna].Name, obtenerSepUnionColumnas);
End;
(******************************************************************************)
Procedure TForm1.btnEliminarColumnaClick(Sender: TObject);
    Procedure copiarCabecera();
    Var
        xFieldDefList: TFieldDefList;
        i: integer;
    Begin
        With cdsRespaldo Do
        Begin
            close;
            FieldDefs.Clear;
            xFieldDefList := cdsPrincipal.FieldDefList;
            For i := 0 To xFieldDefList.Count - 1 Do
                If xFieldDefList.FieldDefs[i].Name <> xColumnaActiva Then
                    With FieldDefs.AddFieldDef Do
                    Begin
                        DataType := ftString;
                        Size := xFieldDefList.FieldDefs[i].Size;
                        Name := xFieldDefList.FieldDefs[i].Name;
                    End;
            CreateDataSet;
        End;
    End;

    Procedure copiarDxs();
    Var
        xFieldDefList: TFieldDefList;
        i: integer;
    Begin
        xFieldDefList := cdsPrincipal.FieldDefList;
        cdsPrincipal.First;
        While Not cdsPrincipal.Eof Do
        Begin
            cdsRespaldo.Append;
            For i := 0 To xFieldDefList.Count - 1 Do
                If xFieldDefList.FieldDefs[i].Name <> xColumnaActiva Then
                    cdsRespaldo.FieldByName(xFieldDefList[i].Name).Value := cdsPrincipal.FieldByName(xFieldDefList[i].Name).AsString;
            cdsRespaldo.Post;
            cdsPrincipal.Next;
        End;
    End;

Begin
    copiarCabecera();
    copiarDxs();
    recargarDxsPrincipal();
    seleccionarColumna();
End;
(******************************************************************************)
End.

