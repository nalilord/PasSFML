unit TestSfmlNetwork;

{$I ..\Source\Sfml.inc}

interface

uses
  SysUtils,
{$IFNDEF FPC}
  TestFramework,
  IdFtpServer, IdFTPList, IdFTPListOutput, Windows, Classes,
{$ELSE}
  FPCUnit, TestUtils, TestRegistry,
{$ENDIF}
  SfmlSystem, SfmlNetwork;

type
  TestTSfmlFtp = class(TTestCase)
  strict private
    FSfmlFtp: TSfmlFtp;
{$IFNDEF FPC}
    FFtpServer: TIdFTPServer;
{$ENDIF}
  private
{$IFNDEF FPC}
    procedure FtpUserLoginHandler(ASender: TIdFTPServerContext; const AUsername,
      APassword: string; var AAuthenticated: Boolean);
    procedure FtpListDirectoryHandler(ASender: TIdFTPServerContext;
      const APath: TIdFTPFileName; ADirectoryListing: TIdFTPListOutput;
      const ACmd: string; const ASwitches: string);
    procedure FtpRenameFileHandler(ASender: TIdFTPServerContext;
      const ARenameFromFile, ARenameToFile: string);
    procedure FtpRetrieveFileHandler(ASender: TIdFTPServerContext;
      const AFilename: string; var AStream: TStream);
    procedure FtpStoreFileHandler(ASender: TIdFTPServerContext;
      const AFilename: string; AAppend: Boolean; var AStream: TStream);
    procedure FtpChangeDirectoryHandler(ASender: TIdFTPServerContext;
      var ADirectory: string);
    procedure FtpDeleteFileHandler(ASender: TIdFTPServerContext;
      const APathName: string);
    procedure FtpGetFileSizeHandler(ASender: TIdFTPServerContext;
      const AFilename: string; var AFileSize: Int64);
    procedure FtpMakeDirectoryHandler(ASender: TIdFTPServerContext;
      var ADirectory: string);
    procedure FtpRemoveDirectoryHandler(ASender: TIdFTPServerContext;
      var ADirectory: string);
{$ENDIF}
  public
{$IFNDEF FPC}
    constructor Create(MethodName: string); override;
    destructor Destroy; override;
{$ENDIF}

    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestBasics;
  end;

  TestTSfmlHttpRequest = class(TTestCase)
  strict private
    FSfmlHttpRequest: TSfmlHttpRequest;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSetField;
    procedure TestSetMethod;
    procedure TestSetUri;
    procedure TestSetHttpVersion;
    procedure TestSetBody;
  end;

  TestTSfmlHttp = class(TTestCase)
  strict private
    FSfmlHttp: TSfmlHttp;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestBasics;
  end;

  TestTSfmlPacket = class(TTestCase)
  strict private
    FSfmlPacket: TSfmlPacket;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCopy;
    procedure TestAppendGetDataClear;
    procedure TestEndOfPacket;
    procedure TestCanRead;
    procedure TestReadWrite;
  end;

  TestTSfmlSocketSelector = class(TTestCase)
  strict private
    FSfmlSocketSelector: TSfmlSocketSelector;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAddRemoveTcpListener;
    procedure TestClear;
    procedure TestWait;
    procedure TestIsTcpListenerReady;
    procedure TestIsTcpSocketReady;
    procedure TestIsUdpSocketReady;
  end;

  TestTSfmlTcpListener = class(TTestCase)
  strict private
    FSfmlTcpListener: TSfmlTcpListener;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestListen;
    procedure TestAccept;
  end;

  TestTSfmlTcpSocket = class(TTestCase)
  strict private
    FSfmlTcpSocket: TSfmlTcpSocket;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGetRemoteAddress;
    procedure TestGetRemotePort;
    procedure TestConnect;
    procedure TestDisconnect;
    procedure TestSend;
    procedure TestReceive;
    procedure TestSendPacket;
    procedure TestReceivePacket;
  end;

  TestTSfmlUdpSocket = class(TTestCase)
  strict private
    FSfmlUdpSocket: TSfmlUdpSocket;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestBindUnbind;
    procedure TestSend;
    procedure TestReceive;
    procedure TestSendPacket;
    procedure TestReceivePacket;
  end;

implementation

const
  CTestFtpPort = 21210;

procedure AssertCondition(Condition: Boolean; const Message: string);
begin
  if not Condition then
    raise Exception.Create(Message);
end;

procedure AssertEquals(Expected, Actual: Integer; const Message: string);
begin
  if Expected <> Actual then
    raise Exception.CreateFmt('%s (expected %d, got %d)', [Message, Expected,
      Actual]);
end;

procedure ConnectTcpPair(out Listener: TSfmlTcpListener; out ClientSocket,
  ServerSocket: TSfmlTcpSocket);
var
  Status: TSfmlSocketStatus;
begin
  Listener := TSfmlTcpListener.Create;
  ClientSocket := TSfmlTcpSocket.Create;
  ServerSocket := nil;

  Status := Listener.Listen(TSfmlTcpListener.AnyPort, SfmlIpAddressLocalHost);
  AssertEquals(Ord(sfSocketDone), Ord(Status), 'TCP listener did not start');
  AssertCondition(Listener.LocalPort <> 0, 'TCP listener did not get a port');

  Status := ClientSocket.Connect(SfmlIpAddressLocalHost, Listener.LocalPort,
    SfmlSeconds(1));
  AssertEquals(Ord(sfSocketDone), Ord(Status), 'TCP connect failed');

  Status := Listener.Accept(ServerSocket);
  AssertEquals(Ord(sfSocketDone), Ord(Status), 'TCP accept failed');
  AssertCondition(ServerSocket <> nil, 'TCP accept returned nil socket');
end;

procedure FreeTcpPair(var Listener: TSfmlTcpListener; var ClientSocket,
  ServerSocket: TSfmlTcpSocket);
begin
  FreeAndNil(ServerSocket);
  FreeAndNil(ClientSocket);
  FreeAndNil(Listener);
end;

procedure WaitForTcpSocket(Socket: TSfmlTcpSocket);
var
  Selector: TSfmlSocketSelector;
begin
  Selector := TSfmlSocketSelector.Create;
  try
    Selector.AddTcpSocket(Socket.Handle);
    AssertCondition(Selector.Wait(SfmlSeconds(1)),
      'Timed out waiting for TCP socket readiness');
    AssertCondition(Selector.IsTcpSocketReady(Socket.Handle),
      'TCP socket was not reported ready');
  finally
    Selector.Free;
  end;
end;

procedure PrepareUdpSockets(out SenderSocket, ReceiverSocket: TSfmlUdpSocket);
var
  Status: TSfmlSocketStatus;
begin
  SenderSocket := TSfmlUdpSocket.Create;
  ReceiverSocket := TSfmlUdpSocket.Create;

  Status := ReceiverSocket.Bind(TSfmlUdpSocket.AnyPort, SfmlIpAddressLocalHost);
  AssertEquals(Ord(sfSocketDone), Ord(Status), 'UDP bind failed');
  AssertCondition(ReceiverSocket.LocalPort <> 0, 'UDP socket did not get a port');
end;

procedure WaitForUdpSocket(Socket: TSfmlUdpSocket);
var
  Selector: TSfmlSocketSelector;
begin
  Selector := TSfmlSocketSelector.Create;
  try
    Selector.AddUdpSocket(Socket.Handle);
    AssertCondition(Selector.Wait(SfmlSeconds(1)),
      'Timed out waiting for UDP socket readiness');
    AssertCondition(Selector.IsUdpSocketReady(Socket.Handle),
      'UDP socket was not reported ready');
  finally
    Selector.Free;
  end;
end;

{ TestTSfmlFtp }

{$IFNDEF FPC}
constructor TestTSfmlFtp.Create(MethodName: string);
begin
  inherited;
  FFtpServer := nil;
end;

destructor TestTSfmlFtp.Destroy;
begin
  FreeAndNil(FFtpServer);
  inherited;
end;

procedure TestTSfmlFtp.FtpListDirectoryHandler(ASender: TIdFTPServerContext;
  const APath: TIdFTPFileName; ADirectoryListing: TIdFTPListOutput; const ACmd,
  ASwitches: string);
var
  ListItem: TIdFTPListOutputItem;
begin
  // add test file
  ListItem := ADirectoryListing.Add;
  ListItem.ItemType := ditFile;
  ListItem.FileName := 'File';
  ListItem.Size := 1024;
  ListItem.ModifiedDate := Now;

  // add test directory
  ListItem := ADirectoryListing.Add;
  ListItem.ItemType := ditDirectory;
  ListItem.FileName := 'Dir';
  ListItem.Size := 1024;
  ListItem.ModifiedDate := Now;
end;

procedure TestTSfmlFtp.FtpUserLoginHandler(ASender: TIdFTPServerContext;
  const AUsername, APassword: string; var AAuthenticated: Boolean);
begin
  AAuthenticated := (AUsername = 'Test') and (APassword = 'Test') ;
  if not AAuthenticated then
    Exit;
  ASender.HomeDir := '/';
  ASender.CurrentDir := '/';
end;

procedure TestTSfmlFtp.FtpRenameFileHandler(ASender: TIdFTPServerContext;
  const ARenameFromFile, ARenameToFile: string);
begin
end;

procedure TestTSfmlFtp.FtpRetrieveFileHandler(ASender: TIdFTPServerContext;
  const AFilename: string; var AStream: TStream);
begin
end;


procedure TestTSfmlFtp.FtpStoreFileHandler(ASender: TIdFTPServerContext;
  const AFilename: string; AAppend: Boolean; var AStream: TStream);
begin
end;


procedure TestTSfmlFtp.FtpRemoveDirectoryHandler(ASender: TIdFTPServerContext;
  var ADirectory: string);
begin
end;


procedure TestTSfmlFtp.FtpMakeDirectoryHandler(ASender: TIdFTPServerContext;
  var ADirectory: string);
begin
end;


procedure TestTSfmlFtp.FtpGetFileSizeHandler(ASender: TIdFTPServerContext;
  const AFilename: string; var AFileSize: Int64);
begin
end;


procedure TestTSfmlFtp.FtpDeleteFileHandler(ASender: TIdFTPServerContext;
  const APathname: string);
begin
end;


procedure TestTSfmlFtp.FtpChangeDirectoryHandler(ASender: TIdFTPServerContext;
  var ADirectory: string);
begin
end;
{$ENDIF}

procedure TestTSfmlFtp.SetUp;
begin
  FSfmlFtp := TSfmlFtp.Create;
{$IFNDEF FPC}
  if FFtpServer = nil then
  begin
    FFtpServer := TIdFTPServer.Create(nil);
    FFtpServer.DefaultPort := CTestFtpPort;
    FFtpServer.AllowAnonymousLogin := True;
    FFtpServer.OnGetFileSize := FtpGetFileSizeHandler;
    FFtpServer.OnChangeDirectory := FtpChangeDirectoryHandler;
    FFtpServer.OnGetFileSize := FtpGetFileSizeHandler;
    FFtpServer.OnListDirectory := FtpListDirectoryHandler;
    FFtpServer.OnUserLogin := FtpUserLoginHandler;
    FFtpServer.OnRenameFile := FtpRenameFileHandler;
    FFtpServer.OnDeleteFile := FtpDeleteFileHandler;
    FFtpServer.OnRetrieveFile := FtpRetrieveFileHandler;
    FFtpServer.OnStoreFile := FtpStoreFileHandler;
    FFtpServer.OnMakeDirectory := FtpMakeDirectoryHandler;
    FFtpServer.OnRemoveDirectory := FtpRemoveDirectoryHandler;
    FFtpServer.Greeting.NumericCode := 220;
  end;
  FFtpServer.Active := True;
{$ENDIF}
end;

procedure TestTSfmlFtp.TearDown;
begin
{$IFNDEF FPC}
  if FFtpServer <> nil then
  begin
    FFtpServer.Active := False;
    FreeAndNil(FFtpServer);
  end;
{$ENDIF}
  FSfmlFtp.Free;
  FSfmlFtp := nil;
end;

procedure TestTSfmlFtp.TestBasics;
var
  Response: TSfmlFtpResponse;
begin
{$IFDEF FPC}
  Response := FSfmlFtp.Connect(SfmlIpAddressLocalHost, 21, SfmlSeconds(1));
  CheckTrue(Response.Status = sfFtpConnectionFailed);
  CheckFalse(Response.IsOk);
{$ELSE}
  // connect
  Response := FSfmlFtp.Connect(SfmlIpAddressLocalHost, FFtpServer.DefaultPort,
    SfmlSeconds(5));
  CheckTrue(Response.Status <> sfFtpConnectionFailed);

  // disconnect
  Response := FSfmlFtp.Disconnect;
  CheckTrue(Response.Status <> sfFtpConnectionFailed);
{$ENDIF}
end;


{ TestTSfmlHttpRequest }

procedure TestTSfmlHttpRequest.SetUp;
begin
  FSfmlHttpRequest := TSfmlHttpRequest.Create;
end;

procedure TestTSfmlHttpRequest.TearDown;
begin
  FSfmlHttpRequest.Free;
  FSfmlHttpRequest := nil;
end;

procedure TestTSfmlHttpRequest.TestSetField;
begin
  FSfmlHttpRequest.SetField('Foo', 'Bar');
  // TODO: check return values
end;

procedure TestTSfmlHttpRequest.TestSetMethod;
begin
  FSfmlHttpRequest.SetMethod(sfHttpGet);
  FSfmlHttpRequest.SetMethod(sfHttpPost);
  FSfmlHttpRequest.SetMethod(sfHttpHead);
  FSfmlHttpRequest.SetMethod(sfHttpPut);
  FSfmlHttpRequest.SetMethod(sfHttpDelete);
  // TODO: check return values
end;

procedure TestTSfmlHttpRequest.TestSetUri;
begin
  FSfmlHttpRequest.SetUri('www.google.com');
end;

procedure TestTSfmlHttpRequest.TestSetHttpVersion;
begin
  FSfmlHttpRequest.SetHttpVersion(1, 1);
end;

procedure TestTSfmlHttpRequest.TestSetBody;
var
  Body: AnsiString;
begin
  FSfmlHttpRequest.SetBody(Body);
end;


{ TestTSfmlHttp }

procedure TestTSfmlHttp.SetUp;
begin
  FSfmlHttp := TSfmlHttp.Create;
end;

procedure TestTSfmlHttp.TearDown;
begin
  FSfmlHttp.Free;
  FSfmlHttp := nil;
end;

procedure TestTSfmlHttp.TestBasics;
var
  Request: TSfmlHttpRequest;
  ReturnValue: TSfmlHttpResponse;
begin
  FSfmlHttp.SetHost('www.google.com', 80);

  Request := TSfmlHttpRequest.Create;
  Request.SetMethod(sfHttpGet);

  ReturnValue := FSfmlHttp.SendRequest(Request, SfmlSeconds(5));
  CheckTrue(ReturnValue.GetStatus = sfHttpOk);
  // TODO: check return values
end;


{ TestTSfmlPacket }

procedure TestTSfmlPacket.SetUp;
begin
  FSfmlPacket := TSfmlPacket.Create;
end;

procedure TestTSfmlPacket.TearDown;
begin
  FSfmlPacket.Free;
  FSfmlPacket := nil;
end;

procedure TestTSfmlPacket.TestCopy;
var
  ReturnValue: TSfmlPacket;
begin
  ReturnValue := FSfmlPacket.Copy;
  try
    CheckEquals(FSfmlPacket.DataSize, ReturnValue.DataSize);
    CheckEquals(FSfmlPacket.EndOfPacket, ReturnValue.EndOfPacket);
    CheckEquals(FSfmlPacket.CanRead, ReturnValue.CanRead);
  finally
    ReturnValue.Free;
  end;
end;

procedure TestTSfmlPacket.TestAppendGetDataClear;
var
  Data: PByteArray;
  PacketData: PByteArray;
  Index: Integer;
const
  CDataSize = 10;
begin
  GetMem(Data, CDataSize);
  try
    // append some data
    FillChar(Data^, CDataSize, 42);
    FSfmlPacket.Append(Data, CDataSize);

    // ensure the size equals the data size
    CheckEquals(CDataSize, FSfmlPacket.DataSize);

    // get packet data
    PacketData := FSfmlPacket.GetData;

    // check data for validity
    for Index := 0 to CDataSize - 1 do
      CheckEquals(42, PacketData^[Index]);

    // clear contained data
    FSfmlPacket.Clear;

    // ensure the size is zero
    CheckEquals(0, FSfmlPacket.DataSize);
  finally
    Dispose(Data);
  end;
end;

procedure TestTSfmlPacket.TestEndOfPacket;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FSfmlPacket.EndOfPacket;
  CheckTrue(ReturnValue);
end;

procedure TestTSfmlPacket.TestCanRead;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FSfmlPacket.CanRead;
  CheckTrue(ReturnValue);
end;

procedure TestTSfmlPacket.TestReadWrite;
var
  Ansi: AnsiString;
  Wide: UnicodeString;
begin
  // Boolean
  FSfmlPacket.WriteBool(True);
  CheckEquals(True, FSfmlPacket.ReadBool);

  // ShortInt
  FSfmlPacket.Writeint8(123);
  CheckEquals(123, FSfmlPacket.ReadInt8);

  // Byte
  FSfmlPacket.WriteUint8(234);
  CheckEquals(234, FSfmlPacket.ReadUInt8);

  // SmallInt
  FSfmlPacket.WriteInt16(345);
  CheckEquals(345, FSfmlPacket.ReadInt16);

  // Word
  FSfmlPacket.WriteUint16(456);
  CheckEquals(456, FSfmlPacket.ReadUInt16);

  FSfmlPacket.WriteUint16(567);
  CheckEquals(567, FSfmlPacket.ReadUint16);

  FSfmlPacket.WriteInt32(678);
  CheckEquals(678, FSfmlPacket.ReadInt32);

  FSfmlPacket.WriteUint32(789);
  CheckEquals(789, FSfmlPacket.ReadUint32);

  FSfmlPacket.WriteInt64(890);
  CheckEquals(Int64(890), FSfmlPacket.ReadInt64);

  FSfmlPacket.WriteUint64(901);
  CheckEquals(UInt64(901), FSfmlPacket.ReadUint64);

  FSfmlPacket.WriteFloat(0.25);
  CheckEquals(0.25, FSfmlPacket.ReadFloat);

  FSfmlPacket.WriteDouble(0.125);
  CheckEquals(0.125, FSfmlPacket.ReadDouble);

  FSfmlPacket.WriteString(AnsiString('Foo'));
  FSfmlPacket.ReadString(Ansi);
  CheckEquals(AnsiString('Foo'), Ansi);

  FSfmlPacket.WriteWideString('Bar');
  FSfmlPacket.ReadWideString(Wide);
  CheckEquals('Bar', Wide);
end;


{ TestTSfmlSocketSelector }

procedure TestTSfmlSocketSelector.SetUp;
begin
  FSfmlSocketSelector := TSfmlSocketSelector.Create;
end;

procedure TestTSfmlSocketSelector.TearDown;
begin
  FSfmlSocketSelector.Free;
  FSfmlSocketSelector := nil;
end;

procedure TestTSfmlSocketSelector.TestAddRemoveTcpListener;
var
  Socket: TSfmlTcpListener;
begin
  Socket := TSfmlTcpListener.Create;
  try
    FSfmlSocketSelector.AddTcpListener(Socket.Handle);
    // TODO: check return values

    FSfmlSocketSelector.RemoveTcpListener(Socket.Handle);
    // TODO: check return values
  finally
    Socket.Free;
  end;
end;

procedure TestTSfmlSocketSelector.TestClear;
var
  Socket: TSfmlTcpListener;
begin
  Socket := TSfmlTcpListener.Create;
  try
    FSfmlSocketSelector.AddTcpListener(Socket.Handle);
    FSfmlSocketSelector.Clear;
    // TODO: check return values
  finally
    Socket.Free;
  end;
end;

procedure TestTSfmlSocketSelector.TestWait;
var
  ReturnValue: Boolean;
  Listener: TSfmlTcpListener;
  ClientSocket: TSfmlTcpSocket;
begin
  Listener := TSfmlTcpListener.Create;
  ClientSocket := TSfmlTcpSocket.Create;
  try
    CheckEquals(Ord(sfSocketDone),
      Ord(Listener.Listen(TSfmlTcpListener.AnyPort, SfmlIpAddressLocalHost)));
    FSfmlSocketSelector.AddTcpListener(Listener.Handle);

    CheckEquals(Ord(sfSocketDone), Ord(ClientSocket.Connect(
      SfmlIpAddressLocalHost, Listener.LocalPort, SfmlSeconds(1))));

    ReturnValue := FSfmlSocketSelector.Wait(SfmlSeconds(1));
    CheckTrue(ReturnValue);
    CheckTrue(FSfmlSocketSelector.IsTcpListenerReady(Listener.Handle));
  finally
    ClientSocket.Free;
    Listener.Free;
  end;
end;

procedure TestTSfmlSocketSelector.TestIsTcpListenerReady;
var
  ReturnValue: Boolean;
  Listener: TSfmlTcpListener;
  ClientSocket: TSfmlTcpSocket;
begin
  Listener := TSfmlTcpListener.Create;
  ClientSocket := TSfmlTcpSocket.Create;
  try
    CheckEquals(Ord(sfSocketDone),
      Ord(Listener.Listen(TSfmlTcpListener.AnyPort, SfmlIpAddressLocalHost)));
    FSfmlSocketSelector.AddTcpListener(Listener.Handle);
    CheckEquals(Ord(sfSocketDone), Ord(ClientSocket.Connect(
      SfmlIpAddressLocalHost, Listener.LocalPort, SfmlSeconds(1))));
    CheckTrue(FSfmlSocketSelector.Wait(SfmlSeconds(1)));

    ReturnValue := FSfmlSocketSelector.IsTcpListenerReady(Listener.Handle);
    CheckTrue(ReturnValue);
  finally
    ClientSocket.Free;
    Listener.Free;
  end;
end;

procedure TestTSfmlSocketSelector.TestIsTcpSocketReady;
var
  ReturnValue: Boolean;
  Listener: TSfmlTcpListener;
  ClientSocket: TSfmlTcpSocket;
  ServerSocket: TSfmlTcpSocket;
  Data: Byte;
begin
  ConnectTcpPair(Listener, ClientSocket, ServerSocket);
  try
    FSfmlSocketSelector.AddTcpSocket(ServerSocket.Handle);

    Data := 42;
    CheckEquals(Ord(sfSocketDone), Ord(ClientSocket.Send(@Data, SizeOf(Data))));
    CheckTrue(FSfmlSocketSelector.Wait(SfmlSeconds(1)));

    ReturnValue := FSfmlSocketSelector.IsTcpSocketReady(ServerSocket.Handle);
    CheckTrue(ReturnValue);
  finally
    FreeTcpPair(Listener, ClientSocket, ServerSocket);
  end;
end;

procedure TestTSfmlSocketSelector.TestIsUdpSocketReady;
var
  ReturnValue: Boolean;
  SenderSocket: TSfmlUdpSocket;
  ReceiverSocket: TSfmlUdpSocket;
  Data: Byte;
begin
  PrepareUdpSockets(SenderSocket, ReceiverSocket);
  try
    FSfmlSocketSelector.AddUdpSocket(ReceiverSocket.Handle);

    Data := 24;
    CheckEquals(Ord(sfSocketDone), Ord(SenderSocket.Send(@Data, SizeOf(Data),
      SfmlIpAddressLocalHost, ReceiverSocket.LocalPort)));
    CheckTrue(FSfmlSocketSelector.Wait(SfmlSeconds(1)));

    ReturnValue := FSfmlSocketSelector.IsUdpSocketReady(ReceiverSocket.Handle);
    CheckTrue(ReturnValue);
  finally
    ReceiverSocket.Free;
    SenderSocket.Free;
  end;
end;


{ TestTSfmlTcpListener }

procedure TestTSfmlTcpListener.SetUp;
begin
  FSfmlTcpListener := TSfmlTcpListener.Create;
end;

procedure TestTSfmlTcpListener.TearDown;
begin
  FSfmlTcpListener.Free;
  FSfmlTcpListener := nil;
end;

procedure TestTSfmlTcpListener.TestListen;
var
  ReturnValue: TSfmlSocketStatus;
begin
  ReturnValue := FSfmlTcpListener.Listen(TSfmlTcpListener.AnyPort,
    SfmlIpAddressLocalHost);
  CheckEquals(Ord(sfSocketDone), Ord(ReturnValue));
  CheckTrue(FSfmlTcpListener.LocalPort <> 0);
end;

procedure TestTSfmlTcpListener.TestAccept;
var
  ReturnValue: TSfmlSocketStatus;
  ClientSocket: TSfmlTcpSocket;
  Connected: TSfmlTcpSocket;
begin
  ClientSocket := TSfmlTcpSocket.Create;
  Connected := nil;
  try
    CheckEquals(Ord(sfSocketDone), Ord(FSfmlTcpListener.Listen(
      TSfmlTcpListener.AnyPort, SfmlIpAddressLocalHost)));
    CheckEquals(Ord(sfSocketDone), Ord(ClientSocket.Connect(
      SfmlIpAddressLocalHost, FSfmlTcpListener.LocalPort, SfmlSeconds(1))));

    ReturnValue := FSfmlTcpListener.Accept(Connected);
    CheckEquals(Ord(sfSocketDone), Ord(ReturnValue));
    CheckTrue(Connected <> nil);
  finally
    Connected.Free;
    ClientSocket.Free;
  end;
end;


{ TestTSfmlTcpSocket }

procedure TestTSfmlTcpSocket.SetUp;
begin
  FSfmlTcpSocket := TSfmlTcpSocket.Create;
end;

procedure TestTSfmlTcpSocket.TearDown;
begin
  FSfmlTcpSocket.Free;
  FSfmlTcpSocket := nil;
end;

procedure TestTSfmlTcpSocket.TestGetRemoteAddress;
var
  Listener: TSfmlTcpListener;
  ServerSocket: TSfmlTcpSocket;
  ReturnValue: TSfmlIpAddress;
begin
  Listener := nil;
  ServerSocket := nil;
  ConnectTcpPair(Listener, FSfmlTcpSocket, ServerSocket);
  try
  ReturnValue := FSfmlTcpSocket.GetRemoteAddress;
    CheckEquals(Integer(SfmlIpAddressToInteger(SfmlIpAddressLocalHost)),
      Integer(SfmlIpAddressToInteger(ReturnValue)));
  finally
    FreeTcpPair(Listener, FSfmlTcpSocket, ServerSocket);
    FSfmlTcpSocket := TSfmlTcpSocket.Create;
  end;
end;

procedure TestTSfmlTcpSocket.TestGetRemotePort;
var
  Listener: TSfmlTcpListener;
  ServerSocket: TSfmlTcpSocket;
  ReturnValue: Word;
begin
  Listener := nil;
  ServerSocket := nil;
  ConnectTcpPair(Listener, FSfmlTcpSocket, ServerSocket);
  try
    ReturnValue := FSfmlTcpSocket.GetRemotePort;
    CheckEquals(FSfmlTcpSocket.GetRemotePort, Listener.LocalPort);
  finally
    FreeTcpPair(Listener, FSfmlTcpSocket, ServerSocket);
    FSfmlTcpSocket := TSfmlTcpSocket.Create;
  end;
end;

procedure TestTSfmlTcpSocket.TestConnect;
var
  Listener: TSfmlTcpListener;
  ReturnValue: TSfmlSocketStatus;
  Connected: TSfmlTcpSocket;
begin
  Listener := TSfmlTcpListener.Create;
  Connected := nil;
  try
    CheckEquals(Ord(sfSocketDone), Ord(Listener.Listen(TSfmlTcpListener.AnyPort,
      SfmlIpAddressLocalHost)));
    ReturnValue := FSfmlTcpSocket.Connect(SfmlIpAddressLocalHost,
      Listener.LocalPort, SfmlSeconds(1));
    CheckEquals(Ord(sfSocketDone), Ord(ReturnValue));
    CheckEquals(Ord(sfSocketDone), Ord(Listener.Accept(Connected)));
  finally
    Connected.Free;
    Listener.Free;
  end;
end;

procedure TestTSfmlTcpSocket.TestDisconnect;
begin
  FSfmlTcpSocket.Disconnect;
  // TODO: check return values
end;

procedure TestTSfmlTcpSocket.TestSend;
var
  Listener: TSfmlTcpListener;
  ServerSocket: TSfmlTcpSocket;
  ReturnValue: TSfmlSocketStatus;
  Size: NativeUInt;
  Data: Pointer;
begin
  Listener := nil;
  ServerSocket := nil;
  ConnectTcpPair(Listener, FSfmlTcpSocket, ServerSocket);
  Size := 1024;
  GetMem(Data, Size);
  try
    FillChar(Data^, Size, 0);
    ReturnValue := FSfmlTcpSocket.Send(Data, Size);
    CheckEquals(Ord(sfSocketDone), Ord(ReturnValue));
  finally
    FreeMem(Data);
    FreeTcpPair(Listener, FSfmlTcpSocket, ServerSocket);
    FSfmlTcpSocket := TSfmlTcpSocket.Create;
  end;
end;

procedure TestTSfmlTcpSocket.TestReceive;
var
  Listener: TSfmlTcpListener;
  ServerSocket: TSfmlTcpSocket;
  ReturnValue: TSfmlSocketStatus;
  SizeReceived: NativeUInt;
  Data: array [0 .. 3] of Byte;
  SentData: array [0 .. 3] of Byte;
begin
  Listener := nil;
  ServerSocket := nil;
  ConnectTcpPair(Listener, FSfmlTcpSocket, ServerSocket);
  try
    SentData[0] := 1;
    SentData[1] := 2;
    SentData[2] := 3;
    SentData[3] := 4;
    CheckEquals(Ord(sfSocketDone), Ord(FSfmlTcpSocket.Send(@SentData[0],
      SizeOf(SentData))));
    WaitForTcpSocket(ServerSocket);

    ReturnValue := ServerSocket.Receive(@Data[0], SizeOf(Data), SizeReceived);
    CheckEquals(Ord(sfSocketDone), Ord(ReturnValue));
    CheckEquals(NativeInt(SizeOf(SentData)), NativeInt(SizeReceived));
    CheckTrue(CompareMem(@Data[0], @SentData[0], SizeOf(SentData)));
  finally
    FreeTcpPair(Listener, FSfmlTcpSocket, ServerSocket);
    FSfmlTcpSocket := TSfmlTcpSocket.Create;
  end;
end;

procedure TestTSfmlTcpSocket.TestSendPacket;
var
  Listener: TSfmlTcpListener;
  ServerSocket: TSfmlTcpSocket;
  ReturnValue: TSfmlSocketStatus;
  Packet: TSfmlPacket;
begin
  Listener := nil;
  ServerSocket := nil;
  ConnectTcpPair(Listener, FSfmlTcpSocket, ServerSocket);
  Packet := TSfmlPacket.Create;
  try
    Packet.WriteUint32(42);
    ReturnValue := FSfmlTcpSocket.SendPacket(Packet.Handle);
    CheckEquals(Ord(sfSocketDone), Ord(ReturnValue));
  finally
    Packet.Free;
    FreeTcpPair(Listener, FSfmlTcpSocket, ServerSocket);
    FSfmlTcpSocket := TSfmlTcpSocket.Create;
  end;
end;

procedure TestTSfmlTcpSocket.TestReceivePacket;
var
  Listener: TSfmlTcpListener;
  ServerSocket: TSfmlTcpSocket;
  ReturnValue: TSfmlSocketStatus;
  SentPacket: TSfmlPacket;
  Packet: TSfmlPacket;
begin
  Listener := nil;
  ServerSocket := nil;
  ConnectTcpPair(Listener, FSfmlTcpSocket, ServerSocket);
  SentPacket := TSfmlPacket.Create;
  Packet := TSfmlPacket.Create;
  try
    SentPacket.WriteUint32(1337);
    CheckEquals(Ord(sfSocketDone), Ord(FSfmlTcpSocket.SendPacket(
      SentPacket.Handle)));
    WaitForTcpSocket(ServerSocket);

    ReturnValue := ServerSocket.ReceivePacket(Packet.Handle);
    CheckEquals(Ord(sfSocketDone), Ord(ReturnValue));
    CheckEquals(Cardinal(1337), Packet.ReadUint32);
  finally
    SentPacket.Free;
    Packet.Free;
    FreeTcpPair(Listener, FSfmlTcpSocket, ServerSocket);
    FSfmlTcpSocket := TSfmlTcpSocket.Create;
  end;
end;


{ TestTSfmlUdpSocket }

procedure TestTSfmlUdpSocket.SetUp;
begin
  FSfmlUdpSocket := TSfmlUdpSocket.Create;
end;

procedure TestTSfmlUdpSocket.TearDown;
begin
  FSfmlUdpSocket.Free;
  FSfmlUdpSocket := nil;
end;

procedure TestTSfmlUdpSocket.TestBindUnbind;
var
  ReturnValue: TSfmlSocketStatus;
begin
  ReturnValue := FSfmlUdpSocket.Bind(TSfmlUdpSocket.AnyPort,
    SfmlIpAddressLocalHost);
  CheckEquals(Ord(sfSocketDone), Ord(ReturnValue));
  CheckTrue(FSfmlUdpSocket.LocalPort <> 0);
  FSfmlUdpSocket.Unbind;
end;

procedure TestTSfmlUdpSocket.TestSend;
var
  ReceiverSocket: TSfmlUdpSocket;
  ReturnValue: TSfmlSocketStatus;
  Size: NativeUInt;
  Data: Pointer;
begin
  ReceiverSocket := TSfmlUdpSocket.Create;
  Size := 1024;
  GetMem(Data, Size);
  try
    CheckEquals(Ord(sfSocketDone), Ord(ReceiverSocket.Bind(
      TSfmlUdpSocket.AnyPort, SfmlIpAddressLocalHost)));
    FillChar(Data^, Size, 0);
    ReturnValue := FSfmlUdpSocket.Send(Data, Size, SfmlIpAddressLocalHost,
      ReceiverSocket.LocalPort);
    CheckEquals(Ord(sfSocketDone), Ord(ReturnValue));
  finally
    FreeMem(Data);
    ReceiverSocket.Free;
  end;
end;

procedure TestTSfmlUdpSocket.TestReceive;
var
  SenderSocket: TSfmlUdpSocket;
  ReturnValue: TSfmlSocketStatus;
  Port: Word;
  Address: TSfmlIpAddress;
  SizeReceived: NativeUInt;
  Data: array [0 .. 3] of Byte;
  SentData: array [0 .. 3] of Byte;
begin
  SenderSocket := nil;
  PrepareUdpSockets(SenderSocket, FSfmlUdpSocket);
  try
    SentData[0] := 9;
    SentData[1] := 8;
    SentData[2] := 7;
    SentData[3] := 6;
    CheckEquals(Ord(sfSocketDone), Ord(SenderSocket.Send(@SentData[0],
      SizeOf(SentData), SfmlIpAddressLocalHost, FSfmlUdpSocket.LocalPort)));
    WaitForUdpSocket(FSfmlUdpSocket);

    ReturnValue := FSfmlUdpSocket.Receive(@Data[0], SizeOf(Data), SizeReceived,
      Address, Port);

    CheckEquals(Ord(sfSocketDone), Ord(ReturnValue));
    CheckEquals(NativeInt(SizeOf(SentData)), NativeInt(SizeReceived));
    CheckTrue(CompareMem(@Data[0], @SentData[0], SizeOf(SentData)));
    CheckEquals(Integer(SenderSocket.LocalPort), Integer(Port));
    CheckEquals(Integer(SfmlIpAddressToInteger(SfmlIpAddressLocalHost)),
      Integer(SfmlIpAddressToInteger(Address)));
  finally
    SenderSocket.Free;
    FSfmlUdpSocket.Free;
    FSfmlUdpSocket := TSfmlUdpSocket.Create;
  end;
end;

procedure TestTSfmlUdpSocket.TestSendPacket;
var
  ReceiverSocket: TSfmlUdpSocket;
  ReturnValue: TSfmlSocketStatus;
  Packet: TSfmlPacket;
begin
  ReceiverSocket := TSfmlUdpSocket.Create;
  Packet := TSfmlPacket.Create;
  try
    CheckEquals(Ord(sfSocketDone), Ord(ReceiverSocket.Bind(
      TSfmlUdpSocket.AnyPort, SfmlIpAddressLocalHost)));
    Packet.WriteUint32(77);
    ReturnValue := FSfmlUdpSocket.SendPacket(Packet.Handle, SfmlIpAddressLocalHost,
      ReceiverSocket.LocalPort);
    CheckEquals(Ord(sfSocketDone), Ord(ReturnValue));
  finally
    Packet.Free;
    ReceiverSocket.Free;
  end;
end;

procedure TestTSfmlUdpSocket.TestReceivePacket;
var
  SenderSocket: TSfmlUdpSocket;
  ReturnValue: TSfmlSocketStatus;
  Port: Word;
  Address: TSfmlIpAddress;
  SentPacket: TSfmlPacket;
  Packet: TSfmlPacket;
begin
  SenderSocket := nil;
  PrepareUdpSockets(SenderSocket, FSfmlUdpSocket);
  SentPacket := TSfmlPacket.Create;
  Packet := TSfmlPacket.Create;
  try
    SentPacket.WriteUint32(5150);
    CheckEquals(Ord(sfSocketDone), Ord(SenderSocket.SendPacket(
      SentPacket.Handle, SfmlIpAddressLocalHost, FSfmlUdpSocket.LocalPort)));
    WaitForUdpSocket(FSfmlUdpSocket);

    ReturnValue := FSfmlUdpSocket.ReceivePacket(Packet.Handle, Address, Port);
    CheckEquals(Ord(sfSocketDone), Ord(ReturnValue));
    CheckEquals(Cardinal(5150), Packet.ReadUint32);
  finally
    SentPacket.Free;
    Packet.Free;
    SenderSocket.Free;
    FSfmlUdpSocket.Free;
    FSfmlUdpSocket := TSfmlUdpSocket.Create;
  end;
end;

initialization
  RegisterTest('SfmlNetwork', TestTSfmlFtp.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlHttpRequest.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlHttp.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlPacket.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlSocketSelector.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlTcpListener.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlTcpSocket.Suite);
  RegisterTest('SfmlNetwork', TestTSfmlUdpSocket.Suite);
end.
