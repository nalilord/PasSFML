unit SfmlAudio;

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
  SfmlSystem;

const
{$IF Defined(MSWINDOWS)}
  CSfmlAudioLibrary = 'csfml-audio-3.dll';
{$ELSEIF Defined(DARWIN) or Defined(MACOS)}
  CSfmlAudioLibrary = 'csfml-audio-3.dylib';
{$ELSEIF Defined(UNIX)}
  CSfmlAudioLibrary = 'csfml-audio.so';
{$IFEND}

type
  // opaque structures
  TSfmlMusicRecord = record end;
  TSfmlSoundRecord = record end;
  TSfmlSoundBufferRecord = record end;
  TSfmlSoundBufferRecorderRecord = record end;
  TSfmlSoundRecorderRecord = record end;
  TSfmlSoundStreamRecord = record end;

  // handles for opaque structures
  PSfmlMusic = ^TSfmlMusicRecord;
  PSfmlSound = ^TSfmlSoundRecord;
  PSfmlSoundBuffer = ^TSfmlSoundBufferRecord;
  PSfmlSoundBufferRecorder = ^TSfmlSoundBufferRecorderRecord;
  PSfmlSoundRecorder = ^TSfmlSoundRecorderRecord;
  PSfmlSoundStream = ^TSfmlSoundStreamRecord;

  TSfmlSoundStatus = (sfStopped, sfPaused, sfPlaying);

  TSfmlSoundSourceCone = record
    InnerAngle: Single;
    OuterAngle: Single;
    OuterGain: Single;
  end;

  TSfmlEffectProcessor = procedure (const InputFrames: PSingle;
    var InputFrameCount: Cardinal; OutputFrames: PSingle;
    var OutputFrameCount: Cardinal; FrameChannelCount: Cardinal); cdecl;

  TSfmlSoundChannel = (sfSoundChannelUnspecified, sfSoundChannelMono,
    sfSoundChannelFrontLeft, sfSoundChannelFrontRight,
    sfSoundChannelFrontCenter, sfSoundChannelFrontLeftOfCenter,
    sfSoundChannelFrontRightOfCenter, sfSoundChannelLowFrequencyEffects,
    sfSoundChannelBackLeft, sfSoundChannelBackRight,
    sfSoundChannelBackCenter, sfSoundChannelSideLeft,
    sfSoundChannelSideRight, sfSoundChannelTopCenter,
    sfSoundChannelTopFrontLeft, sfSoundChannelTopFrontRight,
    sfSoundChannelTopFrontCenter, sfSoundChannelTopBackLeft,
    sfSoundChannelTopBackRight, sfSoundChannelTopBackCenter);
  PSfmlSoundChannel = ^TSfmlSoundChannel;

  TSfmlTimeSpan = record
    Offset: TSfmlTime;
    Length: TSfmlTime;
  end;

  TSfmlSoundStreamChunk = record
    Samples: PSmallInt;
    SampleCount: Cardinal;
  end;
  PSfmlSoundStreamChunk  = ^TSfmlSoundStreamChunk;

  TSfmlSoundStreamGetDataCallback = function (Chunk: PSfmlSoundStreamChunk; UserData: Pointer): LongBool; cdecl;
  TSfmlSoundStreamSeekCallback = procedure (Time: TSfmlTime; UserData: Pointer); cdecl;

  TSfmlSoundRecorderStartCallback = function (UserData: Pointer): LongBool; cdecl;
  TSfmlSoundRecorderProcessCallback = function (Data: PSmallInt; SampleFrames: NativeUInt; UserData: Pointer): LongBool; cdecl;
  TSfmlSoundRecorderStopCallback = procedure (UserData: Pointer); cdecl;

{$IFDEF DynLink}
  TSfmlListenerSetGlobalVolume = procedure (Volume: Single); cdecl;
  TSfmlListenerGetGlobalVolume = function : Single; cdecl;
  TSfmlListenerSetPosition = procedure (Position: TSfmlVector3f); cdecl;
  TSfmlListenerGetPosition = function : TSfmlVector3f; cdecl;
  TSfmlListenerSetDirection = procedure (Direction: TSfmlVector3f); cdecl;
  TSfmlListenerGetDirection = function : TSfmlVector3f; cdecl;
  TSfmlListenerSetUpVector = procedure (UpVector: TSfmlVector3f); cdecl;
  TSfmlListenerGetUpVector = function : TSfmlVector3f; cdecl;
  TSfmlListenerSetVelocity = procedure (Velocity: TSfmlVector3f); cdecl;
  TSfmlListenerGetVelocity = function : TSfmlVector3f; cdecl;
  TSfmlListenerSetCone = procedure (Cone: TSfmlSoundSourceCone); cdecl;
  TSfmlListenerGetCone = function : TSfmlSoundSourceCone; cdecl;

  TSfmlMusicCreateFromFile = function (const FileName: PAnsiChar): PSfmlMusic; cdecl;
  TSfmlMusicCreateFromMemory = function (const Data: Pointer; SizeInBytes: NativeUInt): PSfmlMusic; cdecl;
  TSfmlMusicCreateFromStream = function (Stream: PSfmlInputStream): PSfmlMusic; cdecl;
  TSfmlMusicDestroy = procedure (Music: PSfmlMusic); cdecl;
  TSfmlMusicSetLooping = procedure (Music: PSfmlMusic; Loop: LongBool); cdecl;
  TSfmlMusicIsLooping = function (const Music: PSfmlMusic): LongBool; cdecl;
  TSfmlMusicGetDuration = function (const Music: PSfmlMusic): TSfmlTime; cdecl;
  TSfmlMusicPlay = procedure (Music: PSfmlMusic); cdecl;
  TSfmlMusicPause = procedure (Music: PSfmlMusic); cdecl;
  TSfmlMusicStop = procedure (Music: PSfmlMusic); cdecl;
  TSfmlMusicGetChannelCount = function (const Music: PSfmlMusic): Cardinal; cdecl;
  TSfmlMusicGetSampleRate = function (const Music: PSfmlMusic): Cardinal; cdecl;
  TSfmlMusicGetStatus = function (const Music: PSfmlMusic): TSfmlSoundStatus; cdecl;
  TSfmlMusicGetPlayingOffset = function (const Music: PSfmlMusic): TSfmlTime; cdecl;
  TSfmlMusicSetPitch = procedure (Music: PSfmlMusic; Pitch: Single); cdecl;
  TSfmlMusicSetVolume = procedure (Music: PSfmlMusic; Volume: Single); cdecl;
  TSfmlMusicSetPosition = procedure (Music: PSfmlMusic; Position: TSfmlVector3f); cdecl;
  TSfmlMusicSetRelativeToListener = procedure (Music: PSfmlMusic; Relative: LongBool); cdecl;
  TSfmlMusicSetMinDistance = procedure (Music: PSfmlMusic; Distance: Single); cdecl;
  TSfmlMusicSetAttenuation = procedure (Music: PSfmlMusic; Attenuation: Single); cdecl;
  TSfmlMusicSetPlayingOffset = procedure (Music: PSfmlMusic; TimeOffset: TSfmlTime); cdecl;
  TSfmlMusicGetPitch = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicGetVolume = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicGetPosition = function (const Music: PSfmlMusic): TSfmlVector3f; cdecl;
  TSfmlMusicIsRelativeToListener = function (const Music: PSfmlMusic): LongBool; cdecl;
  TSfmlMusicGetMinDistance = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicGetAttenuation = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicSetPan = procedure (Music: PSfmlMusic; Pan: Single); cdecl;
  TSfmlMusicGetPan = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicSetSpatializationEnabled = procedure (Music: PSfmlMusic; Enabled: LongBool); cdecl;
  TSfmlMusicIsSpatializationEnabled = function (const Music: PSfmlMusic): LongBool; cdecl;
  TSfmlMusicSetDirection = procedure (Music: PSfmlMusic; Direction: TSfmlVector3f); cdecl;
  TSfmlMusicGetDirection = function (const Music: PSfmlMusic): TSfmlVector3f; cdecl;
  TSfmlMusicSetCone = procedure (Music: PSfmlMusic; Cone: TSfmlSoundSourceCone); cdecl;
  TSfmlMusicGetCone = function (const Music: PSfmlMusic): TSfmlSoundSourceCone; cdecl;
  TSfmlMusicSetVelocity = procedure (Music: PSfmlMusic; Velocity: TSfmlVector3f); cdecl;
  TSfmlMusicGetVelocity = function (const Music: PSfmlMusic): TSfmlVector3f; cdecl;
  TSfmlMusicSetDopplerFactor = procedure (Music: PSfmlMusic; Factor: Single); cdecl;
  TSfmlMusicGetDopplerFactor = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicSetDirectionalAttenuationFactor = procedure (Music: PSfmlMusic; Factor: Single); cdecl;
  TSfmlMusicGetDirectionalAttenuationFactor = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicSetMaxDistance = procedure (Music: PSfmlMusic; Distance: Single); cdecl;
  TSfmlMusicGetMaxDistance = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicSetMinGain = procedure (Music: PSfmlMusic; Gain: Single); cdecl;
  TSfmlMusicGetMinGain = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicSetMaxGain = procedure (Music: PSfmlMusic; Gain: Single); cdecl;
  TSfmlMusicGetMaxGain = function (const Music: PSfmlMusic): Single; cdecl;
  TSfmlMusicSetEffectProcessor = procedure (Music: PSfmlMusic; EffectProcessor: TSfmlEffectProcessor); cdecl;
  TSfmlMusicGetChannelMap = function (const Music: PSfmlMusic; Count: PNativeUInt): PSfmlSoundChannel; cdecl;
  TSfmlMusicGetLoopPoints = function (const Music: PSfmlMusic): TSfmlTimeSpan; cdecl;
  TSfmlMusicSetLoopPoints = procedure (Music: PSfmlMusic; TimePoints: TSfmlTimeSpan); cdecl;

  TSfmlSoundStreamCreate = function (OnGetData: TSfmlSoundStreamGetDataCallback; OnSeek: TSfmlSoundStreamSeekCallback; ChannelCount, SampleRate: Cardinal; ChannelMapData: PSfmlSoundChannel; ChannelMapSize: NativeUInt; UserData: Pointer): PSfmlSoundStream; cdecl;
  TSfmlSoundStreamDestroy = procedure (SoundStream: PSfmlSoundStream); cdecl;
  TSfmlSoundStreamPlay = procedure (SoundStream: PSfmlSoundStream); cdecl;
  TSfmlSoundStreamPause = procedure (SoundStream: PSfmlSoundStream); cdecl;
  TSfmlSoundStreamStop = procedure (SoundStream: PSfmlSoundStream); cdecl;
  TSfmlSoundStreamGetStatus = function (const SoundStream: PSfmlSoundStream): TSfmlSoundStatus; cdecl;
  TSfmlSoundStreamGetChannelCount = function (const SoundStream: PSfmlSoundStream): Cardinal; cdecl;
  TSfmlSoundStreamGetSampleRate = function (const SoundStream: PSfmlSoundStream): Cardinal; cdecl;
  TSfmlSoundStreamSetPitch = procedure (SoundStream: PSfmlSoundStream; Pitch: Single); cdecl;
  TSfmlSoundStreamSetVolume = procedure (SoundStream: PSfmlSoundStream; Volume: Single); cdecl;
  TSfmlSoundStreamSetPosition = procedure (SoundStream: PSfmlSoundStream; Position: TSfmlVector3f); cdecl;
  TSfmlSoundStreamSetRelativeToListener = procedure (SoundStream: PSfmlSoundStream; Relative: LongBool); cdecl;
  TSfmlSoundStreamSetMinDistance = procedure (SoundStream: PSfmlSoundStream; Distance: Single); cdecl;
  TSfmlSoundStreamSetAttenuation = procedure (SoundStream: PSfmlSoundStream; Attenuation: Single); cdecl;
  TSfmlSoundStreamSetPlayingOffset = procedure (SoundStream: PSfmlSoundStream; TimeOffset: TSfmlTime); cdecl;
  TSfmlSoundStreamSetLooping = procedure (SoundStream: PSfmlSoundStream; Loop: LongBool); cdecl;
  TSfmlSoundStreamGetPitch = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamGetVolume = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamGetPosition = function (const SoundStream: PSfmlSoundStream): TSfmlVector3f; cdecl;
  TSfmlSoundStreamIsRelativeToListener = function (const SoundStream: PSfmlSoundStream): LongBool; cdecl;
  TSfmlSoundStreamGetMinDistance = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamGetAttenuation = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamIsLooping = function (const SoundStream: PSfmlSoundStream): LongBool; cdecl;
  TSfmlSoundStreamGetPlayingOffset = function (const SoundStream: PSfmlSoundStream): TSfmlTime; cdecl;
  TSfmlSoundStreamGetChannelMap = function (const SoundStream: PSfmlSoundStream; Count: PNativeUInt): PSfmlSoundChannel; cdecl;
  TSfmlSoundStreamSetPan = procedure (SoundStream: PSfmlSoundStream; Pan: Single); cdecl;
  TSfmlSoundStreamGetPan = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamSetSpatializationEnabled = procedure (SoundStream: PSfmlSoundStream; Enabled: LongBool); cdecl;
  TSfmlSoundStreamIsSpatializationEnabled = function (const SoundStream: PSfmlSoundStream): LongBool; cdecl;
  TSfmlSoundStreamSetDirection = procedure (SoundStream: PSfmlSoundStream; Direction: TSfmlVector3f); cdecl;
  TSfmlSoundStreamGetDirection = function (const SoundStream: PSfmlSoundStream): TSfmlVector3f; cdecl;
  TSfmlSoundStreamSetCone = procedure (SoundStream: PSfmlSoundStream; Cone: TSfmlSoundSourceCone); cdecl;
  TSfmlSoundStreamGetCone = function (const SoundStream: PSfmlSoundStream): TSfmlSoundSourceCone; cdecl;
  TSfmlSoundStreamSetVelocity = procedure (SoundStream: PSfmlSoundStream; Velocity: TSfmlVector3f); cdecl;
  TSfmlSoundStreamGetVelocity = function (const SoundStream: PSfmlSoundStream): TSfmlVector3f; cdecl;
  TSfmlSoundStreamSetDopplerFactor = procedure (SoundStream: PSfmlSoundStream; Factor: Single); cdecl;
  TSfmlSoundStreamGetDopplerFactor = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamSetDirectionalAttenuationFactor = procedure (SoundStream: PSfmlSoundStream; Factor: Single); cdecl;
  TSfmlSoundStreamGetDirectionalAttenuationFactor = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamSetMaxDistance = procedure (SoundStream: PSfmlSoundStream; Distance: Single); cdecl;
  TSfmlSoundStreamGetMaxDistance = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamSetMinGain = procedure (SoundStream: PSfmlSoundStream; Gain: Single); cdecl;
  TSfmlSoundStreamGetMinGain = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamSetMaxGain = procedure (SoundStream: PSfmlSoundStream; Gain: Single); cdecl;
  TSfmlSoundStreamGetMaxGain = function (const SoundStream: PSfmlSoundStream): Single; cdecl;
  TSfmlSoundStreamSetEffectProcessor = procedure (SoundStream: PSfmlSoundStream; EffectProcessor: TSfmlEffectProcessor); cdecl;

  TSfmlSoundCreate = function (const Buffer: PSfmlSoundBuffer): PSfmlSound; cdecl;
  TSfmlSoundCopy = function (const Sound: PSfmlSound): PSfmlSound; cdecl;
  TSfmlSoundDestroy = procedure (Sound: PSfmlSound); cdecl;
  TSfmlSoundPlay = procedure (Sound: PSfmlSound); cdecl;
  TSfmlSoundPause = procedure (Sound: PSfmlSound); cdecl;
  TSfmlSoundStop = procedure (Sound: PSfmlSound); cdecl;
  TSfmlSoundSetBuffer = procedure (Sound: PSfmlSound; const Buffer: PSfmlSoundBuffer); cdecl;
  TSfmlSoundGetBuffer = function (const Sound: PSfmlSound): PSfmlSoundBuffer; cdecl;
  TSfmlSoundSetLooping = procedure (Sound: PSfmlSound; Loop: LongBool); cdecl;
  TSfmlSoundIsLooping = function (const Sound: PSfmlSound): LongBool; cdecl;
  TSfmlSoundGetStatus = function (const Sound: PSfmlSound): TSfmlSoundStatus; cdecl;
  TSfmlSoundSetPitch = procedure (Sound: PSfmlSound; Pitch: Single); cdecl;
  TSfmlSoundSetVolume = procedure (Sound: PSfmlSound; Volume: Single); cdecl;
  TSfmlSoundSetPosition = procedure (Sound: PSfmlSound; Position: TSfmlVector3f); cdecl;
  TSfmlSoundSetRelativeToListener = procedure (Sound: PSfmlSound; Relative: LongBool); cdecl;
  TSfmlSoundSetMinDistance = procedure (Sound: PSfmlSound; Distance: Single); cdecl;
  TSfmlSoundSetAttenuation = procedure (Sound: PSfmlSound; Attenuation: Single); cdecl;
  TSfmlSoundSetPlayingOffset = procedure (Sound: PSfmlSound; TimeOffset: TSfmlTime); cdecl;
  TSfmlSoundGetPitch = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundGetVolume = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundGetPosition = function (const Sound: PSfmlSound): TSfmlVector3f; cdecl;
  TSfmlSoundIsRelativeToListener = function (const Sound: PSfmlSound): LongBool; cdecl;
  TSfmlSoundGetMinDistance = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundGetAttenuation = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundGetPlayingOffset = function (const Sound: PSfmlSound): TSfmlTime; cdecl;
  TSfmlSoundSetPan = procedure (Sound: PSfmlSound; Pan: Single); cdecl;
  TSfmlSoundGetPan = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundSetSpatializationEnabled = procedure (Sound: PSfmlSound; Enabled: LongBool); cdecl;
  TSfmlSoundIsSpatializationEnabled = function (const Sound: PSfmlSound): LongBool; cdecl;
  TSfmlSoundSetDirection = procedure (Sound: PSfmlSound; Direction: TSfmlVector3f); cdecl;
  TSfmlSoundGetDirection = function (const Sound: PSfmlSound): TSfmlVector3f; cdecl;
  TSfmlSoundSetCone = procedure (Sound: PSfmlSound; Cone: TSfmlSoundSourceCone); cdecl;
  TSfmlSoundGetCone = function (const Sound: PSfmlSound): TSfmlSoundSourceCone; cdecl;
  TSfmlSoundSetVelocity = procedure (Sound: PSfmlSound; Velocity: TSfmlVector3f); cdecl;
  TSfmlSoundGetVelocity = function (const Sound: PSfmlSound): TSfmlVector3f; cdecl;
  TSfmlSoundSetDopplerFactor = procedure (Sound: PSfmlSound; Factor: Single); cdecl;
  TSfmlSoundGetDopplerFactor = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundSetDirectionalAttenuationFactor = procedure (Sound: PSfmlSound; Factor: Single); cdecl;
  TSfmlSoundGetDirectionalAttenuationFactor = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundSetMaxDistance = procedure (Sound: PSfmlSound; Distance: Single); cdecl;
  TSfmlSoundGetMaxDistance = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundSetMinGain = procedure (Sound: PSfmlSound; Gain: Single); cdecl;
  TSfmlSoundGetMinGain = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundSetMaxGain = procedure (Sound: PSfmlSound; Gain: Single); cdecl;
  TSfmlSoundGetMaxGain = function (const Sound: PSfmlSound): Single; cdecl;
  TSfmlSoundSetEffectProcessor = procedure (Sound: PSfmlSound; EffectProcessor: TSfmlEffectProcessor); cdecl;

  TSfmlSoundBufferCreateFromFile = function (const FileName: PAnsiChar): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferCreateFromMemory = function (const Data: Pointer; SizeInBytes: NativeUInt): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferCreateFromStream = function (Stream: PSfmlInputStream): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferCreateFromSamples = function (const Samples: PSmallInt; SampleCount: UInt64; ChannelCount, SampleRate: Cardinal): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferCopy = function (const SoundBuffer: PSfmlSoundBuffer): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferDestroy = procedure (SoundBuffer: PSfmlSoundBuffer); cdecl;
  TSfmlSoundBufferSaveToFile = function (const SoundBuffer: PSfmlSoundBuffer; const FileName: PAnsiChar): LongBool; cdecl;
  TSfmlSoundBufferGetSamples = function (const SoundBuffer: PSfmlSoundBuffer): PSmallInt; cdecl;
  TSfmlSoundBufferGetSampleCount = function (const SoundBuffer: PSfmlSoundBuffer): NativeUInt; cdecl;
  TSfmlSoundBufferGetSampleRate = function (const SoundBuffer: PSfmlSoundBuffer): Cardinal; cdecl;
  TSfmlSoundBufferGetChannelCount = function (const SoundBuffer: PSfmlSoundBuffer): Cardinal; cdecl;
  TSfmlSoundBufferGetDuration = function (const SoundBuffer: PSfmlSoundBuffer): TSfmlTime; cdecl;

  TSfmlSoundBufferRecorderCreate = function : PSfmlSoundBufferRecorder; cdecl;
  TSfmlSoundBufferRecorderDestroy = procedure (soundBufferRecorder: PSfmlSoundBufferRecorder); cdecl;
  TSfmlSoundBufferRecorderStart = function (soundBufferRecorder: PSfmlSoundBufferRecorder; SampleRate: Cardinal): LongBool; cdecl;
  TSfmlSoundBufferRecorderStop = procedure (soundBufferRecorder: PSfmlSoundBufferRecorder); cdecl;
  TSfmlSoundBufferRecorderGetSampleRate = function (const soundBufferRecorder: PSfmlSoundBufferRecorder): Cardinal; cdecl;
  TSfmlSoundBufferRecorderGetBuffer = function (const soundBufferRecorder: PSfmlSoundBufferRecorder): PSfmlSoundBuffer; cdecl;
  TSfmlSoundBufferRecorderSetDevice = function (SoundRecorder: PSfmlSoundBufferRecorder; const Name: PAnsiChar): LongBool; cdecl;
  TSfmlSoundBufferRecorderGetDevice = function (SoundRecorder: PSfmlSoundBufferRecorder): PAnsiChar; cdecl;

  TSfmlSoundRecorderCreate = function (OnStart: TSfmlSoundRecorderStartCallback; OnProcess: TSfmlSoundRecorderProcessCallback; OnStop: TSfmlSoundRecorderStopCallback; UserData: Pointer): PSfmlSoundRecorder; cdecl;
  TSfmlSoundRecorderDestroy = procedure (SoundRecorder: PSfmlSoundRecorder); cdecl;
  TSfmlSoundRecorderStart = function (SoundRecorder: PSfmlSoundRecorder; SampleRate: Cardinal): LongBool; cdecl;
  TSfmlSoundRecorderStop = procedure (SoundRecorder: PSfmlSoundRecorder); cdecl;
  TSfmlSoundRecorderGetSampleRate = function (const SoundRecorder: PSfmlSoundRecorder): Cardinal; cdecl;
  TSfmlSoundRecorderIsAvailable = function : LongBool; cdecl;
  TSfmlSoundRecorderGetAvailableDevices = function (count: PNativeUInt): PPAnsiChar; cdecl;
  TSfmlSoundRecorderGetDefaultDevice = function : PAnsiChar; cdecl;
  TSfmlSoundRecorderSetDevice = function (SoundRecorder: PSfmlSoundRecorder; const Name: PAnsiChar): LongBool; cdecl;
  TSfmlSoundRecorderGetDevice = function (SoundRecorder: PSfmlSoundRecorder): PAnsiChar; cdecl;
  TSfmlSoundRecorderSetChannelCount = function (SoundRecorder: PSfmlSoundRecorder; const ChannelCount: Cardinal): LongBool; cdecl;
  TSfmlSoundRecorderGetChannelCount = function (const SoundRecorder: PSfmlSoundRecorder): Cardinal; cdecl;
  TSfmlSoundRecorderGetChannelMap = function (const SoundRecorder: PSfmlSoundRecorder; Count: PNativeUInt): PSfmlSoundChannel; cdecl;

var
  SfmlListenerSetGlobalVolume: TSfmlListenerSetGlobalVolume;
  SfmlListenerGetGlobalVolume: TSfmlListenerGetGlobalVolume;
  SfmlListenerSetPosition: TSfmlListenerSetPosition;
  SfmlListenerGetPosition: TSfmlListenerGetPosition;
  SfmlListenerSetDirection: TSfmlListenerSetDirection;
  SfmlListenerGetDirection: TSfmlListenerGetDirection;
  SfmlListenerSetUpVector: TSfmlListenerSetUpVector;
  SfmlListenerGetUpVector: TSfmlListenerGetUpVector;
  SfmlListenerSetVelocity: TSfmlListenerSetVelocity;
  SfmlListenerGetVelocity: TSfmlListenerGetVelocity;
  SfmlListenerSetCone: TSfmlListenerSetCone;
  SfmlListenerGetCone: TSfmlListenerGetCone;

  SfmlMusicCreateFromFile: TSfmlMusicCreateFromFile;
  SfmlMusicCreateFromMemory: TSfmlMusicCreateFromMemory;
  SfmlMusicCreateFromStream: TSfmlMusicCreateFromStream;
  SfmlMusicDestroy: TSfmlMusicDestroy;
  SfmlMusicSetLooping: TSfmlMusicSetLooping;
  SfmlMusicIsLooping: TSfmlMusicIsLooping;
  SfmlMusicPlay: TSfmlMusicPlay;
  SfmlMusicPause: TSfmlMusicPause;
  SfmlMusicStop: TSfmlMusicStop;
  SfmlMusicGetChannelCount: TSfmlMusicGetChannelCount;
  SfmlMusicGetSampleRate: TSfmlMusicGetSampleRate;
  SfmlMusicGetStatus: TSfmlMusicGetStatus;
  SfmlMusicSetPitch: TSfmlMusicSetPitch;
  SfmlMusicSetVolume: TSfmlMusicSetVolume;
  SfmlMusicSetPosition: TSfmlMusicSetPosition;
  SfmlMusicSetRelativeToListener: TSfmlMusicSetRelativeToListener;
  SfmlMusicSetMinDistance: TSfmlMusicSetMinDistance;
  SfmlMusicSetAttenuation: TSfmlMusicSetAttenuation;
  SfmlMusicSetPlayingOffset: TSfmlMusicSetPlayingOffset;
  SfmlMusicGetPitch: TSfmlMusicGetPitch;
  SfmlMusicGetVolume: TSfmlMusicGetVolume;
  SfmlMusicGetPosition: TSfmlMusicGetPosition;
  SfmlMusicIsRelativeToListener: TSfmlMusicIsRelativeToListener;
  SfmlMusicGetMinDistance: TSfmlMusicGetMinDistance;
  SfmlMusicGetAttenuation: TSfmlMusicGetAttenuation;
  SfmlMusicSetPan: TSfmlMusicSetPan;
  SfmlMusicGetPan: TSfmlMusicGetPan;
  SfmlMusicSetSpatializationEnabled: TSfmlMusicSetSpatializationEnabled;
  SfmlMusicIsSpatializationEnabled: TSfmlMusicIsSpatializationEnabled;
  SfmlMusicSetDirection: TSfmlMusicSetDirection;
  SfmlMusicGetDirection: TSfmlMusicGetDirection;
  SfmlMusicSetCone: TSfmlMusicSetCone;
  SfmlMusicGetCone: TSfmlMusicGetCone;
  SfmlMusicSetVelocity: TSfmlMusicSetVelocity;
  SfmlMusicGetVelocity: TSfmlMusicGetVelocity;
  SfmlMusicSetDopplerFactor: TSfmlMusicSetDopplerFactor;
  SfmlMusicGetDopplerFactor: TSfmlMusicGetDopplerFactor;
  SfmlMusicSetDirectionalAttenuationFactor: TSfmlMusicSetDirectionalAttenuationFactor;
  SfmlMusicGetDirectionalAttenuationFactor: TSfmlMusicGetDirectionalAttenuationFactor;
  SfmlMusicSetMaxDistance: TSfmlMusicSetMaxDistance;
  SfmlMusicGetMaxDistance: TSfmlMusicGetMaxDistance;
  SfmlMusicSetMinGain: TSfmlMusicSetMinGain;
  SfmlMusicGetMinGain: TSfmlMusicGetMinGain;
  SfmlMusicSetMaxGain: TSfmlMusicSetMaxGain;
  SfmlMusicGetMaxGain: TSfmlMusicGetMaxGain;
  SfmlMusicSetEffectProcessor: TSfmlMusicSetEffectProcessor;
  SfmlMusicGetChannelMap: TSfmlMusicGetChannelMap;
  SfmlMusicGetLoopPoints: TSfmlMusicGetLoopPoints;
  SfmlMusicSetLoopPoints: TSfmlMusicSetLoopPoints;

  SfmlSoundStreamCreate: TSfmlSoundStreamCreate;
  SfmlSoundStreamDestroy: TSfmlSoundStreamDestroy;
  SfmlSoundStreamPlay: TSfmlSoundStreamPlay;
  SfmlSoundStreamPause: TSfmlSoundStreamPause;
  SfmlSoundStreamStop: TSfmlSoundStreamStop;
  SfmlSoundStreamGetStatus: TSfmlSoundStreamGetStatus;
  SfmlSoundStreamGetChannelCount: TSfmlSoundStreamGetChannelCount;
  SfmlSoundStreamGetSampleRate: TSfmlSoundStreamGetSampleRate;
  SfmlSoundStreamSetPitch: TSfmlSoundStreamSetPitch;
  SfmlSoundStreamSetVolume: TSfmlSoundStreamSetVolume;
  SfmlSoundStreamSetPosition: TSfmlSoundStreamSetPosition;
  SfmlSoundStreamSetRelativeToListener: TSfmlSoundStreamSetRelativeToListener;
  SfmlSoundStreamSetMinDistance: TSfmlSoundStreamSetMinDistance;
  SfmlSoundStreamSetAttenuation: TSfmlSoundStreamSetAttenuation;
  SfmlSoundStreamSetPlayingOffset: TSfmlSoundStreamSetPlayingOffset;
  SfmlSoundStreamSetLooping: TSfmlSoundStreamSetLooping;
  SfmlSoundStreamGetPitch: TSfmlSoundStreamGetPitch;
  SfmlSoundStreamGetVolume: TSfmlSoundStreamGetVolume;
  SfmlSoundStreamGetPosition: TSfmlSoundStreamGetPosition;
  SfmlSoundStreamIsRelativeToListener: TSfmlSoundStreamIsRelativeToListener;
  SfmlSoundStreamGetMinDistance: TSfmlSoundStreamGetMinDistance;
  SfmlSoundStreamGetAttenuation: TSfmlSoundStreamGetAttenuation;
  SfmlSoundStreamIsLooping: TSfmlSoundStreamIsLooping;
  SfmlSoundStreamGetChannelMap: TSfmlSoundStreamGetChannelMap;
  SfmlSoundStreamSetPan: TSfmlSoundStreamSetPan;
  SfmlSoundStreamGetPan: TSfmlSoundStreamGetPan;
  SfmlSoundStreamSetSpatializationEnabled: TSfmlSoundStreamSetSpatializationEnabled;
  SfmlSoundStreamIsSpatializationEnabled: TSfmlSoundStreamIsSpatializationEnabled;
  SfmlSoundStreamSetDirection: TSfmlSoundStreamSetDirection;
  SfmlSoundStreamGetDirection: TSfmlSoundStreamGetDirection;
  SfmlSoundStreamSetCone: TSfmlSoundStreamSetCone;
  SfmlSoundStreamGetCone: TSfmlSoundStreamGetCone;
  SfmlSoundStreamSetVelocity: TSfmlSoundStreamSetVelocity;
  SfmlSoundStreamGetVelocity: TSfmlSoundStreamGetVelocity;
  SfmlSoundStreamSetDopplerFactor: TSfmlSoundStreamSetDopplerFactor;
  SfmlSoundStreamGetDopplerFactor: TSfmlSoundStreamGetDopplerFactor;
  SfmlSoundStreamSetDirectionalAttenuationFactor: TSfmlSoundStreamSetDirectionalAttenuationFactor;
  SfmlSoundStreamGetDirectionalAttenuationFactor: TSfmlSoundStreamGetDirectionalAttenuationFactor;
  SfmlSoundStreamSetMaxDistance: TSfmlSoundStreamSetMaxDistance;
  SfmlSoundStreamGetMaxDistance: TSfmlSoundStreamGetMaxDistance;
  SfmlSoundStreamSetMinGain: TSfmlSoundStreamSetMinGain;
  SfmlSoundStreamGetMinGain: TSfmlSoundStreamGetMinGain;
  SfmlSoundStreamSetMaxGain: TSfmlSoundStreamSetMaxGain;
  SfmlSoundStreamGetMaxGain: TSfmlSoundStreamGetMaxGain;
  SfmlSoundStreamSetEffectProcessor: TSfmlSoundStreamSetEffectProcessor;

  SfmlSoundCreate: TSfmlSoundCreate;
  SfmlSoundCopy: TSfmlSoundCopy;
  SfmlSoundDestroy: TSfmlSoundDestroy;
  SfmlSoundPlay: TSfmlSoundPlay;
  SfmlSoundPause: TSfmlSoundPause;
  SfmlSoundStop: TSfmlSoundStop;
  SfmlSoundSetBuffer: TSfmlSoundSetBuffer;
  SfmlSoundGetBuffer: TSfmlSoundGetBuffer;
  SfmlSoundSetLooping: TSfmlSoundSetLooping;
  SfmlSoundIsLooping: TSfmlSoundIsLooping;
  SfmlSoundGetStatus: TSfmlSoundGetStatus;
  SfmlSoundSetPitch: TSfmlSoundSetPitch;
  SfmlSoundSetVolume: TSfmlSoundSetVolume;
  SfmlSoundSetPosition: TSfmlSoundSetPosition;
  SfmlSoundSetRelativeToListener: TSfmlSoundSetRelativeToListener;
  SfmlSoundSetMinDistance: TSfmlSoundSetMinDistance;
  SfmlSoundSetAttenuation: TSfmlSoundSetAttenuation;
  SfmlSoundSetPlayingOffset: TSfmlSoundSetPlayingOffset;
  SfmlSoundGetPitch: TSfmlSoundGetPitch;
  SfmlSoundGetVolume: TSfmlSoundGetVolume;
  SfmlSoundGetPosition: TSfmlSoundGetPosition;
  SfmlSoundIsRelativeToListener: TSfmlSoundIsRelativeToListener;
  SfmlSoundGetMinDistance: TSfmlSoundGetMinDistance;
  SfmlSoundGetAttenuation: TSfmlSoundGetAttenuation;
  SfmlSoundSetPan: TSfmlSoundSetPan;
  SfmlSoundGetPan: TSfmlSoundGetPan;
  SfmlSoundSetSpatializationEnabled: TSfmlSoundSetSpatializationEnabled;
  SfmlSoundIsSpatializationEnabled: TSfmlSoundIsSpatializationEnabled;
  SfmlSoundSetDirection: TSfmlSoundSetDirection;
  SfmlSoundGetDirection: TSfmlSoundGetDirection;
  SfmlSoundSetCone: TSfmlSoundSetCone;
  SfmlSoundGetCone: TSfmlSoundGetCone;
  SfmlSoundSetVelocity: TSfmlSoundSetVelocity;
  SfmlSoundGetVelocity: TSfmlSoundGetVelocity;
  SfmlSoundSetDopplerFactor: TSfmlSoundSetDopplerFactor;
  SfmlSoundGetDopplerFactor: TSfmlSoundGetDopplerFactor;
  SfmlSoundSetDirectionalAttenuationFactor: TSfmlSoundSetDirectionalAttenuationFactor;
  SfmlSoundGetDirectionalAttenuationFactor: TSfmlSoundGetDirectionalAttenuationFactor;
  SfmlSoundSetMaxDistance: TSfmlSoundSetMaxDistance;
  SfmlSoundGetMaxDistance: TSfmlSoundGetMaxDistance;
  SfmlSoundSetMinGain: TSfmlSoundSetMinGain;
  SfmlSoundGetMinGain: TSfmlSoundGetMinGain;
  SfmlSoundSetMaxGain: TSfmlSoundSetMaxGain;
  SfmlSoundGetMaxGain: TSfmlSoundGetMaxGain;
  SfmlSoundSetEffectProcessor: TSfmlSoundSetEffectProcessor;

  SfmlSoundBufferCreateFromFile: TSfmlSoundBufferCreateFromFile;
  SfmlSoundBufferCreateFromMemory: TSfmlSoundBufferCreateFromMemory;
  SfmlSoundBufferCreateFromStream: TSfmlSoundBufferCreateFromStream;
  SfmlSoundBufferCreateFromSamples: TSfmlSoundBufferCreateFromSamples;
  SfmlSoundBufferCopy: TSfmlSoundBufferCopy;
  SfmlSoundBufferDestroy: TSfmlSoundBufferDestroy;
  SfmlSoundBufferSaveToFile: TSfmlSoundBufferSaveToFile;
  SfmlSoundBufferGetSamples: TSfmlSoundBufferGetSamples;
  SfmlSoundBufferGetSampleCount: TSfmlSoundBufferGetSampleCount;
  SfmlSoundBufferGetSampleRate: TSfmlSoundBufferGetSampleRate;
  SfmlSoundBufferGetChannelCount: TSfmlSoundBufferGetChannelCount;

  SfmlSoundBufferRecorderCreate: TSfmlSoundBufferRecorderCreate;
  SfmlSoundBufferRecorderDestroy: TSfmlSoundBufferRecorderDestroy;
  SfmlSoundBufferRecorderStart: TSfmlSoundBufferRecorderStart;
  SfmlSoundBufferRecorderStop: TSfmlSoundBufferRecorderStop;
  SfmlSoundBufferRecorderGetSampleRate: TSfmlSoundBufferRecorderGetSampleRate;
  SfmlSoundBufferRecorderGetBuffer: TSfmlSoundBufferRecorderGetBuffer;
  SfmlSoundBufferRecorderSetDevice: TSfmlSoundBufferRecorderSetDevice;
  SfmlSoundBufferRecorderGetDevice: TSfmlSoundBufferRecorderGetDevice;

  SfmlSoundRecorderCreate: TSfmlSoundRecorderCreate;
  SfmlSoundRecorderDestroy: TSfmlSoundRecorderDestroy;
  SfmlSoundRecorderStart: TSfmlSoundRecorderStart;
  SfmlSoundRecorderStop: TSfmlSoundRecorderStop;
  SfmlSoundRecorderGetSampleRate: TSfmlSoundRecorderGetSampleRate;
  SfmlSoundRecorderIsAvailable: TSfmlSoundRecorderIsAvailable;
  SfmlSoundRecorderGetAvailableDevices: TSfmlSoundRecorderGetAvailableDevices;
  SfmlSoundRecorderGetDefaultDevice: TSfmlSoundRecorderGetDefaultDevice;
  SfmlSoundRecorderSetDevice: TSfmlSoundRecorderSetDevice;
  SfmlSoundRecorderGetDevice: TSfmlSoundRecorderGetDevice;
  SfmlSoundRecorderSetChannelCount: TSfmlSoundRecorderSetChannelCount;
  SfmlSoundRecorderGetChannelCount: TSfmlSoundRecorderGetChannelCount;
  SfmlSoundRecorderGetChannelMap: TSfmlSoundRecorderGetChannelMap;

{$IFNDEF INT64RETURNWORKAROUND}
  SfmlMusicGetDuration: TSfmlMusicGetDuration;
  SfmlMusicGetPlayingOffset: TSfmlMusicGetPlayingOffset;
  SfmlSoundStreamGetPlayingOffset: TSfmlSoundStreamGetPlayingOffset;
  SfmlSoundGetPlayingOffset: TSfmlSoundGetPlayingOffset;
  SfmlSoundBufferGetDuration: TSfmlSoundBufferGetDuration;
{$ENDIF}
{$ELSE}
  // static linking
  procedure SfmlListenerSetGlobalVolume(Volume: Single); cdecl; external CSfmlAudioLibrary name 'sfListener_setGlobalVolume';
  function SfmlListenerGetGlobalVolume: Single; cdecl; external CSfmlAudioLibrary name 'sfListener_getGlobalVolume';
  procedure SfmlListenerSetPosition(Position: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfListener_setPosition';
  function SfmlListenerGetPosition: TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfListener_getPosition';
  procedure SfmlListenerSetDirection(Direction: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfListener_setDirection';
  function SfmlListenerGetDirection: TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfListener_getDirection';
  procedure SfmlListenerSetUpVector(UpVector: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfListener_setUpVector';
  function SfmlListenerGetUpVector: TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfListener_getUpVector';
  procedure SfmlListenerSetVelocity(Velocity: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfListener_setVelocity';
  function SfmlListenerGetVelocity: TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfListener_getVelocity';
  procedure SfmlListenerSetCone(Cone: TSfmlSoundSourceCone); cdecl; external CSfmlAudioLibrary name 'sfListener_setCone';
  function SfmlListenerGetCone: TSfmlSoundSourceCone; cdecl; external CSfmlAudioLibrary name 'sfListener_getCone';

  function SfmlMusicCreateFromFile(const FileName: PAnsiChar): PSfmlMusic; cdecl; external CSfmlAudioLibrary name 'sfMusic_createFromFile';
  function SfmlMusicCreateFromMemory(const data: Pointer; SizeInBytes: NativeUInt): PSfmlMusic; cdecl; external CSfmlAudioLibrary name 'sfMusic_createFromMemory';
  function SfmlMusicCreateFromStream(Stream: PSfmlInputStream): PSfmlMusic; cdecl; external CSfmlAudioLibrary name 'sfMusic_createFromStream';
  procedure SfmlMusicDestroy(Music: PSfmlMusic); cdecl; external CSfmlAudioLibrary name 'sfMusic_destroy';
  procedure SfmlMusicSetLooping(Music: PSfmlMusic; Loop: LongBool); cdecl; external CSfmlAudioLibrary name 'sfMusic_setLooping';
  function SfmlMusicIsLooping(const Music: PSfmlMusic): LongBool; cdecl; external CSfmlAudioLibrary name 'sfMusic_isLooping';
  {$IFNDEF INT64RETURNWORKAROUND}
  function SfmlMusicGetDuration(const Music: PSfmlMusic): TSfmlTime; cdecl; external CSfmlAudioLibrary name 'sfMusic_getDuration';
  {$ENDIF}
  procedure SfmlMusicPlay(Music: PSfmlMusic); cdecl; external CSfmlAudioLibrary name 'sfMusic_play';
  procedure SfmlMusicPause(Music: PSfmlMusic); cdecl; external CSfmlAudioLibrary name 'sfMusic_pause';
  procedure SfmlMusicStop(Music: PSfmlMusic); cdecl; external CSfmlAudioLibrary name 'sfMusic_stop';
  function SfmlMusicGetChannelCount(const Music: PSfmlMusic): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfMusic_getChannelCount';
  function SfmlMusicGetSampleRate(const Music: PSfmlMusic): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfMusic_getSampleRate';
  function SfmlMusicGetStatus(const Music: PSfmlMusic): TSfmlSoundStatus; cdecl; external CSfmlAudioLibrary name 'sfMusic_getStatus';
  {$IFNDEF INT64RETURNWORKAROUND}
  function SfmlMusicGetPlayingOffset(const Music: PSfmlMusic): TSfmlTime; cdecl; external CSfmlAudioLibrary name 'sfMusic_getPlayingOffset';
  {$ENDIF}
  procedure SfmlMusicSetPitch(Music: PSfmlMusic; Pitch: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setPitch';
  procedure SfmlMusicSetVolume(Music: PSfmlMusic; Volume: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setVolume';
  procedure SfmlMusicSetPosition(Music: PSfmlMusic; Position: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfMusic_setPosition';
  procedure SfmlMusicSetRelativeToListener(Music: PSfmlMusic; Relative: LongBool); cdecl; external CSfmlAudioLibrary name 'sfMusic_setRelativeToListener';
  procedure SfmlMusicSetMinDistance(Music: PSfmlMusic; Distance: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setMinDistance';
  procedure SfmlMusicSetAttenuation(Music: PSfmlMusic; Attenuation: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setAttenuation';
  procedure SfmlMusicSetPlayingOffset(Music: PSfmlMusic; TimeOffset: TSfmlTime); cdecl; external CSfmlAudioLibrary name 'sfMusic_setPlayingOffset';
  function SfmlMusicGetPitch(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getPitch';
  function SfmlMusicGetVolume(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getVolume';
  function SfmlMusicGetPosition(const Music: PSfmlMusic): TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfMusic_getPosition';
  function SfmlMusicIsRelativeToListener(const Music: PSfmlMusic): LongBool; cdecl; external CSfmlAudioLibrary name 'sfMusic_isRelativeToListener';
  function SfmlMusicGetMinDistance(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getMinDistance';
  function SfmlMusicGetAttenuation(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getAttenuation';
  procedure SfmlMusicSetPan(Music: PSfmlMusic; Pan: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setPan';
  function SfmlMusicGetPan(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getPan';
  procedure SfmlMusicSetSpatializationEnabled(Music: PSfmlMusic; Enabled: LongBool); cdecl; external CSfmlAudioLibrary name 'sfMusic_setSpatializationEnabled';
  function SfmlMusicIsSpatializationEnabled(const Music: PSfmlMusic): LongBool; cdecl; external CSfmlAudioLibrary name 'sfMusic_isSpatializationEnabled';
  procedure SfmlMusicSetDirection(Music: PSfmlMusic; Direction: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfMusic_setDirection';
  function SfmlMusicGetDirection(const Music: PSfmlMusic): TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfMusic_getDirection';
  procedure SfmlMusicSetCone(Music: PSfmlMusic; Cone: TSfmlSoundSourceCone); cdecl; external CSfmlAudioLibrary name 'sfMusic_setCone';
  function SfmlMusicGetCone(const Music: PSfmlMusic): TSfmlSoundSourceCone; cdecl; external CSfmlAudioLibrary name 'sfMusic_getCone';
  procedure SfmlMusicSetVelocity(Music: PSfmlMusic; Velocity: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfMusic_setVelocity';
  function SfmlMusicGetVelocity(const Music: PSfmlMusic): TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfMusic_getVelocity';
  procedure SfmlMusicSetDopplerFactor(Music: PSfmlMusic; Factor: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setDopplerFactor';
  function SfmlMusicGetDopplerFactor(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getDopplerFactor';
  procedure SfmlMusicSetDirectionalAttenuationFactor(Music: PSfmlMusic; Factor: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setDirectionalAttenuationFactor';
  function SfmlMusicGetDirectionalAttenuationFactor(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getDirectionalAttenuationFactor';
  procedure SfmlMusicSetMaxDistance(Music: PSfmlMusic; Distance: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setMaxDistance';
  function SfmlMusicGetMaxDistance(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getMaxDistance';
  procedure SfmlMusicSetMinGain(Music: PSfmlMusic; Gain: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setMinGain';
  function SfmlMusicGetMinGain(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getMinGain';
  procedure SfmlMusicSetMaxGain(Music: PSfmlMusic; Gain: Single); cdecl; external CSfmlAudioLibrary name 'sfMusic_setMaxGain';
  function SfmlMusicGetMaxGain(const Music: PSfmlMusic): Single; cdecl; external CSfmlAudioLibrary name 'sfMusic_getMaxGain';
  procedure SfmlMusicSetEffectProcessor(Music: PSfmlMusic; EffectProcessor: TSfmlEffectProcessor); cdecl; external CSfmlAudioLibrary name 'sfMusic_setEffectProcessor';
  function SfmlMusicGetChannelMap(const Music: PSfmlMusic; Count: PNativeUInt): PSfmlSoundChannel; cdecl; external CSfmlAudioLibrary name 'sfMusic_getChannelMap';
  function SfmlMusicGetLoopPoints(const Music: PSfmlMusic): TSfmlTimeSpan; cdecl; external CSfmlAudioLibrary name 'sfMusic_getLoopPoints';
  procedure SfmlMusicSetLoopPoints(Music: PSfmlMusic; TimePoints: TSfmlTimeSpan); cdecl; external CSfmlAudioLibrary name 'sfMusic_setLoopPoints';

  function SfmlSoundStreamCreate(OnGetData: TSfmlSoundStreamGetDataCallback; OnSeek: TSfmlSoundStreamSeekCallback; ChannelCount, SampleRate: Cardinal; ChannelMapData: PSfmlSoundChannel; ChannelMapSize: NativeUInt; UserData: Pointer): PSfmlSoundStream; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_create';
  procedure SfmlSoundStreamDestroy(SoundStream: PSfmlSoundStream); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_destroy';
  procedure SfmlSoundStreamPlay(SoundStream: PSfmlSoundStream); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_play';
  procedure SfmlSoundStreamPause(SoundStream: PSfmlSoundStream); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_pause';
  procedure SfmlSoundStreamStop(SoundStream: PSfmlSoundStream); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_stop';
  function SfmlSoundStreamGetStatus(const SoundStream: PSfmlSoundStream): TSfmlSoundStatus; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getStatus';
  function SfmlSoundStreamGetChannelCount(const SoundStream: PSfmlSoundStream): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getChannelCount';
  function SfmlSoundStreamGetSampleRate(const SoundStream: PSfmlSoundStream): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getSampleRate';
  procedure SfmlSoundStreamSetPitch(SoundStream: PSfmlSoundStream; Pitch: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setPitch';
  procedure SfmlSoundStreamSetVolume(SoundStream: PSfmlSoundStream; Volume: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setVolume';
  procedure SfmlSoundStreamSetPosition(SoundStream: PSfmlSoundStream; Position: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setPosition';
  procedure SfmlSoundStreamSetRelativeToListener(SoundStream: PSfmlSoundStream; Relative: LongBool); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setRelativeToListener';
  procedure SfmlSoundStreamSetMinDistance(SoundStream: PSfmlSoundStream; Distance: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setMinDistance';
  procedure SfmlSoundStreamSetAttenuation(SoundStream: PSfmlSoundStream; Attenuation: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setAttenuation';
  procedure SfmlSoundStreamSetPlayingOffset(SoundStream: PSfmlSoundStream; TimeOffset: TSfmlTime); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setPlayingOffset';
  procedure SfmlSoundStreamSetLooping(SoundStream: PSfmlSoundStream; Loop: LongBool); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setLooping';
  function SfmlSoundStreamGetPitch(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getPitch';
  function SfmlSoundStreamGetVolume(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getVolume';
  function SfmlSoundStreamGetPosition(const SoundStream: PSfmlSoundStream): TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getPosition';
  function SfmlSoundStreamIsRelativeToListener(const SoundStream: PSfmlSoundStream): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_isRelativeToListener';
  function SfmlSoundStreamGetMinDistance(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getMinDistance';
  function SfmlSoundStreamGetAttenuation(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getAttenuation';
  function SfmlSoundStreamIsLooping(const SoundStream: PSfmlSoundStream): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_isLooping';
  {$IFNDEF INT64RETURNWORKAROUND}
  function SfmlSoundStreamGetPlayingOffset(const SoundStream: PSfmlSoundStream): TSfmlTime; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getPlayingOffset';
  {$ENDIF}
  function SfmlSoundStreamGetChannelMap(const SoundStream: PSfmlSoundStream; Count: PNativeUInt): PSfmlSoundChannel; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getChannelMap';
  procedure SfmlSoundStreamSetPan(SoundStream: PSfmlSoundStream; Pan: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setPan';
  function SfmlSoundStreamGetPan(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getPan';
  procedure SfmlSoundStreamSetSpatializationEnabled(SoundStream: PSfmlSoundStream; Enabled: LongBool); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setSpatializationEnabled';
  function SfmlSoundStreamIsSpatializationEnabled(const SoundStream: PSfmlSoundStream): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_isSpatializationEnabled';
  procedure SfmlSoundStreamSetDirection(SoundStream: PSfmlSoundStream; Direction: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setDirection';
  function SfmlSoundStreamGetDirection(const SoundStream: PSfmlSoundStream): TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getDirection';
  procedure SfmlSoundStreamSetCone(SoundStream: PSfmlSoundStream; Cone: TSfmlSoundSourceCone); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setCone';
  function SfmlSoundStreamGetCone(const SoundStream: PSfmlSoundStream): TSfmlSoundSourceCone; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getCone';
  procedure SfmlSoundStreamSetVelocity(SoundStream: PSfmlSoundStream; Velocity: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setVelocity';
  function SfmlSoundStreamGetVelocity(const SoundStream: PSfmlSoundStream): TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getVelocity';
  procedure SfmlSoundStreamSetDopplerFactor(SoundStream: PSfmlSoundStream; Factor: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setDopplerFactor';
  function SfmlSoundStreamGetDopplerFactor(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getDopplerFactor';
  procedure SfmlSoundStreamSetDirectionalAttenuationFactor(SoundStream: PSfmlSoundStream; Factor: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setDirectionalAttenuationFactor';
  function SfmlSoundStreamGetDirectionalAttenuationFactor(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getDirectionalAttenuationFactor';
  procedure SfmlSoundStreamSetMaxDistance(SoundStream: PSfmlSoundStream; Distance: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setMaxDistance';
  function SfmlSoundStreamGetMaxDistance(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getMaxDistance';
  procedure SfmlSoundStreamSetMinGain(SoundStream: PSfmlSoundStream; Gain: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setMinGain';
  function SfmlSoundStreamGetMinGain(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getMinGain';
  procedure SfmlSoundStreamSetMaxGain(SoundStream: PSfmlSoundStream; Gain: Single); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setMaxGain';
  function SfmlSoundStreamGetMaxGain(const SoundStream: PSfmlSoundStream): Single; cdecl; external CSfmlAudioLibrary name 'sfSoundStream_getMaxGain';
  procedure SfmlSoundStreamSetEffectProcessor(SoundStream: PSfmlSoundStream; EffectProcessor: TSfmlEffectProcessor); cdecl; external CSfmlAudioLibrary name 'sfSoundStream_setEffectProcessor';

  function SfmlSoundCreate(const Buffer: PSfmlSoundBuffer): PSfmlSound; cdecl; external CSfmlAudioLibrary name 'sfSound_create';
  function SfmlSoundCopy(const Sound: PSfmlSound): PSfmlSound; cdecl; external CSfmlAudioLibrary name 'sfSound_copy';
  procedure SfmlSoundDestroy(Sound: PSfmlSound); cdecl; external CSfmlAudioLibrary name 'sfSound_destroy';
  procedure SfmlSoundPlay(Sound: PSfmlSound); cdecl; external CSfmlAudioLibrary name 'sfSound_play';
  procedure SfmlSoundPause(Sound: PSfmlSound); cdecl; external CSfmlAudioLibrary name 'sfSound_pause';
  procedure SfmlSoundStop(Sound: PSfmlSound); cdecl; external CSfmlAudioLibrary name 'sfSound_stop';
  procedure SfmlSoundSetBuffer(Sound: PSfmlSound; const Buffer: PSfmlSoundBuffer); cdecl; external CSfmlAudioLibrary name 'sfSound_setBuffer';
  function SfmlSoundGetBuffer(const Sound: PSfmlSound): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSound_getBuffer';
  procedure SfmlSoundSetLooping(Sound: PSfmlSound; Loop: LongBool); cdecl; external CSfmlAudioLibrary name 'sfSound_setLooping';
  function SfmlSoundIsLooping(const Sound: PSfmlSound): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSound_isLooping';
  function SfmlSoundGetStatus(const Sound: PSfmlSound): TSfmlSoundStatus; cdecl; external CSfmlAudioLibrary name 'sfSound_getStatus';
  procedure SfmlSoundSetPitch(Sound: PSfmlSound; Pitch: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setPitch';
  procedure SfmlSoundSetVolume(Sound: PSfmlSound; Volume: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setVolume';
  procedure SfmlSoundSetPosition(Sound: PSfmlSound; Position: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfSound_setPosition';
  procedure SfmlSoundSetRelativeToListener(Sound: PSfmlSound; Relative: LongBool); cdecl; external CSfmlAudioLibrary name 'sfSound_setRelativeToListener';
  procedure SfmlSoundSetMinDistance(Sound: PSfmlSound; Distance: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setMinDistance';
  procedure SfmlSoundSetAttenuation(Sound: PSfmlSound; Attenuation: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setAttenuation';
  procedure SfmlSoundSetPlayingOffset(Sound: PSfmlSound; TimeOffset: TSfmlTime); cdecl; external CSfmlAudioLibrary name 'sfSound_setPlayingOffset';
  function SfmlSoundGetPitch(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getPitch';
  function SfmlSoundGetVolume(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getVolume';
  function SfmlSoundGetPosition(const Sound: PSfmlSound): TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfSound_getPosition';
  function SfmlSoundIsRelativeToListener(const Sound: PSfmlSound): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSound_isRelativeToListener';
  function SfmlSoundGetMinDistance(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getMinDistance';
  function SfmlSoundGetAttenuation(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getAttenuation';
{$IFNDEF INT64RETURNWORKAROUND}
  function SfmlSoundGetPlayingOffset(const Sound: PSfmlSound): TSfmlTime; cdecl; external CSfmlAudioLibrary name 'sfSound_getPlayingOffset';
{$ENDIF}
  procedure SfmlSoundSetPan(Sound: PSfmlSound; Pan: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setPan';
  function SfmlSoundGetPan(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getPan';
  procedure SfmlSoundSetSpatializationEnabled(Sound: PSfmlSound; Enabled: LongBool); cdecl; external CSfmlAudioLibrary name 'sfSound_setSpatializationEnabled';
  function SfmlSoundIsSpatializationEnabled(const Sound: PSfmlSound): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSound_isSpatializationEnabled';
  procedure SfmlSoundSetDirection(Sound: PSfmlSound; Direction: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfSound_setDirection';
  function SfmlSoundGetDirection(const Sound: PSfmlSound): TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfSound_getDirection';
  procedure SfmlSoundSetCone(Sound: PSfmlSound; Cone: TSfmlSoundSourceCone); cdecl; external CSfmlAudioLibrary name 'sfSound_setCone';
  function SfmlSoundGetCone(const Sound: PSfmlSound): TSfmlSoundSourceCone; cdecl; external CSfmlAudioLibrary name 'sfSound_getCone';
  procedure SfmlSoundSetVelocity(Sound: PSfmlSound; Velocity: TSfmlVector3f); cdecl; external CSfmlAudioLibrary name 'sfSound_setVelocity';
  function SfmlSoundGetVelocity(const Sound: PSfmlSound): TSfmlVector3f; cdecl; external CSfmlAudioLibrary name 'sfSound_getVelocity';
  procedure SfmlSoundSetDopplerFactor(Sound: PSfmlSound; Factor: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setDopplerFactor';
  function SfmlSoundGetDopplerFactor(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getDopplerFactor';
  procedure SfmlSoundSetDirectionalAttenuationFactor(Sound: PSfmlSound; Factor: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setDirectionalAttenuationFactor';
  function SfmlSoundGetDirectionalAttenuationFactor(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getDirectionalAttenuationFactor';
  procedure SfmlSoundSetMaxDistance(Sound: PSfmlSound; Distance: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setMaxDistance';
  function SfmlSoundGetMaxDistance(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getMaxDistance';
  procedure SfmlSoundSetMinGain(Sound: PSfmlSound; Gain: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setMinGain';
  function SfmlSoundGetMinGain(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getMinGain';
  procedure SfmlSoundSetMaxGain(Sound: PSfmlSound; Gain: Single); cdecl; external CSfmlAudioLibrary name 'sfSound_setMaxGain';
  function SfmlSoundGetMaxGain(const Sound: PSfmlSound): Single; cdecl; external CSfmlAudioLibrary name 'sfSound_getMaxGain';
  procedure SfmlSoundSetEffectProcessor(Sound: PSfmlSound; EffectProcessor: TSfmlEffectProcessor); cdecl; external CSfmlAudioLibrary name 'sfSound_setEffectProcessor';

  function SfmlSoundBufferCreateFromFile(const FileName: PAnsiChar): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_createFromFile';
  function SfmlSoundBufferCreateFromMemory(const Data: Pointer; SizeInBytes: NativeUInt): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_createFromMemory';
  function SfmlSoundBufferCreateFromStream(Stream: PSfmlInputStream): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_createFromStream';
  function SfmlSoundBufferCreateFromSamples(const Samples: PSmallInt; SampleCount: UInt64; ChannelCount, SampleRate: Cardinal): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_createFromSamples';
  function SfmlSoundBufferCopy(const SoundBuffer: PSfmlSoundBuffer): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_copy';
  procedure SfmlSoundBufferDestroy(SoundBuffer: PSfmlSoundBuffer); cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_destroy';
  function SfmlSoundBufferSaveToFile(const SoundBuffer: PSfmlSoundBuffer; const FileName: PAnsiChar): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_saveToFile';
  function SfmlSoundBufferGetSamples(const SoundBuffer: PSfmlSoundBuffer): PSmallInt; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_getSamples';
  function SfmlSoundBufferGetSampleCount(const SoundBuffer: PSfmlSoundBuffer): NativeUInt; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_getSampleCount';
  function SfmlSoundBufferGetSampleRate(const SoundBuffer: PSfmlSoundBuffer): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_getSampleRate';
  function SfmlSoundBufferGetChannelCount(const SoundBuffer: PSfmlSoundBuffer): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_getChannelCount';
  {$IFNDEF INT64RETURNWORKAROUND}
  function SfmlSoundBufferGetDuration(const SoundBuffer: PSfmlSoundBuffer): TSfmlTime; cdecl; external CSfmlAudioLibrary name 'sfSoundBuffer_getDuration';
  {$ENDIF}

  function SfmlSoundBufferRecorderCreate: PSfmlSoundBufferRecorder; cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_create';
  procedure SfmlSoundBufferRecorderDestroy(soundBufferRecorder: PSfmlSoundBufferRecorder); cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_destroy';
  function SfmlSoundBufferRecorderStart(soundBufferRecorder: PSfmlSoundBufferRecorder; SampleRate: Cardinal): Longbool; cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_start';
  procedure SfmlSoundBufferRecorderStop(soundBufferRecorder: PSfmlSoundBufferRecorder); cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_stop';
  function SfmlSoundBufferRecorderGetSampleRate(const soundBufferRecorder: PSfmlSoundBufferRecorder): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_getSampleRate';
  function SfmlSoundBufferRecorderGetBuffer(const soundBufferRecorder: PSfmlSoundBufferRecorder): PSfmlSoundBuffer; cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_getBuffer';
  function SfmlSoundBufferRecorderSetDevice(SoundRecorder: PSfmlSoundBufferRecorder; const Name: PAnsiChar): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_setDevice';
  function SfmlSoundBufferRecorderGetDevice(SoundRecorder: PSfmlSoundBufferRecorder): PAnsiChar; cdecl; external CSfmlAudioLibrary name 'sfSoundBufferRecorder_getDevice';

  function SfmlSoundRecorderCreate(OnStart: TSfmlSoundRecorderStartCallback; OnProcess: TSfmlSoundRecorderProcessCallback; OnStop: TSfmlSoundRecorderStopCallback; UserData: Pointer): PSfmlSoundRecorder; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_create';
  procedure SfmlSoundRecorderDestroy(SoundRecorder: PSfmlSoundRecorder); cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_destroy';
  function SfmlSoundRecorderStart(SoundRecorder: PSfmlSoundRecorder; SampleRate: Cardinal): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_start';
  procedure SfmlSoundRecorderStop(SoundRecorder: PSfmlSoundRecorder); cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_stop';
  function SfmlSoundRecorderGetSampleRate(const SoundRecorder: PSfmlSoundRecorder): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_getSampleRate';
  function SfmlSoundRecorderIsAvailable: LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_isAvailable';
  function SfmlSoundRecorderGetAvailableDevices(count: PNativeUInt): PPAnsiChar; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_getAvailableDevices';
  function SfmlSoundRecorderGetDefaultDevice: PAnsiChar; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_getDefaultDevice';
  function SfmlSoundRecorderSetDevice(SoundRecorder: PSfmlSoundRecorder; const Name: PAnsiChar): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_setDevice';
  function SfmlSoundRecorderGetDevice(SoundRecorder: PSfmlSoundRecorder): PAnsiChar; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_getDevice';
  function SfmlSoundRecorderSetChannelCount(SoundRecorder: PSfmlSoundRecorder; const ChannelCount: Cardinal): LongBool; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_setChannelCount';
  function SfmlSoundRecorderGetChannelCount(const SoundRecorder: PSfmlSoundRecorder): Cardinal; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_getChannelCount';
  function SfmlSoundRecorderGetChannelMap(const SoundRecorder: PSfmlSoundRecorder; Count: PNativeUInt): PSfmlSoundChannel; cdecl; external CSfmlAudioLibrary name 'sfSoundRecorder_getChannelMap';
{$ENDIF}

type
  TSfmlSoundSource = class
  protected
    function GetAttenuation: Single; virtual; abstract;
    function GetMinDistance: Single; virtual; abstract;
    function GetPitch: Single; virtual; abstract;
    function GetPosition: TSfmlVector3f; virtual; abstract;
    function GetRelativeToListener: Boolean; virtual; abstract;
    function GetStatus: TSfmlSoundStatus; virtual; abstract;
    function GetVolume: Single; virtual; abstract;
    procedure SetAttenuation(Attenuation: Single); virtual; abstract;
    procedure SetMinDistance(Distance: Single); virtual; abstract;
    procedure SetPitch(Pitch: Single); virtual; abstract;
    procedure SetPosition(Position: TSfmlVector3f); virtual; abstract;
    procedure SetRelativeToListener(Relative: Boolean); virtual; abstract;
    procedure SetVolume(Volume: Single); virtual; abstract;
  public
    property Attenuation: Single read GetAttenuation write SetAttenuation;
    property MinDistance: Single read GetMinDistance write SetMinDistance;
    property Pitch: Single read GetPitch write SetPitch;
    property Position: TSfmlVector3f read GetPosition write SetPosition;
    property RelativeToListener: Boolean read GetRelativeToListener write SetRelativeToListener;
    property Status: TSfmlSoundStatus read GetStatus;
    property Volume: Single read GetVolume write SetVolume;
  end;

  TSfmlSoundStream = class(TSfmlSoundSource)
  private
    FHandle: PSfmlSoundStream;
  protected
    function GetAttenuation: Single; override;
    function GetChannelCount: Cardinal; virtual;
    function GetLoop: Boolean; virtual;
    function GetMinDistance: Single; override;
    function GetPitch: Single; override;
    function GetPlayingOffset: TSfmlTime; virtual;
    function GetPosition: TSfmlVector3f; override;
    function GetRelativeToListener: Boolean; override;
    function GetSampleRate: Cardinal; virtual;
    function GetStatus: TSfmlSoundStatus; override;
    function GetVolume: Single; override;
    procedure SetAttenuation(Attenuation: Single); override;
    procedure SetLoop(Loop: Boolean); virtual;
    procedure SetMinDistance(Distance: Single); override;
    procedure SetPitch(Pitch: Single); override;
    procedure SetPlayingOffset(TimeOffset: TSfmlTime); virtual;
    procedure SetPosition(Position: TSfmlVector3f); override;
    procedure SetRelativeToListener(Relative: Boolean); override;
    procedure SetVolume(Volume: Single); override;
  public
    constructor Create(OnGetData: TSfmlSoundStreamGetDataCallback;
      OnSeek: TSfmlSoundStreamSeekCallback;
      ChannelCount, SampleRate: Cardinal; ChannelMapData: PSfmlSoundChannel = nil;
      ChannelMapSize: NativeUInt = 0; UserData: Pointer = nil);
    destructor Destroy; override;

    procedure Play;
    procedure Pause;
    procedure Stop;

    property ChannelCount: Cardinal read GetChannelCount;
    property Handle: PSfmlSoundStream read FHandle;
    property Looping: Boolean read GetLoop write SetLoop;
    property PlayingOffset: TSfmlTime read GetPlayingOffset write SetPlayingOffset;
    property SampleRate: Cardinal read GetSampleRate;
  end;

  TSfmlMusic = class(TSfmlSoundStream)
  private
    FHandle: PSfmlMusic;
    function GetDuration: TSfmlTime;
  protected
    function GetAttenuation: Single; override;
    function GetChannelCount: Cardinal; override;
    function GetLoop: Boolean; override;
    function GetMinDistance: Single; override;
    function GetPitch: Single; override;
    function GetPlayingOffset: TSfmlTime; override;
    function GetPosition: TSfmlVector3f; override;
    function GetRelativeToListener: Boolean; override;
    function GetSampleRate: Cardinal; override;
    function GetStatus: TSfmlSoundStatus; override;
    function GetVolume: Single; override;
    procedure SetAttenuation(Attenuation: Single); override;
    procedure SetLoop(Loop: Boolean); override;
    procedure SetMinDistance(Distance: Single); override;
    procedure SetPitch(Pitch: Single); override;
    procedure SetPlayingOffset(TimeOffset: TSfmlTime); override;
    procedure SetPosition(Position: TSfmlVector3f); override;
    procedure SetRelativeToListener(Relative: Boolean); override;
    procedure SetVolume(Volume: Single); override;
  public
    constructor Create(const FileName: AnsiString); overload;
    constructor Create(const Data: Pointer; SizeInBytes: NativeUInt); overload;
    constructor Create(Stream: PSfmlInputStream); overload;
    destructor Destroy; override;

    procedure Play;
    procedure Pause;
    procedure Stop;

    property Attenuation: Single read GetAttenuation write SetAttenuation;
    property ChannelCount: Cardinal read GetChannelCount;
    property Duration: TSfmlTime read GetDuration;
    property Handle: PSfmlMusic read FHandle;
    property Looping: Boolean read GetLoop write SetLoop;
    property MinDistance: Single read GetMinDistance write SetMinDistance;
    property Pitch: Single read GetPitch write SetPitch;
    property PlayingOffset: TSfmlTime read GetPlayingOffset write SetPlayingOffset;
    property Position: TSfmlVector3f read GetPosition write SetPosition;
    property RelativeToListener: Boolean read GetRelativeToListener write SetRelativeToListener;
    property SampleRate: Cardinal read GetSampleRate;
    property Status: TSfmlSoundStatus read GetStatus;
    property Volume: Single read GetVolume write SetVolume;
  end;

  TSfmlSoundBuffer = class
  private
    FHandle: PSfmlSoundBuffer;
    constructor Create(Handle: PSfmlSoundBuffer); overload;
    function GetSampleCount: NativeUInt;
    function GetSampleRate: Cardinal;
    function GetChannelCount: Cardinal;
    function GetDuration: TSfmlTime;
  public
    constructor Create(const FileName: AnsiString); overload;
    constructor Create(const Data: Pointer; SizeInBytes: NativeUInt); overload;
    constructor Create(Stream: PSfmlInputStream); overload;
    constructor Create(const Samples: PSmallInt; SampleCount: NativeUInt;
      ChannelCount, SampleRate: Cardinal); overload;
    destructor Destroy; override;

    function Copy: TSfmlSoundBuffer;
    function SaveToFile(const FileName: AnsiString): Boolean;
    function GetSamples: PSmallInt;

    property ChannelCount: Cardinal read GetChannelCount;
    property Duration: TSfmlTime read GetDuration;
    property Handle: PSfmlSoundBuffer read FHandle;
    property SampleCount: NativeUInt read GetSampleCount;
    property SampleRate: Cardinal read GetSampleRate;
  end;

  TSfmlSound = class(TSfmlSoundSource)
  private
    FHandle: PSfmlSound;
    constructor Create(Handle: PSfmlSound); overload;
    function GetLoop: Boolean;
    function GetPlayingOffset: TSfmlTime;
    procedure SetLoop(Loop: Boolean);
    procedure SetPlayingOffset(TimeOffset: TSfmlTime);
  protected
    function GetAttenuation: Single; override;
    function GetPitch: Single; override;
    function GetMinDistance: Single; override;
    function GetPosition: TSfmlVector3f; override;
    function GetRelativeToListener: Boolean; override;
    function GetStatus: TSfmlSoundStatus; override;
    function GetVolume: Single; override;
    procedure SetAttenuation(Attenuation: Single); override;
    procedure SetMinDistance(Distance: Single); override;
    procedure SetPitch(Pitch: Single); override;
    procedure SetPosition(Position: TSfmlVector3f); override;
    procedure SetRelativeToListener(Relative: Boolean); override;
    procedure SetVolume(Volume: Single); override;
  public
    constructor Create(Buffer: TSfmlSoundBuffer); overload;
    constructor Create(Buffer: PSfmlSoundBuffer); overload;
    destructor Destroy; override;

    function Copy: TSfmlSound;

    function GetBuffer: PSfmlSoundBuffer;
    procedure SetBuffer(const Buffer: PSfmlSoundBuffer); overload;
    procedure SetBuffer(const Buffer: TSfmlSoundBuffer); overload;

    procedure Pause;
    procedure Play;
    procedure Stop;

    property Handle: PSfmlSound read FHandle;
    property Looping: Boolean read GetLoop write SetLoop;
    property PlayingOffset: TSfmlTime read GetPlayingOffset write SetPlayingOffset;
  end;

  TSfmlSoundBufferRecorder = class
  private
    FHandle: PSfmlSoundBufferRecorder;
    function GetSampleRate: Cardinal;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Start(SampleRate: Cardinal);
    procedure Stop;

    function GetBuffer: PSfmlSoundBuffer;

    property Handle: PSfmlSoundBufferRecorder read FHandle;
    property SampleRate: Cardinal read GetSampleRate;
  end;

  TSfmlSoundRecorder = class
  private
    FHandle: PSfmlSoundRecorder;
    function GetDevice: AnsiString;
    function GetSampleRate: Cardinal;
    procedure SetDevice(const Name: AnsiString);
  public
    constructor Create(OnStart: TSfmlSoundRecorderStartCallback;
      OnProcess: TSfmlSoundRecorderProcessCallback;
      OnStop: TSfmlSoundRecorderStopCallback; UserData: Pointer);
    destructor Destroy; override;

    function Start(SampleRate: Cardinal): Boolean;
    procedure Stop;

    property Handle: PSfmlSoundRecorder read FHandle;
    property Device: AnsiString read GetDevice write SetDevice;
    property SampleRate: Cardinal read GetSampleRate;
  end;

{$IFDEF INT64RETURNWORKAROUND}
  // Workarounds for the Delphi compiler
  function SfmlMusicGetDuration(const Music: PSfmlMusic): TSfmlTime; cdecl;
  function SfmlMusicGetPlayingOffset(const Music: PSfmlMusic): TSfmlTime; cdecl;
  function SfmlSoundStreamGetPlayingOffset(const SoundStream: PSfmlSoundStream): TSfmlTime; cdecl;
  function SfmlSoundGetPlayingOffset(const Sound: PSfmlSound): TSfmlTime; cdecl;
  function SfmlSoundBufferGetDuration(const SoundBuffer: PSfmlSoundBuffer): TSfmlTime; cdecl;
{$ENDIF}

implementation

{$IFDEF DynLink}
uses
{$IFDEF FPC}
  DynLibs;
{$ELSE}
{$IFDEF MSWindows}
  Windows;
{$ENDIF}
{$ENDIF}
{$ENDIF}

{ TSfmlMusic }

constructor TSfmlMusic.Create(const Data: Pointer; SizeInBytes: NativeUInt);
begin
  FHandle := SfmlMusicCreateFromMemory(Data, SizeInBytes);
end;

constructor TSfmlMusic.Create(const FileName: AnsiString);
begin
  FHandle := SfmlMusicCreateFromFile(PAnsiChar(FileName));
end;

constructor TSfmlMusic.Create(Stream: PSfmlInputStream);
begin
  FHandle := SfmlMusicCreateFromStream(Stream);
end;

destructor TSfmlMusic.Destroy;
begin
  SfmlMusicDestroy(FHandle);

  inherited;
end;

function TSfmlMusic.GetAttenuation: Single;
begin
  Result := SfmlMusicGetAttenuation(FHandle);
end;

function TSfmlMusic.GetChannelCount: Cardinal;
begin
  Result := SfmlMusicGetChannelCount(FHandle);
end;

function TSfmlMusic.GetDuration: TSfmlTime;
begin
  Result := SfmlMusicGetDuration(FHandle);
end;

function TSfmlMusic.GetLoop: Boolean;
begin
  Result := SfmlMusicIsLooping(FHandle);
end;

function TSfmlMusic.GetMinDistance: Single;
begin
  Result := SfmlMusicGetMinDistance(FHandle);
end;

function TSfmlMusic.GetPitch: Single;
begin
  Result := SfmlMusicGetPitch(FHandle);
end;

function TSfmlMusic.GetPlayingOffset: TSfmlTime;
begin
  Result := SfmlMusicGetPlayingOffset(FHandle);
end;

function TSfmlMusic.GetPosition: TSfmlVector3f;
begin
  Result := SfmlMusicGetPosition(FHandle);
end;

function TSfmlMusic.GetSampleRate: Cardinal;
begin
  Result := SfmlMusicGetSampleRate(FHandle);
end;

function TSfmlMusic.GetStatus: TSfmlSoundStatus;
begin
  Result := SfmlMusicGetStatus(FHandle);
end;

function TSfmlMusic.GetVolume: Single;
begin
  Result := SfmlMusicGetVolume(FHandle);
end;

function TSfmlMusic.GetRelativeToListener: Boolean;
begin
  Result := SfmlMusicIsRelativeToListener(FHandle);
end;

procedure TSfmlMusic.Pause;
begin
  SfmlMusicPause(FHandle);
end;

procedure TSfmlMusic.Play;
begin
  SfmlMusicPlay(FHandle);
end;

procedure TSfmlMusic.SetAttenuation(Attenuation: Single);
begin
  SfmlMusicSetAttenuation(FHandle, Attenuation);
end;

procedure TSfmlMusic.SetLoop(Loop: Boolean);
begin
  SfmlMusicSetLooping(FHandle, Loop);
end;

procedure TSfmlMusic.SetMinDistance(Distance: Single);
begin
  SfmlMusicSetMinDistance(FHandle, Distance);
end;

procedure TSfmlMusic.SetPitch(Pitch: Single);
begin
  SfmlMusicSetPitch(FHandle, Pitch);
end;

procedure TSfmlMusic.SetPlayingOffset(TimeOffset: TSfmlTime);
begin
  SfmlMusicSetPlayingOffset(FHandle, TimeOffset);
end;

procedure TSfmlMusic.SetPosition(Position: TSfmlVector3f);
begin
  SfmlMusicSetPosition(FHandle, Position);
end;

procedure TSfmlMusic.SetRelativeToListener(Relative: Boolean);
begin
  SfmlMusicSetRelativeToListener(FHandle, Relative);
end;

procedure TSfmlMusic.SetVolume(Volume: Single);
begin
  SfmlMusicSetVolume(FHandle, Volume);
end;

procedure TSfmlMusic.Stop;
begin
  SfmlMusicStop(FHandle);
end;


{ TSfmlSoundStream }

constructor TSfmlSoundStream.Create(OnGetData: TSfmlSoundStreamGetDataCallback;
  OnSeek: TSfmlSoundStreamSeekCallback; ChannelCount, SampleRate: Cardinal;
  ChannelMapData: PSfmlSoundChannel; ChannelMapSize: NativeUInt;
  UserData: Pointer);
begin
  FHandle := SfmlSoundStreamCreate(OnGetData, OnSeek, ChannelCount, SampleRate,
    ChannelMapData, ChannelMapSize, UserData);
end;

destructor TSfmlSoundStream.Destroy;
begin
  SfmlSoundStreamDestroy(FHandle);
  inherited;
end;

function TSfmlSoundStream.GetAttenuation: Single;
begin
  Result := SfmlSoundStreamGetAttenuation(FHandle);
end;

function TSfmlSoundStream.GetChannelCount: Cardinal;
begin
  Result := SfmlSoundStreamGetChannelCount(FHandle);
end;

function TSfmlSoundStream.GetLoop: Boolean;
begin
  Result := SfmlSoundStreamIsLooping(FHandle);
end;

function TSfmlSoundStream.GetMinDistance: Single;
begin
  Result := SfmlSoundStreamGetMinDistance(FHandle);
end;

function TSfmlSoundStream.GetPitch: Single;
begin
  Result := SfmlSoundStreamGetPitch(FHandle);
end;

function TSfmlSoundStream.GetPlayingOffset: TSfmlTime;
begin
  Result := SfmlSoundStreamGetPlayingOffset(FHandle);
end;

function TSfmlSoundStream.GetPosition: TSfmlVector3f;
begin
  Result := SfmlSoundStreamGetPosition(FHandle);
end;

function TSfmlSoundStream.GetSampleRate: Cardinal;
begin
  Result := SfmlSoundStreamGetSampleRate(FHandle);
end;

function TSfmlSoundStream.GetStatus: TSfmlSoundStatus;
begin
  Result := SfmlSoundStreamGetStatus(FHandle);
end;

function TSfmlSoundStream.GetVolume: Single;
begin
  Result := SfmlSoundStreamGetVolume(FHandle);
end;

function TSfmlSoundStream.GetRelativeToListener: Boolean;
begin
  Result := SfmlSoundStreamIsRelativeToListener(FHandle);
end;

procedure TSfmlSoundStream.Pause;
begin
  SfmlSoundStreamPause(FHandle);
end;

procedure TSfmlSoundStream.Play;
begin
  SfmlSoundStreamPlay(FHandle);
end;

procedure TSfmlSoundStream.SetAttenuation(Attenuation: Single);
begin
  SfmlSoundStreamSetAttenuation(FHandle, Attenuation);
end;

procedure TSfmlSoundStream.SetLoop(Loop: Boolean);
begin
  SfmlSoundStreamSetLooping(FHandle, Loop);
end;

procedure TSfmlSoundStream.SetMinDistance(Distance: Single);
begin
  SfmlSoundStreamSetMinDistance(FHandle, Distance);
end;

procedure TSfmlSoundStream.SetPitch(Pitch: Single);
begin
  SfmlSoundStreamSetPitch(FHandle, Pitch);
end;

procedure TSfmlSoundStream.SetPlayingOffset(TimeOffset: TSfmlTime);
begin
  SfmlSoundStreamSetPlayingOffset(FHandle, TimeOffset);
end;

procedure TSfmlSoundStream.SetPosition(Position: TSfmlVector3f);
begin
  SfmlSoundStreamSetPosition(FHandle, Position);
end;

procedure TSfmlSoundStream.SetRelativeToListener(Relative: Boolean);
begin
  SfmlSoundStreamSetRelativeToListener(FHandle, Relative);
end;

procedure TSfmlSoundStream.SetVolume(Volume: Single);
begin
  SfmlSoundStreamSetVolume(FHandle, Volume);
end;

procedure TSfmlSoundStream.Stop;
begin
  SfmlSoundStreamStop(FHandle);
end;


{ TSfmlSoundBuffer }

constructor TSfmlSoundBuffer.Create(Handle: PSfmlSoundBuffer);
begin
  FHandle := Handle;
end;

constructor TSfmlSoundBuffer.Create(const FileName: AnsiString);
begin
  FHandle := SfmlSoundBufferCreateFromFile(PAnsiChar(FileName));
end;

constructor TSfmlSoundBuffer.Create(const Data: Pointer;
  SizeInBytes: NativeUInt);
begin
  FHandle := SfmlSoundBufferCreateFromMemory(Data, SizeInBytes);
end;

constructor TSfmlSoundBuffer.Create(const Samples: PSmallInt;
  SampleCount: NativeUInt; ChannelCount, SampleRate: Cardinal);
begin
  FHandle := SfmlSoundBufferCreateFromSamples(Samples, SampleCount,
    ChannelCount, SampleRate);
end;

constructor TSfmlSoundBuffer.Create(Stream: PSfmlInputStream);
begin
  FHandle := SfmlSoundBufferCreateFromStream(Stream);
end;

destructor TSfmlSoundBuffer.Destroy;
begin
  SfmlSoundBufferDestroy(FHandle);
  inherited;
end;

function TSfmlSoundBuffer.Copy: TSfmlSoundBuffer;
begin
  Result := TSfmlSoundBuffer.Create(SfmlSoundBufferCopy(FHandle));
end;

function TSfmlSoundBuffer.GetChannelCount: Cardinal;
begin
  Result := SfmlSoundBufferGetChannelCount(FHandle);
end;

function TSfmlSoundBuffer.GetDuration: TSfmlTime;
begin
  Result := SfmlSoundBufferGetDuration(FHandle);
end;

function TSfmlSoundBuffer.GetSampleCount: NativeUInt;
begin
  Result := SfmlSoundBufferGetSampleCount(FHandle);
end;

function TSfmlSoundBuffer.GetSampleRate: Cardinal;
begin
  Result := SfmlSoundBufferGetSampleRate(FHandle);
end;

function TSfmlSoundBuffer.GetSamples: PSmallInt;
begin
  Result := SfmlSoundBufferGetSamples(FHandle);
end;

function TSfmlSoundBuffer.SaveToFile(const FileName: AnsiString): Boolean;
begin
  Result := SfmlSoundBufferSaveToFile(FHandle, PAnsiChar(FileName));
end;


{ TSfmlSound }

constructor TSfmlSound.Create(Buffer: TSfmlSoundBuffer);
begin
  FHandle := SfmlSoundCreate(Buffer.Handle);
end;

constructor TSfmlSound.Create(Buffer: PSfmlSoundBuffer);
begin
  FHandle := SfmlSoundCreate(Buffer);
end;

constructor TSfmlSound.Create(Handle: PSfmlSound);
begin
  FHandle := Handle;
end;

destructor TSfmlSound.Destroy;
begin
  SfmlSoundDestroy(FHandle);
  inherited;
end;

function TSfmlSound.Copy: TSfmlSound;
begin
  Result := TSfmlSound.Create(SfmlSoundCopy(FHandle))
end;

function TSfmlSound.GetAttenuation: Single;
begin
  Result := SfmlSoundGetAttenuation(FHandle);
end;

function TSfmlSound.GetBuffer: PSfmlSoundBuffer;
begin
  Result := SfmlSoundGetBuffer(FHandle);
end;

function TSfmlSound.GetLoop: Boolean;
begin
  Result := SfmlSoundIsLooping(FHandle);
end;

function TSfmlSound.GetMinDistance: Single;
begin
  Result := SfmlSoundGetMinDistance(FHandle);
end;

function TSfmlSound.GetPitch: Single;
begin
  Result := SfmlSoundGetPitch(FHandle);
end;

function TSfmlSound.GetPlayingOffset: TSfmlTime;
begin
  Result := SfmlSoundGetPlayingOffset(FHandle);
end;

function TSfmlSound.GetPosition: TSfmlVector3f;
begin
  Result := SfmlSoundGetPosition(FHandle);
end;

function TSfmlSound.GetStatus: TSfmlSoundStatus;
begin
  Result := SfmlSoundGetStatus(FHandle);
end;

function TSfmlSound.GetVolume: Single;
begin
  Result := SfmlSoundGetVolume(FHandle);
end;

function TSfmlSound.GetRelativeToListener: Boolean;
begin
  Result := SfmlSoundIsRelativeToListener(FHandle);
end;

procedure TSfmlSound.Pause;
begin
  SfmlSoundPause(FHandle);
end;

procedure TSfmlSound.Play;
begin
  SfmlSoundPlay(FHandle);
end;

procedure TSfmlSound.SetAttenuation(Attenuation: Single);
begin
  SfmlSoundSetAttenuation(FHandle, Attenuation);
end;

procedure TSfmlSound.SetBuffer(const Buffer: PSfmlSoundBuffer);
begin
  SfmlSoundSetBuffer(FHandle, Buffer);
end;

procedure TSfmlSound.SetBuffer(const Buffer: TSfmlSoundBuffer);
begin
  SfmlSoundSetBuffer(FHandle, Buffer.Handle);
end;

procedure TSfmlSound.SetLoop(Loop: Boolean);
begin
  SfmlSoundSetLooping(FHandle, Loop);
end;

procedure TSfmlSound.SetMinDistance(Distance: Single);
begin
  SfmlSoundSetMinDistance(FHandle, Distance);
end;

procedure TSfmlSound.SetPitch(Pitch: Single);
begin
  SfmlSoundSetPitch(FHandle, Pitch);
end;

procedure TSfmlSound.SetPlayingOffset(TimeOffset: TSfmlTime);
begin
  SfmlSoundSetPlayingOffset(FHandle, TimeOffset);
end;

procedure TSfmlSound.SetPosition(Position: TSfmlVector3f);
begin
  SfmlSoundSetPosition(FHandle, Position);
end;

procedure TSfmlSound.SetRelativeToListener(Relative: Boolean);
begin
  SfmlSoundSetRelativeToListener(FHandle, Relative);
end;

procedure TSfmlSound.SetVolume(Volume: Single);
begin
  SfmlSoundSetVolume(FHandle, Volume);
end;

procedure TSfmlSound.Stop;
begin
  SfmlSoundStop(FHandle);
end;


{ TSfmlSoundBufferRecorder }

constructor TSfmlSoundBufferRecorder.Create;
begin
  FHandle := SfmlSoundBufferRecorderCreate;
end;

destructor TSfmlSoundBufferRecorder.Destroy;
begin
  SfmlSoundBufferRecorderDestroy(FHandle);
  inherited;
end;

function TSfmlSoundBufferRecorder.GetBuffer: PSfmlSoundBuffer;
begin
  Result := SfmlSoundBufferRecorderGetBuffer(FHandle);
end;

function TSfmlSoundBufferRecorder.GetSampleRate: Cardinal;
begin
  Result := SfmlSoundBufferRecorderGetSampleRate(FHandle);
end;

procedure TSfmlSoundBufferRecorder.Start(SampleRate: Cardinal);
begin
  SfmlSoundBufferRecorderStart(FHandle, SampleRate);
end;

procedure TSfmlSoundBufferRecorder.Stop;
begin
  SfmlSoundBufferRecorderStop(FHandle);
end;


{ TSfmlSoundRecorder }

constructor TSfmlSoundRecorder.Create(OnStart: TSfmlSoundRecorderStartCallback;
  OnProcess: TSfmlSoundRecorderProcessCallback;
  OnStop: TSfmlSoundRecorderStopCallback; UserData: Pointer);
begin
  FHandle := SfmlSoundRecorderCreate(OnStart, OnProcess, OnStop, UserData);
end;

destructor TSfmlSoundRecorder.Destroy;
begin
  SfmlSoundRecorderDestroy(FHandle);
  inherited;
end;

function TSfmlSoundRecorder.GetDevice: AnsiString;
begin
  Result := SfmlSoundRecorderGetDevice(FHandle);
end;

function TSfmlSoundRecorder.GetSampleRate: Cardinal;
begin
  Result := SfmlSoundRecorderGetSampleRate(FHandle);
end;

procedure TSfmlSoundRecorder.SetDevice(const Name: AnsiString);
begin
  Assert(SfmlSoundRecorderSetDevice(FHandle, PAnsiChar(Name)));
end;

function TSfmlSoundRecorder.Start(SampleRate: Cardinal): Boolean;
begin
  Result := SfmlSoundRecorderStart(FHandle, SampleRate);
end;

procedure TSfmlSoundRecorder.Stop;
begin
  SfmlSoundRecorderStop(FHandle);
end;

{$IFDEF DynLink}
var
  CSfmlAudioHandle: {$IFDEF FPC}TLibHandle{$ELSE}HINST{$ENDIF};
{$IFDEF INT64RETURNWORKAROUND}
  sfMusic_getDuration: function (const Music: PSfmlMusic): Int64; cdecl;
  sfMusic_getPlayingOffset: function (const Music: PSfmlMusic): Int64; cdecl;
  sfSoundStream_getPlayingOffset: function (const SoundStream: PSfmlSoundStream): Int64; cdecl;
  sfSound_getPlayingOffset: function (const Sound: PSfmlSound): Int64; cdecl;
  sfSoundBuffer_getDuration: function (const SoundBuffer: PSfmlSoundBuffer): Int64; cdecl;
{$ENDIF}

procedure InitDLL;

  function BindFunction(Name: AnsiString): Pointer;
  begin
    Result := GetProcAddress(CSfmlAudioHandle, PAnsiChar(Name));
    Assert(Assigned(Result));
  end;

begin
  // dynamically load external library
  {$IFDEF FPC}
  CSfmlAudioHandle := LoadLibrary(CSfmlAudioLibrary);
  {$ELSE}
  CSfmlAudioHandle := LoadLibraryA(CSfmlAudioLibrary);
  {$ENDIF}

  if CSfmlAudioHandle <> 0 then
    try
      SfmlListenerSetGlobalVolume := BindFunction('sfListener_setGlobalVolume');
      SfmlListenerGetGlobalVolume := BindFunction('sfListener_getGlobalVolume');
      SfmlListenerSetPosition := BindFunction('sfListener_setPosition');
      SfmlListenerGetPosition := BindFunction('sfListener_getPosition');
      SfmlListenerSetDirection := BindFunction('sfListener_setDirection');
      SfmlListenerGetDirection := BindFunction('sfListener_getDirection');
      SfmlListenerSetUpVector := BindFunction('sfListener_setUpVector');
      SfmlListenerGetUpVector := BindFunction('sfListener_getUpVector');
      SfmlListenerSetVelocity := BindFunction('sfListener_setVelocity');
      SfmlListenerGetVelocity := BindFunction('sfListener_getVelocity');
      SfmlListenerSetCone := BindFunction('sfListener_setCone');
      SfmlListenerGetCone := BindFunction('sfListener_getCone');
      SfmlMusicCreateFromFile := BindFunction('sfMusic_createFromFile');
      SfmlMusicCreateFromMemory := BindFunction('sfMusic_createFromMemory');
      SfmlMusicCreateFromStream := BindFunction('sfMusic_createFromStream');
      SfmlMusicDestroy := BindFunction('sfMusic_destroy');
      SfmlMusicSetLooping := BindFunction('sfMusic_setLooping');
      SfmlMusicIsLooping := BindFunction('sfMusic_isLooping');
      SfmlMusicPlay := BindFunction('sfMusic_play');
      SfmlMusicPause := BindFunction('sfMusic_pause');
      SfmlMusicStop := BindFunction('sfMusic_stop');
      SfmlMusicGetChannelCount := BindFunction('sfMusic_getChannelCount');
      SfmlMusicGetSampleRate := BindFunction('sfMusic_getSampleRate');
      SfmlMusicGetStatus := BindFunction('sfMusic_getStatus');
      SfmlMusicSetPitch := BindFunction('sfMusic_setPitch');
      SfmlMusicSetVolume := BindFunction('sfMusic_setVolume');
      SfmlMusicSetPosition := BindFunction('sfMusic_setPosition');
      SfmlMusicSetRelativeToListener := BindFunction('sfMusic_setRelativeToListener');
      SfmlMusicSetMinDistance := BindFunction('sfMusic_setMinDistance');
      SfmlMusicSetAttenuation := BindFunction('sfMusic_setAttenuation');
      SfmlMusicSetPlayingOffset := BindFunction('sfMusic_setPlayingOffset');
      SfmlMusicGetPitch := BindFunction('sfMusic_getPitch');
      SfmlMusicGetVolume := BindFunction('sfMusic_getVolume');
      SfmlMusicGetPosition := BindFunction('sfMusic_getPosition');
      SfmlMusicIsRelativeToListener := BindFunction('sfMusic_isRelativeToListener');
      SfmlMusicGetMinDistance := BindFunction('sfMusic_getMinDistance');
      SfmlMusicGetAttenuation := BindFunction('sfMusic_getAttenuation');
      SfmlMusicSetPan := BindFunction('sfMusic_setPan');
      SfmlMusicGetPan := BindFunction('sfMusic_getPan');
      SfmlMusicSetSpatializationEnabled := BindFunction('sfMusic_setSpatializationEnabled');
      SfmlMusicIsSpatializationEnabled := BindFunction('sfMusic_isSpatializationEnabled');
      SfmlMusicSetDirection := BindFunction('sfMusic_setDirection');
      SfmlMusicGetDirection := BindFunction('sfMusic_getDirection');
      SfmlMusicSetCone := BindFunction('sfMusic_setCone');
      SfmlMusicGetCone := BindFunction('sfMusic_getCone');
      SfmlMusicSetVelocity := BindFunction('sfMusic_setVelocity');
      SfmlMusicGetVelocity := BindFunction('sfMusic_getVelocity');
      SfmlMusicSetDopplerFactor := BindFunction('sfMusic_setDopplerFactor');
      SfmlMusicGetDopplerFactor := BindFunction('sfMusic_getDopplerFactor');
      SfmlMusicSetDirectionalAttenuationFactor := BindFunction('sfMusic_setDirectionalAttenuationFactor');
      SfmlMusicGetDirectionalAttenuationFactor := BindFunction('sfMusic_getDirectionalAttenuationFactor');
      SfmlMusicSetMaxDistance := BindFunction('sfMusic_setMaxDistance');
      SfmlMusicGetMaxDistance := BindFunction('sfMusic_getMaxDistance');
      SfmlMusicSetMinGain := BindFunction('sfMusic_setMinGain');
      SfmlMusicGetMinGain := BindFunction('sfMusic_getMinGain');
      SfmlMusicSetMaxGain := BindFunction('sfMusic_setMaxGain');
      SfmlMusicGetMaxGain := BindFunction('sfMusic_getMaxGain');
      SfmlMusicSetEffectProcessor := BindFunction('sfMusic_setEffectProcessor');
      SfmlMusicGetChannelMap := BindFunction('sfMusic_getChannelMap');
      SfmlMusicGetLoopPoints := BindFunction('sfMusic_getLoopPoints');
      SfmlMusicSetLoopPoints := BindFunction('sfMusic_setLoopPoints');
      SfmlSoundStreamCreate := BindFunction('sfSoundStream_create');
      SfmlSoundStreamDestroy := BindFunction('sfSoundStream_destroy');
      SfmlSoundStreamPlay := BindFunction('sfSoundStream_play');
      SfmlSoundStreamPause := BindFunction('sfSoundStream_pause');
      SfmlSoundStreamStop := BindFunction('sfSoundStream_stop');
      SfmlSoundStreamGetStatus := BindFunction('sfSoundStream_getStatus');
      SfmlSoundStreamGetChannelCount := BindFunction('sfSoundStream_getChannelCount');
      SfmlSoundStreamGetSampleRate := BindFunction('sfSoundStream_getSampleRate');
      SfmlSoundStreamSetPitch := BindFunction('sfSoundStream_setPitch');
      SfmlSoundStreamSetVolume := BindFunction('sfSoundStream_setVolume');
      SfmlSoundStreamSetPosition := BindFunction('sfSoundStream_setPosition');
      SfmlSoundStreamSetRelativeToListener := BindFunction('sfSoundStream_setRelativeToListener');
      SfmlSoundStreamSetMinDistance := BindFunction('sfSoundStream_setMinDistance');
      SfmlSoundStreamSetAttenuation := BindFunction('sfSoundStream_setAttenuation');
      SfmlSoundStreamSetPlayingOffset := BindFunction('sfSoundStream_setPlayingOffset');
      SfmlSoundStreamSetLooping := BindFunction('sfSoundStream_setLooping');
      SfmlSoundStreamGetPitch := BindFunction('sfSoundStream_getPitch');
      SfmlSoundStreamGetVolume := BindFunction('sfSoundStream_getVolume');
      SfmlSoundStreamGetPosition := BindFunction('sfSoundStream_getPosition');
      SfmlSoundStreamIsRelativeToListener := BindFunction('sfSoundStream_isRelativeToListener');
      SfmlSoundStreamGetMinDistance := BindFunction('sfSoundStream_getMinDistance');
      SfmlSoundStreamGetAttenuation := BindFunction('sfSoundStream_getAttenuation');
      SfmlSoundStreamIsLooping := BindFunction('sfSoundStream_isLooping');
      SfmlSoundStreamGetChannelMap := BindFunction('sfSoundStream_getChannelMap');
      SfmlSoundStreamSetPan := BindFunction('sfSoundStream_setPan');
      SfmlSoundStreamGetPan := BindFunction('sfSoundStream_getPan');
      SfmlSoundStreamSetSpatializationEnabled := BindFunction('sfSoundStream_setSpatializationEnabled');
      SfmlSoundStreamIsSpatializationEnabled := BindFunction('sfSoundStream_isSpatializationEnabled');
      SfmlSoundStreamSetDirection := BindFunction('sfSoundStream_setDirection');
      SfmlSoundStreamGetDirection := BindFunction('sfSoundStream_getDirection');
      SfmlSoundStreamSetCone := BindFunction('sfSoundStream_setCone');
      SfmlSoundStreamGetCone := BindFunction('sfSoundStream_getCone');
      SfmlSoundStreamSetVelocity := BindFunction('sfSoundStream_setVelocity');
      SfmlSoundStreamGetVelocity := BindFunction('sfSoundStream_getVelocity');
      SfmlSoundStreamSetDopplerFactor := BindFunction('sfSoundStream_setDopplerFactor');
      SfmlSoundStreamGetDopplerFactor := BindFunction('sfSoundStream_getDopplerFactor');
      SfmlSoundStreamSetDirectionalAttenuationFactor := BindFunction('sfSoundStream_setDirectionalAttenuationFactor');
      SfmlSoundStreamGetDirectionalAttenuationFactor := BindFunction('sfSoundStream_getDirectionalAttenuationFactor');
      SfmlSoundStreamSetMaxDistance := BindFunction('sfSoundStream_setMaxDistance');
      SfmlSoundStreamGetMaxDistance := BindFunction('sfSoundStream_getMaxDistance');
      SfmlSoundStreamSetMinGain := BindFunction('sfSoundStream_setMinGain');
      SfmlSoundStreamGetMinGain := BindFunction('sfSoundStream_getMinGain');
      SfmlSoundStreamSetMaxGain := BindFunction('sfSoundStream_setMaxGain');
      SfmlSoundStreamGetMaxGain := BindFunction('sfSoundStream_getMaxGain');
      SfmlSoundStreamSetEffectProcessor := BindFunction('sfSoundStream_setEffectProcessor');
      SfmlSoundCreate := BindFunction('sfSound_create');
      SfmlSoundCopy := BindFunction('sfSound_copy');
      SfmlSoundDestroy := BindFunction('sfSound_destroy');
      SfmlSoundPlay := BindFunction('sfSound_play');
      SfmlSoundPause := BindFunction('sfSound_pause');
      SfmlSoundStop := BindFunction('sfSound_stop');
      SfmlSoundSetBuffer := BindFunction('sfSound_setBuffer');
      SfmlSoundGetBuffer := BindFunction('sfSound_getBuffer');
      SfmlSoundSetLooping := BindFunction('sfSound_setLooping');
      SfmlSoundIsLooping := BindFunction('sfSound_isLooping');
      SfmlSoundGetStatus := BindFunction('sfSound_getStatus');
      SfmlSoundSetPitch := BindFunction('sfSound_setPitch');
      SfmlSoundSetVolume := BindFunction('sfSound_setVolume');
      SfmlSoundSetPosition := BindFunction('sfSound_setPosition');
      SfmlSoundSetRelativeToListener := BindFunction('sfSound_setRelativeToListener');
      SfmlSoundSetMinDistance := BindFunction('sfSound_setMinDistance');
      SfmlSoundSetAttenuation := BindFunction('sfSound_setAttenuation');
      SfmlSoundSetPlayingOffset := BindFunction('sfSound_setPlayingOffset');
      SfmlSoundGetPitch := BindFunction('sfSound_getPitch');
      SfmlSoundGetVolume := BindFunction('sfSound_getVolume');
      SfmlSoundGetPosition := BindFunction('sfSound_getPosition');
      SfmlSoundIsRelativeToListener := BindFunction('sfSound_isRelativeToListener');
      SfmlSoundGetMinDistance := BindFunction('sfSound_getMinDistance');
      SfmlSoundGetAttenuation := BindFunction('sfSound_getAttenuation');
      SfmlSoundSetPan := BindFunction('sfSound_setPan');
      SfmlSoundGetPan := BindFunction('sfSound_getPan');
      SfmlSoundSetSpatializationEnabled := BindFunction('sfSound_setSpatializationEnabled');
      SfmlSoundIsSpatializationEnabled := BindFunction('sfSound_isSpatializationEnabled');
      SfmlSoundSetDirection := BindFunction('sfSound_setDirection');
      SfmlSoundGetDirection := BindFunction('sfSound_getDirection');
      SfmlSoundSetCone := BindFunction('sfSound_setCone');
      SfmlSoundGetCone := BindFunction('sfSound_getCone');
      SfmlSoundSetVelocity := BindFunction('sfSound_setVelocity');
      SfmlSoundGetVelocity := BindFunction('sfSound_getVelocity');
      SfmlSoundSetDopplerFactor := BindFunction('sfSound_setDopplerFactor');
      SfmlSoundGetDopplerFactor := BindFunction('sfSound_getDopplerFactor');
      SfmlSoundSetDirectionalAttenuationFactor := BindFunction('sfSound_setDirectionalAttenuationFactor');
      SfmlSoundGetDirectionalAttenuationFactor := BindFunction('sfSound_getDirectionalAttenuationFactor');
      SfmlSoundSetMaxDistance := BindFunction('sfSound_setMaxDistance');
      SfmlSoundGetMaxDistance := BindFunction('sfSound_getMaxDistance');
      SfmlSoundSetMinGain := BindFunction('sfSound_setMinGain');
      SfmlSoundGetMinGain := BindFunction('sfSound_getMinGain');
      SfmlSoundSetMaxGain := BindFunction('sfSound_setMaxGain');
      SfmlSoundGetMaxGain := BindFunction('sfSound_getMaxGain');
      SfmlSoundSetEffectProcessor := BindFunction('sfSound_setEffectProcessor');
      SfmlSoundBufferCreateFromFile := BindFunction('sfSoundBuffer_createFromFile');
      SfmlSoundBufferCreateFromMemory := BindFunction('sfSoundBuffer_createFromMemory');
      SfmlSoundBufferCreateFromStream := BindFunction('sfSoundBuffer_createFromStream');
      SfmlSoundBufferCreateFromSamples := BindFunction('sfSoundBuffer_createFromSamples');
      SfmlSoundBufferCopy := BindFunction('sfSoundBuffer_copy');
      SfmlSoundBufferDestroy := BindFunction('sfSoundBuffer_destroy');
      SfmlSoundBufferSaveToFile := BindFunction('sfSoundBuffer_saveToFile');
      SfmlSoundBufferGetSamples := BindFunction('sfSoundBuffer_getSamples');
      SfmlSoundBufferGetSampleCount := BindFunction('sfSoundBuffer_getSampleCount');
      SfmlSoundBufferGetSampleRate := BindFunction('sfSoundBuffer_getSampleRate');
      SfmlSoundBufferGetChannelCount := BindFunction('sfSoundBuffer_getChannelCount');
      SfmlSoundBufferRecorderCreate := BindFunction('sfSoundBufferRecorder_create');
      SfmlSoundBufferRecorderDestroy := BindFunction('sfSoundBufferRecorder_destroy');
      SfmlSoundBufferRecorderStart := BindFunction('sfSoundBufferRecorder_start');
      SfmlSoundBufferRecorderStop := BindFunction('sfSoundBufferRecorder_stop');
      SfmlSoundBufferRecorderGetSampleRate := BindFunction('sfSoundBufferRecorder_getSampleRate');
      SfmlSoundBufferRecorderGetBuffer := BindFunction('sfSoundBufferRecorder_getBuffer');
      SfmlSoundBufferRecorderSetDevice := BindFunction('sfSoundBufferRecorder_setDevice');
      SfmlSoundBufferRecorderGetDevice := BindFunction('sfSoundBufferRecorder_getDevice');
      SfmlSoundRecorderCreate := BindFunction('sfSoundRecorder_create');
      SfmlSoundRecorderDestroy := BindFunction('sfSoundRecorder_destroy');
      SfmlSoundRecorderStart := BindFunction('sfSoundRecorder_start');
      SfmlSoundRecorderStop := BindFunction('sfSoundRecorder_stop');
      SfmlSoundRecorderGetSampleRate := BindFunction('sfSoundRecorder_getSampleRate');
      SfmlSoundRecorderIsAvailable := BindFunction('sfSoundRecorder_isAvailable');
      SfmlSoundRecorderGetAvailableDevices := BindFunction('sfSoundRecorder_getAvailableDevices');
      SfmlSoundRecorderGetDefaultDevice := BindFunction('sfSoundRecorder_getDefaultDevice');
      SfmlSoundRecorderSetDevice := BindFunction('sfSoundRecorder_setDevice');
      SfmlSoundRecorderGetDevice := BindFunction('sfSoundRecorder_getDevice');
      SfmlSoundRecorderSetChannelCount := BindFunction('sfSoundRecorder_setChannelCount');
      SfmlSoundRecorderGetChannelCount := BindFunction('sfSoundRecorder_getChannelCount');
      SfmlSoundRecorderGetChannelMap := BindFunction('sfSoundRecorder_getChannelMap');

{$IFDEF INT64RETURNWORKAROUND}
      sfMusic_getDuration := BindFunction('sfMusic_getDuration');
      sfMusic_getPlayingOffset := BindFunction('sfMusic_getPlayingOffset');
      sfSoundStream_getPlayingOffset := BindFunction('sfSoundStream_getPlayingOffset');
      sfSound_getPlayingOffset := BindFunction('sfSound_getPlayingOffset');
      sfSoundBuffer_getDuration := BindFunction('sfSoundBuffer_getDuration');
{$ELSE}
      SfmlMusicGetDuration := BindFunction('sfMusic_getDuration');
      SfmlMusicGetPlayingOffset := BindFunction('sfMusic_getPlayingOffset');
      SfmlSoundStreamGetPlayingOffset := BindFunction('sfSoundStream_getPlayingOffset');
      SfmlSoundGetPlayingOffset := BindFunction('sfSound_getPlayingOffset');
      SfmlSoundBufferGetDuration := BindFunction('sfSoundBuffer_getDuration');
{$ENDIF}
    except
      FreeLibrary(CSfmlAudioHandle);
      CSfmlAudioHandle := 0;
    end;
end;

procedure FreeDLL;
begin
  if CSfmlAudioHandle <> 0 then
    FreeLibrary(CSfmlAudioHandle);
end;
{$ELSE}
{$IFDEF INT64RETURNWORKAROUND}
function sfMusic_getDuration(const Music: PSfmlMusic): Int64; cdecl; external CSfmlAudioLibrary;
function sfMusic_getPlayingOffset(const Music: PSfmlMusic): Int64; cdecl; external CSfmlAudioLibrary;
function sfSoundStream_getPlayingOffset(const SoundStream: PSfmlSoundStream): Int64; cdecl; external CSfmlAudioLibrary;
function sfSound_getPlayingOffset(const Sound: PSfmlSound): Int64; cdecl; external CSfmlAudioLibrary;
function sfSoundBuffer_getDuration(const SoundBuffer: PSfmlSoundBuffer): Int64; cdecl; external CSfmlAudioLibrary;
{$ENDIF}
{$ENDIF}

{$IFDEF INT64RETURNWORKAROUND}
function SfmlMusicGetDuration(const Music: PSfmlMusic): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfMusic_getDuration(Music);
end;

function SfmlMusicGetPlayingOffset(const Music: PSfmlMusic): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfMusic_getPlayingOffset(Music);
end;

function SfmlSoundStreamGetPlayingOffset(const SoundStream: PSfmlSoundStream): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfSoundStream_getPlayingOffset(SoundStream);
end;

function SfmlSoundGetPlayingOffset(const Sound: PSfmlSound): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfSound_getPlayingOffset(Sound);
end;

function SfmlSoundBufferGetDuration(const SoundBuffer: PSfmlSoundBuffer): TSfmlTime; cdecl;
begin
  Result.MicroSeconds := sfSoundBuffer_getDuration(SoundBuffer);
end;
{$ENDIF}

{$IFDEF DynLink}
initialization

InitDLL;

finalization

FreeDLL;

{$ENDIF}
end.
