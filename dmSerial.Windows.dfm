object dmSerial: TdmSerial
  OldCreateOrder = False
  Height = 411
  Width = 474
  object Serial: TFComPort
    Active = False
    BufferSizes.Output = 4096
    DeviceName = 'COM1'
    Options = [opAbortOnError]
    Left = 192
    Top = 208
  end
  object FComSignalRX: TFComSignal
    ColorOff = claMaroon
    ColorOn = claRed
    ComPort = Serial
    Delay = 50
    Signal = siRxChar
    Left = 96
    Top = 24
  end
  object FComSignalCTS: TFComSignal
    ColorOff = claOlive
    ColorOn = claYellow
    ComPort = Serial
    Delay = 50
    Signal = siCTS
    Left = 96
    Top = 80
  end
  object FComSignalRing: TFComSignal
    ColorOff = claMaroon
    ColorOn = claRed
    ComPort = Serial
    Delay = 50
    Signal = siRing
    Left = 96
    Top = 144
  end
  object FComSignalBreak: TFComSignal
    ColorOff = claNavy
    ColorOn = claBlue
    ComPort = Serial
    Delay = 50
    Signal = siBreak
    Left = 96
    Top = 208
  end
  object FComSignalRLSD: TFComSignal
    ColorOff = claMaroon
    ColorOn = claRed
    ComPort = Serial
    Delay = 50
    Signal = siRLSD
    Left = 192
    Top = 144
  end
  object FComSignalDSR: TFComSignal
    ColorOff = claOlive
    ColorOn = claYellow
    ComPort = Serial
    Delay = 50
    Signal = siDSR
    Left = 192
    Top = 80
  end
  object FComSignalTX: TFComSignal
    ComPort = Serial
    Delay = 50
    Signal = siTxChar
    Left = 192
    Top = 24
  end
end
