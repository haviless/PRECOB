object Fprodis: TFprodis
  Left = 81
  Top = 128
  BorderStyle = bsDialog
  Caption = 'Proceso de disquetes (Reporte de utilidad)'
  ClientHeight = 424
  ClientWidth = 792
  Color = 10207162
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object lblAno: TLabel
    Left = 418
    Top = 42
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
  object lblMes: TLabel
    Left = 511
    Top = 42
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
  object dbgcabecera: TwwDBGrid
    Left = 6
    Top = 72
    Width = 779
    Height = 297
    DisableThemesInTitle = False
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Options = [dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFooter3DCells]
    TabOrder = 0
    TitleAlignment = taCenter
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 2
    TitleButtons = False
    object wwDBGrid1IButton: TwwIButton
      Left = 0
      Top = 0
      Width = 30
      Height = 30
      AllowAllUp = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033377F3333333777333993333333
        300033F77FFF3333377739999993333333333777777F3333333F399999933333
        33003777777333333377333993333333330033377F3333333377333993333333
        3333333773333333333F333333333333330033333333F33333773333333C3333
        330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
        333333333337733333FF3333333C333330003333333733333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = wwDBGrid1IButtonClick
    end
  end
  object btnplantilla: TBitBtn
    Left = 78
    Top = 381
    Width = 73
    Height = 30
    Caption = 'Plantilla'
    TabOrder = 1
    OnClick = btnplantillaClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555550FF0559
      1950555FF75F7557F7F757000FF055591903557775F75557F77570FFFF055559
      1933575FF57F5557F7FF0F00FF05555919337F775F7F5557F7F700550F055559
      193577557F7F55F7577F07550F0555999995755575755F7FFF7F5570F0755011
      11155557F755F777777555000755033305555577755F75F77F55555555503335
      0555555FF5F75F757F5555005503335505555577FF75F7557F55505050333555
      05555757F75F75557F5505000333555505557F777FF755557F55000000355557
      07557777777F55557F5555000005555707555577777FF5557F55553000075557
      0755557F7777FFF5755555335000005555555577577777555555}
    NumGlyphs = 2
  end
  object btndepura: TBitBtn
    Left = 5
    Top = 381
    Width = 71
    Height = 30
    Caption = 'Depurar'
    TabOrder = 2
    OnClick = btndepuraClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555000000
      000055555F77777777775555000FFFFFFFF0555F777F5FFFF55755000F0F0000
      FFF05F777F7F77775557000F0F0FFFFFFFF0777F7F7F5FFFFFF70F0F0F0F0000
      00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFFFFF70F0F0F0F0000
      00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFF55570F0F0F0F000F
      FFF07F7F7F7F77755FF70F0F0F0FFFFF00007F7F7F7F5FF577770F0F0F0F00FF
      0F057F7F7F7F77557F750F0F0F0FFFFF00557F7F7F7FFFFF77550F0F0F000000
      05557F7F7F77777775550F0F0000000555557F7F7777777555550F0000000555
      55557F7777777555555500000005555555557777777555555555}
    NumGlyphs = 2
  end
  object btneliminar: TBitBtn
    Left = 400
    Top = 381
    Width = 80
    Height = 30
    Caption = 'Eliminar'
    TabOrder = 3
    OnClick = btneliminarClick
    Glyph.Data = {
      42010000424D4201000000000000760000002800000011000000110000000100
      040000000000CC00000000000000000000001000000010000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      777770000000777777777777777770000000777777777777770F700000007777
      0F777777777770000000777000F7777770F770000000777000F777770F777000
      00007777000F77700F777000000077777000F700F7777000000077777700000F
      7777700000007777777000F777777000000077777700000F7777700000007777
      7000F70F7777700000007770000F77700F7770000000770000F7777700F77000
      00007700F7777777700F70000000777777777777777770000000777777777777
      777770000000}
  end
  object btnidentificacion: TBitBtn
    Left = 153
    Top = 381
    Width = 114
    Height = 30
    Caption = 'Ide. del asociado'
    TabOrder = 4
    OnClick = btnidentificacionClick
    Glyph.Data = {
      9A050000424D9A05000000000000360000002800000014000000170000000100
      18000000000064050000C40E0000C40E00000000000000000000F6FFFFC9D4E2
      5259712E37303E393C767687AAB9D9A5C3E494B4D986A1CC91A9CDC3E1F7DAFF
      FFD6EEF98F96A038373743443F47514FD0D7DFFBFFFFF2FFFFA5BCC63C3A453A
      4037373A343B494A4C60775974925A73944F6A8E6585B084A8CE98C3E38DB0C8
      525F6439383353515077827FF9F9F9F5FFFFF9FFFF8BA4B33E3F404342373438
      3A2C39404D546E5E7293556C94637DA56D8DB67F9BC4859BC55A6B873D494543
      473E434340A2B2B2FDFFFFF3FFFFEBF4F68699A13235373937373A3B3C3A3B39
      4F565E56637E90A3C5C2E1FCB3E0F689AED57289B43E4A532E382A4445403737
      33C6D6D6FFFFFFF9FFFFB5C1C54C55583232343C3B3B3C3C3C38353138434C7F
      A2BCD7FFFFE1F1FAE2F5FCD3FFFF83A4C52838472C3625595856343735D6D7D6
      FFFFFFFEFFFFE1E1E2373A372827274040403A3A372F2927687891B6E4F9B5DC
      FAAFC2E9B2D0EEC0ECFFB7E7F8506A7B2A2C1D4D4D4A373A38D9DAD8FFFFFFFF
      FFFFFFFFFF93938E1C1B1A3E3D3F32322F43474AA0BED896C5E97088C59A9BDA
      90A8DA87A8DCB5E8FB98BCC832373F2E2E273D4338DFE0DDFFFFFFFFFFFFFFFF
      FFD4D4D3373F3C2B303133302768757CBCE3F6B6E1F5B4D4E6BCD4EECDD9EDC6
      E0EFCEF9FFB9E3EE5562741614125A5E56EBECE9FFFFFFFFFFFFFFFFFFFCFBFC
      8D9695181E1E363430839AA6D0F8FFEEFFFFCCEAF47DA7CE9FC5E1EDF9FBEEFF
      FFCDF6FD718798130F135B5F56EBECE9FFFFFFFFFFFFFFFFFFFFFFFFD0D1D21A
      18143B3B3D9BB6C5E1FFFFF5FFFFB5DFF1C4DCEAC9E5F1D7F2F8F7FFFFDBFFFF
      87A6B513191B595B52EBEBEAFFFFFFFFFFFFFFFFFFFFFFFFD5D5D4130F0C3F43
      49B5CFD5F4FFFFF6FFFEC8F5FFEFFEFFEEFFFFEEFFFFFAFFFFE9FFFFACCDD31C
      242A5F6058F0F1EEFFFFFFFFFFFFFFFFFFFFFFFFE1E2DF37372E313233B8CBCB
      EEFFFFD0F4FFD5FAFDE2F9FFEEFFFFDDF9FBD1F3FFF9FFFFB9D4DA1D252F7879
      74F9F9F8FFFFFFFFFFFFFFFFFFFFFFFFD0D0CE4A4A48282A248395A49CBEE0B2
      BDD9CAEDFAE8FAFEE7FFFFB5DAF29BAEC1B1D4E6A4B6C216181B878787FDFDFE
      FFFFFFFFFFFFFFFFFFFFFFFFF5F5F56E6E6E0B14074B5F626E748C6B67707699
      B6E7F9FCD8F1FE6F85A975777B90AFCE647D95090E08ADAEA9FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF99999A0B0F024E4F48838C968AA6B590AEC1EBFFFF
      DBF3FA83A3BAA0B5C6ADC5D758616822221EC6C7C6FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFBCBDBD30322C3938393F444FB3C6CDFAFFFFF6FFFFF0FFFFF1
      FFFFF0FCFF9AAAB424251E42423CD6D7D7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFDBDBDB5557535153544748523E4553D9E1EAF8FFFFF1FCFFFCFFFFC2D6
      E9383F5A221A0C737471ECEEEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEB
      ECEC77797350544E6D6F7D31333A92A8B8FDFFFFFEFFFFEDFFFF7692B2332A32
      3F352F8B8B8BF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFEAAAB
      A6555951727273737A78888F98EEF9FCF9FFFFB9D4E86C727B534D4C4F4F4AB0
      B1B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6D6D474766F
      636A5E81787D726E648A9495BACEE26D747A868775747A6D808580E2E4E3FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBB5B5AF636B5F64
      5E59524E43544E47747C7D4B453D7B7164889080C2CAC5FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F1F1A5A3A44E54454842
      305E5E514F5C5C362C2060614BC1C6BCFAFDFDFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDE3E38997959A9B9B
      9EAC9EA0A094ECEDE9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
  end
  object btncerrar: TBitBtn
    Left = 706
    Top = 381
    Width = 80
    Height = 30
    Caption = 'Cerrar'
    TabOrder = 5
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
  object btncierre: TBitBtn
    Left = 269
    Top = 381
    Width = 129
    Height = 30
    Caption = 'Cierre de informaci'#243'n'
    TabOrder = 6
    OnClick = btncierreClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      55555555FFFFFFFF5555555000000005555555577777777FF555550999999900
      55555575555555775F55509999999901055557F55555557F75F5001111111101
      105577FFFFFFFF7FF75F00000000000011057777777777775F755070FFFFFF0F
      01105777F555557F75F75500FFFFFF0FF0105577F555FF7F57575550FF700008
      8F0055575FF7777555775555000888888F005555777FFFFFFF77555550000000
      0F055555577777777F7F555550FFFFFF0F05555557F5FFF57F7F555550F000FF
      0005555557F777557775555550FFFFFF0555555557F555FF7F55555550FF7000
      05555555575FF777755555555500055555555555557775555555}
    NumGlyphs = 2
  end
  object GroupBox1: TGroupBox
    Left = 11
    Top = 1
    Width = 390
    Height = 64
    Caption = 'Cambio de Oficina'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    inline fraOficina: TfraOficina
      Left = 8
      Top = 23
      Width = 377
      Height = 25
      TabOrder = 0
      inherited pnlOficina: TPanel
        inherited dblcdOficina: TwwDBLookupComboDlg
          OnChange = fraOficinadblcdOficinaChange
          OnExit = fraOficinadblcdOficinaExit
        end
      end
    end
  end
  object seano: TSpinEdit
    Left = 444
    Top = 38
    Width = 57
    Height = 22
    MaxValue = 2050
    MinValue = 2008
    TabOrder = 8
    Value = 2008
  end
  object semes: TSpinEdit
    Left = 540
    Top = 38
    Width = 57
    Height = 22
    MaxValue = 12
    MinValue = 1
    TabOrder = 9
    Value = 1
  end
  object btnprocesar: TBitBtn
    Left = 608
    Top = 35
    Width = 78
    Height = 28
    Caption = 'Procesar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
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
  object rgFiltraPeriodo: TRadioGroup
    Left = 416
    Top = 2
    Width = 185
    Height = 30
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Todo'
      'por Periodo')
    TabOrder = 11
    OnClick = rgFiltraPeriodoClick
  end
end
