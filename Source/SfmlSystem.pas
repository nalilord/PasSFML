unit SfmlSystem;

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

const
{$IF Defined(MSWINDOWS)}
  CSfmlSystemLibrary = 'csfml-system-3.dll';
{$ELSEIF Defined(DARWIN) or Defined(MACOS)}
  CSfmlSystemLibrary = 'csfml-system-3.dylib';
{$ELSEIF Defined(UNIX)}
  CSfmlSystemLibrary = 'csfml-system.so';
{$IFEND}

  CSFML_VERSION_MAJOR = 3;
  CSFML_VERSION_MINOR = 0;
  CSFML_VERSION_PATCH = 0;

type
  TSfmlBool = Boolean;

  // opaque structures
  TSfmlBufferRecord = record end;
  TSfmlClockRecord = record end;
  TSfmlMutexRecord = record end;
  TSfmlThreadRecord = record end;

  // handles for opaque structures
  PSfmlBuffer = ^TSfmlBufferRecord;
  PSfmlClock = ^TSfmlClockRecord;
  PSfmlMutex = ^TSfmlMutexRecord;
  PSfmlThread = ^TSfmlThreadRecord;

  TSfmlTime = record
    MicroSeconds: Int64;
    function AsMilliseconds: LongInt;
    function AsSeconds: Single;
    {$IFDEF RecordConstructors}
    constructor Create(MicroSeconds: LongInt);
    {$ENDIF}
    {$IFDEF RecordOperators}
    class operator Equal(const Lhs, Rhs: TSfmlTime): Boolean;
    class operator Add(const Lhs, Rhs: TSfmlTime): TSfmlTime;
    class operator Subtract(const Lhs, Rhs: TSfmlTime): TSfmlTime;
    {$ENDIF}
  end;

  TSfmlVector2i = record
    X, Y: LongInt;
    {$IFDEF RecordConstructors}
    constructor Create(X, Y: LongInt);
    {$ENDIF}
    {$IFDEF RecordOperators}
    class operator Equal(const Lhs, Rhs: TSfmlVector2i): Boolean;
    class operator Add(const Lhs, Rhs: TSfmlVector2i): TSfmlVector2i;
    class operator Subtract(const Lhs, Rhs: TSfmlVector2i): TSfmlVector2i;
    {$ENDIF}
  end;

  PSfmlVector2u = ^TSfmlVector2u;
  TSfmlVector2u = record
    X, Y: Cardinal;
    {$IFDEF RecordConstructors}
    constructor Create(X, Y: Cardinal);
    {$ENDIF}
    {$IFDEF RecordOperators}
    class operator Equal(const Lhs, Rhs: TSfmlVector2u): Boolean;
    class operator Add(const Lhs, Rhs: TSfmlVector2u): TSfmlVector2u;
    class operator Subtract(const Lhs, Rhs: TSfmlVector2u): TSfmlVector2u;
    {$ENDIF}
  end;

  TSfmlVector2f = record
    X, Y : Single;
    {$IFDEF RecordConstructors}
    constructor Create(X, Y: Double);
    {$ENDIF}
    {$IFDEF RecordOperators}
    class operator Equal(const Lhs, Rhs: TSfmlVector2f): Boolean;
    class operator Add(const Lhs, Rhs: TSfmlVector2f): TSfmlVector2f;
    class operator Subtract(const Lhs, Rhs: TSfmlVector2f): TSfmlVector2f;
    class operator Multiply(const Lhs, Rhs: TSfmlVector2f): TSfmlVector2f;
    class operator Divide(const Lhs, Rhs: TSfmlVector2f): TSfmlVector2f;
    class operator Multiply(const Lhs: TSfmlVector2f; Rhs: Single): TSfmlVector2f;
    class operator Divide(const Lhs: TSfmlVector2f; Rhs: Single): TSfmlVector2f;
    {$ENDIF}
  end;

  TSfmlVector3f = record
    X, Y, Z: Single;
    {$IFDEF RecordConstructors}
    constructor Create(X, Y, Z: Single);
    {$ENDIF}
    {$IFDEF RecordOperators}
    class operator Equal(const Lhs, Rhs: TSfmlVector3f): Boolean;
    class operator Add(const Lhs, Rhs: TSfmlVector3f): TSfmlVector3f;
    class operator Subtract(const Lhs, Rhs: TSfmlVector3f): TSfmlVector3f;
    {$ENDIF}
  end;

  TSfmlInputStreamReadFunc = function (Data: Pointer; Size: Int64; UserData: Pointer): Int64; cdecl;
  TSfmlInputStreamSeekFunc = function (Position: Int64; UserData: Pointer): Int64; cdecl;
  TSfmlInputStreamTellFunc = function (UserData: Pointer): Int64; cdecl;
  TSfmlInputStreamGetSizeFunc = function (UserData: Pointer): Int64; cdecl;

  TSfmlInputStream = record
    Read: TSfmlInputStreamReadFunc;
    Seek: TSfmlInputStreamSeekFunc;
    Tell: TSfmlInputStreamTellFunc;
    GetSize: TSfmlInputStreamGetSizeFunc;
    UserData: Pointer;
  end;
  PSfmlInputStream = ^TSfmlInputStream;

  TSfmlThreadEntryPoint = procedure (UserData: Pointer); cdecl;

{$IFDEF DynLink}
  TSfmlTimeAsSeconds = function (Time: TSfmlTime): Single; cdecl;
  TSfmlTimeAsMilliseconds = function (Time: TSfmlTime): LongInt; cdecl;
  TSfmlTimeAsMicroseconds = function (Time: TSfmlTime): Int64; cdecl;

  TSfmlSeconds = function (Amount: Single): TSfmlTime; cdecl;
  TSfmlMilliseconds = function (Amount: LongInt): TSfmlTime; cdecl;
  TSfmlMicroseconds = function (Amount: Int64): TSfmlTime; cdecl;

  TSfmlBufferCreate = function : PSfmlBuffer; cdecl;
  TSfmlBufferDestroy = procedure (Buffer: PSfmlBuffer); cdecl;
  TSfmlBufferGetSize = function (const Buffer: PSfmlBuffer): NativeUInt; cdecl;
  TSfmlBufferGetData = function (const Buffer: PSfmlBuffer): PByte; cdecl;
  TSfmlFree = procedure (Ptr: Pointer); cdecl;

  TSfmlClockCreate = function : PSfmlClock; cdecl;
  TSfmlClockCopy = function (const Clock: PSfmlClock): PSfmlClock; cdecl;
  TSfmlClockDestroy = procedure (Clock: PSfmlClock); cdecl;
  TSfmlClockGetElapsedTime = function (const Clock: PSfmlClock): TSfmlTime; cdecl;
  TSfmlClockRestart = function (Clock: PSfmlClock): TSfmlTime; cdecl;
  TSfmlClockIsRunning = function (const Clock: PSfmlClock): TSfmlBool; cdecl;
  TSfmlClockStart = procedure (Clock: PSfmlClock); cdecl;
  TSfmlClockStop = procedure (Clock: PSfmlClock); cdecl;
  TSfmlClockReset = function (Clock: PSfmlClock): TSfmlTime; cdecl;

  TSfmlMutexCreate = function : PSfmlMutex; cdecl;
  TSfmlMutexDestroy = procedure (Mutex: PSfmlMutex); cdecl;

  TSfmlMutexLock = procedure (Mutex: PSfmlMutex); cdecl;
  TSfmlMutexUnlock = procedure (Mutex: PSfmlMutex); cdecl;

  TSfmlSleep = procedure (Duration: TSfmlTime); cdecl;

  TSfmlThreadCreate = function (ThreadEntryPoint: TSfmlThreadEntryPoint; UserData: Pointer): PSfmlThread; cdecl;
  TSfmlThreadDestroy = procedure (Thread: PSfmlThread); cdecl;
  TSfmlThreadLaunch = procedure (Thread: PSfmlThread); cdecl;
  TSfmlThreadWait = procedure (Thread: PSfmlThread); cdecl;
  TSfmlThreadTerminate = procedure (Thread: PSfmlThread); cdecl;

var
  SfmlTimeZero: TSfmlTime;
  SfmlTimeAsSeconds: TSfmlTimeAsSeconds;
  SfmlTimeAsMilliseconds: TSfmlTimeAsMilliseconds;
  SfmlTimeAsMicroseconds: TSfmlTimeAsMicroseconds;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlSeconds: TSfmlSeconds;
  SfmlMilliseconds: TSfmlMilliseconds;
  SfmlMicroseconds: TSfmlMicroseconds;
{$ENDIF}

  SfmlBufferCreate: TSfmlBufferCreate;
  SfmlBufferDestroy: TSfmlBufferDestroy;
  SfmlBufferGetSize: TSfmlBufferGetSize;
  SfmlBufferGetData: TSfmlBufferGetData;
  SfmlFree: TSfmlFree;

  SfmlClockCreate: TSfmlClockCreate;
  SfmlClockCopy: TSfmlClockCopy;
  SfmlClockDestroy: TSfmlClockDestroy;
  SfmlClockIsRunning: TSfmlClockIsRunning;
  SfmlClockStart: TSfmlClockStart;
  SfmlClockStop: TSfmlClockStop;
{$IFNDEF INT64RETURNWORKAROUND}
  SfmlClockGetElapsedTime: TSfmlClockGetElapsedTime;
  SfmlClockRestart: TSfmlClockRestart;
  SfmlClockReset: TSfmlClockReset;
{$ENDIF}

  SfmlMutexCreate: TSfmlMutexCreate;
  SfmlMutexDestroy: TSfmlMutexDestroy;
  SfmlMutexLock: TSfmlMutexLock;
  SfmlMutexUnlock: TSfmlMutexUnlock;

  SfmlSleep: TSfmlSleep;

  SfmlThreadCreate: TSfmlThreadCreate;
  SfmlThreadDestroy: TSfmlThreadDestroy;
  SfmlThreadLaunch: TSfmlThreadLaunch;
  SfmlThreadWait: TSfmlThreadWait;
  SfmlThreadTerminate: TSfmlThreadTerminate;
{$ELSE}
const
  SfmlTimeZero: TSfmlTime = (MicroSeconds: 0);

  // static linking
  function SfmlTimeAsSeconds(Time: TSfmlTime): Single; cdecl; external CSfmlSystemLibrary name 'sfTime_asSeconds';
  function SfmlTimeAsMilliseconds(Time: TSfmlTime): LongInt; cdecl; external CSfmlSystemLibrary name 'sfTime_asMilliseconds';
  function SfmlTimeAsMicroseconds(Time: TSfmlTime): Int64; cdecl; external CSfmlSystemLibrary name 'sfTime_asMicroseconds';

{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlSeconds(Amount: Single): TSfmlTime; cdecl; external CSfmlSystemLibrary name 'sfSeconds';
  function SfmlMilliseconds(Amount: LongInt): TSfmlTime; cdecl; external CSfmlSystemLibrary name 'sfMilliseconds';
  function SfmlMicroseconds(Amount: Int64): TSfmlTime; cdecl; external CSfmlSystemLibrary name 'sfMicroseconds';
{$ENDIF}

  function SfmlBufferCreate: PSfmlBuffer; cdecl; external CSfmlSystemLibrary name 'sfBuffer_create';
  procedure SfmlBufferDestroy(Buffer: PSfmlBuffer); cdecl; external CSfmlSystemLibrary name 'sfBuffer_destroy';
  function SfmlBufferGetSize(const Buffer: PSfmlBuffer): NativeUInt; cdecl; external CSfmlSystemLibrary name 'sfBuffer_getSize';
  function SfmlBufferGetData(const Buffer: PSfmlBuffer): PByte; cdecl; external CSfmlSystemLibrary name 'sfBuffer_getData';
  procedure SfmlFree(Ptr: Pointer); cdecl; external CSfmlSystemLibrary name 'sfFree';

  function SfmlClockCreate: PSfmlClock; cdecl; external CSfmlSystemLibrary name 'sfClock_create';
  function SfmlClockCopy(const Clock: PSfmlClock): PSfmlClock; cdecl; external CSfmlSystemLibrary name 'sfClock_copy';
  procedure SfmlClockDestroy(Clock: PSfmlClock); cdecl; external CSfmlSystemLibrary name 'sfClock_destroy';
  function SfmlClockIsRunning(const Clock: PSfmlClock): TSfmlBool; cdecl; external CSfmlSystemLibrary name 'sfClock_isRunning';
  procedure SfmlClockStart(Clock: PSfmlClock); cdecl; external CSfmlSystemLibrary name 'sfClock_start';
  procedure SfmlClockStop(Clock: PSfmlClock); cdecl; external CSfmlSystemLibrary name 'sfClock_stop';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlClockGetElapsedTime(const Clock: PSfmlClock): TSfmlTime; cdecl; external CSfmlSystemLibrary name 'sfClock_getElapsedTime';
  function SfmlClockRestart(Clock: PSfmlClock): TSfmlTime; cdecl; external CSfmlSystemLibrary name 'sfClock_restart';
  function SfmlClockReset(Clock: PSfmlClock): TSfmlTime; cdecl; external CSfmlSystemLibrary name 'sfClock_reset';
{$ENDIF}

  function SfmlMutexCreate: PSfmlMutex; cdecl;
  procedure SfmlMutexDestroy(Mutex: PSfmlMutex); cdecl;
  procedure SfmlMutexLock(Mutex: PSfmlMutex); cdecl;
  procedure SfmlMutexUnlock(Mutex: PSfmlMutex); cdecl;

  procedure SfmlSleep(Duration: TSfmlTime); cdecl; external CSfmlSystemLibrary name 'sfSleep';

  function SfmlThreadCreate(ThreadEntryPoint: TSfmlThreadEntryPoint; UserData: Pointer): PSfmlThread; cdecl;
  procedure SfmlThreadDestroy(Thread: PSfmlThread); cdecl;
  procedure SfmlThreadLaunch(Thread: PSfmlThread); cdecl;
  procedure SfmlThreadWait(Thread: PSfmlThread); cdecl;
  procedure SfmlThreadTerminate(Thread: PSfmlThread); cdecl;
{$ENDIF}

type
  TSfmlBuffer = class
  private
    FHandle: PSfmlBuffer;
    function GetSize: NativeUInt;
    function GetData: PByte;
  public
    constructor Create;
    destructor Destroy; override;

    property Size: NativeUInt read GetSize;
    property Data: PByte read GetData;
    property Handle: PSfmlBuffer read FHandle;
  end;

  TSfmlClock = class
  private
    FHandle: PSfmlClock;
    constructor Create(Handle: PSfmlClock); overload;
    function GetElapsedTime: TSfmlTime;
    function GetIsRunning: Boolean;
  public
    constructor Create; overload;
    destructor Destroy; override;

    function Copy: TSfmlClock;
    function Restart: TSfmlTime;
    function Reset: TSfmlTime;
    procedure Start;
    procedure Stop;

    property ElapsedTime: TSfmlTime read GetElapsedTime;
    property IsRunning: Boolean read GetIsRunning;
    property Handle: PSfmlClock read FHandle;
  end;

  TSfmlMutex = class
  private
    FHandle: PSfmlMutex;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Lock;
    procedure Unlock;
  end;

  TSfmlThread = class
  private
    FHandle: PSfmlThread;
  public
    constructor Create(ThreadEntryPoint: TSfmlThreadEntryPoint; UserData: Pointer);
    destructor Destroy; override;

    procedure Launch;
    procedure Wait;
    procedure Terminate;
  end;

{$IFDEF INT64RETURNWORKAROUND}
  // Workarounds for the Delphi compiler
  function SfmlSeconds(Amount: Single): TSfmlTime; cdecl;
  function SfmlMilliseconds(Amount: LongInt): TSfmlTime; cdecl;
  function SfmlMicroseconds(Amount: Int64): TSfmlTime; cdecl;
  function SfmlClockGetElapsedTime(const Clock: PSfmlClock): TSfmlTime; cdecl;
  function SfmlClockRestart(Clock: PSfmlClock): TSfmlTime; cdecl;
  function SfmlClockReset(Clock: PSfmlClock): TSfmlTime; cdecl;
{$ENDIF}

function SfmlTime(MicroSeconds: Int64): TSfmlTime;
function SfmlVector2u(X, Y: Cardinal): TSfmlVector2u;
function SfmlVector2f(X, Y: Single): TSfmlVector2f;
function SfmlVector3f(X, Y, Z: Single): TSfmlVector3f;

implementation

uses
  Classes, SyncObjs
{$IFDEF DynLink}
{$IFDEF FPC}
  , DynLibs
{$ELSE}
{$IFDEF MSWindows}
  , Windows
{$ENDIF}
{$ENDIF}
{$ENDIF}
  ;

type
  TSfmlMutexInternal = record
    CriticalSection: TCriticalSection;
  end;
  PSfmlMutexInternal = ^TSfmlMutexInternal;

  TSfmlPasThread = class(TThread)
  private
    FEntryPoint: TSfmlThreadEntryPoint;
    FStartEvent: TEvent;
    FUserData: Pointer;
  protected
    procedure Execute; override;
  public
    constructor Create(ThreadEntryPoint: TSfmlThreadEntryPoint; UserData: Pointer);
    destructor Destroy; override;

    procedure Launch;
    procedure Stop;
  end;

  TSfmlThreadInternal = record
    Worker: TSfmlPasThread;
  end;
  PSfmlThreadInternal = ^TSfmlThreadInternal;

constructor TSfmlPasThread.Create(ThreadEntryPoint: TSfmlThreadEntryPoint; UserData: Pointer);
begin
  inherited Create(False);
  FreeOnTerminate := False;
  FEntryPoint := ThreadEntryPoint;
  FUserData := UserData;
  FStartEvent := TEvent.Create(nil, True, False, '');
end;

destructor TSfmlPasThread.Destroy;
begin
  FStartEvent.Free;
  inherited;
end;

procedure TSfmlPasThread.Execute;
begin
  FStartEvent.WaitFor($FFFFFFFF);
  if Terminated then
    Exit;

  if Assigned(FEntryPoint) then
    FEntryPoint(FUserData);
end;

procedure TSfmlPasThread.Launch;
begin
  FStartEvent.SetEvent;
end;

procedure TSfmlPasThread.Stop;
begin
  Terminate;
  FStartEvent.SetEvent;
end;

function SfmlMutexCreate: PSfmlMutex; cdecl;
var
  Mutex: PSfmlMutexInternal;
begin
  New(Mutex);
  Mutex^.CriticalSection := TCriticalSection.Create;
  Result := PSfmlMutex(Mutex);
end;

procedure SfmlMutexDestroy(Mutex: PSfmlMutex); cdecl;
var
  Internal: PSfmlMutexInternal;
begin
  if Mutex = nil then
    Exit;

  Internal := PSfmlMutexInternal(Mutex);
  Internal^.CriticalSection.Free;
  Dispose(Internal);
end;

procedure SfmlMutexLock(Mutex: PSfmlMutex); cdecl;
begin
  if Mutex <> nil then
    PSfmlMutexInternal(Mutex)^.CriticalSection.Acquire;
end;

procedure SfmlMutexUnlock(Mutex: PSfmlMutex); cdecl;
begin
  if Mutex <> nil then
    PSfmlMutexInternal(Mutex)^.CriticalSection.Release;
end;

function SfmlThreadCreate(ThreadEntryPoint: TSfmlThreadEntryPoint; UserData: Pointer): PSfmlThread; cdecl;
var
  Thread: PSfmlThreadInternal;
begin
  New(Thread);
  Thread^.Worker := TSfmlPasThread.Create(ThreadEntryPoint, UserData);
  Result := PSfmlThread(Thread);
end;

procedure SfmlThreadDestroy(Thread: PSfmlThread); cdecl;
var
  Internal: PSfmlThreadInternal;
begin
  if Thread = nil then
    Exit;

  Internal := PSfmlThreadInternal(Thread);
  Internal^.Worker.Stop;
  Internal^.Worker.WaitFor;
  Internal^.Worker.Free;
  Dispose(Internal);
end;

procedure SfmlThreadLaunch(Thread: PSfmlThread); cdecl;
begin
  if Thread <> nil then
    PSfmlThreadInternal(Thread)^.Worker.Launch;
end;

procedure SfmlThreadWait(Thread: PSfmlThread); cdecl;
begin
  if Thread <> nil then
    PSfmlThreadInternal(Thread)^.Worker.WaitFor;
end;

procedure SfmlThreadTerminate(Thread: PSfmlThread); cdecl;
begin
  if Thread <> nil then
    PSfmlThreadInternal(Thread)^.Worker.Stop;
end;

{ TSfmlTime }

function TSfmlTime.AsMilliseconds: LongInt;
begin
  Result := SfmlTimeAsMilliseconds(Self);
end;

function TSfmlTime.AsSeconds: Single;
begin
  Result := SfmlTimeAsSeconds(Self);
end;

function SfmlTime(MicroSeconds: Int64): TSfmlTime;
begin
  Result.MicroSeconds := MicroSeconds;
end;


function SfmlVector2u(X, Y: Cardinal): TSfmlVector2u;
begin
  Result.X := X;
  Result.Y := Y;
end;


{ TSfmlVector2f }

function SfmlVector2f(X, Y: Single): TSfmlVector2f;
begin
  Result.X := X;
  Result.Y := Y;
end;


{ TSfmlVector3f }

function SfmlVector3f(X, Y, Z: Single): TSfmlVector3f;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
end;


{$IFDEF RecordConstructors}
constructor TSfmlTime.Create(Microseconds: LongInt);
begin
  Self.MicroSeconds := Microseconds;
end;

constructor TSfmlVector2i.Create(X, Y: LongInt);
begin
  Self.X := X;
  Self.Y := Y;
end;

constructor TSfmlVector2u.Create(X, Y: Cardinal);
begin
  Self.X := X;
  Self.Y := Y;
end;

constructor TSfmlVector2f.Create(X, Y: Double);
begin
  Self.X := X;
  Self.Y := Y;
end;

constructor TSfmlVector3f.Create(X, Y, Z: Single);
begin
  Self.X := X;
  Self.Y := Y;
  Self.Z := Z;
end;
{$ENDIF}

{$IFDEF RecordOperators}
class operator TSfmlTime.Equal(const Lhs, Rhs: TSfmlTime): Boolean;
begin
  Result := Lhs.MicroSeconds = Rhs.MicroSeconds;
end;

class operator TSfmlTime.Add(const Lhs, Rhs: TSfmlTime): TSfmlTime;
begin
  Result.MicroSeconds := Lhs.MicroSeconds + Rhs.MicroSeconds;
end;

class operator TSfmlTime.Subtract(const Lhs, Rhs: TSfmlTime): TSfmlTime;
begin
  Result.MicroSeconds := Lhs.MicroSeconds - Rhs.MicroSeconds;
end;

class operator TSfmlVector2i.Equal(const Lhs, Rhs: TSfmlVector2i): Boolean;
begin
  Result := (Lhs.X = Rhs.X) and (Lhs.Y = Rhs.Y);
end;

class operator TSfmlVector2i.Add(const Lhs, Rhs: TSfmlVector2i): TSfmlVector2i;
begin
  Result.X := Lhs.X + Rhs.X;
  Result.Y := Lhs.Y + Rhs.Y;
end;

class operator TSfmlVector2i.Subtract(const Lhs, Rhs: TSfmlVector2i): TSfmlVector2i;
begin
  Result.X := Lhs.X - Rhs.X;
  Result.Y := Lhs.Y - Rhs.Y;
end;

class operator TSfmlVector2u.Equal(const Lhs, Rhs: TSfmlVector2u): Boolean;
begin
  Result := (Lhs.X = Rhs.X) and (Lhs.Y = Rhs.Y);
end;

class operator TSfmlVector2u.Add(const Lhs, Rhs: TSfmlVector2u): TSfmlVector2u;
begin
  Result.X := Lhs.X + Rhs.X;
  Result.Y := Lhs.Y + Rhs.Y;
end;

class operator TSfmlVector2u.Subtract(const Lhs, Rhs: TSfmlVector2u): TSfmlVector2u;
begin
  Result.X := Lhs.X - Rhs.X;
  Result.Y := Lhs.Y - Rhs.Y;
end;

class operator TSfmlVector2f.Equal(const Lhs, Rhs: TSfmlVector2f): Boolean;
begin
  Result := (Lhs.X = Rhs.X) and (Lhs.Y = Rhs.Y);
end;

class operator TSfmlVector2f.Add(const Lhs, Rhs: TSfmlVector2f): TSfmlVector2f;
begin
  Result.X := Lhs.X + Rhs.X;
  Result.Y := Lhs.Y + Rhs.Y;
end;

class operator TSfmlVector2f.Subtract(const Lhs, Rhs: TSfmlVector2f): TSfmlVector2f;
begin
  Result.X := Lhs.X - Rhs.X;
  Result.Y := Lhs.Y - Rhs.Y;
end;

class operator TSfmlVector2f.Multiply(const Lhs, Rhs: TSfmlVector2f): TSfmlVector2f;
begin
  Result.X := Lhs.X * Rhs.X;
  Result.Y := Lhs.Y * Rhs.Y;
end;

class operator TSfmlVector2f.Divide(const Lhs, Rhs: TSfmlVector2f): TSfmlVector2f;
begin
  Result.X := Lhs.X / Rhs.X;
  Result.Y := Lhs.Y / Rhs.Y;
end;

class operator TSfmlVector2f.Multiply(const Lhs: TSfmlVector2f; Rhs: Single): TSfmlVector2f;
begin
  Result.X := Lhs.X * Rhs;
  Result.Y := Lhs.Y * Rhs;
end;

class operator TSfmlVector2f.Divide(const Lhs: TSfmlVector2f; Rhs: Single): TSfmlVector2f;
begin
  Result.X := Lhs.X / Rhs;
  Result.Y := Lhs.Y / Rhs;
end;

class operator TSfmlVector3f.Equal(const Lhs, Rhs: TSfmlVector3f): Boolean;
begin
  Result := (Lhs.X = Rhs.X) and (Lhs.Y = Rhs.Y) and (Lhs.Z = Rhs.Z);
end;

class operator TSfmlVector3f.Add(const Lhs, Rhs: TSfmlVector3f): TSfmlVector3f;
begin
  Result.X := Lhs.X + Rhs.X;
  Result.Y := Lhs.Y + Rhs.Y;
  Result.Z := Lhs.Z + Rhs.Z;
end;

class operator TSfmlVector3f.Subtract(const Lhs, Rhs: TSfmlVector3f): TSfmlVector3f;
begin
  Result.X := Lhs.X - Rhs.X;
  Result.Y := Lhs.Y - Rhs.Y;
  Result.Z := Lhs.Z - Rhs.Z;
end;
{$ENDIF}


{ TSfmlBuffer }

constructor TSfmlBuffer.Create;
begin
  FHandle := SfmlBufferCreate;
end;

destructor TSfmlBuffer.Destroy;
begin
  SfmlBufferDestroy(FHandle);
  inherited;
end;

function TSfmlBuffer.GetSize: NativeUInt;
begin
  Result := SfmlBufferGetSize(FHandle);
end;

function TSfmlBuffer.GetData: PByte;
begin
  Result := SfmlBufferGetData(FHandle);
end;


{ TSfmlClock }

constructor TSfmlClock.Create;
begin
  FHandle := SfmlClockCreate;
end;

constructor TSfmlClock.Create(Handle: PSfmlClock);
begin
  FHandle := Handle;
end;

destructor TSfmlClock.Destroy;
begin
  SfmlClockDestroy(FHandle);
  inherited;
end;

function TSfmlClock.GetElapsedTime: TSfmlTime;
begin
  Result := SfmlClockGetElapsedTime(FHandle);
end;

function TSfmlClock.GetIsRunning: Boolean;
begin
  Result := SfmlClockIsRunning(FHandle);
end;

function TSfmlClock.Restart: TSfmlTime;
begin
  Result := SfmlClockRestart(FHandle);
end;

function TSfmlClock.Reset: TSfmlTime;
begin
  Result := SfmlClockReset(FHandle);
end;

procedure TSfmlClock.Start;
begin
  SfmlClockStart(FHandle);
end;

procedure TSfmlClock.Stop;
begin
  SfmlClockStop(FHandle);
end;

function TSfmlClock.Copy: TSfmlClock;
begin
  Result := TSfmlClock.Create(SfmlClockCopy(FHandle));
end;


{ TSfmlMutex }

constructor TSfmlMutex.Create;
begin
  FHandle := SfmlMutexCreate;
end;

destructor TSfmlMutex.Destroy;
begin
  SfmlMutexDestroy(FHandle);
  inherited;
end;

procedure TSfmlMutex.Lock;
begin
  SfmlMutexLock(FHandle);
end;

procedure TSfmlMutex.Unlock;
begin
  SfmlMutexUnlock(FHandle);
end;


{ TSfmlThread }

constructor TSfmlThread.Create(ThreadEntryPoint: TSfmlThreadEntryPoint; UserData: Pointer);
begin
  FHandle := SfmlThreadCreate(ThreadEntryPoint, UserData)
end;

destructor TSfmlThread.Destroy;
begin
  SfmlThreadDestroy(FHandle);
end;

procedure TSfmlThread.Launch;
begin
  SfmlThreadLaunch(FHandle);
end;

procedure TSfmlThread.Terminate;
begin
  SfmlThreadTerminate(FHandle);
end;

procedure TSfmlThread.Wait;
begin
  SfmlThreadWait(FHandle);
end;

{$IFDEF DynLink}
var
  CSfmlSystemHandle: {$IFDEF FPC}TLibHandle{$ELSE}HINST{$ENDIF};
{$IFDEF INT64RETURNWORKAROUND}
  sfSeconds: function (Amount: Single): Int64; cdecl;
  sfMilliseconds: function (Amount: LongInt): Int64; cdecl;
  sfMicroseconds: function (Amount: Int64): Int64; cdecl;
  sfClock_getElapsedTime: function (const Clock: PSfmlClock): Int64; cdecl;
  sfClock_restart: function (Clock: PSfmlClock): Int64; cdecl;
{$ENDIF}

procedure InitDLL;

  function BindFunction(Name: AnsiString): Pointer;
  begin
    Result := GetProcAddress(CSfmlSystemHandle, PAnsiChar(Name));
    Assert(Assigned(Result));
  end;

begin
  {$IFDEF FPC}
  CSfmlSystemHandle := LoadLibrary(CSfmlSystemLibrary);
  {$ELSE}
  CSfmlSystemHandle := LoadLibraryA(CSfmlSystemLibrary);
  {$ENDIF}
  if CSfmlSystemHandle <> 0 then
    try
      Move(GetProcAddress(CSfmlSystemHandle, PAnsiChar('sfTime_Zero'))^, SfmlTimeZero, SizeOf(SfmlTimeZero));

      SfmlTimeAsSeconds := BindFunction('sfTime_asSeconds');
      SfmlTimeAsMilliseconds := BindFunction('sfTime_asMilliseconds');
      SfmlTimeAsMicroseconds := BindFunction('sfTime_asMicroseconds');
{$IFNDEF INT64RETURNWORKAROUND}
      SfmlSeconds := BindFunction('sfSeconds');
      SfmlMilliseconds := BindFunction('sfMilliseconds');
      SfmlMicroseconds := BindFunction('sfMicroseconds');
{$ELSE}
      // Workarounds for the Delphi compiler
      sfSeconds := BindFunction('sfSeconds');
      sfMilliseconds := BindFunction('sfMilliseconds');
      sfMicroseconds := BindFunction('sfMicroseconds');
{$ENDIF}
      SfmlBufferCreate := BindFunction('sfBuffer_create');
      SfmlBufferDestroy := BindFunction('sfBuffer_destroy');
      SfmlBufferGetSize := BindFunction('sfBuffer_getSize');
      SfmlBufferGetData := BindFunction('sfBuffer_getData');
      SfmlFree := BindFunction('sfFree');
      SfmlClockCreate := BindFunction('sfClock_create');
      SfmlClockCopy := BindFunction('sfClock_copy');
      SfmlClockDestroy := BindFunction('sfClock_destroy');
      SfmlClockIsRunning := BindFunction('sfClock_isRunning');
      SfmlClockStart := BindFunction('sfClock_start');
      SfmlClockStop := BindFunction('sfClock_stop');
{$IFNDEF INT64RETURNWORKAROUND}
      SfmlClockGetElapsedTime := BindFunction('sfClock_getElapsedTime');
      SfmlClockRestart := BindFunction('sfClock_restart');
      SfmlClockReset := BindFunction('sfClock_reset');
{$ELSE}
      sfClock_getElapsedTime := BindFunction('sfClock_getElapsedTime');
      sfClock_restart := BindFunction('sfClock_restart');
{$ENDIF}
      SfmlMutexCreate := @SfmlMutexCreate;
      SfmlMutexDestroy := @SfmlMutexDestroy;
      SfmlMutexLock := @SfmlMutexLock;
      SfmlMutexUnlock := @SfmlMutexUnlock;
      SfmlSleep := BindFunction('sfSleep');
      SfmlThreadCreate := @SfmlThreadCreate;
      SfmlThreadDestroy := @SfmlThreadDestroy;
      SfmlThreadLaunch := @SfmlThreadLaunch;
      SfmlThreadWait := @SfmlThreadWait;
      SfmlThreadTerminate := @SfmlThreadTerminate;
    except
      FreeLibrary(CSfmlSystemHandle);
      CSfmlSystemHandle := 0;
    end;
end;

procedure FreeDLL;
begin
  if CSfmlSystemHandle <> 0 then
    FreeLibrary(CSfmlSystemHandle);
end;
{$ELSE}
{$IFDEF INT64RETURNWORKAROUND}
// Workarounds for the Delphi compiler
function sfSeconds(Amount: Single): Int64; cdecl; external CSfmlSystemLibrary name 'sfSeconds';
function sfMilliseconds(Amount: LongInt): Int64; cdecl; external CSfmlSystemLibrary name 'sfMilliseconds';
function sfMicroseconds(Amount: Int64): Int64; cdecl; external CSfmlSystemLibrary name 'sfMicroseconds';
function sfClock_getElapsedTime(const Clock: PSfmlClock): Int64; cdecl; external CSfmlSystemLibrary name 'sfClock_getElapsedTime';
function sfClock_restart(Clock: PSfmlClock): Int64; cdecl; external CSfmlSystemLibrary;
function sfClock_reset(Clock: PSfmlClock): Int64; cdecl; external CSfmlSystemLibrary name 'sfClock_reset';
{$ENDIF}
{$ENDIF}

{$IFDEF INT64RETURNWORKAROUND}
// workarounds for the Delphi compiler
function SfmlSeconds(Amount: Single): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfSeconds(Amount);
end;

function SfmlMilliseconds(Amount: LongInt): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfMilliseconds(Amount);
end;

function SfmlMicroseconds(Amount: Int64): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfMicroseconds(Amount);
end;

function SfmlClockGetElapsedTime(const Clock: PSfmlClock): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfClock_getElapsedTime(Clock);
end;

function SfmlClockRestart(Clock: PSfmlClock): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfClock_restart(Clock);
end;

function SfmlClockReset(Clock: PSfmlClock): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfClock_reset(Clock);
end;
{$ENDIF}

{$IFDEF DynLink}
initialization

InitDLL;

finalization

FreeDLL;

{$ENDIF}
end.
