object DMConexao: TDMConexao
  OnCreate = DataModuleCreate
  Height = 174
  Width = 260
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=C:\src\db\FDCMARKET\FDCMARKET.GDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 112
    Top = 32
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT RDB$RELATION_NAME'
      'FROM RDB$RELATIONS'
      'WHERE RDB$SYSTEM_FLAG = 0 AND RDB$VIEW_BLR IS NULL'
      'ORDER BY RDB$RELATION_NAME;')
    Left = 56
    Top = 80
  end
  object FDMetaInfoQuery1: TFDMetaInfoQuery
    Connection = FDConnection
    Left = 180
    Top = 46
  end
end
