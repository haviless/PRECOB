object FImpDBF: TFImpDBF
  Left = 271
  Top = 119
  BorderStyle = bsSingle
  Caption = 'Migrar informaci'#243'n DBF'
  ClientHeight = 546
  ClientWidth = 941
  Color = 10207162
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 0
    Top = 272
    Width = 941
    Height = 274
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      941
      274)
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 116
      Height = 16
      Caption = 'Columna Activa :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edRenombrarOriginal: TEdit
      Left = 129
      Top = 13
      Width = 273
      Height = 24
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object GroupBox3: TGroupBox
      Left = 232
      Top = 48
      Width = 363
      Height = 119
      Caption = 'Unir Dos Columnas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object btnUnirAnt: TButton
        Left = 5
        Top = 89
        Width = 175
        Height = 25
        Caption = '<- Con la Columna Izquierda'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnUnirAntClick
      end
      object btnUnirSig: TButton
        Left = 183
        Top = 89
        Width = 175
        Height = 25
        Caption = 'Con la Columna Derecha ->'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnUnirSigClick
      end
      object rgTipoSep: TRadioGroup
        Left = 5
        Top = 12
        Width = 353
        Height = 73
        Ctl3D = True
        ItemIndex = 1
        Items.Strings = (
          'Sin Separador'
          'Separado por un Espacion en Blanco'
          'Otro Separador')
        ParentCtl3D = False
        TabOrder = 2
        OnClick = rgTipoSepClick
      end
      object edSepUnionCol: TEdit
        Left = 121
        Top = 60
        Width = 41
        Height = 21
        Enabled = False
        TabOrder = 3
      end
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 48
      Width = 217
      Height = 69
      Caption = 'Renombrar Columna Activa'
      Color = 10207162
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 2
      object edRenombrarModificado: TEdit
        Left = 8
        Top = 15
        Width = 201
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 30
        TabOrder = 0
      end
      object btnRenombrarColumna: TButton
        Left = 9
        Top = 39
        Width = 201
        Height = 25
        Caption = 'Renombrar Columna'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnRenombrarColumnaClick
      end
    end
    object btnprocesar: TBitBtn
      Left = 810
      Top = 199
      Width = 120
      Height = 28
      Anchors = [akRight, akBottom]
      Caption = 'Procesar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnProcesarClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00370777033333
        3330337F3F7F33333F3787070003333707303F737773333373F7007703333330
        700077337F3333373777887007333337007733F773F333337733700070333333
        077037773733333F7F37703707333300080737F373333377737F003333333307
        78087733FFF3337FFF7F33300033330008073F3777F33F777F73073070370733
        078073F7F7FF73F37FF7700070007037007837773777F73377FF007777700730
        70007733FFF77F37377707700077033707307F37773F7FFF7337080777070003
        3330737F3F7F777F333778080707770333333F7F737F3F7F3333080787070003
        33337F73FF737773333307800077033333337337773373333333}
      NumGlyphs = 2
    end
    object btnSalir: TBitBtn
      Left = 810
      Top = 230
      Width = 120
      Height = 28
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnSalirClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F3333333F7F333301111111B10333337F333333737F33330111111111
        0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
        0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
        0333337F377777337F333301111111110333337F333333337F33330111111111
        0333337FFFFFFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
    end
    object GroupBox5: TGroupBox
      Left = 8
      Top = 122
      Width = 217
      Height = 46
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object btnEliminarColumna: TButton
        Left = 8
        Top = 13
        Width = 201
        Height = 25
        Caption = ' Eliminar Columna Activa'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnEliminarColumnaClick
      end
    end
    object GroupBox6: TGroupBox
      Left = 8
      Top = 170
      Width = 217
      Height = 49
      Caption = 'Mover Columna'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object btnMoverIzda: TButton
        Left = 7
        Top = 16
        Width = 102
        Height = 25
        Caption = '<- A la Izquierda'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnMoverIzdaClick
      end
      object btnMoverDrch: TButton
        Left = 111
        Top = 16
        Width = 102
        Height = 25
        Caption = 'A la Derecha ->'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnMoverDrchClick
      end
    end
    object bbtnVerPrevio: TBitBtn
      Left = 810
      Top = 171
      Width = 120
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Vistra Previa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = bbtnVerPrevioClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
        3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
        33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
        333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
    end
    object GroupBox7: TGroupBox
      Left = 8
      Top = 220
      Width = 217
      Height = 49
      Caption = 'Recortar Ancho de la Columna'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object btnAplicarAnchoColumna: TButton
        Left = 87
        Top = 19
        Width = 74
        Height = 25
        Caption = 'Aplicar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnAplicarAnchoColumnaClick
      end
      object seAnchoColumna: TSpinEdit
        Left = 16
        Top = 19
        Width = 65
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
    end
    object GroupBox8: TGroupBox
      Left = 232
      Top = 170
      Width = 362
      Height = 99
      Caption = 'Completar Data (Codigo Modular, Codigo de Pago y Cargo)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      object lblFallosCompletarData: TLabel
        Left = 8
        Top = 80
        Width = 165
        Height = 16
        Caption = 'lblFallosCompletarData'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object btnCompletarData: TButton
        Left = 104
        Top = 43
        Width = 153
        Height = 25
        Caption = 'Completar Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnCompletarDataClick
      end
    end
    object btnExportar: TBitBtn
      Left = 810
      Top = 142
      Width = 120
      Height = 26
      Anchors = [akRight, akBottom]
      Caption = 'A Excel'
      TabOrder = 10
      OnClick = btnExportarClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
        FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
        00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
        F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
        00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
        F033777777777337F73309999990FFF0033377777777FFF77333099999000000
        3333777777777777333333399033333333333337773333333333333903333333
        3333333773333333333333303333333333333337333333333333}
      NumGlyphs = 2
    end
    object DBGrid: TDBGrid
      Left = 842
      Top = 15
      Width = 83
      Height = 33
      TabOrder = 11
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Visible = False
    end
  end
  object MTxt: TMemo
    Left = 840
    Top = 320
    Width = 89
    Height = 41
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 672
    Top = 304
    Width = 105
    Height = 57
    Caption = 'GroupBox1'
    TabOrder = 2
    Visible = False
    object btnCargarDxs: TButton
      Left = 0
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
  object dbgPrincipal: TwwDBGrid
    Left = 0
    Top = 0
    Width = 941
    Height = 272
    DisableThemesInTitle = False
    IniAttributes.Delimiter = ';;'
    TitleColor = 10207162
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = dsPrincipal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    KeyOptions = []
    Options = [dgAlwaysShowEditor, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgFooter3DCells]
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    TitleAlignment = taCenter
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    TitleLines = 2
    TitleButtons = True
    OnCalcTitleAttributes = dbgPrincipalCalcTitleAttributes
    OnTitleButtonClick = dbgPrincipalTitleButtonClick
    OnColumnMoved = dbgPrincipalColumnMoved
    FooterColor = clSilver
    FooterCellColor = clBtnHighlight
    PadColumnStyle = pcsPadHeader
    PaintOptions.AlternatingRowRegions = [arrDataColumns, arrActiveDataColumn]
    PaintOptions.AlternatingRowColor = 14342874
  end
  object tFuente: TTable
    Left = 144
    Top = 80
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
  object dsPrincipal: TDataSource
    DataSet = cdsPrincipal
    Left = 144
    Top = 144
  end
  object cdsRespaldo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 112
  end
  object odLeer: TOpenDialog
    Options = [ofReadOnly, ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 742
    Top = 289
  end
end
