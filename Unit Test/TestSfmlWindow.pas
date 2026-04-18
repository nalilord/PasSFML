unit TestSfmlWindow;

{$I ..\Source\Sfml.inc}

interface

uses
{$IFNDEF FPC}
  TestFramework,
{$ELSE}
  FPCUnit, TestUtils, TestRegistry,
{$ENDIF}
  SfmlSystem, SfmlWindow;

type
  TestTSfmlVideoMode = class(TTestCase)
  published
    procedure TestDesktopMode;
    procedure TestFullscreenModes;
  end;

  TestTSfmlWindow = class(TTestCase)
  strict private
    FSfmlWindow: TSfmlWindow;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestBasics;
    procedure TestSetTitle;
    procedure TestSetUnicodeTitle;
  end;

implementation

{ TestTSfmlWindow }

procedure TestTSfmlWindow.SetUp;
begin
  FSfmlWindow := TSfmlWindow.Create(SfmlVideoMode(800, 600),
    'Test', sfTitleBar or sfResize or sfClose, sfWindowed);
end;

procedure TestTSfmlWindow.TearDown;
begin
  FSfmlWindow.Free;
  FSfmlWindow := nil;
end;

procedure TestTSfmlWindow.TestBasics;
var
  Settings: TSfmlContextSettings;
begin
  // get settings
  Settings := FSfmlWindow.GetSettings;

  CheckTrue(FSfmlWindow.IsOpen);

  // display window
  FSfmlWindow.Display;

  // close window
  FSfmlWindow.Close;
  CheckFalse(FSfmlWindow.IsOpen);
end;

procedure TestTSfmlWindow.TestSetTitle;
begin
  FSfmlWindow.SetTitle(AnsiString('ANSI Title'));
  FSfmlWindow.Display;

  // close window
  FSfmlWindow.Close;
  CheckFalse(FSfmlWindow.IsOpen);
end;

procedure TestTSfmlWindow.TestSetUnicodeTitle;
begin
  FSfmlWindow.SetTitle(UnicodeString('Unicode Title'));
  FSfmlWindow.Display;

  // close window
  FSfmlWindow.Close;
  CheckFalse(FSfmlWindow.IsOpen);
end;

{ TestTSfmlVideoMode }

procedure TestTSfmlVideoMode.TestDesktopMode;
var
  VideoMode: TSfmlVideoMode;
begin
  VideoMode := SfmlVideoModeGetDesktopMode;
  CheckTrue(VideoMode.Width > 0);
  CheckTrue(VideoMode.Height > 0);
  CheckTrue(VideoMode.BitsPerPixel > 0);
  CheckTrue(SfmlVideoModeIsValid(VideoMode));
end;

procedure TestTSfmlVideoMode.TestFullscreenModes;
var
  Index, Count: NativeUInt;
  VideoModes: PSfmlVideoMode;
begin
  VideoModes := SfmlVideoModeGetFullscreenModes(Count);
  CheckTrue(Count > 0);

  for Index := 0 to Count - 1 do
  begin
    CheckTrue(VideoModes^.Width > 0);
    CheckTrue(VideoModes^.Height > 0);
    CheckTrue(VideoModes^.BitsPerPixel > 0);
    CheckTrue(SfmlVideoModeIsValid(VideoModes^));

    Inc(VideoModes);
  end;
end;

initialization
  RegisterTest('SfmlWindow', TestTSfmlVideoMode.Suite);
  RegisterTest('SfmlWindow', TestTSfmlWindow.Suite);
end.
