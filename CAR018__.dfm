object FEnvVsRep: TFEnvVsRep
  Left = 19
  Top = 71
  Width = 984
  Height = 616
  Caption = 'Enviados - Descargo Global'
  Color = 10207162
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  DesignSize = (
    976
    589)
  PixelsPerInch = 96
  TextHeight = 13
  object lblNroRegistros: TLabel
    Left = 8
    Top = 526
    Width = 139
    Height = 13
    Caption = '0 Registros encontrados'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 184
    Top = 554
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 6
    Visible = False
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 216
    Top = 562
    Width = 641
    Height = 25
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 976
    Height = 68
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 12
      Top = 14
      Width = 100
      Height = 13
      Caption = 'Tipo de Asociado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 90
      Top = 38
      Width = 23
      Height = 13
      Caption = 'A'#241'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 183
      Top = 38
      Width = 24
      Height = 13
      Caption = 'Mes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnprocesar: TBitBtn
      Left = 340
      Top = 34
      Width = 78
      Height = 28
      Caption = 'Procesar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnprocesarClick
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
    object seano: TSpinEdit
      Left = 116
      Top = 34
      Width = 57
      Height = 22
      MaxValue = 2009
      MinValue = 2008
      TabOrder = 1
      Value = 2008
    end
    object semes: TSpinEdit
      Left = 212
      Top = 34
      Width = 57
      Height = 22
      MaxValue = 12
      MinValue = 1
      TabOrder = 2
      Value = 1
    end
    object dblcdasotipid: TwwDBLookupComboDlg
      Left = 116
      Top = 11
      Width = 49
      Height = 21
      CharCase = ecUpperCase
      GridOptions = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgPerfectRowFit]
      GridColor = clWhite
      GridTitleAlignment = taLeftJustify
      Caption = 'Lookup'
      MaxWidth = 0
      MaxHeight = 209
      LookupTable = DM1.cdsTaso
      LookupField = 'ASOTIPID'
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnChange = dblcdasotipidChange
      OnExit = dblcdasotipidExit
    end
    object measotipdes: TMaskEdit
      Left = 166
      Top = 11
      Width = 154
      Height = 21
      Enabled = False
      TabOrder = 4
    end
  end
  object BitBtn1: TBitBtn
    Left = 892
    Top = 559
    Width = 78
    Height = 28
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar'
    TabOrder = 1
    OnClick = BitBtn1Click
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
  object BitBtn3: TBitBtn
    Left = 810
    Top = 559
    Width = 78
    Height = 28
    Anchors = [akRight, akBottom]
    Caption = 'A Excel'
    TabOrder = 2
    OnClick = BitBtn3Click
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
  object pagecontrol: TPageControl
    Left = 0
    Top = 68
    Width = 976
    Height = 488
    ActivePage = TabSheet3
    Align = alTop
    TabOrder = 3
    OnChange = pagecontrolChange
    object TabSheet3: TTabSheet
      Caption = 'Resumen General'
      ImageIndex = 2
      object dbgprevioresgeneral: TwwDBGrid
        Left = 0
        Top = 80
        Width = 968
        Height = 380
        DisableThemesInTitle = False
        IniAttributes.Delimiter = ';;'
        TitleColor = 10207162
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = DM1.dsQry6
        KeyOptions = []
        Options = [dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFooter3DCells]
        TabOrder = 0
        TitleAlignment = taCenter
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        TitleLines = 4
        TitleButtons = True
        OnCalcCellColors = dbgprevioresgeneralCalcCellColors
        OnTitleButtonClick = dbgprevioresgeneralTitleButtonClick
        OnDblClick = dbgprevioresgeneralDblClick
        FooterColor = clSilver
        FooterCellColor = clBtnHighlight
      end
      object gbFiltro: TGroupBox
        Left = 0
        Top = 0
        Width = 968
        Height = 80
        Align = alTop
        Caption = 'Filtro'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label1: TLabel
          Left = 22
          Top = 37
          Width = 50
          Height = 13
          Caption = 'U.Proceso'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 36
          Top = 57
          Width = 36
          Height = 13
          Caption = 'U.Pago'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 39
          Top = 16
          Width = 33
          Height = 13
          Caption = 'Oficina'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dblcdUPro: TwwDBLookupComboDlg
          Left = 75
          Top = 35
          Width = 65
          Height = 21
          CharCase = ecUpperCase
          GridOptions = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgPerfectRowFit]
          GridColor = clWhite
          GridTitleAlignment = taLeftJustify
          Caption = 'Lookup'
          MaxWidth = 0
          MaxHeight = 209
          LookupTable = DM1.cdsUPro
          LookupField = 'UPROID'
          TabOrder = 0
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
          OnChange = dblcdUProChange
          OnExit = dblcdUProExit
        end
        object meUPro: TMaskEdit
          Left = 140
          Top = 35
          Width = 250
          Height = 21
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
        object meUPago: TMaskEdit
          Left = 140
          Top = 55
          Width = 250
          Height = 21
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
        object dblcdUPago: TwwDBLookupComboDlg
          Left = 75
          Top = 55
          Width = 65
          Height = 21
          CharCase = ecUpperCase
          GridOptions = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgPerfectRowFit]
          GridColor = clWhite
          GridTitleAlignment = taLeftJustify
          Caption = 'Lookup'
          MaxWidth = 0
          MaxHeight = 209
          LookupTable = DM1.cdsUPago
          LookupField = 'UPAGOID'
          TabOrder = 3
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
          OnChange = dblcdUPagoChange
          OnExit = dblcdUPagoExit
        end
        object bbtnQuitarFiltro: TBitBtn
          Left = 406
          Top = 14
          Width = 97
          Height = 28
          Caption = 'Quitar Filtro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = bbtnQuitarFiltroClick
          NumGlyphs = 2
        end
        object dblcdOficina: TwwDBLookupComboDlg
          Left = 75
          Top = 14
          Width = 65
          Height = 21
          GridOptions = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgPerfectRowFit]
          GridColor = clWhite
          GridTitleAlignment = taLeftJustify
          Caption = 'Lookup'
          MaxWidth = 0
          MaxHeight = 209
          TabOrder = 5
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
          OnChange = dblcdOficinaChange
          OnExit = dblcdOficinaExit
        end
        object meofdes: TMaskEdit
          Left = 140
          Top = 14
          Width = 250
          Height = 21
          Enabled = False
          TabOrder = 6
        end
      end
    end
  end
  object DBGrid: TDBGrid
    Left = 580
    Top = 7
    Width = 83
    Height = 33
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
end
