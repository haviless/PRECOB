object FCtrlAcceso: TFCtrlAcceso
  Left = 315
  Top = 282
  BorderStyle = bsDialog
  Caption = 'Control de Acceso'
  ClientHeight = 212
  ClientWidth = 315
  Color = 10207162
  Constraints.MaxHeight = 239
  Constraints.MaxWidth = 323
  Constraints.MinHeight = 239
  Constraints.MinWidth = 323
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 11
    Top = 4
    Width = 137
    Height = 20
    Alignment = taCenter
    Caption = 'Modulo PRECOB'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 256
    Top = 184
    Width = 48
    Height = 13
    Caption = 'DeMaSoft'
  end
  object gbControlAcceso: TGroupBox
    Left = 8
    Top = 27
    Width = 297
    Height = 151
    Caption = 'Control de Acceso'
    TabOrder = 0
    object lblUsuario: TLabel
      Left = 30
      Top = 32
      Width = 36
      Height = 13
      Caption = 'Usuario'
    end
    object lblContrasena: TLabel
      Left = 30
      Top = 71
      Width = 54
      Height = 13
      Caption = 'Contrase'#241'a'
    end
    object dbePassword: TwwDBEdit
      Left = 112
      Top = 69
      Width = 121
      Height = 19
      BorderStyle = bsNone
      Frame.Enabled = True
      Frame.NonFocusBorders = [efRightBorder, efBottomBorder]
      PasswordChar = '*'
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnKeyDown = dbePasswordKeyDown
    end
    object dbeUsuario: TwwDBEdit
      Left = 112
      Top = 29
      Width = 121
      Height = 19
      BorderStyle = bsNone
      CharCase = ecUpperCase
      Frame.Enabled = True
      Frame.NonFocusBorders = [efRightBorder, efBottomBorder]
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnKeyPress = FormKeyPress
    end
    object bbtnOkIngreso: TBitBtn
      Left = 128
      Top = 112
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 2
      OnClick = bbtnOkIngresoClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object bbtnCancelaIngreso: TBitBtn
      Left = 208
      Top = 112
      Width = 75
      Height = 25
      Caption = 'Cancela'
      ModalResult = 2
      TabOrder = 3
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
end
