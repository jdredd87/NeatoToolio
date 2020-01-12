object dmSerial: TdmSerial
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 411
  Width = 474
  object COM: TFComPort
    Active = False
    DeviceName = 'COM1'
    Options = []
    Left = 192
    Top = 208
  end
  object FComSignalRX: TFComSignal
    ColorOff = claMaroon
    ColorOn = claRed
    ComPort = COM
    Delay = 100
    Signal = siRxChar
    Left = 96
    Top = 24
  end
  object FComSignalCTS: TFComSignal
    ColorOff = claOlive
    ColorOn = claYellow
    ComPort = COM
    Delay = 100
    Signal = siCTS
    Left = 96
    Top = 80
  end
  object FComSignalRing: TFComSignal
    ColorOff = claMaroon
    ColorOn = claRed
    ComPort = COM
    Delay = 100
    Signal = siRing
    Left = 96
    Top = 144
  end
  object FComSignalBreak: TFComSignal
    ColorOff = claNavy
    ColorOn = claBlue
    ComPort = COM
    Delay = 100
    Signal = siBreak
    Left = 96
    Top = 208
  end
  object FComSignalRLSD: TFComSignal
    ColorOff = claMaroon
    ColorOn = claRed
    ComPort = COM
    Delay = 100
    Signal = siRLSD
    Left = 192
    Top = 144
  end
  object FComSignalDSR: TFComSignal
    ColorOff = claOlive
    ColorOn = claYellow
    ComPort = COM
    Delay = 100
    Signal = siDSR
    Left = 192
    Top = 80
  end
  object FComSignalTX: TFComSignal
    ComPort = COM
    Delay = 100
    Signal = siTxChar
    Left = 192
    Top = 24
  end
end
