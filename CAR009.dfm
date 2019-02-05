object Fimptex_res: TFimptex_res
  Left = 175
  Top = 207
  BorderStyle = bsDialog
  Caption = 'Migrar informaci'#243'n (Reporte de Resultado)'
  ClientHeight = 213
  ClientWidth = 446
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
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 3
    Top = 1
    Width = 438
    Height = 208
    Caption = ' Informaci'#243'n a migrar '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 18
      Width = 94
      Height = 15
      Caption = 'Unidad de proceso'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 9
      Top = 101
      Width = 20
      Height = 15
      Caption = 'A'#241'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 9
      Top = 129
      Width = 21
      Height = 15
      Caption = 'Mes'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 38
      Top = 101
      Width = 3
      Height = 15
      Caption = ':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 38
      Top = 130
      Width = 3
      Height = 15
      Caption = ':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 9
      Top = 43
      Width = 78
      Height = 15
      Caption = 'Unidad de pago'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 9
      Top = 68
      Width = 86
      Height = 15
      Caption = 'Tipo de asociado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 104
      Top = 18
      Width = 3
      Height = 14
      Caption = ':'
    end
    object Label10: TLabel
      Left = 104
      Top = 43
      Width = 3
      Height = 14
      Caption = ':'
    end
    object Label2: TLabel
      Left = 104
      Top = 68
      Width = 3
      Height = 14
      Caption = ':'
    end
    object dblcduproid: TwwDBLookupComboDlg
      Left = 112
      Top = 15
      Width = 50
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      CharCase = ecUpperCase
      GridOptions = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgPerfectRowFit]
      GridColor = clWhite
      GridTitleAlignment = taLeftJustify
      Caption = 'Lookup'
      MaxWidth = 0
      MaxHeight = 209
      LookupField = 'UPROID'
      MaxLength = 3
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnChange = dblcduproidChange
      OnExit = dblcduproidExit
    end
    object Panel1: TPanel
      Left = 168
      Top = 15
      Width = 234
      Height = 23
      Caption = 'Panel1'
      Enabled = False
      TabOrder = 7
      object meupronom: TMaskEdit
        Left = 1
        Top = 1
        Width = 232
        Height = 22
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object seano: TSpinEdit
      Left = 46
      Top = 97
      Width = 57
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxValue = 2050
      MinValue = 2007
      ParentFont = False
      TabOrder = 3
      Value = 2008
    end
    object semes: TSpinEdit
      Left = 46
      Top = 126
      Width = 43
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxValue = 12
      MinValue = 1
      ParentFont = False
      TabOrder = 4
      Value = 1
    end
    object dblcdupagoid: TwwDBLookupComboDlg
      Left = 112
      Top = 39
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      GridOptions = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgPerfectRowFit]
      GridColor = clWhite
      GridTitleAlignment = taLeftJustify
      Caption = 'Lookup'
      MaxWidth = 0
      MaxHeight = 209
      LookupField = 'UPAGOID'
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnChange = dblcdupagoidChange
      OnExit = dblcdupagoidExit
    end
    object Panel2: TPanel
      Left = 168
      Top = 39
      Width = 234
      Height = 23
      Caption = 'Panel1'
      Enabled = False
      TabOrder = 8
      object meupagonom: TMaskEdit
        Left = 1
        Top = 1
        Width = 232
        Height = 22
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object dblcdasotipid: TwwDBLookupComboDlg
      Left = 112
      Top = 64
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      GridOptions = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgPerfectRowFit]
      GridColor = clWhite
      GridTitleAlignment = taLeftJustify
      Caption = 'Lookup'
      MaxWidth = 0
      MaxHeight = 209
      LookupField = 'ASOTIPID'
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnChange = dblcdasotipidChange
      OnExit = dblcdasotipidExit
    end
    object Panel3: TPanel
      Left = 168
      Top = 64
      Width = 234
      Height = 23
      Caption = 'Panel1'
      Enabled = False
      TabOrder = 9
      object measotipdes: TMaskEdit
        Left = 1
        Top = 1
        Width = 232
        Height = 22
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object btnprocesar: TBitBtn
      Left = 186
      Top = 169
      Width = 169
      Height = 28
      Caption = 'Seleccionar Archivo y Migrar'
      TabOrder = 5
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
    object btnSalir: TBitBtn
      Left = 358
      Top = 169
      Width = 78
      Height = 28
      Caption = 'Salir'
      TabOrder = 6
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
    object pnlBar: TPanel
      Left = 6
      Top = 173
      Width = 172
      Height = 21
      Caption = 'Por Archivo'
      TabOrder = 10
      object lblTReg: TLabel
        Left = 191
        Top = 7
        Width = 3
        Height = 15
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Comic Sans MS'
        Font.Style = []
        ParentFont = False
      end
      object pbData: TProgressBar
        Left = 2
        Top = 2
        Width = 167
        Height = 16
        TabOrder = 0
      end
    end
    object gbTipoPlanilla: TGroupBox
      Left = 111
      Top = 88
      Width = 125
      Height = 67
      Caption = 'Tipo de Planilla'
      TabOrder = 11
      object rbCuotasAportes: TRadioButton
        Left = 8
        Top = 16
        Width = 113
        Height = 17
        Caption = 'Cuotas + Aportes'
        TabOrder = 0
      end
      object rbCuotas: TRadioButton
        Left = 8
        Top = 32
        Width = 113
        Height = 17
        Caption = 'Cuotas'
        TabOrder = 1
      end
      object rbAportes: TRadioButton
        Left = 8
        Top = 48
        Width = 113
        Height = 17
        Caption = 'Aportes'
        TabOrder = 2
      end
    end
  end
  object odLeer: TOpenDialog
    Options = [ofReadOnly, ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 326
    Top = 105
  end
end
