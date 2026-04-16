unit SfmlWindow;

////////////////////////////////////////////////////////////////////////////////
//
// PasSFML - Simple and Fast Multimedia Library for Pascal
// Copyright (C) 2015-2017 Christian-W. Budde (Christian@pcjv.de)
//
// This software is provided 'as-is', without any express or implied warranty.
// In no event will the authors be held liable for any damages arising from the use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it freely,
// subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented;
//    you must not claim that you wrote the original software.
//    If you use this software in a product, an acknowledgment
//    in the product documentation would be appreciated but is not required.
//
// 2. Altered source versions must be plainly marked as such,
//    and must not be misrepresented as being the original software.
//
// 3. This notice may not be removed or altered from any source distribution.
//
////////////////////////////////////////////////////////////////////////////////

interface

{$I Sfml.inc}

uses
  {$IFDEF DynLink}
  {$IFDEF FPC}
    DynLibs,
  {$ENDIF}
  {$ENDIF}
  {$IFDEF MSWindows} Windows, {$ENDIF} SfmlSystem;

const
{$IF Defined(MSWINDOWS)}
  CSfmlWindowLibrary = 'csfml-window-3.dll';
{$ELSEIF Defined(DARWIN) or Defined(MACOS)}
  CSfmlWindowLibrary = 'csfml-window-3.dylib';
{$ELSEIF Defined(UNIX)}
  CSfmlWindowLibrary = 'csfml-window.so';
{$IFEND}

  CSflmJoystickCount       = 8;
  CSflmJoystickButtonCount = 32;
  CSflmJoystickAxisCount   = 8;

type
  // opaque structures
  TSfmlContextRecord = record end;
  TSfmlWindowRecord = record end;

  // handles for opaque structures
  PSfmlContext = ^TSfmlContextRecord;
  PSfmlWindow = ^TSfmlWindowRecord;

  TSfmlVideoMode = record
    Width, Height, BitsPerPixel: Cardinal;
    {$IFDEF RecordConstructors}
    constructor Create(Width, Height, BitsPerPixel: Cardinal);
    {$ENDIF}
  end;
  PSfmlVideoMode = ^TSfmlVideoMode;

{$IF Defined(MSWINDOWS)}
  TSfmlWindowHandle = HWND;
{$ELSEIF Defined(DARWIN) or Defined(MACOS)}
  TSfmlWindowHandle = Pointer;
{$ELSEIF Defined(UNIX)}
  TSfmlWindowHandle = NativeUInt;
{$IFEND}

  TSfmlWindowStyle = Cardinal;
  TSfmlScanCode = LongInt;

  TSfmlWindowState = (sfWindowed, sfFullscreen);
  TSfmlContextAttributeFlags = Cardinal;

const
  sfNone = 0;
  sfTitleBar = 1 shl 0;
  sfResize = 1 shl 1;
  sfClose = 1 shl 2;
  sfDefaultStyle = sfTitleBar or sfResize or sfClose;
  sfContextDefault = 0;
  sfContextCore = 1 shl 0;
  sfContextDebug = 1 shl 2;

type

  TSfmlContextSettings = record
    DepthBits: Cardinal;
    StencilBits: Cardinal;
    AntialiasingLevel: Cardinal;
    MajorVersion: Cardinal;
    MinorVersion: Cardinal;
    AttributeFlags: TSfmlContextAttributeFlags;
    SRgbCapable: LongBool;
  end;
  PSfmlContextSettings = ^TSfmlContextSettings;

  TSfmlEventType = (sfEvtClosed, sfEvtResized, sfEvtLostFocus,
    sfEvtGainedFocus, sfEvtTextEntered, sfEvtKeyPressed, sfEvtKeyReleased,
    sfEvtMouseWheelScrolled, sfEvtMouseButtonPressed,
    sfEvtMouseButtonReleased, sfEvtMouseMoved, sfEvtMouseMovedRaw,
    sfEvtMouseEntered, sfEvtMouseLeft, sfEvtJoystickButtonPressed,
    sfEvtJoystickButtonReleased, sfEvtJoystickMoved, sfEvtJoystickConnected,
    sfEvtJoystickDisconnected, sfEvtTouchBegan, sfEvtTouchMoved,
    sfEvtTouchEnded, sfEvtSensorChanged, sfEvtCount);

  TSfmlKeyCode = (sfKeyUnknown = -1, sfKeyA, sfKeyB, sfKeyC, sfKeyD,
    sfKeyE, sfKeyF, sfKeyG, sfKeyH, sfKeyI, sfKeyJ, sfKeyK, sfKeyL, sfKeyM,
    sfKeyN, sfKeyO, sfKeyP, sfKeyQ, sfKeyR, sfKeyS, sfKeyT, sfKeyU, sfKeyV,
    sfKeyW, sfKeyX, sfKeyY, sfKeyZ, sfKeyNum0, sfKeyNum1, sfKeyNum2,
    sfKeyNum3, sfKeyNum4, sfKeyNum5, sfKeyNum6, sfKeyNum7, sfKeyNum8,
    sfKeyNum9, sfKeyEscape, sfKeyLControl, sfKeyLShift, sfKeyLAlt,
    sfKeyLSystem, sfKeyRControl, sfKeyRShift, sfKeyRAlt, sfKeyRSystem,
    sfKeyMenu, sfKeyLBracket, sfKeyRBracket, sfKeySemiColon, sfKeyComma,
    sfKeyPeriod, sfKeyQuote, sfKeySlash, sfKeyBackSlash, sfKeyTilde,
    sfKeyEqual, sfKeyDash, sfKeySpace, sfKeyReturn, sfKeyBack, sfKeyTab,
    sfKeyPageUp, sfKeyPageDown, sfKeyEnd, sfKeyHome, sfKeyInsert, sfKeyDelete,
    sfKeyAdd, sfKeySubtract, sfKeyMultiply, sfKeyDivide, sfKeyLeft,
    sfKeyRight, sfKeyUp, sfKeyDown, sfKeyNumpad0, sfKeyNumpad1, sfKeyNumpad2,
    sfKeyNumpad3, sfKeyNumpad4, sfKeyNumpad5, sfKeyNumpad6, sfKeyNumpad7,
    sfKeyNumpad8, sfKeyNumpad9, sfKeyF1, sfKeyF2, sfKeyF3, sfKeyF4, sfKeyF5,
    sfKeyF6, sfKeyF7, sfKeyF8, sfKeyF9, sfKeyF10, sfKeyF11, sfKeyF12, sfKeyF13,
    sfKeyF14, sfKeyF15, sfKeyPause);

  TSfmlJoystickAxis = (sfJoystickX, sfJoystickY, sfJoystickZ, sfJoystickR,
    sfJoystickU, sfJoystickV, sfJoystickPovX, sfJoystickPovY);

  TSfmlMouseButton = (sfMouseLeft, sfMouseRight, sfMouseMiddle,
    sfMouseXButton1, sfMouseXButton2);

  TSfmlMouseWheel = (sfMouseVerticalWheel, sfMouseHorizontalWheel);

  TSfmlSensorType = (sfSensorAccelerometer, sfSensorGyroscope,
    sfSensorMagnetometer, sfSensorGravity, sfSensorUserAcceleration,
    sfSensorOrientation);

  TSfmlKeyEvent = record
    EventType: TSfmlEventType;
    Code: TSfmlKeyCode;
    ScanCode: TSfmlScanCode;
    Alt: ByteBool;
    Control: ByteBool;
    Shift: ByteBool;
    System: ByteBool;
  end;

  TSfmlJoystickIdentification = record
    Name: PAnsiChar;
    VendorId: Cardinal;
    ProductId: Cardinal;
  end;

  TSfmlTextEvent = record
    EventType: TSfmlEventType;
    Unicode: Cardinal;
  end;

  TSfmlMouseMoveEvent = record
    EventType: TSfmlEventType;
    X, Y: LongInt;
  end;

  TSfmlMouseButtonEvent = record
    EventType: TSfmlEventType;
    Button: TSfmlMouseButton;
    X, Y: LongInt;
  end;

  TSfmlMouseWheelScrollEvent = record
    EventType: TSfmlEventType;
    Wheel: TSfmlMouseWheel;
    Delta: Single;
    X, Y: LongInt;
  end;

  TSfmlJoystickMoveEvent = record
    EventType: TSfmlEventType;
    JoystickId: Cardinal;
    Axis: TSfmlJoystickAxis;
    Position: Single;
  end;

  TSfmlJoystickButtonEvent = record
    EventType: TSfmlEventType;
    JoystickId, Button: Cardinal;
  end;

  TSfmlJoystickConnectEvent = record
    EventType: TSfmlEventType;
    JoystickId: Cardinal;
  end;

  TSfmlSizeEvent = record
    EventType: TSfmlEventType;
    Width, Height: Cardinal;
  end;

  TSfmlTouchEvent = record
    EventType: TSfmlEventType;
    Finger: Cardinal;
    X, Y: Integer;
  end;

  TSfmlSensorEvent = record
    EventType: TSfmlEventType;
    SensorType: TSfmlSensorType;
    X, Y, Z: Single;
  end;

  TSfmlEvent = record
    case LongInt of
      1 : ( EventType: TSfmlEventType );
      0 : ( Size : TSfmlSizeEvent );
      2 : ( Key : TSfmlKeyEvent );
      3 : ( Text : TSfmlTextEvent );
      4 : ( MouseMove : TSfmlMouseMoveEvent );
      5 : ( MouseButton : TSfmlMouseButtonEvent );
      6 : ( MouseWheelScroll : TSfmlMouseWheelScrollEvent );
      7 : ( JoystickMove : TSfmlJoystickMoveEvent );
      8 : ( JoystickButton : TSfmlJoystickButtonEvent );
      9 : ( JoystickConnect : TSfmlJoystickConnectEvent );
      10 : ( Touch : TSfmlTouchEvent );
      11 : ( Sensor : TSfmlSensorEvent );
    end;
  PSfmlEvent = ^TSfmlEvent;

{$IFDEF DynLink}
  TSfmlContextCreate = function : PSfmlContext; cdecl;
  TSfmlContextDestroy = procedure (Context: PSfmlContext); cdecl;
  TSfmlContextSetActive = function (Context: PSfmlContext; Active: LongBool): LongBool; cdecl;
  TSfmlContextGetSettings = function (const Context: PSfmlContext): TSfmlContextSettings; cdecl;

  TSfmlKeyboardIsKeyPressed = function (Key: TSfmlKeyCode): LongBool; cdecl;
  TSfmlKeyboardSetVirtualKeyboardVisible =  procedure (Visible: LongBool); cdecl;

  TSfmlJoystickIsConnected = function (Joystick: Cardinal): LongBool; cdecl;
  TSfmlJoystickGetButtonCount = function (Joystick: Cardinal): Cardinal; cdecl;
  TSfmlJoystickHasAxis = function (Joystick: Cardinal; Axis: TSfmlJoystickAxis): LongBool; cdecl;
  TSfmlJoystickIsButtonPressed = function (Joystick, button: Cardinal): LongBool; cdecl;
  TSfmlJoystickGetAxisPosition = function (Joystick: Cardinal; Axis: TSfmlJoystickAxis): Single; cdecl;
  TSfmlJoystickGetIdentification = function (Joystick: Cardinal): TSfmlJoystickIdentification; cdecl;
  TSfmlJoystickUpdate = procedure; cdecl;

  TSfmlMouseIsButtonPressed = function (Button: TSfmlMouseButton): LongBool; cdecl;
  TSfmlMouseGetPosition = function (const RelativeTo: PSfmlWindow): TSfmlVector2i; cdecl;
  TSfmlMouseSetPosition = procedure (Position: TSfmlVector2i; const RelativeTo: PSfmlWindow); cdecl;

  TSfmlSensorIsAvailable = function (Sensor: TSfmlSensorType): LongBool; cdecl;
  TSfmlSensorSetEnabled = procedure (Sensor: TSfmlSensorType; Enabled: LongBool); cdecl;
  TSfmlSensorGetValue = function (Sensor: TSfmlSensorType): TSfmlVector3f; cdecl;

  TSfmlTouchIsDown = function (Finger: Cardinal): LongBool; cdecl;
  TSfmlTouchGetPosition = function (Finger: Cardinal; const RelativeTo: PSfmlWindow): TSfmlVector2i; cdecl;

  TSfmlVideoModeGetDesktopMode = function: TSfmlVideoMode; cdecl;
  TSfmlVideoModeGetFullscreenModes = function (var Count: NativeUInt): PSfmlVideoMode; cdecl;
  TSfmlVideoModeIsValid = function (Mode: TSfmlVideoMode): LongBool; cdecl;

  TSfmlWindowCreate = function (Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyle; State: TSfmlWindowState; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl;
  TSfmlWindowCreateUnicode = function (Mode: TSfmlVideoMode; const Title: PUCS4Char; Style: TSfmlWindowStyle; State: TSfmlWindowState; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl;
  TSfmlWindowCreateFromHandle = function (Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl;
  TSfmlWindowDestroy = procedure (Window: PSfmlWindow); cdecl;
  TSfmlWindowClose = procedure (Window: PSfmlWindow); cdecl;
  TSfmlWindowIsOpen = function (const Window: PSfmlWindow): LongBool; cdecl;
  TSfmlWindowGetSettings = function (const Window: PSfmlWindow): TSfmlContextSettings; cdecl;
  TSfmlWindowPollEvent = function (Window: PSfmlWindow; var Event: TSfmlEvent): LongBool; cdecl;
  TSfmlWindowWaitEvent = function (Window: PSfmlWindow; Timeout: TSfmlTime; var Event: TSfmlEvent): LongBool; cdecl;
  TSfmlWindowGetPosition = function (const Window: PSfmlWindow): TSfmlVector2i; cdecl;
  TSfmlWindowSetPosition = procedure (Window: PSfmlWindow; Position: TSfmlVector2i); cdecl;
  TSfmlWindowGetSize = function (const Window: PSfmlWindow): TSfmlVector2u; cdecl;
  TSfmlWindowSetSize = procedure (Window: PSfmlWindow; Size: TSfmlVector2u); cdecl;
  TSfmlWindowSetTitle = procedure (Window: PSfmlWindow; const Title: PAnsiChar); cdecl;
  TSfmlWindowSetUnicodeTitle = procedure (Window: PSfmlWindow; const Title: PUCS4Char); cdecl;
  TSfmlWindowSetIcon = procedure (Window: PSfmlWindow; Width, Height: Cardinal; const Pixels: PByte); cdecl;
  TSfmlWindowSetVisible = procedure (Window: PSfmlWindow; Visible: LongBool); cdecl;
  TSfmlWindowSetMouseCursorVisible = procedure (Window: PSfmlWindow; Visible: LongBool); cdecl;
  TSfmlWindowSetMouseCursorGrabbed = procedure (Window: PSfmlWindow; Grabbed: LongBool); cdecl;
  TSfmlWindowSetVerticalSyncEnabled = procedure (Window: PSfmlWindow; Enabled: LongBool); cdecl;
  TSfmlWindowSetKeyRepeatEnabled = procedure (Window: PSfmlWindow; Enabled: LongBool); cdecl;
  TSfmlWindowSetActive = function (Window: PSfmlWindow; Active: LongBool): LongBool; cdecl;
  TSfmlWindowRequestFocus = procedure (Window: PSfmlWindow); cdecl;
  TSfmlWindowHasFocus = function (const Window: PSfmlWindow): LongBool; cdecl;
  TSfmlWindowDisplay = procedure (Window: PSfmlWindow); cdecl;
  TSfmlWindowSetFramerateLimit = procedure (Window: PSfmlWindow; limit: Cardinal); cdecl;
  TSfmlWindowSetJoystickThreshold = procedure (Window: PSfmlWindow; Threshold: Single); cdecl;
  TSfmlWindowGetNativeHandle = function (const Window: PSfmlWindow): TSfmlWindowHandle; cdecl;
  TSfmlWindowSetMinimumSize = procedure (Window: PSfmlWindow; const MinimumSize: PSfmlVector2u); cdecl;
  TSfmlWindowSetMaximumSize = procedure (Window: PSfmlWindow; const MaximumSize: PSfmlVector2u); cdecl;

var
  SfmlContextCreate: TSfmlContextCreate;
  SfmlContextDestroy: TSfmlContextDestroy;
  SfmlContextSetActive: TSfmlContextSetActive;
  SfmlContextGetSettings: TSfmlContextGetSettings;

  SfmlKeyboardIsKeyPressed: TSfmlKeyboardIsKeyPressed;
  SfmlKeyboardSetVirtualKeyboardVisible: TSfmlKeyboardSetVirtualKeyboardVisible;

  SfmlJoystickIsConnected: TSfmlJoystickIsConnected;
  SfmlJoystickGetButtonCount: TSfmlJoystickGetButtonCount;
  SfmlJoystickHasAxis: TSfmlJoystickHasAxis;
  SfmlJoystickIsButtonPressed: TSfmlJoystickIsButtonPressed;
  SfmlJoystickGetAxisPosition: TSfmlJoystickGetAxisPosition;
  SfmlJoystickGetIdentification: TSfmlJoystickGetIdentification;
  SfmlJoystickUpdate: TSfmlJoystickUpdate;

  SfmlMouseIsButtonPressed: TSfmlMouseIsButtonPressed;
  SfmlMouseGetPosition: TSfmlMouseGetPosition;
  SfmlMouseSetPosition: TSfmlMouseSetPosition;

  SfmlSensorIsAvailable: TSfmlSensorIsAvailable;
  SfmlSensorSetEnabled: TSfmlSensorSetEnabled;
  SfmlSensorGetValue: TSfmlSensorGetValue;

  SfmlTouchIsDown: TSfmlTouchIsDown;
  SfmlTouchGetPosition: TSfmlTouchGetPosition;

  SfmlVideoModeGetDesktopMode: TSfmlVideoModeGetDesktopMode;
  SfmlVideoModeGetFullscreenModes: TSfmlVideoModeGetFullscreenModes;
  SfmlVideoModeIsValid: TSfmlVideoModeIsValid;

  SfmlWindowCreate: TSfmlWindowCreate;
  SfmlWindowCreateUnicode: TSfmlWindowCreateUnicode;
  SfmlWindowCreateFromHandle: TSfmlWindowCreateFromHandle;
  SfmlWindowDestroy: TSfmlWindowDestroy;
  SfmlWindowClose: TSfmlWindowClose;
  SfmlWindowIsOpen: TSfmlWindowIsOpen;
  SfmlWindowGetSettings: TSfmlWindowGetSettings;
  SfmlWindowPollEvent: TSfmlWindowPollEvent;
  SfmlWindowWaitEvent: TSfmlWindowWaitEvent;
  SfmlWindowGetPosition: TSfmlWindowGetPosition;
  SfmlWindowSetPosition: TSfmlWindowSetPosition;
  SfmlWindowGetSize: TSfmlWindowGetSize;
  SfmlWindowSetSize: TSfmlWindowSetSize;
  SfmlWindowSetTitle: TSfmlWindowSetTitle;
  SfmlWindowSetUnicodeTitle: TSfmlWindowSetUnicodeTitle;
  SfmlWindowSetIcon: TSfmlWindowSetIcon;
  SfmlWindowSetVisible: TSfmlWindowSetVisible;
  SfmlWindowSetMouseCursorVisible: TSfmlWindowSetMouseCursorVisible;
  SfmlWindowSetMouseCursorGrabbed: TSfmlWindowSetMouseCursorGrabbed;
  SfmlWindowSetVerticalSyncEnabled: TSfmlWindowSetVerticalSyncEnabled;
  SfmlWindowSetKeyRepeatEnabled: TSfmlWindowSetKeyRepeatEnabled;
  SfmlWindowSetActive: TSfmlWindowSetActive;
  SfmlWindowRequestFocus: TSfmlWindowRequestFocus;
  SfmlWindowHasFocus: TSfmlWindowHasFocus;
  SfmlWindowDisplay: TSfmlWindowDisplay;
  SfmlWindowSetFramerateLimit: TSfmlWindowSetFramerateLimit;
  SfmlWindowSetJoystickThreshold: TSfmlWindowSetJoystickThreshold;
  SfmlWindowGetNativeHandle: TSfmlWindowGetNativeHandle;
  SfmlWindowSetMinimumSize: TSfmlWindowSetMinimumSize;
  SfmlWindowSetMaximumSize: TSfmlWindowSetMaximumSize;
{$ELSE}
  function SfmlContextCreate: PSfmlContext; cdecl; external CSfmlWindowLibrary name 'sfContext_create';
  procedure SfmlContextDestroy(Context: PSfmlContext); cdecl; external CSfmlWindowLibrary name 'sfContext_destroy';
  function SfmlContextSetActive(Context: PSfmlContext; Active: LongBool): LongBool; cdecl; external CSfmlWindowLibrary name 'sfContext_setActive';
  function SfmlContextGetSettings(const Context: PSfmlContext): TSfmlContextSettings; cdecl; external CSfmlWindowLibrary name 'sfContext_getSettings';

  function SfmlKeyboardIsKeyPressed(Key: TSfmlKeyCode): LongBool; cdecl; external CSfmlWindowLibrary name 'sfKeyboard_isKeyPressed';
  procedure SfmlKeyboardSetVirtualKeyboardVisible(Visible: LongBool); cdecl; external CSfmlWindowLibrary name 'sfKeyboard_setVirtualKeyboardVisible';

  function SfmlJoystickIsConnected(Joystick: Cardinal): LongBool; cdecl; external CSfmlWindowLibrary name 'sfJoystick_isConnected';
  function SfmlJoystickGetButtonCount(Joystick: Cardinal): Cardinal; cdecl; external CSfmlWindowLibrary name 'sfJoystick_getButtonCount';
  function SfmlJoystickHasAxis(Joystick: Cardinal; Axis: TSfmlJoystickAxis): LongBool; cdecl; external CSfmlWindowLibrary name 'sfJoystick_hasAxis';
  function SfmlJoystickIsButtonPressed(Joystick, button: Cardinal): LongBool; cdecl; external CSfmlWindowLibrary name 'sfJoystick_isButtonPressed';
  function SfmlJoystickGetAxisPosition(Joystick: Cardinal; Axis: TSfmlJoystickAxis): Single; cdecl; external CSfmlWindowLibrary name 'sfJoystick_getAxisPosition';
  function SfmlJoystickGetIdentification(Joystick: Cardinal): TSfmlJoystickIdentification; cdecl; external CSfmlWindowLibrary name 'sfJoystick_getIdentification';
  procedure SfmlJoystickUpdate; cdecl; external CSfmlWindowLibrary name 'sfJoystick_update';

  function SfmlMouseIsButtonPressed(Button: TSfmlMouseButton): LongBool; cdecl; external CSfmlWindowLibrary name 'sfMouse_isButtonPressed';
  function SfmlMouseGetPosition(const RelativeTo: PSfmlWindow): TSfmlVector2i; cdecl; external CSfmlWindowLibrary name 'sfMouse_getPosition';
  procedure SfmlMouseSetPosition(Position: TSfmlVector2i; const RelativeTo: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfMouse_setPosition';

  function SfmlSensorIsAvailable(Sensor: TSfmlSensorType): LongBool; cdecl; external CSfmlWindowLibrary name 'sfSensor_isAvailable';
  procedure SfmlSensorSetEnabled(Sensor: TSfmlSensorType; Enabled: LongBool); cdecl; external CSfmlWindowLibrary name 'sfSensor_setEnabled';
  function SfmlSensorGetValue(Sensor: TSfmlSensorType): TSfmlVector3f; cdecl; external CSfmlWindowLibrary name 'sfSensor_getValue';

  function SfmlTouchIsDown(Finger: Cardinal): LongBool; cdecl; external CSfmlWindowLibrary name 'sfTouch_isDown';
  function SfmlTouchGetPosition(Finger: Cardinal; const RelativeTo: PSfmlWindow): TSfmlVector2i; cdecl; external CSfmlWindowLibrary name 'sfTouch_getPosition';

  function SfmlVideoModeGetDesktopMode: TSfmlVideoMode; cdecl; external CSfmlWindowLibrary name 'sfVideoMode_getDesktopMode';
  function SfmlVideoModeGetFullscreenModes(var Count: NativeUInt): PSfmlVideoMode; cdecl; external CSfmlWindowLibrary name 'sfVideoMode_getFullscreenModes';
  function SfmlVideoModeIsValid(Mode: TSfmlVideoMode): LongBool; cdecl; external CSfmlWindowLibrary name 'sfVideoMode_isValid';

  function SfmlWindowCreate(Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyle; State: TSfmlWindowState; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl; external CSfmlWindowLibrary name 'sfWindow_create';
  function SfmlWindowCreateUnicode(Mode: TSfmlVideoMode; const Title: PUCS4Char; Style: TSfmlWindowStyle; State: TSfmlWindowState; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl; external CSfmlWindowLibrary name 'sfWindow_createUnicode';
  function SfmlWindowCreateFromHandle(Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl; external CSfmlWindowLibrary name 'sfWindow_createFromHandle';
  procedure SfmlWindowDestroy(Window: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfWindow_destroy';
  procedure SfmlWindowClose(Window: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfWindow_close';
  function SfmlWindowIsOpen(const Window: PSfmlWindow): LongBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_isOpen';
  function SfmlWindowGetSettings(const Window: PSfmlWindow): TSfmlContextSettings; cdecl; external CSfmlWindowLibrary name 'sfWindow_getSettings';
  function SfmlWindowPollEvent(Window: PSfmlWindow; var Event: TSfmlEvent): LongBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_pollEvent';
  function SfmlWindowWaitEvent(Window: PSfmlWindow; Timeout: TSfmlTime; var Event: TSfmlEvent): LongBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_waitEvent';
  function SfmlWindowGetPosition(const Window: PSfmlWindow): TSfmlVector2i; cdecl; external CSfmlWindowLibrary name 'sfWindow_getPosition';
  procedure SfmlWindowSetPosition(Window: PSfmlWindow; Position: TSfmlVector2i); cdecl; external CSfmlWindowLibrary name 'sfWindow_setPosition';
  function SfmlWindowGetSize(const Window: PSfmlWindow): TSfmlVector2u; cdecl; external CSfmlWindowLibrary name 'sfWindow_getSize';
  procedure SfmlWindowSetSize(Window: PSfmlWindow; Size: TSfmlVector2u); cdecl; external CSfmlWindowLibrary name 'sfWindow_setSize';
  procedure SfmlWindowSetTitle(Window: PSfmlWindow; const Title: PAnsiChar); cdecl; external CSfmlWindowLibrary name 'sfWindow_setTitle';
  procedure SfmlWindowSetUnicodeTitle(Window: PSfmlWindow; const Title: PUCS4Char); cdecl; external CSfmlWindowLibrary name 'sfWindow_setUnicodeTitle';
  procedure SfmlWindowSetIcon(Window: PSfmlWindow; Width, Height: Cardinal; const Pixels: PByte); cdecl; external CSfmlWindowLibrary name 'sfWindow_setIcon';
  procedure SfmlWindowSetVisible(Window: PSfmlWindow; Visible: LongBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setVisible';
  procedure SfmlWindowSetMouseCursorVisible(Window: PSfmlWindow; Visible: LongBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setMouseCursorVisible';
  procedure SfmlWindowSetMouseCursorGrabbed(Window: PSfmlWindow; Grabbed: LongBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setMouseCursorGrabbed';
  procedure SfmlWindowSetFramerateLimit(Window: PSfmlWindow; limit: Cardinal); cdecl; external CSfmlWindowLibrary name 'sfWindow_setFramerateLimit';
  procedure SfmlWindowSetJoystickThreshold(Window: PSfmlWindow; Threshold: Single); cdecl; external CSfmlWindowLibrary name 'sfWindow_setJoystickThreshold';
  procedure SfmlWindowSetVerticalSyncEnabled(Window: PSfmlWindow; Enabled: LongBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setVerticalSyncEnabled';
  procedure SfmlWindowSetKeyRepeatEnabled(Window: PSfmlWindow; Enabled: LongBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setKeyRepeatEnabled';
  function SfmlWindowSetActive(Window: PSfmlWindow; Active: LongBool): LongBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_setActive';
  procedure SfmlWindowRequestFocus(Window: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfWindow_requestFocus';
  function SfmlWindowHasFocus(const Window: PSfmlWindow): LongBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_hasFocus';
  procedure SfmlWindowDisplay(Window: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfWindow_display';
  function SfmlWindowGetNativeHandle(const Window: PSfmlWindow): TSfmlWindowHandle; cdecl; external CSfmlWindowLibrary name 'sfWindow_getNativeHandle';
  procedure SfmlWindowSetMinimumSize(Window: PSfmlWindow; const MinimumSize: PSfmlVector2u); cdecl; external CSfmlWindowLibrary name 'sfWindow_setMinimumSize';
  procedure SfmlWindowSetMaximumSize(Window: PSfmlWindow; const MaximumSize: PSfmlVector2u); cdecl; external CSfmlWindowLibrary name 'sfWindow_setMaximumSize';
{$ENDIF}

type
  TSfmlContext = class
  private
    FActive: Boolean;
    FHandle: PSfmlContext;
    procedure SetActive(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    property Active: Boolean read FActive write SetActive;
    property Handle: PSfmlContext read FHandle;
  end;

  ISfmlWindow = interface
    function GetPosition: TSfmlVector2i;
    function GetSize: TSfmlVector2u;
    procedure SetPosition(Position: TSfmlVector2i);
    procedure SetSize(Size: TSfmlVector2u);
    procedure SetTitle(const Title: AnsiString); overload;
    procedure SetTitle(const Title: UnicodeString); overload;
    procedure SetIcon(Width, Height: Cardinal; const Pixels: PByte);
    procedure SetVisible(Visible: Boolean);
    procedure SetVerticalSyncEnabled(Enabled: Boolean);
    procedure SetMouseCursorVisible(Visible: Boolean);
    procedure SetKeyRepeatEnabled(Enabled: Boolean);
    procedure SetFramerateLimit(Limit: Cardinal);
    procedure SetJoystickThreshold(Threshold: Single);
    function SetActive(Active: Boolean): Boolean;

    procedure RequestFocus;
    function HasFocus: Boolean;
    procedure Display;
    function GetNativeHandle: TSfmlWindowHandle;

    procedure Close;
    function IsOpen: Boolean;
    function GetSettings: TSfmlContextSettings;
    function PollEvent(out Event: TSfmlEvent): Boolean;
    function WaitEvent(Timeout: TSfmlTime; out Event: TSfmlEvent): Boolean;

    property Position: TSfmlVector2i read GetPosition write SetPosition;
    property Size: TSfmlVector2u read GetSize write SetSize;
  end;

  TSfmlWindow = class(TInterfacedObject, ISfmlWindow)
  private
    FHandle: PSfmlWindow;
    function GetMousePosition: TSfmlVector2i;
    function GetPosition: TSfmlVector2i;
    function GetSize: TSfmlVector2u;
    procedure SetMousePosition(Position: TSfmlVector2i);
    procedure SetPosition(Position: TSfmlVector2i);
    procedure SetSize(Size: TSfmlVector2u);
  public
    constructor Create(VideoMode: TSfmlVideoMode; Title: AnsiString;
      Style: TSfmlWindowStyle = sfDefaultStyle; State: TSfmlWindowState = sfWindowed); overload;
    constructor Create(VideoMode: TSfmlVideoMode; Title: Unicodestring;
      Style: TSfmlWindowStyle = sfDefaultStyle; State: TSfmlWindowState = sfWindowed); overload;
    constructor Create(VideoMode: TSfmlVideoMode; Title: AnsiString;
      Style: TSfmlWindowStyle; State: TSfmlWindowState; ContextSetting: PSfmlContextSettings); overload;
    constructor Create(VideoMode: TSfmlVideoMode; Title: Unicodestring;
      Style: TSfmlWindowStyle; State: TSfmlWindowState; ContextSetting: PSfmlContextSettings); overload;
    constructor Create(Handle: TSfmlWindowHandle); overload;
    destructor Destroy; override;

    procedure Close;
    function IsOpen: Boolean;
    function GetSettings: TSfmlContextSettings;
    function PollEvent(out Event: TSfmlEvent): Boolean;
    function WaitEvent(Timeout: TSfmlTime; out Event: TSfmlEvent): Boolean;
    procedure SetTitle(const Title: AnsiString); overload;
    procedure SetTitle(const Title: UnicodeString); overload;
    procedure SetIcon(Width, Height: Cardinal; const Pixels: PByte);
    procedure SetVisible(Visible: Boolean);
    procedure SetVerticalSyncEnabled(Enabled: Boolean);
    procedure SetMouseCursorVisible(Visible: Boolean);
    procedure SetMouseCursorGrabbed(Grabbed: Boolean);
    procedure SetKeyRepeatEnabled(Enabled: Boolean);
    procedure SetFramerateLimit(Limit: Cardinal);
    procedure SetJoystickThreshold(Threshold: Single);
    function SetActive(Active: Boolean): Boolean;
    procedure SetMinimumSize(const MinimumSize: PSfmlVector2u);
    procedure SetMaximumSize(const MaximumSize: PSfmlVector2u);

    procedure RequestFocus;
    function HasFocus: Boolean;
    procedure Display;
    function GetNativeHandle: TSfmlWindowHandle;

    property Handle: PSfmlWindow read FHandle;
    property MousePosition: TSfmlVector2i read GetMousePosition write SetMousePosition;
    property Position: TSfmlVector2i read GetPosition write SetPosition;
    property Size: TSfmlVector2u read GetSize write SetSize;
  end;

function SfmlVideoMode(Width, Height: Cardinal;
  BitsPerPixel: Cardinal = 32) : TSfmlVideoMode;

implementation

function SfmlVideoMode(Width, Height: Cardinal; BitsPerPixel: Cardinal = 32): TSfmlVideoMode;
begin
  Result.Width := Width;
  Result.Height := Height;
  Result.BitsPerPixel := BitsPerPixel;
end;


{ TSfmlVideoMode }

{$IFDEF RecordConstructors}
constructor TSfmlVideoMode.Create(Width, Height, BitsPerPixel: Cardinal);
begin
  Self.Width := Width;
  Self.Height := Height;
  Self.BitsPerPixel := BitsPerPixel;
end;
{$ENDIF}


{ TSfmlContext }

constructor TSfmlContext.Create;
begin
  FHandle := SfmlContextCreate;
  FActive := False;
end;

destructor TSfmlContext.Destroy;
begin
  SfmlContextDestroy(FHandle);
  inherited;
end;

procedure TSfmlContext.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    SfmlContextSetActive(FHandle, Value);
  end;
end;


{ TSfmlWindow }

constructor TSfmlWindow.Create(VideoMode: TSfmlVideoMode; Title: AnsiString;
  Style: TSfmlWindowStyle; State: TSfmlWindowState);
begin
  FHandle := SfmlWindowCreate(VideoMode, PAnsiChar(Title), Style, State, nil);
end;

constructor TSfmlWindow.Create(VideoMode: TSfmlVideoMode; Title: UnicodeString;
  Style: TSfmlWindowStyle; State: TSfmlWindowState);
begin
  FHandle := SfmlWindowCreateUnicode(VideoMode,
    PUCS4Char(UnicodeStringToUCS4String(Title)), Style, State, nil);
end;

constructor TSfmlWindow.Create(VideoMode: TSfmlVideoMode; Title: AnsiString;
  Style: TSfmlWindowStyle; State: TSfmlWindowState;
  ContextSetting: PSfmlContextSettings);
begin
  FHandle := SfmlWindowCreate(VideoMode, PAnsiChar(Title), Style, State,
    ContextSetting);
end;

constructor TSfmlWindow.Create(VideoMode: TSfmlVideoMode; Title: UnicodeString;
  Style: TSfmlWindowStyle; State: TSfmlWindowState;
  ContextSetting: PSfmlContextSettings);
begin
  FHandle := SfmlWindowCreateUnicode(VideoMode,
    PUCS4Char(UnicodeStringToUCS4String(Title)), Style, State,
    ContextSetting);
end;

constructor TSfmlWindow.Create(Handle: TSfmlWindowHandle);
begin
  FHandle := SfmlWindowCreateFromHandle(Handle, nil);
end;

destructor TSfmlWindow.Destroy;
begin
  SfmlWindowDestroy(FHandle);
  inherited;
end;

procedure TSfmlWindow.Close;
begin
  SfmlWindowClose(FHandle);
end;

procedure TSfmlWindow.Display;
begin
  SfmlWindowDisplay(FHandle);
end;

function TSfmlWindow.GetMousePosition: TSfmlVector2i;
begin
  Result := SfmlMouseGetPosition(FHandle);
end;

function TSfmlWindow.GetPosition: TSfmlVector2i;
begin
  Result := SfmlWindowGetPosition(FHandle);
end;

function TSfmlWindow.GetSettings: TSfmlContextSettings;
begin
  Result := SfmlWindowGetSettings(FHandle);
end;

function TSfmlWindow.GetSize: TSfmlVector2u;
begin
  Result := SfmlWindowGetSize(FHandle);
end;

function TSfmlWindow.GetNativeHandle: TSfmlWindowHandle;
begin
  Result := SfmlWindowGetNativeHandle(FHandle);
end;

function TSfmlWindow.HasFocus: Boolean;
begin
  Result := SfmlWindowHasFocus(FHandle);
end;

function TSfmlWindow.IsOpen: Boolean;
begin
  Result := SfmlWindowIsOpen(FHandle);
end;

function TSfmlWindow.PollEvent(out Event: TSfmlEvent): Boolean;
begin
  Result := SfmlWindowPollEvent(FHandle, Event);
end;

procedure TSfmlWindow.RequestFocus;
begin
  SfmlWindowRequestFocus(FHandle);
end;

function TSfmlWindow.SetActive(Active: Boolean): Boolean;
begin
  Result := SfmlWindowSetActive(FHandle, Boolean(Active));
end;

procedure TSfmlWindow.SetFramerateLimit(Limit: Cardinal);
begin
  SfmlWindowSetFramerateLimit(FHandle, Limit);
end;

procedure TSfmlWindow.SetIcon(Width, Height: Cardinal; const Pixels: PByte);
begin
  SfmlWindowSetIcon(FHandle, Width, Height, Pixels);
end;

procedure TSfmlWindow.SetJoystickThreshold(Threshold: Single);
begin
  SfmlWindowSetJoystickThreshold(FHandle, Threshold);
end;

procedure TSfmlWindow.SetMinimumSize(const MinimumSize: PSfmlVector2u);
begin
  SfmlWindowSetMinimumSize(FHandle, MinimumSize);
end;

procedure TSfmlWindow.SetMaximumSize(const MaximumSize: PSfmlVector2u);
begin
  SfmlWindowSetMaximumSize(FHandle, MaximumSize);
end;

procedure TSfmlWindow.SetKeyRepeatEnabled(Enabled: Boolean);
begin
  SfmlWindowSetKeyRepeatEnabled(FHandle, Enabled);
end;

procedure TSfmlWindow.SetMouseCursorVisible(Visible: Boolean);
begin
  SfmlWindowSetMouseCursorVisible(FHandle, Visible);
end;

procedure TSfmlWindow.SetMouseCursorGrabbed(Grabbed: Boolean);
begin
  SfmlWindowSetMouseCursorGrabbed(FHandle, Grabbed);
end;

procedure TSfmlWindow.SetMousePosition(Position: TSfmlVector2i);
begin
  SfmlMouseSetPosition(Position, FHandle);
end;

procedure TSfmlWindow.SetPosition(Position: TSfmlVector2i);
begin
  SfmlWindowSetPosition(FHandle, Position);
end;

procedure TSfmlWindow.SetSize(Size: TSfmlVector2u);
begin
  SfmlWindowSetSize(FHandle, Size);
end;

procedure TSfmlWindow.SetTitle(const Title: AnsiString);
begin
  SfmlWindowSetTitle(FHandle, PAnsiChar(Title));
end;

procedure TSfmlWindow.SetTitle(const Title: UnicodeString);
begin
  SfmlWindowSetUnicodeTitle(FHandle, PUCS4Char(UnicodeStringToUCS4String(Title)));
end;

procedure TSfmlWindow.SetVerticalSyncEnabled(Enabled: Boolean);
begin
  SfmlWindowSetVerticalSyncEnabled(FHandle, Enabled);
end;

procedure TSfmlWindow.SetVisible(Visible: Boolean);
begin
  SfmlWindowSetVisible(FHandle, Visible);
end;

function TSfmlWindow.WaitEvent(Timeout: TSfmlTime; out Event: TSfmlEvent): Boolean;
begin
  Result := SfmlWindowWaitEvent(FHandle, Timeout, Event);
end;

{$IFDEF DynLink}

var
  CSfmlWindowHandle: {$IFDEF FPC}TLibHandle{$ELSE}HINST{$ENDIF};

procedure InitDLL;

  function BindFunction(Name: AnsiString): Pointer;
  begin
    Result := GetProcAddress(CSfmlWindowHandle, PAnsiChar(Name));
    Assert(Assigned(Result));
  end;

begin
  // dynamically load external library
  {$IFDEF FPC}
  CSfmlWindowHandle := LoadLibrary(CSfmlWindowLibrary);
  {$ELSE}
  CSfmlWindowHandle := LoadLibraryA(CSfmlWindowLibrary);
  {$ENDIF}

  if CSfmlWindowHandle <> 0 then
    try
      SfmlContextCreate := BindFunction('sfContext_create');
      SfmlContextDestroy := BindFunction('sfContext_destroy');
      SfmlContextSetActive := BindFunction('sfContext_setActive');
      SfmlContextGetSettings := BindFunction('sfContext_getSettings');
      SfmlKeyboardIsKeyPressed := BindFunction('sfKeyboard_isKeyPressed');
      SfmlKeyboardSetVirtualKeyboardVisible := BindFunction('sfKeyboard_setVirtualKeyboardVisible');
      SfmlJoystickIsConnected := BindFunction('sfJoystick_isConnected');
      SfmlJoystickGetButtonCount := BindFunction('sfJoystick_getButtonCount');
      SfmlJoystickHasAxis := BindFunction('sfJoystick_hasAxis');
      SfmlJoystickIsButtonPressed := BindFunction('sfJoystick_isButtonPressed');
      SfmlJoystickGetAxisPosition := BindFunction('sfJoystick_getAxisPosition');
      SfmlJoystickGetIdentification := BindFunction('sfJoystick_getIdentification');
      SfmlJoystickUpdate := BindFunction('sfJoystick_update');
      SfmlMouseIsButtonPressed := BindFunction('sfMouse_isButtonPressed');
      SfmlMouseGetPosition := BindFunction('sfMouse_getPosition');
      SfmlMouseSetPosition := BindFunction('sfMouse_setPosition');
      SfmlSensorIsAvailable := BindFunction('sfSensor_isAvailable');
      SfmlSensorSetEnabled := BindFunction('sfSensor_setEnabled');
      SfmlSensorGetValue := BindFunction('sfSensor_getValue');
      SfmlTouchIsDown := BindFunction('sfTouch_isDown');
      SfmlTouchGetPosition := BindFunction('sfTouch_getPosition');
      SfmlVideoModeGetDesktopMode := BindFunction('sfVideoMode_getDesktopMode');
      SfmlVideoModeGetFullscreenModes := BindFunction('sfVideoMode_getFullscreenModes');
      SfmlVideoModeIsValid := BindFunction('sfVideoMode_isValid');
      SfmlWindowCreate := BindFunction('sfWindow_create');
      SfmlWindowCreateUnicode := BindFunction('sfWindow_createUnicode');
      SfmlWindowCreateFromHandle := BindFunction('sfWindow_createFromHandle');
      SfmlWindowDestroy := BindFunction('sfWindow_destroy');
      SfmlWindowClose := BindFunction('sfWindow_close');
      SfmlWindowIsOpen := BindFunction('sfWindow_isOpen');
      SfmlWindowGetSettings := BindFunction('sfWindow_getSettings');
      SfmlWindowPollEvent := BindFunction('sfWindow_pollEvent');
      SfmlWindowWaitEvent := BindFunction('sfWindow_waitEvent');
      SfmlWindowGetPosition := BindFunction('sfWindow_getPosition');
      SfmlWindowSetPosition := BindFunction('sfWindow_setPosition');
      SfmlWindowGetSize := BindFunction('sfWindow_getSize');
      SfmlWindowSetSize := BindFunction('sfWindow_setSize');
      SfmlWindowSetTitle := BindFunction('sfWindow_setTitle');
      SfmlWindowSetUnicodeTitle := BindFunction('sfWindow_setUnicodeTitle');
      SfmlWindowSetIcon := BindFunction('sfWindow_setIcon');
      SfmlWindowSetVisible := BindFunction('sfWindow_setVisible');
      SfmlWindowSetMouseCursorVisible := BindFunction('sfWindow_setMouseCursorVisible');
      SfmlWindowSetMouseCursorGrabbed := BindFunction('sfWindow_setMouseCursorGrabbed');
      SfmlWindowSetVerticalSyncEnabled := BindFunction('sfWindow_setVerticalSyncEnabled');
      SfmlWindowSetKeyRepeatEnabled := BindFunction('sfWindow_setKeyRepeatEnabled');
      SfmlWindowSetActive := BindFunction('sfWindow_setActive');
      SfmlWindowRequestFocus := BindFunction('sfWindow_requestFocus');
      SfmlWindowHasFocus := BindFunction('sfWindow_hasFocus');
      SfmlWindowDisplay := BindFunction('sfWindow_display');
      SfmlWindowSetFramerateLimit := BindFunction('sfWindow_setFramerateLimit');
      SfmlWindowSetJoystickThreshold := BindFunction('sfWindow_setJoystickThreshold');
      SfmlWindowGetNativeHandle := BindFunction('sfWindow_getNativeHandle');
      SfmlWindowSetMinimumSize := BindFunction('sfWindow_setMinimumSize');
      SfmlWindowSetMaximumSize := BindFunction('sfWindow_setMaximumSize');
    except
      FreeLibrary(CSfmlWindowHandle);
      CSfmlWindowHandle := 0;
    end;
end;

procedure FreeDLL;
begin
  if CSfmlWindowHandle <> 0 then
    FreeLibrary(CSfmlWindowHandle);
end;

initialization

InitDLL;

finalization

FreeDLL;

{$ENDIF}
end.
