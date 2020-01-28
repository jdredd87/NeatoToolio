object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 343
  Width = 424
  object IdCmdTCPClient1: TIdCmdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    CommandHandlers = <
      item
        CmdDelimiter = ' '
        Disconnect = False
        Name = 'TIdCommandHandler0'
        NormalReply.Code = '200'
        ParamDelimiter = ' '
        ParseParams = True
        Tag = 0
      end>
    ExceptionReply.Code = '500'
    ExceptionReply.Text.Strings = (
      'Unknown Internal Error')
    Left = 200
    Top = 152
  end
end
