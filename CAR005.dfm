object Fdeparc: TFdeparc
  Left = 124
  Top = 143
  Width = 844
  Height = 497
  Caption = 'Manipulaci'#243'n de la data'
  Color = 10207162
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object dbgPlantilla: TwwDBGrid
    Left = 0
    Top = 0
    Width = 836
    Height = 313
    DisableThemesInTitle = False
    IniAttributes.Delimiter = ';;'
    TitleColor = 10207162
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    Color = 15792632
    DataSource = DMPreCob.dsQry4
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    KeyOptions = [dgAllowDelete]
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentFont = False
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clNavy
    TitleFont.Height = -11
    TitleFont.Name = 'Courier New'
    TitleFont.Style = []
    TitleLines = 3
    TitleButtons = False
    OnDblClick = dbgPlantillaDblClick
  end
  object Panel4: TPanel
    Left = 0
    Top = 313
    Width = 836
    Height = 157
    Align = alBottom
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      836
      157)
    object Panel1: TPanel
      Left = 436
      Top = 11
      Width = 137
      Height = 115
      Anchors = [akLeft, akBottom]
      BorderStyle = bsSingle
      Caption = 'Panel1'
      Color = 10207162
      TabOrder = 0
      object GroupBox1: TGroupBox
        Left = 4
        Top = 20
        Width = 127
        Height = 58
        TabOrder = 0
        object Label1: TLabel
          Left = 9
          Top = 10
          Width = 31
          Height = 13
          Caption = 'Desde'
        end
        object Label2: TLabel
          Left = 72
          Top = 10
          Width = 28
          Height = 13
          Caption = 'Hasta'
        end
        object seinicio: TSpinEdit
          Left = 9
          Top = 30
          Width = 45
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 3
          MaxValue = 500
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 0
        end
        object sefinal: TSpinEdit
          Left = 72
          Top = 30
          Width = 45
          Height = 22
          MaxLength = 3
          MaxValue = 500
          MinValue = 0
          TabOrder = 1
          Value = 0
        end
      end
      object StaticText1: TStaticText
        Left = 1
        Top = 1
        Width = 131
        Height = 17
        Align = alTop
        Alignment = taCenter
        BorderStyle = sbsSunken
        Caption = 'ELIMINAR COLUMNA'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 1
      end
      object BitBtn6: TBitBtn
        Left = 50
        Top = 81
        Width = 80
        Height = 27
        Caption = 'Eliminar'
        TabOrder = 2
        OnClick = BitBtn6Click
      end
    end
    object Panel2: TPanel
      Left = 5
      Top = 11
      Width = 428
      Height = 142
      Anchors = [akLeft, akBottom]
      BorderStyle = bsSingle
      Color = 10207162
      TabOrder = 1
      object GroupBox2: TGroupBox
        Left = 209
        Top = 18
        Width = 106
        Height = 44
        BiDiMode = bdRightToLeftReadingOnly
        Ctl3D = False
        ParentBiDiMode = False
        ParentCtl3D = False
        TabOrder = 1
        object btnmartod: TBitBtn
          Left = 9
          Top = 11
          Width = 80
          Height = 27
          Caption = 'Marcar Todo'
          TabOrder = 0
          OnClick = btnmartodClick
        end
      end
      object GroupBox9: TGroupBox
        Left = 314
        Top = 18
        Width = 106
        Height = 44
        BiDiMode = bdRightToLeftReadingOnly
        Ctl3D = False
        ParentBiDiMode = False
        ParentCtl3D = False
        TabOrder = 2
        object btnmarigu: TBitBtn
          Left = 7
          Top = 11
          Width = 92
          Height = 27
          Caption = 'Marcar iguales'
          TabOrder = 0
          OnClick = btnmariguClick
        end
      end
      object StaticText2: TStaticText
        Left = 1
        Top = 1
        Width = 422
        Height = 17
        Align = alTop
        Alignment = taCenter
        BorderStyle = sbsSunken
        Caption = 'ELIMINAR LINEAS'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
      object GroupBox11: TGroupBox
        Left = 5
        Top = 18
        Width = 201
        Height = 57
        BiDiMode = bdRightToLeftReadingOnly
        Ctl3D = False
        ParentBiDiMode = False
        ParentCtl3D = False
        TabOrder = 3
        object Label3: TLabel
          Left = 6
          Top = 10
          Width = 31
          Height = 13
          Caption = 'Desde'
        end
        object Label8: TLabel
          Left = 60
          Top = 10
          Width = 28
          Height = 13
          Caption = 'Hasta'
        end
        object btnmarlin: TBitBtn
          Left = 117
          Top = 25
          Width = 80
          Height = 27
          Caption = 'Marcar Lineas'
          TabOrder = 0
          OnClick = btnmarlinClick
        end
        object selinini: TSpinEdit
          Left = 6
          Top = 28
          Width = 50
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
        end
        object selinfin: TSpinEdit
          Left = 60
          Top = 28
          Width = 50
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
        end
      end
      object btndesmarcar: TBitBtn
        Left = 338
        Top = 101
        Width = 80
        Height = 27
        Caption = 'Des-Marcar'
        TabOrder = 4
        OnClick = btndesmarcarClick
      end
      object btneliminar: TBitBtn
        Left = 339
        Top = 68
        Width = 80
        Height = 27
        Caption = 'Elimina'
        TabOrder = 5
        OnClick = btneliminarClick
      end
      object GroupBox3: TGroupBox
        Left = 5
        Top = 77
        Width = 327
        Height = 53
        BiDiMode = bdRightToLeftReadingOnly
        Ctl3D = False
        ParentBiDiMode = False
        ParentCtl3D = False
        TabOrder = 6
        object Label6: TLabel
          Left = 78
          Top = 10
          Width = 74
          Height = 13
          Caption = 'Desde columna'
        end
        object Label9: TLabel
          Left = 4
          Top = 10
          Width = 175
          Height = 13
          Caption = 'Marcar lineas que contengan el texto'
        end
        object btnmarlinbus: TBitBtn
          Left = 243
          Top = 9
          Width = 80
          Height = 27
          Caption = 'Marcar Lineas'
          TabOrder = 0
          OnClick = btnmarlinbusClick
        end
        object mebuscacad: TMaskEdit
          Left = 4
          Top = 28
          Width = 231
          Height = 19
          CharCase = ecUpperCase
          TabOrder = 1
        end
      end
    end
    object Panel3: TPanel
      Left = 578
      Top = 10
      Width = 154
      Height = 114
      Anchors = [akLeft, akBottom]
      BorderStyle = bsSingle
      Caption = 'Panel1'
      Color = 10207162
      TabOrder = 2
      object GroupBox4: TGroupBox
        Left = 4
        Top = 20
        Width = 143
        Height = 56
        TabOrder = 0
        object Label4: TLabel
          Left = 9
          Top = 9
          Width = 33
          Height = 13
          Caption = 'Buscar'
        end
        object Label5: TLabel
          Left = 61
          Top = 9
          Width = 56
          Height = 13
          Caption = 'Reemplazar'
        end
        object mebusca: TMaskEdit
          Left = 9
          Top = 28
          Width = 33
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 0
        end
        object mereemplaza: TMaskEdit
          Left = 61
          Top = 28
          Width = 33
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 1
        end
      end
      object StaticText3: TStaticText
        Left = 1
        Top = 1
        Width = 148
        Height = 17
        Align = alTop
        Alignment = taCenter
        BorderStyle = sbsSunken
        Caption = 'BUSCAR Y REMPLAZAR'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 1
      end
      object btnreemplazar: TBitBtn
        Left = 67
        Top = 80
        Width = 80
        Height = 27
        Caption = 'Reemplazar'
        TabOrder = 2
        OnClick = btnreemplazarClick
        NumGlyphs = 2
      end
    end
    object btncerrar: TBitBtn
      Left = 747
      Top = 123
      Width = 80
      Height = 28
      Anchors = [akRight, akBottom]
      Caption = 'Cerrar'
      TabOrder = 3
      OnClick = btncerrarClick
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
  end
end
