unit TSTOBCell.IO;

interface

Uses HsStreamEx, TSTOBCellIntf;

Type
  ITSTOBCellFileIO = Interface(ITSTOBCellFile)
    ['{4B61686E-29A0-2112-A3F0-FBA086E051C1}']
    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);
        
    Property AsXml : String Read GetAsXml Write SetAsXml;
    
  End;

  TTSTOBCellFileIO = Class(TObject)
  Public
    Class Function CreateBCellFile() : ITSTOBCellFileIO;

  End;

implementation

Uses
  HsXmlDocEx, TSTOBCellImpl, TSTOBCell.Bin, TSTOBCell.Xml;

Type
  TTSTOBCellFileIOImpl = Class(TTSTOBCellFile, ITSTOBCellFileIO, IBinTSTOBCellFile, IXmlTSTOBCellFile)
  Private
    FBinImpl : IBinTSTOBCellFile;
    FXmlImpl : IXmlTSTOBCellFile;

    Function GetBinImplementor() : IBinTSTOBCellFile;
    Function GetXmlImplementor() : IXmlTSTOBCellFile;

  Protected
    Property BinImpl : IBinTSTOBCellFile Read GetBinImplementor Implements IBinTSTOBCellFile;
    Property XmlImpl : IXmlTSTOBCellFile Read GetXmlImplementor Implements IXmlTSTOBCellFile;

    Function  GetAsXml() : String;
    Procedure SetAsXml(Const AXmlString : String);

    Procedure LoadFromStream(ASource : IStreamEx);
    Procedure LoadFromFile(Const AFileName : String);

    Procedure SaveToStream(ATarget : IStreamEx);
    Procedure SaveToFile(Const AFileName : String);

  End;

Class Function TTSTOBCellFileIO.CreateBCellFile() : ITSTOBCellFileIO;
Begin
  Result := TTSTOBCellFileIOImpl.Create();
End;

Function TTSTOBCellFileIOImpl.GetBinImplementor() : IBinTSTOBCellFile;
Begin
  If Not Assigned(FBinImpl) Then
    FBinImpl := TBinTSTOBCellFile.CreateBCellFile();
  FBinImpl.Assign(Self);

  Result := FBinImpl;
End;

Function TTSTOBCellFileIOImpl.GetXmlImplementor() : IXmlTSTOBCellFile;
Begin
  If Not Assigned(FXmlImpl) Then
    FXmlImpl := TXmlTSTOBCellFile.CreateBCellFile();
  FXmlImpl.Assign(Self);

  Result := FXmlImpl;
End;

Function TTSTOBCellFileIOImpl.GetAsXml() : String;
Begin
  Result := FormatXmlData(XmlImpl.Xml);
End;

Procedure TTSTOBCellFileIOImpl.SetAsXml(Const AXmlString : String);
Begin
  FXmlImpl := TXmlTSTOBCellFile.CreateBCellFile(AXmlString);
  Assign(FXmlImpl);
End;

Procedure TTSTOBCellFileIOImpl.LoadFromStream(ASource : IStreamEx);
Begin
  FBinImpl := TBinTSTOBCellFile.CreateBCellFile();
  FBinImpl.LoadFromStream(ASource);
  Assign(FBinImpl);
End;

Procedure TTSTOBCellFileIOImpl.LoadFromFile(Const AFileName : String);
Begin
  FBinImpl := TBinTSTOBCellFile.CreateBCellFile();
  FBinImpl.LoadFromFile(AFileName);
  Assign(FBinImpl);
End;

Procedure TTSTOBCellFileIOImpl.SaveToStream(ATarget : IStreamEx);
Begin
  BinImpl.SaveToStream(ATarget);
End;

Procedure TTSTOBCellFileIOImpl.SaveToFile(Const AFileName : String);
Begin
  BinImpl.SaveToFile(AFileName);
End;

end.
