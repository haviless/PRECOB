object fraOficina: TfraOficina
  Left = 0
  Top = 0
  Width = 377
  Height = 25
  TabOrder = 0
  object Label5: TLabel
    Left = 46
    Top = 5
    Width = 5
    Height = 13
    Caption = ':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Oficina: TLabel
    Left = 6
    Top = 5
    Width = 41
    Height = 13
    Caption = 'Oficina'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlOficina: TPanel
    Left = 55
    Top = 1
    Width = 320
    Height = 23
    BevelOuter = bvNone
    Caption = 'pnlOficina'
    ParentColor = True
    TabOrder = 0
    object meofdes: TMaskEdit
      Left = 61
      Top = 1
      Width = 252
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object dblcdOficina: TwwDBLookupComboDlg
      Left = 3
      Top = 1
      Width = 51
      Height = 21
      GridOptions = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgPerfectRowFit]
      GridColor = clWhite
      GridTitleAlignment = taLeftJustify
      Caption = 'Lookup'
      MaxWidth = 0
      MaxHeight = 209
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnChange = dblcdOficinaChange
      OnExit = dblcdOficinaExit
    end
  end
end
