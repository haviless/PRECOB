object Form1: TForm1
  Left = 138
  Top = 52
  Width = 781
  Height = 722
  Caption = 'DEMO'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 200
    Width = 105
    Height = 57
    Caption = 'GroupBox1'
    TabOrder = 0
    object btnCargarDxs: TButton
      Left = 8
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Cargar Dxs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnCargarDxsClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 125
    Top = 199
    Width = 321
    Height = 282
    Caption = 'Renombrar Columna'
    TabOrder = 1
    object edRenombrarOriginal: TEdit
      Left = 16
      Top = 24
      Width = 273
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object btnRenombrarColumna: TButton
      Left = 16
      Top = 72
      Width = 137
      Height = 25
      Caption = 'Renombrar Columna'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnRenombrarColumnaClick
    end
    object edRenombrarModificado: TEdit
      Left = 16
      Top = 48
      Width = 273
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 104
      Width = 297
      Height = 121
      Caption = 'Unir Columnas'
      TabOrder = 3
      object Label1: TLabel
        Left = 216
        Top = 24
        Width = 20
        Height = 13
        Caption = 'Otro'
      end
      object btnUnirAnt: TButton
        Left = 16
        Top = 88
        Width = 137
        Height = 25
        Caption = '<- Columna Izquierda'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnUnirAntClick
      end
      object btnUnirSig: TButton
        Left = 155
        Top = 88
        Width = 137
        Height = 25
        Caption = 'Columna Derecha ->'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnUnirSigClick
      end
      object rgTipoSep: TRadioGroup
        Left = 8
        Top = 16
        Width = 185
        Height = 65
        Caption = 'Separado Por'
        ItemIndex = 0
        Items.Strings = (
          'Sin Separador'
          'Espacion en Blanco'
          'Otros')
        TabOrder = 2
        OnClick = rgTipoSepClick
      end
      object edSepUnionCol: TEdit
        Left = 248
        Top = 24
        Width = 41
        Height = 21
        Enabled = False
        TabOrder = 3
      end
    end
    object btnEliminarColumna: TButton
      Left = 40
      Top = 240
      Width = 137
      Height = 25
      Caption = 'Eliminar Columna'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnEliminarColumnaClick
    end
  end
  object dbgPrincipal: TwwDBGrid
    Left = 0
    Top = 0
    Width = 773
    Height = 185
    DisableThemesInTitle = False
    IniAttributes.Delimiter = ';;'
    TitleColor = 10207162
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alTop
    DataSource = dsPrincipal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    KeyOptions = []
    Options = [dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFooter3DCells]
    ParentFont = False
    TabOrder = 2
    TitleAlignment = taCenter
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    TitleLines = 2
    TitleButtons = True
    OnTitleButtonClick = dbgPrincipalTitleButtonClick
    FooterColor = clSilver
    FooterCellColor = clBtnHighlight
    PaintOptions.AlternatingRowRegions = [arrDataColumns, arrActiveDataColumn]
    PaintOptions.AlternatingRowColor = 14342874
  end
  object wwDBGrid1: TwwDBGrid
    Left = 0
    Top = 501
    Width = 773
    Height = 194
    DisableThemesInTitle = False
    IniAttributes.Delimiter = ';;'
    TitleColor = 10207162
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alBottom
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    KeyOptions = []
    Options = [dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFooter3DCells]
    ParentFont = False
    TabOrder = 3
    TitleAlignment = taCenter
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    TitleLines = 2
    TitleButtons = True
    OnTitleButtonClick = dbgPrincipalTitleButtonClick
    FooterColor = clSilver
    FooterCellColor = clBtnHighlight
    PaintOptions.AlternatingRowRegions = [arrDataColumns, arrActiveDataColumn]
    PaintOptions.AlternatingRowColor = 14342874
  end
  object dsPrincipal: TDataSource
    DataSet = cdsPrincipal
    Left = 144
    Top = 144
  end
  object cdsPrincipal: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 144
    Top = 112
  end
  object odLeer: TOpenDialog
    Options = [ofReadOnly, ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 662
    Top = 33
  end
  object cdsRespaldo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 112
  end
  object tFuente: TTable
    Left = 144
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = cdsRespaldo
    Left = 304
    Top = 544
  end
  object SimpleDataSet1: TSimpleDataSet
    Aggregates = <>
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 544
    Top = 248
  end
end
