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
  TSfmlCursorRecord = record end;
  TSfmlWindowBaseRecord = record end;
  TSfmlWindowRecord = record end;

  // handles for opaque structures
  PSfmlContext = ^TSfmlContextRecord;
  PSfmlCursor = ^TSfmlCursorRecord;
  PSfmlWindowBase = ^TSfmlWindowBaseRecord;
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
  TSfmlGlFunctionPointer = Pointer;
  TSfmlVulkanFunctionPointer = Pointer;

  TSfmlWindowState = (sfWindowed, sfFullscreen);
  TSfmlContextAttributeFlags = Cardinal;
  TSfmlCursorType = (sfCursorArrow, sfCursorArrowWait, sfCursorWait,
    sfCursorText, sfCursorHand, sfCursorSizeHorizontal,
    sfCursorSizeVertical, sfCursorSizeTopLeftBottomRight,
    sfCursorSizeBottomLeftTopRight, sfCursorSizeLeft, sfCursorSizeRight,
    sfCursorSizeTop, sfCursorSizeBottom, sfCursorSizeTopLeft,
    sfCursorSizeBottomRight, sfCursorSizeBottomLeft, sfCursorSizeTopRight,
    sfCursorSizeAll, sfCursorCross, sfCursorHelp, sfCursorNotAllowed);

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
    SRgbCapable: TSfmlBool;
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
  TSfmlContextSetActive = function (Context: PSfmlContext; Active: TSfmlBool): TSfmlBool; cdecl;
  TSfmlContextGetSettings = function (const Context: PSfmlContext): TSfmlContextSettings; cdecl;
  TSfmlContextIsExtensionAvailable = function (const Name: PAnsiChar): TSfmlBool; cdecl;
  TSfmlContextGetFunction = function (const Name: PAnsiChar): TSfmlGlFunctionPointer; cdecl;
  TSfmlContextGetActiveContextId = function : UInt64; cdecl;

  TSfmlClipboardGetString = function : PAnsiChar; cdecl;
  TSfmlClipboardGetUnicodeString = function : PUCS4Char; cdecl;
  TSfmlClipboardSetString = procedure (const Text: PAnsiChar); cdecl;
  TSfmlClipboardSetUnicodeString = procedure (const Text: PUCS4Char); cdecl;

  TSfmlCursorCreateFromPixels = function (const Pixels: PByte; Size, Hotspot: TSfmlVector2u): PSfmlCursor; cdecl;
  TSfmlCursorCreateFromSystem = function (&Type: TSfmlCursorType): PSfmlCursor; cdecl;
  TSfmlCursorDestroy = procedure (const Cursor: PSfmlCursor); cdecl;

  TSfmlKeyboardIsKeyPressed = function (Key: TSfmlKeyCode): TSfmlBool; cdecl;
  TSfmlKeyboardIsScancodePressed = function (Code: TSfmlScanCode): TSfmlBool; cdecl;
  TSfmlKeyboardLocalize = function (Code: TSfmlScanCode): TSfmlKeyCode; cdecl;
  TSfmlKeyboardDelocalize = function (Key: TSfmlKeyCode): TSfmlScanCode; cdecl;
  TSfmlKeyboardGetDescription = function (Code: TSfmlScanCode): PAnsiChar; cdecl;
  TSfmlKeyboardSetVirtualKeyboardVisible =  procedure (Visible: TSfmlBool); cdecl;

  TSfmlJoystickIsConnected = function (Joystick: Cardinal): TSfmlBool; cdecl;
  TSfmlJoystickGetButtonCount = function (Joystick: Cardinal): Cardinal; cdecl;
  TSfmlJoystickHasAxis = function (Joystick: Cardinal; Axis: TSfmlJoystickAxis): TSfmlBool; cdecl;
  TSfmlJoystickIsButtonPressed = function (Joystick, button: Cardinal): TSfmlBool; cdecl;
  TSfmlJoystickGetAxisPosition = function (Joystick: Cardinal; Axis: TSfmlJoystickAxis): Single; cdecl;
  TSfmlJoystickGetIdentification = function (Joystick: Cardinal): TSfmlJoystickIdentification; cdecl;
  TSfmlJoystickUpdate = procedure; cdecl;

  TSfmlMouseIsButtonPressed = function (Button: TSfmlMouseButton): TSfmlBool; cdecl;
  TSfmlMouseGetPositionWindowBase = function (const RelativeTo: PSfmlWindowBase): TSfmlVector2i; cdecl;
  TSfmlMouseSetPositionWindowBase = procedure (Position: TSfmlVector2i; const RelativeTo: PSfmlWindowBase); cdecl;
  TSfmlMouseGetPosition = function (const RelativeTo: PSfmlWindow): TSfmlVector2i; cdecl;
  TSfmlMouseSetPosition = procedure (Position: TSfmlVector2i; const RelativeTo: PSfmlWindow); cdecl;

  TSfmlSensorIsAvailable = function (Sensor: TSfmlSensorType): TSfmlBool; cdecl;
  TSfmlSensorSetEnabled = procedure (Sensor: TSfmlSensorType; Enabled: TSfmlBool); cdecl;
  TSfmlSensorGetValue = function (Sensor: TSfmlSensorType): TSfmlVector3f; cdecl;

  TSfmlTouchIsDown = function (Finger: Cardinal): TSfmlBool; cdecl;
  TSfmlTouchGetPositionWindowBase = function (Finger: Cardinal; const RelativeTo: PSfmlWindowBase): TSfmlVector2i; cdecl;
  TSfmlTouchGetPosition = function (Finger: Cardinal; const RelativeTo: PSfmlWindow): TSfmlVector2i; cdecl;

  TSfmlVideoModeGetDesktopMode = function: TSfmlVideoMode; cdecl;
  TSfmlVideoModeGetFullscreenModes = function (var Count: NativeUInt): PSfmlVideoMode; cdecl;
  TSfmlVideoModeIsValid = function (Mode: TSfmlVideoMode): TSfmlBool; cdecl;

  TSfmlWindowBaseCreate = function (Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyle; State: TSfmlWindowState): PSfmlWindowBase; cdecl;
  TSfmlWindowBaseCreateUnicode = function (Mode: TSfmlVideoMode; const Title: PUCS4Char; Style: TSfmlWindowStyle; State: TSfmlWindowState): PSfmlWindowBase; cdecl;
  TSfmlWindowBaseCreateFromHandle = function (Handle: TSfmlWindowHandle): PSfmlWindowBase; cdecl;
  TSfmlWindowBaseDestroy = procedure (const WindowBase: PSfmlWindowBase); cdecl;
  TSfmlWindowBaseClose = procedure (WindowBase: PSfmlWindowBase); cdecl;
  TSfmlWindowBaseIsOpen = function (const WindowBase: PSfmlWindowBase): TSfmlBool; cdecl;
  TSfmlWindowBasePollEvent = function (WindowBase: PSfmlWindowBase; var Event: TSfmlEvent): TSfmlBool; cdecl;
  TSfmlWindowBaseWaitEvent = function (WindowBase: PSfmlWindowBase; Timeout: TSfmlTime; var Event: TSfmlEvent): TSfmlBool; cdecl;
  TSfmlWindowBaseGetPosition = function (const WindowBase: PSfmlWindowBase): TSfmlVector2i; cdecl;
  TSfmlWindowBaseSetPosition = procedure (WindowBase: PSfmlWindowBase; Position: TSfmlVector2i); cdecl;
  TSfmlWindowBaseGetSize = function (const WindowBase: PSfmlWindowBase): TSfmlVector2u; cdecl;
  TSfmlWindowBaseSetSize = procedure (WindowBase: PSfmlWindowBase; Size: TSfmlVector2u); cdecl;
  TSfmlWindowBaseSetMinimumSize = procedure (WindowBase: PSfmlWindowBase; const MinimumSize: PSfmlVector2u); cdecl;
  TSfmlWindowBaseSetMaximumSize = procedure (WindowBase: PSfmlWindowBase; const MaximumSize: PSfmlVector2u); cdecl;
  TSfmlWindowBaseSetTitle = procedure (WindowBase: PSfmlWindowBase; const Title: PAnsiChar); cdecl;
  TSfmlWindowBaseSetUnicodeTitle = procedure (WindowBase: PSfmlWindowBase; const Title: PUCS4Char); cdecl;
  TSfmlWindowBaseSetIcon = procedure (WindowBase: PSfmlWindowBase; Size: TSfmlVector2u; const Pixels: PByte); cdecl;
  TSfmlWindowBaseSetVisible = procedure (WindowBase: PSfmlWindowBase; Visible: TSfmlBool); cdecl;
  TSfmlWindowBaseSetMouseCursorVisible = procedure (WindowBase: PSfmlWindowBase; Visible: TSfmlBool); cdecl;
  TSfmlWindowBaseSetMouseCursorGrabbed = procedure (WindowBase: PSfmlWindowBase; Grabbed: TSfmlBool); cdecl;
  TSfmlWindowBaseSetMouseCursor = procedure (WindowBase: PSfmlWindowBase; const Cursor: PSfmlCursor); cdecl;
  TSfmlWindowBaseSetKeyRepeatEnabled = procedure (WindowBase: PSfmlWindowBase; Enabled: TSfmlBool); cdecl;
  TSfmlWindowBaseSetJoystickThreshold = procedure (WindowBase: PSfmlWindowBase; Threshold: Single); cdecl;
  TSfmlWindowBaseRequestFocus = procedure (WindowBase: PSfmlWindowBase); cdecl;
  TSfmlWindowBaseHasFocus = function (const WindowBase: PSfmlWindowBase): TSfmlBool; cdecl;
  TSfmlWindowBaseGetNativeHandle = function (const WindowBase: PSfmlWindowBase): TSfmlWindowHandle; cdecl;
  TSfmlWindowBaseCreateVulkanSurface = function (WindowBase: PSfmlWindowBase; Instance, Surface, Allocator: Pointer): TSfmlBool; cdecl;

  TSfmlWindowCreate = function (Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyle; State: TSfmlWindowState; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl;
  TSfmlWindowCreateUnicode = function (Mode: TSfmlVideoMode; const Title: PUCS4Char; Style: TSfmlWindowStyle; State: TSfmlWindowState; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl;
  TSfmlWindowCreateFromHandle = function (Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl;
  TSfmlWindowDestroy = procedure (Window: PSfmlWindow); cdecl;
  TSfmlWindowClose = procedure (Window: PSfmlWindow); cdecl;
  TSfmlWindowIsOpen = function (const Window: PSfmlWindow): TSfmlBool; cdecl;
  TSfmlWindowGetSettings = function (const Window: PSfmlWindow): TSfmlContextSettings; cdecl;
  TSfmlWindowPollEvent = function (Window: PSfmlWindow; var Event: TSfmlEvent): TSfmlBool; cdecl;
  TSfmlWindowWaitEvent = function (Window: PSfmlWindow; Timeout: TSfmlTime; var Event: TSfmlEvent): TSfmlBool; cdecl;
  TSfmlWindowGetPosition = function (const Window: PSfmlWindow): TSfmlVector2i; cdecl;
  TSfmlWindowSetPosition = procedure (Window: PSfmlWindow; Position: TSfmlVector2i); cdecl;
  TSfmlWindowGetSize = function (const Window: PSfmlWindow): TSfmlVector2u; cdecl;
  TSfmlWindowSetSize = procedure (Window: PSfmlWindow; Size: TSfmlVector2u); cdecl;
  TSfmlWindowSetTitle = procedure (Window: PSfmlWindow; const Title: PAnsiChar); cdecl;
  TSfmlWindowSetUnicodeTitle = procedure (Window: PSfmlWindow; const Title: PUCS4Char); cdecl;
  TSfmlWindowSetIcon = procedure (Window: PSfmlWindow; Width, Height: Cardinal; const Pixels: PByte); cdecl;
  TSfmlWindowSetVisible = procedure (Window: PSfmlWindow; Visible: TSfmlBool); cdecl;
  TSfmlWindowSetMouseCursorVisible = procedure (Window: PSfmlWindow; Visible: TSfmlBool); cdecl;
  TSfmlWindowSetMouseCursorGrabbed = procedure (Window: PSfmlWindow; Grabbed: TSfmlBool); cdecl;
  TSfmlWindowSetMouseCursor = procedure (Window: PSfmlWindow; const Cursor: PSfmlCursor); cdecl;
  TSfmlWindowSetVerticalSyncEnabled = procedure (Window: PSfmlWindow; Enabled: TSfmlBool); cdecl;
  TSfmlWindowSetKeyRepeatEnabled = procedure (Window: PSfmlWindow; Enabled: TSfmlBool); cdecl;
  TSfmlWindowSetActive = function (Window: PSfmlWindow; Active: TSfmlBool): TSfmlBool; cdecl;
  TSfmlWindowRequestFocus = procedure (Window: PSfmlWindow); cdecl;
  TSfmlWindowHasFocus = function (const Window: PSfmlWindow): TSfmlBool; cdecl;
  TSfmlWindowDisplay = procedure (Window: PSfmlWindow); cdecl;
  TSfmlWindowSetFramerateLimit = procedure (Window: PSfmlWindow; limit: Cardinal); cdecl;
  TSfmlWindowSetJoystickThreshold = procedure (Window: PSfmlWindow; Threshold: Single); cdecl;
  TSfmlWindowGetNativeHandle = function (const Window: PSfmlWindow): TSfmlWindowHandle; cdecl;
  TSfmlWindowCreateVulkanSurface = function (Window: PSfmlWindow; Instance, Surface, Allocator: Pointer): TSfmlBool; cdecl;
  TSfmlWindowSetMinimumSize = procedure (Window: PSfmlWindow; const MinimumSize: PSfmlVector2u); cdecl;
  TSfmlWindowSetMaximumSize = procedure (Window: PSfmlWindow; const MaximumSize: PSfmlVector2u); cdecl;
  TSfmlVulkanIsAvailable = function (RequireGraphics: TSfmlBool): TSfmlBool; cdecl;
  TSfmlVulkanGetFunction = function (const Name: PAnsiChar): TSfmlVulkanFunctionPointer; cdecl;
  TSfmlVulkanGetGraphicsRequiredInstanceExtensions = function (Count: PNativeUInt): PPAnsiChar; cdecl;

var
  SfmlContextCreate: TSfmlContextCreate;
  SfmlContextDestroy: TSfmlContextDestroy;
  SfmlContextSetActive: TSfmlContextSetActive;
  SfmlContextGetSettings: TSfmlContextGetSettings;
  SfmlContextIsExtensionAvailable: TSfmlContextIsExtensionAvailable;
  SfmlContextGetFunction: TSfmlContextGetFunction;
  SfmlContextGetActiveContextId: TSfmlContextGetActiveContextId;

  SfmlClipboardGetString: TSfmlClipboardGetString;
  SfmlClipboardGetUnicodeString: TSfmlClipboardGetUnicodeString;
  SfmlClipboardSetString: TSfmlClipboardSetString;
  SfmlClipboardSetUnicodeString: TSfmlClipboardSetUnicodeString;

  SfmlCursorCreateFromPixels: TSfmlCursorCreateFromPixels;
  SfmlCursorCreateFromSystem: TSfmlCursorCreateFromSystem;
  SfmlCursorDestroy: TSfmlCursorDestroy;

  SfmlKeyboardIsKeyPressed: TSfmlKeyboardIsKeyPressed;
  SfmlKeyboardIsScancodePressed: TSfmlKeyboardIsScancodePressed;
  SfmlKeyboardLocalize: TSfmlKeyboardLocalize;
  SfmlKeyboardDelocalize: TSfmlKeyboardDelocalize;
  SfmlKeyboardGetDescription: TSfmlKeyboardGetDescription;
  SfmlKeyboardSetVirtualKeyboardVisible: TSfmlKeyboardSetVirtualKeyboardVisible;

  SfmlJoystickIsConnected: TSfmlJoystickIsConnected;
  SfmlJoystickGetButtonCount: TSfmlJoystickGetButtonCount;
  SfmlJoystickHasAxis: TSfmlJoystickHasAxis;
  SfmlJoystickIsButtonPressed: TSfmlJoystickIsButtonPressed;
  SfmlJoystickGetAxisPosition: TSfmlJoystickGetAxisPosition;
  SfmlJoystickGetIdentification: TSfmlJoystickGetIdentification;
  SfmlJoystickUpdate: TSfmlJoystickUpdate;

  SfmlMouseIsButtonPressed: TSfmlMouseIsButtonPressed;
  SfmlMouseGetPositionWindowBase: TSfmlMouseGetPositionWindowBase;
  SfmlMouseSetPositionWindowBase: TSfmlMouseSetPositionWindowBase;
  SfmlMouseGetPosition: TSfmlMouseGetPosition;
  SfmlMouseSetPosition: TSfmlMouseSetPosition;

  SfmlSensorIsAvailable: TSfmlSensorIsAvailable;
  SfmlSensorSetEnabled: TSfmlSensorSetEnabled;
  SfmlSensorGetValue: TSfmlSensorGetValue;

  SfmlTouchIsDown: TSfmlTouchIsDown;
  SfmlTouchGetPositionWindowBase: TSfmlTouchGetPositionWindowBase;
  SfmlTouchGetPosition: TSfmlTouchGetPosition;

  SfmlVideoModeGetDesktopMode: TSfmlVideoModeGetDesktopMode;
  SfmlVideoModeGetFullscreenModes: TSfmlVideoModeGetFullscreenModes;
  SfmlVideoModeIsValid: TSfmlVideoModeIsValid;

  SfmlWindowBaseCreate: TSfmlWindowBaseCreate;
  SfmlWindowBaseCreateUnicode: TSfmlWindowBaseCreateUnicode;
  SfmlWindowBaseCreateFromHandle: TSfmlWindowBaseCreateFromHandle;
  SfmlWindowBaseDestroy: TSfmlWindowBaseDestroy;
  SfmlWindowBaseClose: TSfmlWindowBaseClose;
  SfmlWindowBaseIsOpen: TSfmlWindowBaseIsOpen;
  SfmlWindowBasePollEvent: TSfmlWindowBasePollEvent;
  SfmlWindowBaseWaitEvent: TSfmlWindowBaseWaitEvent;
  SfmlWindowBaseGetPosition: TSfmlWindowBaseGetPosition;
  SfmlWindowBaseSetPosition: TSfmlWindowBaseSetPosition;
  SfmlWindowBaseGetSize: TSfmlWindowBaseGetSize;
  SfmlWindowBaseSetSize: TSfmlWindowBaseSetSize;
  SfmlWindowBaseSetMinimumSize: TSfmlWindowBaseSetMinimumSize;
  SfmlWindowBaseSetMaximumSize: TSfmlWindowBaseSetMaximumSize;
  SfmlWindowBaseSetTitle: TSfmlWindowBaseSetTitle;
  SfmlWindowBaseSetUnicodeTitle: TSfmlWindowBaseSetUnicodeTitle;
  SfmlWindowBaseSetIcon: TSfmlWindowBaseSetIcon;
  SfmlWindowBaseSetVisible: TSfmlWindowBaseSetVisible;
  SfmlWindowBaseSetMouseCursorVisible: TSfmlWindowBaseSetMouseCursorVisible;
  SfmlWindowBaseSetMouseCursorGrabbed: TSfmlWindowBaseSetMouseCursorGrabbed;
  SfmlWindowBaseSetMouseCursor: TSfmlWindowBaseSetMouseCursor;
  SfmlWindowBaseSetKeyRepeatEnabled: TSfmlWindowBaseSetKeyRepeatEnabled;
  SfmlWindowBaseSetJoystickThreshold: TSfmlWindowBaseSetJoystickThreshold;
  SfmlWindowBaseRequestFocus: TSfmlWindowBaseRequestFocus;
  SfmlWindowBaseHasFocus: TSfmlWindowBaseHasFocus;
  SfmlWindowBaseGetNativeHandle: TSfmlWindowBaseGetNativeHandle;
  SfmlWindowBaseCreateVulkanSurface: TSfmlWindowBaseCreateVulkanSurface;

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
  SfmlWindowSetMouseCursor: TSfmlWindowSetMouseCursor;
  SfmlWindowSetVerticalSyncEnabled: TSfmlWindowSetVerticalSyncEnabled;
  SfmlWindowSetKeyRepeatEnabled: TSfmlWindowSetKeyRepeatEnabled;
  SfmlWindowSetActive: TSfmlWindowSetActive;
  SfmlWindowRequestFocus: TSfmlWindowRequestFocus;
  SfmlWindowHasFocus: TSfmlWindowHasFocus;
  SfmlWindowDisplay: TSfmlWindowDisplay;
  SfmlWindowSetFramerateLimit: TSfmlWindowSetFramerateLimit;
  SfmlWindowSetJoystickThreshold: TSfmlWindowSetJoystickThreshold;
  SfmlWindowGetNativeHandle: TSfmlWindowGetNativeHandle;
  SfmlWindowCreateVulkanSurface: TSfmlWindowCreateVulkanSurface;
  SfmlWindowSetMinimumSize: TSfmlWindowSetMinimumSize;
  SfmlWindowSetMaximumSize: TSfmlWindowSetMaximumSize;
  SfmlVulkanIsAvailable: TSfmlVulkanIsAvailable;
  SfmlVulkanGetFunction: TSfmlVulkanGetFunction;
  SfmlVulkanGetGraphicsRequiredInstanceExtensions: TSfmlVulkanGetGraphicsRequiredInstanceExtensions;
{$ELSE}
  function SfmlContextCreate: PSfmlContext; cdecl; external CSfmlWindowLibrary name 'sfContext_create';
  procedure SfmlContextDestroy(Context: PSfmlContext); cdecl; external CSfmlWindowLibrary name 'sfContext_destroy';
  function SfmlContextSetActive(Context: PSfmlContext; Active: TSfmlBool): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfContext_setActive';
  function SfmlContextGetSettings(const Context: PSfmlContext): TSfmlContextSettings; cdecl; external CSfmlWindowLibrary name 'sfContext_getSettings';
  function SfmlContextIsExtensionAvailable(const Name: PAnsiChar): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfContext_isExtensionAvailable';
  function SfmlContextGetFunction(const Name: PAnsiChar): TSfmlGlFunctionPointer; cdecl; external CSfmlWindowLibrary name 'sfContext_getFunction';
  function SfmlContextGetActiveContextId: UInt64; cdecl; external CSfmlWindowLibrary name 'sfContext_getActiveContextId';

  function SfmlClipboardGetString: PAnsiChar; cdecl; external CSfmlWindowLibrary name 'sfClipboard_getString';
  function SfmlClipboardGetUnicodeString: PUCS4Char; cdecl; external CSfmlWindowLibrary name 'sfClipboard_getUnicodeString';
  procedure SfmlClipboardSetString(const Text: PAnsiChar); cdecl; external CSfmlWindowLibrary name 'sfClipboard_setString';
  procedure SfmlClipboardSetUnicodeString(const Text: PUCS4Char); cdecl; external CSfmlWindowLibrary name 'sfClipboard_setUnicodeString';

  function SfmlCursorCreateFromPixels(const Pixels: PByte; Size, Hotspot: TSfmlVector2u): PSfmlCursor; cdecl; external CSfmlWindowLibrary name 'sfCursor_createFromPixels';
  function SfmlCursorCreateFromSystem(&Type: TSfmlCursorType): PSfmlCursor; cdecl; external CSfmlWindowLibrary name 'sfCursor_createFromSystem';
  procedure SfmlCursorDestroy(const Cursor: PSfmlCursor); cdecl; external CSfmlWindowLibrary name 'sfCursor_destroy';

  function SfmlKeyboardIsKeyPressed(Key: TSfmlKeyCode): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfKeyboard_isKeyPressed';
  function SfmlKeyboardIsScancodePressed(Code: TSfmlScanCode): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfKeyboard_isScancodePressed';
  function SfmlKeyboardLocalize(Code: TSfmlScanCode): TSfmlKeyCode; cdecl; external CSfmlWindowLibrary name 'sfKeyboard_localize';
  function SfmlKeyboardDelocalize(Key: TSfmlKeyCode): TSfmlScanCode; cdecl; external CSfmlWindowLibrary name 'sfKeyboard_delocalize';
  function SfmlKeyboardGetDescription(Code: TSfmlScanCode): PAnsiChar; cdecl; external CSfmlWindowLibrary name 'sfKeyboard_getDescription';
  procedure SfmlKeyboardSetVirtualKeyboardVisible(Visible: TSfmlBool); cdecl; external CSfmlWindowLibrary name 'sfKeyboard_setVirtualKeyboardVisible';

  function SfmlJoystickIsConnected(Joystick: Cardinal): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfJoystick_isConnected';
  function SfmlJoystickGetButtonCount(Joystick: Cardinal): Cardinal; cdecl; external CSfmlWindowLibrary name 'sfJoystick_getButtonCount';
  function SfmlJoystickHasAxis(Joystick: Cardinal; Axis: TSfmlJoystickAxis): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfJoystick_hasAxis';
  function SfmlJoystickIsButtonPressed(Joystick, button: Cardinal): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfJoystick_isButtonPressed';
  function SfmlJoystickGetAxisPosition(Joystick: Cardinal; Axis: TSfmlJoystickAxis): Single; cdecl; external CSfmlWindowLibrary name 'sfJoystick_getAxisPosition';
  function SfmlJoystickGetIdentification(Joystick: Cardinal): TSfmlJoystickIdentification; cdecl; external CSfmlWindowLibrary name 'sfJoystick_getIdentification';
  procedure SfmlJoystickUpdate; cdecl; external CSfmlWindowLibrary name 'sfJoystick_update';

  function SfmlMouseIsButtonPressed(Button: TSfmlMouseButton): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfMouse_isButtonPressed';
  function SfmlMouseGetPositionWindowBase(const RelativeTo: PSfmlWindowBase): TSfmlVector2i; cdecl; external CSfmlWindowLibrary name 'sfMouse_getPositionWindowBase';
  procedure SfmlMouseSetPositionWindowBase(Position: TSfmlVector2i; const RelativeTo: PSfmlWindowBase); cdecl; external CSfmlWindowLibrary name 'sfMouse_setPositionWindowBase';
  function SfmlMouseGetPosition(const RelativeTo: PSfmlWindow): TSfmlVector2i; cdecl; external CSfmlWindowLibrary name 'sfMouse_getPosition';
  procedure SfmlMouseSetPosition(Position: TSfmlVector2i; const RelativeTo: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfMouse_setPosition';

  function SfmlSensorIsAvailable(Sensor: TSfmlSensorType): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfSensor_isAvailable';
  procedure SfmlSensorSetEnabled(Sensor: TSfmlSensorType; Enabled: TSfmlBool); cdecl; external CSfmlWindowLibrary name 'sfSensor_setEnabled';
  function SfmlSensorGetValue(Sensor: TSfmlSensorType): TSfmlVector3f; cdecl; external CSfmlWindowLibrary name 'sfSensor_getValue';

  function SfmlTouchIsDown(Finger: Cardinal): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfTouch_isDown';
  function SfmlTouchGetPositionWindowBase(Finger: Cardinal; const RelativeTo: PSfmlWindowBase): TSfmlVector2i; cdecl; external CSfmlWindowLibrary name 'sfTouch_getPositionWindowBase';
  function SfmlTouchGetPosition(Finger: Cardinal; const RelativeTo: PSfmlWindow): TSfmlVector2i; cdecl; external CSfmlWindowLibrary name 'sfTouch_getPosition';

  function SfmlVideoModeGetDesktopMode: TSfmlVideoMode; cdecl; external CSfmlWindowLibrary name 'sfVideoMode_getDesktopMode';
  function SfmlVideoModeGetFullscreenModes(var Count: NativeUInt): PSfmlVideoMode; cdecl; external CSfmlWindowLibrary name 'sfVideoMode_getFullscreenModes';
  function SfmlVideoModeIsValid(Mode: TSfmlVideoMode): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfVideoMode_isValid';

  function SfmlWindowBaseCreate(Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyle; State: TSfmlWindowState): PSfmlWindowBase; cdecl; external CSfmlWindowLibrary name 'sfWindowBase_create';
  function SfmlWindowBaseCreateUnicode(Mode: TSfmlVideoMode; const Title: PUCS4Char; Style: TSfmlWindowStyle; State: TSfmlWindowState): PSfmlWindowBase; cdecl; external CSfmlWindowLibrary name 'sfWindowBase_createUnicode';
  function SfmlWindowBaseCreateFromHandle(Handle: TSfmlWindowHandle): PSfmlWindowBase; cdecl; external CSfmlWindowLibrary name 'sfWindowBase_createFromHandle';
  procedure SfmlWindowBaseDestroy(const WindowBase: PSfmlWindowBase); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_destroy';
  procedure SfmlWindowBaseClose(WindowBase: PSfmlWindowBase); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_close';
  function SfmlWindowBaseIsOpen(const WindowBase: PSfmlWindowBase): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfWindowBase_isOpen';
  function SfmlWindowBasePollEvent(WindowBase: PSfmlWindowBase; var Event: TSfmlEvent): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfWindowBase_pollEvent';
  function SfmlWindowBaseWaitEvent(WindowBase: PSfmlWindowBase; Timeout: TSfmlTime; var Event: TSfmlEvent): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfWindowBase_waitEvent';
  function SfmlWindowBaseGetPosition(const WindowBase: PSfmlWindowBase): TSfmlVector2i; cdecl; external CSfmlWindowLibrary name 'sfWindowBase_getPosition';
  procedure SfmlWindowBaseSetPosition(WindowBase: PSfmlWindowBase; Position: TSfmlVector2i); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_setPosition';
  function SfmlWindowBaseGetSize(const WindowBase: PSfmlWindowBase): TSfmlVector2u; cdecl; external CSfmlWindowLibrary name 'sfWindowBase_getSize';
  procedure SfmlWindowBaseSetSize(WindowBase: PSfmlWindowBase; Size: TSfmlVector2u); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_setSize';
  procedure SfmlWindowBaseSetMinimumSize(WindowBase: PSfmlWindowBase; const MinimumSize: PSfmlVector2u); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_setMinimumSize';
  procedure SfmlWindowBaseSetMaximumSize(WindowBase: PSfmlWindowBase; const MaximumSize: PSfmlVector2u); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_setMaximumSize';
  procedure SfmlWindowBaseSetTitle(WindowBase: PSfmlWindowBase; const Title: PAnsiChar); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_setTitle';
  procedure SfmlWindowBaseSetUnicodeTitle(WindowBase: PSfmlWindowBase; const Title: PUCS4Char); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_setUnicodeTitle';
  procedure SfmlWindowBaseSetIcon(WindowBase: PSfmlWindowBase; Size: TSfmlVector2u; const Pixels: PByte); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_setIcon';
  procedure SfmlWindowBaseSetVisible(WindowBase: PSfmlWindowBase; Visible: TSfmlBool); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_setVisible';
  procedure SfmlWindowBaseSetMouseCursorVisible(WindowBase: PSfmlWindowBase; Visible: TSfmlBool); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_setMouseCursorVisible';
  procedure SfmlWindowBaseSetMouseCursorGrabbed(WindowBase: PSfmlWindowBase; Grabbed: TSfmlBool); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_setMouseCursorGrabbed';
  procedure SfmlWindowBaseSetMouseCursor(WindowBase: PSfmlWindowBase; const Cursor: PSfmlCursor); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_setMouseCursor';
  procedure SfmlWindowBaseSetKeyRepeatEnabled(WindowBase: PSfmlWindowBase; Enabled: TSfmlBool); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_setKeyRepeatEnabled';
  procedure SfmlWindowBaseSetJoystickThreshold(WindowBase: PSfmlWindowBase; Threshold: Single); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_setJoystickThreshold';
  procedure SfmlWindowBaseRequestFocus(WindowBase: PSfmlWindowBase); cdecl; external CSfmlWindowLibrary name 'sfWindowBase_requestFocus';
  function SfmlWindowBaseHasFocus(const WindowBase: PSfmlWindowBase): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfWindowBase_hasFocus';
  function SfmlWindowBaseGetNativeHandle(const WindowBase: PSfmlWindowBase): TSfmlWindowHandle; cdecl; external CSfmlWindowLibrary name 'sfWindowBase_getNativeHandle';
  function SfmlWindowBaseCreateVulkanSurface(WindowBase: PSfmlWindowBase; Instance, Surface, Allocator: Pointer): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfWindowBase_createVulkanSurface';

  function SfmlWindowCreate(Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyle; State: TSfmlWindowState; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl; external CSfmlWindowLibrary name 'sfWindow_create';
  function SfmlWindowCreateUnicode(Mode: TSfmlVideoMode; const Title: PUCS4Char; Style: TSfmlWindowStyle; State: TSfmlWindowState; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl; external CSfmlWindowLibrary name 'sfWindow_createUnicode';
  function SfmlWindowCreateFromHandle(Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings): PSfmlWindow; cdecl; external CSfmlWindowLibrary name 'sfWindow_createFromHandle';
  procedure SfmlWindowDestroy(Window: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfWindow_destroy';
  procedure SfmlWindowClose(Window: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfWindow_close';
  function SfmlWindowIsOpen(const Window: PSfmlWindow): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_isOpen';
  function SfmlWindowGetSettings(const Window: PSfmlWindow): TSfmlContextSettings; cdecl; external CSfmlWindowLibrary name 'sfWindow_getSettings';
  function SfmlWindowPollEvent(Window: PSfmlWindow; var Event: TSfmlEvent): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_pollEvent';
  function SfmlWindowWaitEvent(Window: PSfmlWindow; Timeout: TSfmlTime; var Event: TSfmlEvent): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_waitEvent';
  function SfmlWindowGetPosition(const Window: PSfmlWindow): TSfmlVector2i; cdecl; external CSfmlWindowLibrary name 'sfWindow_getPosition';
  procedure SfmlWindowSetPosition(Window: PSfmlWindow; Position: TSfmlVector2i); cdecl; external CSfmlWindowLibrary name 'sfWindow_setPosition';
  function SfmlWindowGetSize(const Window: PSfmlWindow): TSfmlVector2u; cdecl; external CSfmlWindowLibrary name 'sfWindow_getSize';
  procedure SfmlWindowSetSize(Window: PSfmlWindow; Size: TSfmlVector2u); cdecl; external CSfmlWindowLibrary name 'sfWindow_setSize';
  procedure SfmlWindowSetTitle(Window: PSfmlWindow; const Title: PAnsiChar); cdecl; external CSfmlWindowLibrary name 'sfWindow_setTitle';
  procedure SfmlWindowSetUnicodeTitle(Window: PSfmlWindow; const Title: PUCS4Char); cdecl; external CSfmlWindowLibrary name 'sfWindow_setUnicodeTitle';
  procedure SfmlWindowSetIcon(Window: PSfmlWindow; Width, Height: Cardinal; const Pixels: PByte); cdecl; external CSfmlWindowLibrary name 'sfWindow_setIcon';
  procedure SfmlWindowSetVisible(Window: PSfmlWindow; Visible: TSfmlBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setVisible';
  procedure SfmlWindowSetMouseCursorVisible(Window: PSfmlWindow; Visible: TSfmlBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setMouseCursorVisible';
  procedure SfmlWindowSetMouseCursorGrabbed(Window: PSfmlWindow; Grabbed: TSfmlBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setMouseCursorGrabbed';
  procedure SfmlWindowSetMouseCursor(Window: PSfmlWindow; const Cursor: PSfmlCursor); cdecl; external CSfmlWindowLibrary name 'sfWindow_setMouseCursor';
  procedure SfmlWindowSetFramerateLimit(Window: PSfmlWindow; limit: Cardinal); cdecl; external CSfmlWindowLibrary name 'sfWindow_setFramerateLimit';
  procedure SfmlWindowSetJoystickThreshold(Window: PSfmlWindow; Threshold: Single); cdecl; external CSfmlWindowLibrary name 'sfWindow_setJoystickThreshold';
  procedure SfmlWindowSetVerticalSyncEnabled(Window: PSfmlWindow; Enabled: TSfmlBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setVerticalSyncEnabled';
  procedure SfmlWindowSetKeyRepeatEnabled(Window: PSfmlWindow; Enabled: TSfmlBool); cdecl; external CSfmlWindowLibrary name 'sfWindow_setKeyRepeatEnabled';
  function SfmlWindowSetActive(Window: PSfmlWindow; Active: TSfmlBool): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_setActive';
  procedure SfmlWindowRequestFocus(Window: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfWindow_requestFocus';
  function SfmlWindowHasFocus(const Window: PSfmlWindow): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_hasFocus';
  procedure SfmlWindowDisplay(Window: PSfmlWindow); cdecl; external CSfmlWindowLibrary name 'sfWindow_display';
  function SfmlWindowGetNativeHandle(const Window: PSfmlWindow): TSfmlWindowHandle; cdecl; external CSfmlWindowLibrary name 'sfWindow_getNativeHandle';
  function SfmlWindowCreateVulkanSurface(Window: PSfmlWindow; Instance, Surface, Allocator: Pointer): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfWindow_createVulkanSurface';
  procedure SfmlWindowSetMinimumSize(Window: PSfmlWindow; const MinimumSize: PSfmlVector2u); cdecl; external CSfmlWindowLibrary name 'sfWindow_setMinimumSize';
  procedure SfmlWindowSetMaximumSize(Window: PSfmlWindow; const MaximumSize: PSfmlVector2u); cdecl; external CSfmlWindowLibrary name 'sfWindow_setMaximumSize';
  function SfmlVulkanIsAvailable(RequireGraphics: TSfmlBool): TSfmlBool; cdecl; external CSfmlWindowLibrary name 'sfVulkan_isAvailable';
  function SfmlVulkanGetFunction(const Name: PAnsiChar): TSfmlVulkanFunctionPointer; cdecl; external CSfmlWindowLibrary name 'sfVulkan_getFunction';
  function SfmlVulkanGetGraphicsRequiredInstanceExtensions(Count: PNativeUInt): PPAnsiChar; cdecl; external CSfmlWindowLibrary name 'sfVulkan_getGraphicsRequiredInstanceExtensions';
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
    class function IsExtensionAvailable(const Name: AnsiString): Boolean; static;
    class function GetFunction(const Name: AnsiString): Pointer; static;
    class function GetActiveContextId: UInt64; static;

    property Active: Boolean read FActive write SetActive;
    property Handle: PSfmlContext read FHandle;
  end;

  TSfmlCursor = class
  private
    FHandle: PSfmlCursor;
  public
    constructor Create(const Pixels: PByte; Size, Hotspot: TSfmlVector2u); overload;
    constructor Create(CursorType: TSfmlCursorType); overload;
    destructor Destroy; override;

    property Handle: PSfmlCursor read FHandle;
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
    procedure SetMouseCursor(const Cursor: TSfmlCursor);
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
    procedure SetMouseCursor(const Cursor: TSfmlCursor);
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
    function CreateVulkanSurface(Instance, Surface, Allocator: Pointer): Boolean;

    property Handle: PSfmlWindow read FHandle;
    property MousePosition: TSfmlVector2i read GetMousePosition write SetMousePosition;
    property Position: TSfmlVector2i read GetPosition write SetPosition;
    property Size: TSfmlVector2u read GetSize write SetSize;
  end;

function SfmlVideoMode(Width, Height: Cardinal;
  BitsPerPixel: Cardinal = 32) : TSfmlVideoMode;
function SfmlClipboardGetText: AnsiString;
function SfmlClipboardGetUnicodeText: UnicodeString;
procedure SfmlClipboardSetText(const Text: AnsiString); overload;
procedure SfmlClipboardSetText(const Text: UnicodeString); overload;
function SfmlKeyboardCheckScancodePressed(Code: TSfmlScanCode): Boolean;
function SfmlKeyboardLocalizeScancode(Code: TSfmlScanCode): TSfmlKeyCode;
function SfmlKeyboardDelocalizeKey(Key: TSfmlKeyCode): TSfmlScanCode;
function SfmlKeyboardGetScancodeDescription(Code: TSfmlScanCode): AnsiString;
function SfmlVulkanCheckAvailable(RequireGraphics: Boolean): Boolean;
function SfmlVulkanGetNamedFunctionPointer(const Name: AnsiString): Pointer;
function SfmlVulkanGetRequiredInstanceExtensions(out Count: NativeUInt): PPAnsiChar;

implementation

function SfmlVideoMode(Width, Height: Cardinal; BitsPerPixel: Cardinal = 32): TSfmlVideoMode;
begin
  Result.Width := Width;
  Result.Height := Height;
  Result.BitsPerPixel := BitsPerPixel;
end;

function SfmlClipboardGetText: AnsiString;
begin
  Result := SfmlClipboardGetString;
end;

function SfmlClipboardGetUnicodeText: UnicodeString;
begin
  Result := UCS4StringToUnicodeString(UCS4String(SfmlClipboardGetUnicodeString));
end;

procedure SfmlClipboardSetText(const Text: AnsiString);
begin
  SfmlClipboardSetString(PAnsiChar(Text));
end;

procedure SfmlClipboardSetText(const Text: UnicodeString);
begin
  SfmlClipboardSetUnicodeString(PUCS4Char(UnicodeStringToUCS4String(Text)));
end;

function SfmlKeyboardCheckScancodePressed(Code: TSfmlScanCode): Boolean;
begin
  Result := SfmlKeyboardIsScancodePressed(Code);
end;

function SfmlKeyboardLocalizeScancode(Code: TSfmlScanCode): TSfmlKeyCode;
begin
  Result := SfmlKeyboardLocalize(Code);
end;

function SfmlKeyboardDelocalizeKey(Key: TSfmlKeyCode): TSfmlScanCode;
begin
  Result := SfmlKeyboardDelocalize(Key);
end;

function SfmlKeyboardGetScancodeDescription(Code: TSfmlScanCode): AnsiString;
begin
  Result := SfmlKeyboardGetDescription(Code);
end;

function SfmlVulkanCheckAvailable(RequireGraphics: Boolean): Boolean;
begin
  Result := SfmlVulkanIsAvailable(RequireGraphics);
end;

function SfmlVulkanGetNamedFunctionPointer(const Name: AnsiString): Pointer;
begin
  Result := SfmlVulkanGetFunction(PAnsiChar(Name));
end;

function SfmlVulkanGetRequiredInstanceExtensions(out Count: NativeUInt): PPAnsiChar;
begin
  Result := SfmlVulkanGetGraphicsRequiredInstanceExtensions(@Count);
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

class function TSfmlContext.GetActiveContextId: UInt64;
begin
  Result := SfmlContextGetActiveContextId;
end;

class function TSfmlContext.GetFunction(const Name: AnsiString): Pointer;
begin
  Result := SfmlContextGetFunction(PAnsiChar(Name));
end;

class function TSfmlContext.IsExtensionAvailable(const Name: AnsiString): Boolean;
begin
  Result := SfmlContextIsExtensionAvailable(PAnsiChar(Name));
end;

procedure TSfmlContext.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    SfmlContextSetActive(FHandle, Value);
  end;
end;


{ TSfmlCursor }

constructor TSfmlCursor.Create(const Pixels: PByte; Size, Hotspot: TSfmlVector2u);
begin
  FHandle := SfmlCursorCreateFromPixels(Pixels, Size, Hotspot);
end;

constructor TSfmlCursor.Create(CursorType: TSfmlCursorType);
begin
  FHandle := SfmlCursorCreateFromSystem(CursorType);
end;

destructor TSfmlCursor.Destroy;
begin
  SfmlCursorDestroy(FHandle);
  inherited;
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

function TSfmlWindow.CreateVulkanSurface(Instance, Surface,
  Allocator: Pointer): Boolean;
begin
  Result := SfmlWindowCreateVulkanSurface(FHandle, Instance, Surface, Allocator);
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

procedure TSfmlWindow.SetMouseCursor(const Cursor: TSfmlCursor);
begin
  if Assigned(Cursor) then
    SfmlWindowSetMouseCursor(FHandle, Cursor.Handle)
  else
    SfmlWindowSetMouseCursor(FHandle, nil);
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
      SfmlContextIsExtensionAvailable := BindFunction('sfContext_isExtensionAvailable');
      SfmlContextGetFunction := BindFunction('sfContext_getFunction');
      SfmlContextGetActiveContextId := BindFunction('sfContext_getActiveContextId');
      SfmlClipboardGetString := BindFunction('sfClipboard_getString');
      SfmlClipboardGetUnicodeString := BindFunction('sfClipboard_getUnicodeString');
      SfmlClipboardSetString := BindFunction('sfClipboard_setString');
      SfmlClipboardSetUnicodeString := BindFunction('sfClipboard_setUnicodeString');
      SfmlCursorCreateFromPixels := BindFunction('sfCursor_createFromPixels');
      SfmlCursorCreateFromSystem := BindFunction('sfCursor_createFromSystem');
      SfmlCursorDestroy := BindFunction('sfCursor_destroy');
      SfmlKeyboardIsKeyPressed := BindFunction('sfKeyboard_isKeyPressed');
      SfmlKeyboardIsScancodePressed := BindFunction('sfKeyboard_isScancodePressed');
      SfmlKeyboardLocalize := BindFunction('sfKeyboard_localize');
      SfmlKeyboardDelocalize := BindFunction('sfKeyboard_delocalize');
      SfmlKeyboardGetDescription := BindFunction('sfKeyboard_getDescription');
      SfmlKeyboardSetVirtualKeyboardVisible := BindFunction('sfKeyboard_setVirtualKeyboardVisible');
      SfmlJoystickIsConnected := BindFunction('sfJoystick_isConnected');
      SfmlJoystickGetButtonCount := BindFunction('sfJoystick_getButtonCount');
      SfmlJoystickHasAxis := BindFunction('sfJoystick_hasAxis');
      SfmlJoystickIsButtonPressed := BindFunction('sfJoystick_isButtonPressed');
      SfmlJoystickGetAxisPosition := BindFunction('sfJoystick_getAxisPosition');
      SfmlJoystickGetIdentification := BindFunction('sfJoystick_getIdentification');
      SfmlJoystickUpdate := BindFunction('sfJoystick_update');
      SfmlMouseIsButtonPressed := BindFunction('sfMouse_isButtonPressed');
      SfmlMouseGetPositionWindowBase := BindFunction('sfMouse_getPositionWindowBase');
      SfmlMouseSetPositionWindowBase := BindFunction('sfMouse_setPositionWindowBase');
      SfmlMouseGetPosition := BindFunction('sfMouse_getPosition');
      SfmlMouseSetPosition := BindFunction('sfMouse_setPosition');
      SfmlSensorIsAvailable := BindFunction('sfSensor_isAvailable');
      SfmlSensorSetEnabled := BindFunction('sfSensor_setEnabled');
      SfmlSensorGetValue := BindFunction('sfSensor_getValue');
      SfmlTouchIsDown := BindFunction('sfTouch_isDown');
      SfmlTouchGetPositionWindowBase := BindFunction('sfTouch_getPositionWindowBase');
      SfmlTouchGetPosition := BindFunction('sfTouch_getPosition');
      SfmlVideoModeGetDesktopMode := BindFunction('sfVideoMode_getDesktopMode');
      SfmlVideoModeGetFullscreenModes := BindFunction('sfVideoMode_getFullscreenModes');
      SfmlVideoModeIsValid := BindFunction('sfVideoMode_isValid');
      SfmlWindowBaseCreate := BindFunction('sfWindowBase_create');
      SfmlWindowBaseCreateUnicode := BindFunction('sfWindowBase_createUnicode');
      SfmlWindowBaseCreateFromHandle := BindFunction('sfWindowBase_createFromHandle');
      SfmlWindowBaseDestroy := BindFunction('sfWindowBase_destroy');
      SfmlWindowBaseClose := BindFunction('sfWindowBase_close');
      SfmlWindowBaseIsOpen := BindFunction('sfWindowBase_isOpen');
      SfmlWindowBasePollEvent := BindFunction('sfWindowBase_pollEvent');
      SfmlWindowBaseWaitEvent := BindFunction('sfWindowBase_waitEvent');
      SfmlWindowBaseGetPosition := BindFunction('sfWindowBase_getPosition');
      SfmlWindowBaseSetPosition := BindFunction('sfWindowBase_setPosition');
      SfmlWindowBaseGetSize := BindFunction('sfWindowBase_getSize');
      SfmlWindowBaseSetSize := BindFunction('sfWindowBase_setSize');
      SfmlWindowBaseSetMinimumSize := BindFunction('sfWindowBase_setMinimumSize');
      SfmlWindowBaseSetMaximumSize := BindFunction('sfWindowBase_setMaximumSize');
      SfmlWindowBaseSetTitle := BindFunction('sfWindowBase_setTitle');
      SfmlWindowBaseSetUnicodeTitle := BindFunction('sfWindowBase_setUnicodeTitle');
      SfmlWindowBaseSetIcon := BindFunction('sfWindowBase_setIcon');
      SfmlWindowBaseSetVisible := BindFunction('sfWindowBase_setVisible');
      SfmlWindowBaseSetMouseCursorVisible := BindFunction('sfWindowBase_setMouseCursorVisible');
      SfmlWindowBaseSetMouseCursorGrabbed := BindFunction('sfWindowBase_setMouseCursorGrabbed');
      SfmlWindowBaseSetMouseCursor := BindFunction('sfWindowBase_setMouseCursor');
      SfmlWindowBaseSetKeyRepeatEnabled := BindFunction('sfWindowBase_setKeyRepeatEnabled');
      SfmlWindowBaseSetJoystickThreshold := BindFunction('sfWindowBase_setJoystickThreshold');
      SfmlWindowBaseRequestFocus := BindFunction('sfWindowBase_requestFocus');
      SfmlWindowBaseHasFocus := BindFunction('sfWindowBase_hasFocus');
      SfmlWindowBaseGetNativeHandle := BindFunction('sfWindowBase_getNativeHandle');
      SfmlWindowBaseCreateVulkanSurface := BindFunction('sfWindowBase_createVulkanSurface');
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
      SfmlWindowSetMouseCursor := BindFunction('sfWindow_setMouseCursor');
      SfmlWindowSetVerticalSyncEnabled := BindFunction('sfWindow_setVerticalSyncEnabled');
      SfmlWindowSetKeyRepeatEnabled := BindFunction('sfWindow_setKeyRepeatEnabled');
      SfmlWindowSetActive := BindFunction('sfWindow_setActive');
      SfmlWindowRequestFocus := BindFunction('sfWindow_requestFocus');
      SfmlWindowHasFocus := BindFunction('sfWindow_hasFocus');
      SfmlWindowDisplay := BindFunction('sfWindow_display');
      SfmlWindowSetFramerateLimit := BindFunction('sfWindow_setFramerateLimit');
      SfmlWindowSetJoystickThreshold := BindFunction('sfWindow_setJoystickThreshold');
      SfmlWindowGetNativeHandle := BindFunction('sfWindow_getNativeHandle');
      SfmlWindowCreateVulkanSurface := BindFunction('sfWindow_createVulkanSurface');
      SfmlWindowSetMinimumSize := BindFunction('sfWindow_setMinimumSize');
      SfmlWindowSetMaximumSize := BindFunction('sfWindow_setMaximumSize');
      SfmlVulkanIsAvailable := BindFunction('sfVulkan_isAvailable');
      SfmlVulkanGetFunction := BindFunction('sfVulkan_getFunction');
      SfmlVulkanGetGraphicsRequiredInstanceExtensions := BindFunction('sfVulkan_getGraphicsRequiredInstanceExtensions');
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
