PROGRAM CAR000;
USES
   Forms,
   Windows,
   Controls,
   Msgdlgs,
   CARDM1 IN 'CARDM1.pas' {DM1: TDataModule},
   CARFRA001 IN 'CARFRA001.pas' {fraOficina: TFrame},
   CARFRA002 IN 'CARFRA002.pas' {fraUse: TFrame},
   CAR001 IN 'CAR001.pas' {FPrincipal},
   CAR002 IN 'CAR002.pas' {Fprodis},
   CAR003 IN 'CAR003.pas' {fimptexto},
   CAR004 IN 'CAR004.pas' {Fproinfpla},
   CAR005 IN 'CAR005.pas' {Fdeparc},
   CAR006 IN 'CAR006.pas' {Fideaso},
   CAR007 IN 'CAR007.pas' {Fbuscaasociado},
   CAR008 IN 'CAR008.pas' {Fprodis_res},
   CAR009 IN 'CAR009.pas' {Fimptex_res},
   CAR010 IN 'CAR010.pas' {Fproinfpla_res},
   CAR018 IN 'CAR018.pas' {FEnvVsRep},
   CAR019 IN 'CAR019.pas' {FEnvVsRepPorResultado},
   CAR020 IN 'CAR020.pas' {FEnvVsRepDetallado},
   CAR021 IN 'CAR021.pas' {FCtrlAcceso},
   CAR022 IN 'CAR022.pas' {FCambioContrasena},
   CAR025 IN 'CAR025.pas' {FEnvVsCobVsPrecob_Det},
   UDEMO IN 'UDEMO.pas' {Form1},
   CAR024 IN 'CAR024.pas' {FImpDBF},
   CAR023 IN 'CAR023.pas' {FEnvVsCobVsPrecob},
   CAR026 IN 'CAR026.pas' {FVistaPreviaTXT}; // HPP_200902_PRCB - JCARBONEL

{$R *.RES}
VAR
   HMutex: THandle;
BEGIN
   HMutex := CreateMutex(NIL, False, 'OneCopyMutexPRECOB');
   IF WaitForSingleObject(HMutex, 0) <> wait_TimeOut THEN
   BEGIN
      Application.Initialize;
      Application.Title := 'Carga Descuento x Planilla';
      Application.CreateForm(TDMPreCob, DMPreCob);
      FCtrlAcceso := TFCtrlAcceso.Create(NIL);
      TRY
         IF FCtrlAcceso.ShowModal = mrOk THEN
           // HPP_200902_PRCB - JCARBONEL
           Application.CreateForm(TFPrincipal, FPrincipal);
           //Application.CreateForm(TFImpDBF, FImpDBF);
      FINALLY
         FCtrlAcceso.Free;
      END;
      Application.Run;
   END
   ELSE
      ErrorMsg('Modulo de Proceso de Carga de Descuento', 'Ya se Encuentra en ejecución el Modulo');
END.

