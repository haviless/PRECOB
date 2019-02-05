object DMPreCob: TDMPreCob
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 76
  Top = 175
  Height = 477
  Width = 765
  object cdsUsuarios: TwwClientDataSet
    Aggregates = <>
    IndexFieldNames = 'USERID'
    Params = <>
    ProviderName = 'dspQRY13'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 214
    Top = 377
  end
  object dsUsuarios: TwwDataSource
    DataSet = cdsUsuarios
    Left = 222
    Top = 390
  end
  object cdsGrupos: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY2'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 523
    Top = 241
  end
  object dsGrupos: TwwDataSource
    DataSet = cdsGrupos
    Left = 531
    Top = 246
  end
  object cdsMGrupo: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY14'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 355
    Top = 241
  end
  object dsMGrupo: TwwDataSource
    DataSet = cdsMGrupo
    Left = 363
    Top = 254
  end
  object cdsAcceso: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY12'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 238
    Top = 241
  end
  object dsAcceso: TwwDataSource
    DataSet = cdsAcceso
    Left = 246
    Top = 246
  end
  object cdsAso: TwwClientDataSet
    Aggregates = <>
    PacketRecords = 50
    Params = <>
    ProviderName = 'dspQRY5'
    RemoteServer = DCOM1
    OnReconcileError = cdsEjecutaReconcileError
    PictureMasks.Strings = (
      'ASORUC'#9'###########'#9'T'#9'F'
      'ASOID'#9'*15[#]'#9'T'#9'F'
      'ASONUMDIR'#9'*5[#]'#9'T'#9'F'
      'ASODPTO'#9'*5[#]'#9'T'#9'F'
      'ASORESNOM'#9'*15[#]'#9'T'#9'F')
    ValidateWithMask = True
    Left = 142
    Top = 305
  end
  object dsAso: TwwDataSource
    DataSet = cdsAso
    Left = 150
    Top = 310
  end
  object cdsUSES: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY10'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 124
    Top = 238
  end
  object dsUSES: TwwDataSource
    DataSet = cdsUSES
    Left = 132
    Top = 243
  end
  object cdsUPro: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY8'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 10
    Top = 238
  end
  object dsUPro: TwwDataSource
    DataSet = cdsUPro
    Left = 19
    Top = 235
  end
  object cdsUPago: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY9'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 66
    Top = 238
  end
  object dsUPago: TwwDataSource
    DataSet = cdsUPago
    Left = 74
    Top = 235
  end
  object cdsSAso: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY6'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 201
    Top = 302
  end
  object dsSAso: TwwDataSource
    DataSet = cdsSAso
    Left = 210
    Top = 307
  end
  object cdsCAso: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY8'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 326
    Top = 310
  end
  object dsCAso: TwwDataSource
    DataSet = cdsCAso
    Left = 334
    Top = 323
  end
  object cdsOfDes: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY11'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 181
    Top = 238
  end
  object dsOfDes: TwwDataSource
    DataSet = cdsOfDes
    Left = 189
    Top = 243
  end
  object cdsQry: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 84
    Top = 13
  end
  object dsQry: TwwDataSource
    DataSet = cdsQry
    Left = 92
    Top = 18
  end
  object cdsDpto: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY9'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 379
    Top = 309
  end
  object dsDpto: TwwDataSource
    DataSet = cdsDpto
    Left = 387
    Top = 322
  end
  object cdsModelo: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY13'
    RemoteServer = DCOM1
    OnReconcileError = cdsEjecutaReconcileError
    ValidateWithMask = True
    Left = 295
    Top = 241
  end
  object cdsPlantilla: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY3'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 149
    Top = 441
  end
  object dsModelo: TwwDataSource
    DataSet = cdsModelo
    Left = 303
    Top = 254
  end
  object dsPlantilla: TwwDataSource
    DataSet = cdsPlantilla
    Left = 157
    Top = 446
  end
  object cdsCuotas: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY15'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 414
    Top = 245
  end
  object dsCuotas: TwwDataSource
    DataSet = cdsCuotas
    Left = 422
    Top = 250
  end
  object cdsCredito: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY15'
    RemoteServer = DCOM1
    OnReconcileError = cdsEjecutaReconcileError
    ValidateWithMask = True
    Left = 389
    Top = 387
  end
  object dsCredito: TwwDataSource
    DataSet = cdsCredito
    Left = 405
    Top = 391
  end
  object cdsReporte: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY3'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 23
    Top = 304
  end
  object dsReporte: TwwDataSource
    DataSet = cdsReporte
    Left = 31
    Top = 309
  end
  object cdsQry2: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY2'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 191
    Top = 20
  end
  object cdsAutdisk: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY12'
    RemoteServer = DCOM1
    OnReconcileError = cdsEjecutaReconcileError
    ControlType.Strings = (
      'FREGCOB;CheckBox;S;N')
    ValidateWithMask = True
    Left = 158
    Top = 370
  end
  object cdsQry3: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY3'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 249
    Top = 25
  end
  object cdsQry4: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY4'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 299
    Top = 23
  end
  object dsQry3: TwwDataSource
    DataSet = cdsQry3
    Left = 254
    Top = 30
  end
  object dsQry4: TwwDataSource
    DataSet = cdsQry4
    Left = 307
    Top = 28
  end
  object cdsQry1: TwwClientDataSet
    Aggregates = <>
    AutoCalcFields = False
    Params = <>
    ProviderName = 'dspQRY1'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 141
    Top = 16
  end
  object cdsSolicitud: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY7'
    RemoteServer = DCOM1
    OnReconcileError = cdsEjecutaReconcileError
    ValidateWithMask = True
    Left = 266
    Top = 301
  end
  object cdsProvCta: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY15'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 437
    Top = 312
  end
  object dsProvCta: TwwDataSource
    DataSet = cdsProvCta
    Left = 438
    Top = 325
  end
  object dsQry1: TwwDataSource
    DataSet = cdsQry1
    Left = 141
    Top = 37
  end
  object dsQry2: TwwDataSource
    AutoEdit = False
    DataSet = cdsQry2
    Left = 199
    Top = 25
  end
  object dsSolicitud: TwwDataSource
    DataSet = cdsSolicitud
    Left = 275
    Top = 306
  end
  object dsAutdisk: TwwDataSource
    DataSet = cdsAutdisk
    Left = 166
    Top = 375
  end
  object ExcelApp: TExcelApplication
    AutoConnect = False
    ConnectKind = ckNewInstance
    AutoQuit = False
    Left = 602
    Top = 269
  end
  object ExcelBook: TExcelWorkbook
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 598
    Top = 365
  end
  object WS: TExcelWorksheet
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 602
    Top = 317
  end
  object cdsQry6: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY6'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 403
    Top = 24
  end
  object dsQry6: TwwDataSource
    DataSet = cdsQry6
    Left = 403
    Top = 37
  end
  object cdsEjecuta: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY14'
    RemoteServer = DCOM1
    OnReconcileError = cdsEjecutaReconcileError
    ValidateWithMask = True
    Left = 311
    Top = 374
  end
  object dsEjecuta: TwwDataSource
    DataSet = cdsEjecuta
    Left = 319
    Top = 379
  end
  object cdsQry5: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY5'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 349
    Top = 26
  end
  object dsqry5: TwwDataSource
    DataSet = cdsQry5
    Left = 357
    Top = 31
  end
  object cdsUser: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY1'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 472
    Top = 244
  end
  object dsUser: TwwDataSource
    DataSet = cdsUser
    Left = 480
    Top = 249
  end
  object cdsTaso: TwwClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cdsTasoField1'
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'dspQRY4'
    RemoteServer = DCOM1
    StoreDefs = True
    ValidateWithMask = True
    Left = 81
    Top = 302
  end
  object dsTaso: TwwDataSource
    DataSet = cdsTaso
    Left = 90
    Top = 307
  end
  object cdsReporteest: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY4'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 223
    Top = 448
  end
  object dsReporteest: TwwDataSource
    DataSet = cdsReporteest
    Left = 231
    Top = 461
  end
  object cdsOficina: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY1'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 23
    Top = 436
  end
  object dsOficina: TwwDataSource
    AutoEdit = False
    DataSet = cdsOficina
    Left = 31
    Top = 449
  end
  object cdsUse: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY2'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 87
    Top = 436
  end
  object dsUse: TwwDataSource
    AutoEdit = False
    DataSet = cdsUse
    Left = 95
    Top = 449
  end
  object dsQry7: TwwDataSource
    DataSet = cdsQry7
    Left = 451
    Top = 29
  end
  object cdsQry7: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY7'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 467
    Top = 40
  end
  object cdsProv: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY10'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 19
    Top = 373
  end
  object dsProv: TwwDataSource
    DataSet = cdsProv
    Left = 27
    Top = 378
  end
  object cdsDist: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY11'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 91
    Top = 365
  end
  object dsDist: TwwDataSource
    DataSet = cdsDist
    Left = 107
    Top = 378
  end
  object DCOM1: TSocketConnection
    ServerGUID = '{784F2821-E03D-45D7-BC8A-7198A8FC7048}'
    ServerName = 'PreCobSrvPrj.SrvPreCob'
    Address = '192.168.20.34'
    Left = 16
    Top = 8
  end
  object dsQry8: TwwDataSource
    DataSet = cdsQry8
    Left = 531
    Top = 21
  end
  object cdsQry8: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY7'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 547
    Top = 32
  end
  object cdsQry9: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY5'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 589
    Top = 34
  end
  object dsQry9: TwwDataSource
    DataSet = cdsQry9
    Left = 613
    Top = 23
  end
  object dsQry10: TwwDataSource
    DataSet = cdsQry10
    Left = 683
    Top = 21
  end
  object cdsQry10: TwwClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQRY7'
    RemoteServer = DCOM1
    ValidateWithMask = True
    Left = 699
    Top = 32
  end
end
