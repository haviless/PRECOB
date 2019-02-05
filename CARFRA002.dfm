object fraUse: TfraUse
  Left = 0
  Top = 0
  Width = 375
  Height = 26
  TabOrder = 0
  object Label6: TLabel
    Left = 46
    Top = 7
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
  object Label1: TLabel
    Left = 5
    Top = 8
    Width = 27
    Height = 13
    Caption = 'Ugel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dblcduse: TwwDBLookupComboDlg
    Left = 55
    Top = 4
    Width = 44
    Height = 21
    GridOptions = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgPerfectRowFit]
    GridColor = clWhite
    GridTitleAlignment = taLeftJustify
    Caption = 'Lookup'
    MaxWidth = 0
    MaxHeight = 209
    LookupTable = DMPreCob.cdsUse
    LookupField = 'USEID'
    TabOrder = 0
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
    OnChange = dblcduseChange
    OnExit = dblcduseExit
  end
  object meusedes: TMaskEdit
    Left = 104
    Top = 3
    Width = 268
    Height = 21
    Enabled = False
    TabOrder = 1
  end
end
