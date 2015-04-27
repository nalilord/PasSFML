unit SfmlGraphics;

////////////////////////////////////////////////////////////
//
// PasSFML - Simple and Fast Multimedia Library for Pascal
// Copyright (C) 2015 Christian-W. Budde (Christian@savioursofsoul.de)
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
////////////////////////////////////////////////////////////

interface

{$I Sfml.inc}

uses
  SfmlWindow, SfmlSystem;

const
{$IF Defined(MSWINDOWS)}
  CSfmlGraphicsLibrary = 'csfml-graphics-2.dll';
{$ELSEIF Defined(DARWIN)}
  CSfmlGraphicsLibrary = 'csfml-graphics-2.dylib';
{$ELSEIF Defined(UNIX)}
  CSfmlGraphicsLibrary = 'csfml-graphics-2.so';
{$IFEND}

type
  PSfmlCircleShape = Pointer;
  PSfmlConvexShape = Pointer;
  PSfmlFont = Pointer;
  PSfmlImage = Pointer;
  PSfmlShader = Pointer;
  PSfmlRectangleShape = Pointer;
  PSfmlRenderTexture = Pointer;
  PSfmlRenderWindow = Pointer;
  PSfmlShape = Pointer;
  PSfmlSprite = Pointer;
  PSfmlText = Pointer;
  PSfmlTexture = Pointer;
  PSfmlTransformable = Pointer;
  PSfmlVertexArray = Pointer;
  PSfmlView = Pointer;

  TSfmlBlendFactor = (sfBlendFactorZero, sfBlendFactorOne,
    sfBlendFactorSrcColor, sfBlendFactorOneMinusSrcColor,
    sfBlendFactorDstColor, sfBlendFactorOneMinusDstColor,
    sfBlendFactorSrcAlpha, sfBlendFactorOneMinusSrcAlpha,
    sfBlendFactorDstAlpha, sfBlendFactorOneMinusDstAlpha);

  TSfmlBlendEquation = (sfBlendEquationAdd, sfBlendEquationSubtract);

  TSfmlBlendMode = record
    colorSrcFactor: TSfmlBlendFactor;
    colorDstFactor: TSfmlBlendFactor;
    colorEquation: TSfmlBlendEquation;
    alphaSrcFactor: TSfmlBlendFactor;
    alphaDstFactor: TSfmlBlendFactor;
    alphaEquation: TSfmlBlendEquation;
  end;

  TSfmlColor = packed record
    r, g, b, a: Byte;
  end;

  TSfmlFontInfo = record
    Family: PAnsiChar;
  end;

  TSfmlFloatRect = record
    Left, Top, Width, Height: Single;
  end;

  TSfmlIntRect = record
    Left, Top, Width, Height: longint;
  end;
  PSfmlIntRect = ^TSfmlIntRect;

  TSfmlGlyph = record
    Advance: Single;
    Bounds: TSfmlFloatRect;
    TextureRect: TSfmlIntRect;
  end;

  TSfmlPrimitiveType = (sfPoints, sfLines, sfLinesStrip, sfTriangles,
    sfTrianglesStrip, sfTrianglesFan, sfQuads);

  TSfmlTransform = record
    Matrix : array [0 .. 8] of Single;
  end;
  PSfmlTransform = ^TSfmlTransform;

  TSfmlRenderStates = record
    BlendMode: TSfmlBlendMode;
    Transform: TSfmlTransform;
    Texture: PSfmlTexture;
    Shader: PSfmlShader;
  end;
  PSfmlRenderStates = ^TSfmlRenderStates;

  TSfmlShapeGetPointCountCallback = function (Para1: Pointer): Cardinal; cdecl;
  TSfmlShapeGetPointCallback = function (Para1: Cardinal; Para2: Pointer): TSfmlVector2f; cdecl;

  TSfmlTextStyle = (sfTextBold, sfTextItalic, sfTextUnderlined,
    sfTextStrikeThrough);
  TSfmlTextStyles = set of TSfmlTextStyle;

  TSfmlVertex = record
    Position: TSfmlVector2f;
    Color: TSfmlColor;
    TexCoords: TSfmlVector2f;
  end;
  PSfmlVertex = ^TSfmlVertex;

{$IFDEF DynLink}
  TSfmlBlendAlpha = function : TSfmlBlendMode; cdecl;
  TSfmlBlendAdd = function : TSfmlBlendMode; cdecl;
  TSfmlBlendMultiply = function : TSfmlBlendMode; cdecl;
  TSfmlBlendNone = function : TSfmlBlendMode; cdecl;

  TSfmlColorFromRGB = function (Red, Green, Blue: Byte): TSfmlColor; cdecl;
  TSfmlColorFromRGBA = function (Red, Green, Blue, Alpha: Byte): TSfmlColor; cdecl;
  TSfmlColorAdd = function (color1, color2: TSfmlColor): TSfmlColor; cdecl;
  TSfmlColorModulate = function (color1, color2: TSfmlColor): TSfmlColor; cdecl;

  TSfmlCircleShapeCreate = function : PSfmlCircleShape; cdecl;
  TSfmlCircleShapeCopy = function (const Shape: PSfmlCircleShape): PSfmlCircleShape; cdecl;
  TSfmlCircleShapeDestroy = procedure (Shape: PSfmlCircleShape); cdecl;
  TSfmlCircleShapeSetPosition = procedure (Shape: PSfmlCircleShape; Position: TSfmlVector2f); cdecl;
  TSfmlCircleShapeSetRotation = procedure (Shape: PSfmlCircleShape; Angle: Single); cdecl;
  TSfmlCircleShapeSetScale = procedure (Shape: PSfmlCircleShape; Scale: TSfmlVector2f); cdecl;
  TSfmlCircleShapeSetOrigin = procedure (Shape: PSfmlCircleShape; Origin: TSfmlVector2f); cdecl;
  TSfmlCircleShapeGetPosition = function (const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl;
  TSfmlCircleShapeGetRotation = function (const Shape: PSfmlCircleShape): Single; cdecl;
  TSfmlCircleShapeGetScale = function (const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl;
  TSfmlCircleShapeGetOrigin = function (const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl;
  TSfmlCircleShapeMove = procedure (Shape: PSfmlCircleShape; Offset: TSfmlVector2f); cdecl;
  TSfmlCircleShapeRotate = procedure (Shape: PSfmlCircleShape; Angle: Single); cdecl;
  TSfmlCircleShapeScale = procedure (Shape: PSfmlCircleShape; Factors: TSfmlVector2f); cdecl;
  TSfmlCircleShapeGetTransform = function (const Shape: PSfmlCircleShape): TSfmlTransform; cdecl;
  TSfmlCircleShapeGetInverseTransform = function (const Shape: PSfmlCircleShape): TSfmlTransform; cdecl;
  TSfmlCircleShapeSetTexture = procedure (Shape: PSfmlCircleShape; const Texture: PSfmlTexture; resetRect: sfBool); cdecl;
  TSfmlCircleShapeSetTextureRect = procedure (Shape: PSfmlCircleShape; Rect: TSfmlIntRect); cdecl;
  TSfmlCircleShapeSetFillColor = procedure (Shape: PSfmlCircleShape; Color: TSfmlColor); cdecl;
  TSfmlCircleShapeSetOutlineColor = procedure (Shape: PSfmlCircleShape; Color: TSfmlColor); cdecl;
  TSfmlCircleShapeSetOutlineThickness = procedure (Shape: PSfmlCircleShape; Thickness: Single); cdecl;
  TSfmlCircleShapeGetTexture = function (const Shape: PSfmlCircleShape): PSfmlTexture; cdecl;
  TSfmlCircleShapeGetTextureRect = function (const Shape: PSfmlCircleShape): TSfmlIntRect; cdecl;
  TSfmlCircleShapeGetFillColor = function (const Shape: PSfmlCircleShape): TSfmlColor; cdecl;
  TSfmlCircleShapeGetOutlineColor = function (const Shape: PSfmlCircleShape): TSfmlColor; cdecl;
  TSfmlCircleShapeGetOutlineThickness = function (const Shape: PSfmlCircleShape): Single; cdecl;
  TSfmlCircleShapeGetPointCount = function (const Shape: PSfmlCircleShape): Cardinal; cdecl;
  TSfmlCircleShapeGetPoint = function (const Shape: PSfmlCircleShape; Index: Cardinal): TSfmlVector2f; cdecl;
  TSfmlCircleShapeSetRadius = procedure (Shape: PSfmlCircleShape; Radius: Single); cdecl;
  TSfmlCircleShapeGetRadius = function (const Shape: PSfmlCircleShape): Single; cdecl;
  TSfmlCircleShapeSetPointCount = procedure (Shape: PSfmlCircleShape; Count: Cardinal); cdecl;
  TSfmlCircleShapeGetLocalBounds = function (const Shape: PSfmlCircleShape): TSfmlFloatRect; cdecl;
  TSfmlCircleShapeGetGlobalBounds = function (const Shape: PSfmlCircleShape): TSfmlFloatRect; cdecl;

  TSfmlConvexShapeCreate = function : PSfmlConvexShape; cdecl;
  TSfmlConvexShapeCopy = function (const Shape: PSfmlConvexShape): PSfmlConvexShape; cdecl;
  TSfmlConvexShapeDestroy = procedure (Shape: PSfmlConvexShape); cdecl;
  TSfmlConvexShapeSetPosition = procedure (Shape: PSfmlConvexShape; Position: TSfmlVector2f); cdecl;
  TSfmlConvexShapeSetRotation = procedure (Shape: PSfmlConvexShape; Angle: Single); cdecl;
  TSfmlConvexShapeSetScale = procedure (Shape: PSfmlConvexShape; Scale: TSfmlVector2f); cdecl;
  TSfmlConvexShapeSetOrigin = procedure (Shape: PSfmlConvexShape; Origin: TSfmlVector2f); cdecl;
  TSfmlConvexShapeGetPosition = function (const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl;
  TSfmlConvexShapeGetRotation = function (const Shape: PSfmlConvexShape): Single; cdecl;
  TSfmlConvexShapeGetScale = function (const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl;
  TSfmlConvexShapeGetOrigin = function (const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl;
  TSfmlConvexShapeMove = procedure (Shape: PSfmlConvexShape; Offset: TSfmlVector2f); cdecl;
  TSfmlConvexShapeRotate = procedure (Shape: PSfmlConvexShape; Angle: Single); cdecl;
  TSfmlConvexShapeScale = procedure (Shape: PSfmlConvexShape; Factors: TSfmlVector2f); cdecl;
  TSfmlConvexShapeGetTransform = function (const Shape: PSfmlConvexShape): TSfmlTransform; cdecl;
  TSfmlConvexShapeGetInverseTransform = function (const Shape: PSfmlConvexShape): TSfmlTransform; cdecl;
  TSfmlConvexShapeSetTexture = procedure (Shape: PSfmlConvexShape; const Texture: PSfmlTexture; ResetRect: sfBool); cdecl;
  TSfmlConvexShapeSetTextureRect = procedure (Shape: PSfmlConvexShape; Rect: TSfmlIntRect); cdecl;
  TSfmlConvexShapeSetFillColor = procedure (Shape: PSfmlConvexShape; Color: TSfmlColor); cdecl;
  TSfmlConvexShapeSetOutlineColor = procedure (Shape: PSfmlConvexShape; Color: TSfmlColor); cdecl;
  TSfmlConvexShapeSetOutlineThickness = procedure (Shape: PSfmlConvexShape; Thickness: Single); cdecl;
  TSfmlConvexShapeGetTexture = function (const Shape: PSfmlConvexShape): PSfmlTexture; cdecl;
  TSfmlConvexShapeGetTextureRect = function (const Shape: PSfmlConvexShape): TSfmlIntRect; cdecl;
  TSfmlConvexShapeGetFillColor = function (const Shape: PSfmlConvexShape): TSfmlColor; cdecl;
  TSfmlConvexShapeGetOutlineColor = function (const Shape: PSfmlConvexShape): TSfmlColor; cdecl;
  TSfmlConvexShapeGetOutlineThickness = function (const Shape: PSfmlConvexShape): Single; cdecl;
  TSfmlConvexShapeGetPointCount = function (const Shape: PSfmlConvexShape): Cardinal; cdecl;
  TSfmlConvexShapeGetPoint = function (const Shape: PSfmlConvexShape; Index: Cardinal): TSfmlVector2f; cdecl;
  TSfmlConvexShapeSetPointCount = procedure (Shape: PSfmlConvexShape; Count: Cardinal); cdecl;
  TSfmlConvexShapeSetPoint = procedure (Shape: PSfmlConvexShape; Index: Cardinal; Point: TSfmlVector2f); cdecl;
  TSfmlConvexShapeGetLocalBounds = function (const Shape: PSfmlConvexShape): TSfmlFloatRect; cdecl;
  TSfmlConvexShapeGetGlobalBounds = function (const Shape: PSfmlConvexShape): TSfmlFloatRect; cdecl;

  TSfmlFontCreateFromFile = function (const FileName: PAnsiChar): PSfmlFont; cdecl;
  TSfmlFontCreateFromMemory = function (const Data: Pointer; SizeInBytes: NativeUInt): PSfmlFont; cdecl;
  TSfmlFontCreateFromStream = function (const Stream: PSfmlInputStream): PSfmlFont; cdecl;
  TSfmlFontCopy = function (const Font: PSfmlFont): PSfmlFont; cdecl;
  TSfmlFontDestroy = procedure (Font: PSfmlFont); cdecl;
  TSfmlFontGetGlyph = function (Font: PSfmlFont; CodePoint: sfUint32; CharacterSize: Cardinal; Bold: sfBool): TSfmlGlyph; cdecl;
  TSfmlFontGetKerning = function (Font: PSfmlFont; First, second: sfUint32; CharacterSize: Cardinal): Single; cdecl;
  TSfmlFontGetLineSpacing = function (Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl;
  TSfmlFontGetUnderlinePosition = function (Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl;
  TSfmlFontGetUnderlineThickness = function (Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl;
  TSfmlFontGetTexture = function (Font: PSfmlFont; CharacterSize: Cardinal): PSfmlTexture; cdecl;
  TSfmlFontGetInfo = function (const Font: PSfmlFont): TSfmlFontInfo; cdecl;

  TSfmlImageCreate = function (Width, Height: Cardinal): PSfmlImage; cdecl;
  TSfmlImageCreateFromColor = function (Width, Height: Cardinal; Color: TSfmlColor): PSfmlImage; cdecl;
  TSfmlImageCreateFromPixels = function (Width, Height: Cardinal; const Pixels: PByte): PSfmlImage; cdecl;
  TSfmlImageCreateFromFile = function (const FileName: PAnsiChar): PSfmlImage; cdecl;
  TSfmlImageCreateFromMemory = function (const data: Pointer; Size: NativeUInt): PSfmlImage; cdecl;
  TSfmlImageCreateFromStream = function (const Stream: PSfmlInputStream): PSfmlImage; cdecl;
  TSfmlImageCopy = function (const Image: PSfmlImage): PSfmlImage; cdecl;
  TSfmlImageDestroy = procedure (Image: PSfmlImage); cdecl;
  TSfmlImageSaveToFile = function (const Image: PSfmlImage; const FileName: PAnsiChar): sfBool; cdecl;
  TSfmlImageGetSize = function (const Image: PSfmlImage): TSfmlVector2u; cdecl;
  TSfmlImageCreateMaskFromColor = procedure (Image: PSfmlImage; Color: TSfmlColor; Alpha: Byte); cdecl;
  TSfmlImageCopyImage = procedure (Image: PSfmlImage; const source: PSfmlImage; destX, destY: Cardinal; sourceRect: TSfmlIntRect; applyAlpha: sfBool); cdecl;
  TSfmlImageSetPixel = procedure (Image: PSfmlImage; X, Y: Cardinal; Color: TSfmlColor); cdecl;
  TSfmlImageGetPixel = function (const Image: PSfmlImage; X, Y: Cardinal): TSfmlColor; cdecl;
  TSfmlImageGetPixelsPtr = function (const Image: PSfmlImage): PByte; cdecl;
  TSfmlImageFlipHorizontally = procedure (Image: PSfmlImage); cdecl;
  TSfmlImageFlipVertically = procedure (Image: PSfmlImage); cdecl;

  TSfmlFloatRectContains = function (var Rect: TSfmlFloatRect; X, Y: Single): sfBool; cdecl;
  TSfmlIntRectContains = function (var Rect: TSfmlIntRect; X, Y: LongInt): sfBool; cdecl;
  TSfmlFloatRectIntersects = function (var rect1, rect2: TSfmlFloatRect; var Intersection: TSfmlFloatRect): sfBool; cdecl;
  TSfmlIntRectIntersects = function (var rect1, rect2: TSfmlIntRect; var Intersection: TSfmlFloatRect): sfBool; cdecl;

  TSfmlRectangleShapeCreate = function : PSfmlRectangleShape; cdecl;
  TSfmlRectangleShapeCopy = function (const Shape: PSfmlRectangleShape): PSfmlRectangleShape; cdecl;
  TSfmlRectangleShapeDestroy = procedure (Shape: PSfmlRectangleShape); cdecl;
  TSfmlRectangleShapeSetPosition = procedure (Shape: PSfmlRectangleShape; Position: TSfmlVector2f); cdecl;
  TSfmlRectangleShapeSetRotation = procedure (Shape: PSfmlRectangleShape; Angle: Single); cdecl;
  TSfmlRectangleShapeSetScale = procedure (Shape: PSfmlRectangleShape; Scale: TSfmlVector2f); cdecl;
  TSfmlRectangleShapeSetOrigin = procedure (Shape: PSfmlRectangleShape; Origin: TSfmlVector2f); cdecl;
  TSfmlRectangleShapeGetPosition = function (const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
  TSfmlRectangleShapeGetRotation = function (const Shape: PSfmlRectangleShape): Single; cdecl;
  TSfmlRectangleShapeGetScale = function (const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
  TSfmlRectangleShapeGetOrigin = function (const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
  TSfmlRectangleShapeMove = procedure (Shape: PSfmlRectangleShape; Offset: TSfmlVector2f); cdecl;
  TSfmlRectangleShapeRotate = procedure (Shape: PSfmlRectangleShape; Angle: Single); cdecl;
  TSfmlRectangleShapeScale = procedure (Shape: PSfmlRectangleShape; Factors: TSfmlVector2f); cdecl;
  TSfmlRectangleShapeGetTransform = function (const Shape: PSfmlRectangleShape): TSfmlTransform; cdecl;
  TSfmlRectangleShapeGetInverseTransform = function (const Shape: PSfmlRectangleShape): TSfmlTransform; cdecl;
  TSfmlRectangleShapeSetTexture = procedure (Shape: PSfmlRectangleShape; const Texture: PSfmlTexture; resetRect: sfBool); cdecl;
  TSfmlRectangleShapeSetTextureRect = procedure (Shape: PSfmlRectangleShape; rect: TSfmlIntRect); cdecl;
  TSfmlRectangleShapeSetFillColor = procedure (Shape: PSfmlRectangleShape; Color: TSfmlColor); cdecl;
  TSfmlRectangleShapeSetOutlineColor = procedure (Shape: PSfmlRectangleShape; Color: TSfmlColor); cdecl;
  TSfmlRectangleShapeSetOutlineThickness = procedure (Shape: PSfmlRectangleShape; Thickness: Single); cdecl;
  TSfmlRectangleShapeGetTexture = function (const Shape: PSfmlRectangleShape): PSfmlTexture; cdecl;
  TSfmlRectangleShapeGetTextureRect = function (const Shape: PSfmlRectangleShape): TSfmlIntRect; cdecl;
  TSfmlRectangleShapeGetFillColor = function (const Shape: PSfmlRectangleShape): TSfmlColor; cdecl;
  TSfmlRectangleShapeGetOutlineColor = function (const Shape: PSfmlRectangleShape): TSfmlColor; cdecl;
  TSfmlRectangleShapeGetOutlineThickness = function (const Shape: PSfmlRectangleShape): Single; cdecl;
  TSfmlRectangleShapeGetPointCount = function (const Shape: PSfmlRectangleShape): Cardinal; cdecl;
  TSfmlRectangleShapeGetPoint = function (const Shape: PSfmlRectangleShape; Index: Cardinal): TSfmlVector2f; cdecl;
  TSfmlRectangleShapeSetSize = procedure (Shape: PSfmlRectangleShape; Size: TSfmlVector2f); cdecl;
  TSfmlRectangleShapeGetSize = function (const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl;
  TSfmlRectangleShapeGetLocalBounds = function (const Shape: PSfmlRectangleShape): TSfmlFloatRect; cdecl;
  TSfmlRectangleShapeGetGlobalBounds = function (const Shape: PSfmlRectangleShape): TSfmlFloatRect; cdecl;

  TSfmlRenderTextureCreate = function (Width, Height: Cardinal; depthBuffer: sfBool): PSfmlRenderTexture; cdecl;
  TSfmlRenderTextureDestroy = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTextureGetSize = function (const RenderTexture: PSfmlRenderTexture): TSfmlVector2u; cdecl;
  TSfmlRenderTextureSetActive = function (RenderTexture: PSfmlRenderTexture; Active: sfBool): sfBool; cdecl;
  TSfmlRenderTextureDisplay = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTextureClear = procedure (RenderTexture: PSfmlRenderTexture; Color: TSfmlColor); cdecl;
  TSfmlRenderTextureSetView = procedure (RenderTexture: PSfmlRenderTexture; const View: PSfmlView); cdecl;
  TSfmlRenderTextureGetView = function (const RenderTexture: PSfmlRenderTexture): PSfmlView; cdecl;
  TSfmlRenderTextureGetDefaultView = function (const RenderTexture: PSfmlRenderTexture): PSfmlView; cdecl;
  TSfmlRenderTextureGetViewport = function (const RenderTexture: PSfmlRenderTexture; const View: PSfmlView): TSfmlIntRect; cdecl;
  TSfmlRenderTextureMapPixelToCoords = function (const RenderTexture: PSfmlRenderTexture; point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f; cdecl;
  TSfmlRenderTextureMapCoordsToPixel = function (const RenderTexture: PSfmlRenderTexture; point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i; cdecl;
  TSfmlRenderTextureDrawSprite = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlSprite; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawText = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlText; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawShape = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawCircleShape = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlCircleShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawConvexShape = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlConvexShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawRectangleShape = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawVertexArray = procedure (RenderTexture: PSfmlRenderTexture; const &Object: PSfmlVertexArray; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderTextureDrawPrimitives = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTexturePushGLStates = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTexturePopGLStates = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTextureResetGLStates = procedure (RenderTexture: PSfmlRenderTexture); cdecl;
  TSfmlRenderTextureGetTexture = function (const RenderTexture: PSfmlRenderTexture): PSfmlTexture ; cdecl;
  TSfmlRenderTextureSetSmooth = procedure (RenderTexture: PSfmlRenderTexture; Smooth: sfBool); cdecl;
  TSfmlRenderTextureIsSmooth = function (const RenderTexture: PSfmlRenderTexture): sfBool; cdecl;
  TSfmlRenderTextureSetRepeated = procedure (RenderTexture: PSfmlRenderTexture; Repeated: sfBool); cdecl;
  TSfmlRenderTextureIsRepeated = function (const RenderTexture: PSfmlRenderTexture): sfBool; cdecl;

  TSfmlRenderWindowCreate = function (Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl;
  TSfmlRenderWindowCreateUnicode = function (Mode: TSfmlVideoMode; const Title: PWideChar; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl;
  TSfmlRenderWindowCreateFromHandle = function (Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl;
  TSfmlRenderWindowDestroy = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowClose = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowIsOpen = function (const RenderWindow: PSfmlRenderWindow): sfBool; cdecl;
  TSfmlRenderWindowGetSettings = function (const RenderWindow: PSfmlRenderWindow): TSfmlContextSettings; cdecl;
  TSfmlRenderWindowPollEvent = function (RenderWindow: PSfmlRenderWindow; Event: PSfmlEvent): sfBool; cdecl;
  TSfmlRenderWindowWaitEvent = function (RenderWindow: PSfmlRenderWindow; Event: PSfmlEvent): sfBool; cdecl;
  TSfmlRenderWindowGetPosition = function (const RenderWindow: PSfmlRenderWindow): TSfmlVector2i; cdecl;
  TSfmlRenderWindowSetPosition = procedure (RenderWindow: PSfmlRenderWindow; Position: TSfmlVector2i); cdecl;
  TSfmlRenderWindowGetSize = function (const RenderWindow: PSfmlRenderWindow): TSfmlVector2u; cdecl;
  TSfmlRenderWindowSetSize = procedure (RenderWindow: PSfmlRenderWindow; Size: TSfmlVector2u); cdecl;
  TSfmlRenderWindowSetTitle = procedure (RenderWindow: PSfmlRenderWindow; const Title: PAnsiChar); cdecl;
  TSfmlRenderWindowSetUnicodeTitle = procedure (RenderWindow: PSfmlRenderWindow; const Title: PWideChar); cdecl;
  TSfmlRenderWindowSetIcon = procedure (RenderWindow: PSfmlRenderWindow; Width, Height: Cardinal; const Pixels: PByte); cdecl;
  TSfmlRenderWindowSetVisible = procedure (RenderWindow: PSfmlRenderWindow; Visible: sfBool); cdecl;
  TSfmlRenderWindowSetMouseCursorVisible = procedure (RenderWindow: PSfmlRenderWindow; show: sfBool); cdecl;
  TSfmlRenderWindowSetVerticalSyncEnabled = procedure (RenderWindow: PSfmlRenderWindow; enabled: sfBool); cdecl;
  TSfmlRenderWindowSetKeyRepeatEnabled = procedure (RenderWindow: PSfmlRenderWindow; enabled: sfBool); cdecl;
  TSfmlRenderWindowSetActive = function (RenderWindow: PSfmlRenderWindow; Active: sfBool): sfBool; cdecl;
  TSfmlRenderWindowRequestFocus = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowHasFocus = function (const RenderWindow: PSfmlRenderWindow): sfBool; cdecl;
  TSfmlRenderWindowDisplay = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowSetFramerateLimit = procedure (RenderWindow: PSfmlRenderWindow; Limit: Cardinal); cdecl;
  TSfmlRenderWindowSetJoystickThreshold = procedure (RenderWindow: PSfmlRenderWindow; Threshold: Single); cdecl;
  TSfmlRenderWindowGetSystemHandle = function (const RenderWindow: PSfmlRenderWindow): TSfmlWindowHandle; cdecl;
  TSfmlRenderWindowClear = procedure (RenderWindow: PSfmlRenderWindow; Color: TSfmlColor); cdecl;
  TSfmlRenderWindowSetView = procedure (RenderWindow: PSfmlRenderWindow; const View: PSfmlView); cdecl;
  TSfmlRenderWindowGetView = function (const RenderWindow: PSfmlRenderWindow): PSfmlView; cdecl;
  TSfmlRenderWindowGetDefaultView = function (const RenderWindow: PSfmlRenderWindow): PSfmlView; cdecl;
  TSfmlRenderWindowGetViewport = function (const RenderWindow: PSfmlRenderWindow; const View: PSfmlView): TSfmlIntRect; cdecl;
  TSfmlRenderWindowMapPixelToCoords = function (const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f; cdecl;
  TSfmlRenderWindowMapCoordsToPixel = function (const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i; cdecl;
  TSfmlRenderWindowDrawSprite = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlSprite; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawText = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlText; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawShape = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawCircleShape = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlCircleShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawConvexShape = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlConvexShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawRectangleShape = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawVertexArray = procedure (RenderWindow: PSfmlRenderWindow; const &Object: PSfmlVertexArray; const States: PSfmlRenderStates); cdecl;
  TSfmlRenderWindowDrawPrimitives = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowPushGLStates = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowPopGLStates = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowResetGLStates = procedure (RenderWindow: PSfmlRenderWindow); cdecl;
  TSfmlRenderWindowCapture = function (const RenderWindow: PSfmlRenderWindow): PSfmlImage; cdecl;
  TSfmlMouseGetPositionRenderWindow = function (const relativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl;
  TSfmlMouseSetPositionRenderWindow = procedure (position: TSfmlVector2i; const RelativeTo: PSfmlRenderWindow); cdecl;
  TSfmlTouchGetPositionRenderWindow = function (Finger: Cardinal; const RelativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl;

  TSfmlShaderCreateFromFile = function (const VertexShaderFilename: PAnsiChar; const FragmentShaderFilename: PAnsiChar): PSfmlShader; cdecl;
  TSfmlShaderCreateFromMemory = function (const VertexShader: PAnsiChar; const FragmentShader: PAnsiChar): PSfmlShader; cdecl;
  TSfmlShaderCreateFromStream = function (VertexShaderStream: PSfmlInputStream; FragmentShaderStream: PSfmlInputStream): PSfmlShader; cdecl;
  TSfmlShaderDestroy = procedure (Shader: PSfmlShader); cdecl;
  TSfmlShaderSetFloatParameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; X: Single); cdecl;
  TSfmlShaderSetFloat2Parameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; X, Y: Single); cdecl;
  TSfmlShaderSetFloat3Parameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; X, Y, Z: Single); cdecl;
  TSfmlShaderSetFloat4Parameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; X, Y, Z, W: Single); cdecl;
  TSfmlShaderSetVector2Parameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlVector2f); cdecl;
  TSfmlShaderSetVector3Parameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlVector3f); cdecl;
  TSfmlShaderSetColorParameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Color: TSfmlColor); cdecl;
  TSfmlShaderSetTransformParameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; Transform: TSfmlTransform); cdecl;
  TSfmlShaderSetTextureParameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar; const Texture: PSfmlTexture); cdecl;
  TSfmlShaderSetCurrentTextureParameter = procedure (Shader: PSfmlShader; const Name: PAnsiChar); cdecl;
  TSfmlShaderBind = procedure (const Shader: PSfmlShader); cdecl;
  TSfmlShaderIsAvailable = function : sfBool; cdecl;

  TSfmlShapeCreate = function (getPointCount: TSfmlShapeGetPointCountCallback; GetPoint: TSfmlShapeGetPointCallback; UserData: Pointer): PSfmlShape; cdecl;
  TSfmlShapeDestroy = procedure (Shape: PSfmlShape); cdecl;
  TSfmlShapeSetPosition = procedure (Shape: PSfmlShape; Position: TSfmlVector2f); cdecl;
  TSfmlShapeSetRotation = procedure (Shape: PSfmlShape; Angle: Single); cdecl;
  TSfmlShapeSetScale = procedure (Shape: PSfmlShape; Scale: TSfmlVector2f); cdecl;
  TSfmlShapeSetOrigin = procedure (Shape: PSfmlShape; Origin: TSfmlVector2f); cdecl;
  TSfmlShapeGetPosition = function (const Shape: PSfmlShape): TSfmlVector2f; cdecl;
  TSfmlShapeGetRotation = function (const Shape: PSfmlShape): Single; cdecl;
  TSfmlShapeGetScale = function (const Shape: PSfmlShape): TSfmlVector2f; cdecl;
  TSfmlShapeGetOrigin = function (const Shape: PSfmlShape): TSfmlVector2f; cdecl;
  TSfmlShapeMove = procedure (Shape: PSfmlShape; Offset: TSfmlVector2f); cdecl;
  TSfmlShapeRotate = procedure (Shape: PSfmlShape; Angle: Single); cdecl;
  TSfmlShapeScale = procedure (Shape: PSfmlShape; Factors: TSfmlVector2f); cdecl;
  TSfmlShapeGetTransform = function (const Shape: PSfmlShape): TSfmlTransform; cdecl;
  TSfmlShapeGetInverseTransform = function (const Shape: PSfmlShape): TSfmlTransform; cdecl;
  TSfmlShapeSetTexture = procedure (Shape: PSfmlShape; const Texture: PSfmlTexture; ResetRect: sfBool); cdecl;
  TSfmlShapeSetTextureRect = procedure (Shape: PSfmlShape; Rect: TSfmlIntRect); cdecl;
  TSfmlShapeSetFillColor = procedure (Shape: PSfmlShape; Color: TSfmlColor); cdecl;
  TSfmlShapeSetOutlineColor = procedure (Shape: PSfmlShape; Color: TSfmlColor); cdecl;
  TSfmlShapeSetOutlineThickness = procedure (Shape: PSfmlShape; Thickness: Single); cdecl;
  TSfmlShapeGetTexture = function (const Shape: PSfmlShape): PSfmlTexture; cdecl;
  TSfmlShapeGetTextureRect = function (const Shape: PSfmlShape): TSfmlIntRect; cdecl;
  TSfmlShapeGetFillColor = function (const Shape: PSfmlShape): TSfmlColor; cdecl;
  TSfmlShapeGetOutlineColor = function (const Shape: PSfmlShape): TSfmlColor; cdecl;
  TSfmlShapeGetOutlineThickness = function (const Shape: PSfmlShape): Single; cdecl;
  TSfmlShapeGetPointCount = function (const Shape: PSfmlShape): Cardinal; cdecl;
  TSfmlShapeGetPoint = function (const Shape: PSfmlShape; Index: Cardinal): TSfmlVector2f; cdecl;
  TSfmlShapeGetLocalBounds = function (const Shape: PSfmlShape): TSfmlFloatRect; cdecl;
  TSfmlShapeGetGlobalBounds = function (const Shape: PSfmlShape): TSfmlFloatRect; cdecl;
  TSfmlShapeUpdate = procedure (Shape: PSfmlShape); cdecl;

  TSfmlSpriteCreate = function : PSfmlSprite; cdecl;
  TSfmlSpriteCopy = function (const Sprite: PSfmlSprite): PSfmlSprite; cdecl;
  TSfmlSpriteDestroy = procedure (Sprite: PSfmlSprite); cdecl;
  TSfmlSpriteSetPosition = procedure (Sprite: PSfmlSprite; Position: TSfmlVector2f); cdecl;
  TSfmlSpriteSetRotation = procedure (Sprite: PSfmlSprite; Angle: Single); cdecl;
  TSfmlSpriteSetScale = procedure (Sprite: PSfmlSprite; Scale: TSfmlVector2f); cdecl;
  TSfmlSpriteSetOrigin = procedure (Sprite: PSfmlSprite; Origin: TSfmlVector2f); cdecl;
  TSfmlSpriteGetPosition = function (const Sprite: PSfmlSprite): TSfmlVector2f; cdecl;
  TSfmlSpriteGetRotation = function (const Sprite: PSfmlSprite): Single; cdecl;
  TSfmlSpriteGetScale = function (const Sprite: PSfmlSprite): TSfmlVector2f; cdecl;
  TSfmlSpriteGetOrigin = function (const Sprite: PSfmlSprite): TSfmlVector2f; cdecl;
  TSfmlSpriteMove = procedure (Sprite: PSfmlSprite; Offset: TSfmlVector2f); cdecl;
  TSfmlSpriteRotate = procedure (Sprite: PSfmlSprite; Angle: Single); cdecl;
  TSfmlSpriteScale = procedure (Sprite: PSfmlSprite; Factors: TSfmlVector2f); cdecl;
  TSfmlSpriteGetTransform = function (const Sprite: PSfmlSprite): TSfmlTransform; cdecl;
  TSfmlSpriteGetInverseTransform = function (const Sprite: PSfmlSprite): TSfmlTransform; cdecl;
  TSfmlSpriteSetTexture = procedure (Sprite: PSfmlSprite; const Texture: PSfmlTexture; resetRect: sfBool); cdecl;
  TSfmlSpriteSetTextureRect = procedure (Sprite: PSfmlSprite; Rectangle: TSfmlIntRect); cdecl;
  TSfmlSpriteSetColor = procedure (Sprite: PSfmlSprite; Color: TSfmlColor); cdecl;
  TSfmlSpriteGetTexture = function (const Sprite: PSfmlSprite): PSfmlTexture; cdecl;
  TSfmlSpriteGetTextureRect = function (const Sprite: PSfmlSprite): TSfmlIntRect; cdecl;
  TSfmlSpriteGetColor = function (const Sprite: PSfmlSprite): TSfmlColor; cdecl;
  TSfmlSpriteGetLocalBounds = function (const Sprite: PSfmlSprite): TSfmlFloatRect; cdecl;
  TSfmlSpriteGetGlobalBounds = function (const Sprite: PSfmlSprite): TSfmlFloatRect; cdecl;

  TSfmlTextCreate = function : PSfmlText; cdecl;
  TSfmlTextCopy = function (const Text: PSfmlText): PSfmlText; cdecl;
  TSfmlTextDestroy = procedure (Text: PSfmlText); cdecl;
  TSfmlTextSetPosition = procedure (Text: PSfmlText; Position: TSfmlVector2f); cdecl;
  TSfmlTextSetRotation = procedure (Text: PSfmlText; Angle: Single); cdecl;
  TSfmlTextSetScale = procedure (Text: PSfmlText; Scale: TSfmlVector2f); cdecl;
  TSfmlTextSetOrigin = procedure (Text: PSfmlText; Origin: TSfmlVector2f); cdecl;
  TSfmlTextGetPosition = function (const Text: PSfmlText): TSfmlVector2f; cdecl;
  TSfmlTextGetRotation = function (const Text: PSfmlText): Single; cdecl;
  TSfmlTextGetScale = function (const Text: PSfmlText): TSfmlVector2f; cdecl;
  TSfmlTextGetOrigin = function (const Text: PSfmlText): TSfmlVector2f; cdecl;
  TSfmlTextMove = procedure (Text: PSfmlText; Offset: TSfmlVector2f); cdecl;
  TSfmlTextRotate = procedure (Text: PSfmlText; Angle: Single); cdecl;
  TSfmlTextScale = procedure (Text: PSfmlText; Factors: TSfmlVector2f); cdecl;
  TSfmlTextGetTransform = function (const Text: PSfmlText): TSfmlTransform; cdecl;
  TSfmlTextGetInverseTransform = function (const Text: PSfmlText): TSfmlTransform; cdecl;
  TSfmlTextSetString = procedure (Text: PSfmlText; const &string: PAnsiChar); cdecl;
  TSfmlTextSetUnicodeString = procedure (Text: PSfmlText; const &string: PWideChar); cdecl;
  TSfmlTextSetFont = procedure (Text: PSfmlText; const Font: PSfmlFont); cdecl;
  TSfmlTextSetCharacterSize = procedure (Text: PSfmlText; Size: Cardinal); cdecl;
  TSfmlTextSetStyle = procedure (Text: PSfmlText; Style: sfUint32); cdecl;
  TSfmlTextSetColor = procedure (Text: PSfmlText; Color: TSfmlColor); cdecl;
  TSfmlTextGetString = function (const Text: PSfmlText): PAnsiChar; cdecl;
  TSfmlTextGetUnicodeString = function (const Text: PSfmlText): PWideChar; cdecl;
  TSfmlTextGetFont = function (const Text: PSfmlText): PSfmlFont; cdecl;
  TSfmlTextGetCharacterSize = function (const Text: PSfmlText): Cardinal; cdecl;
  TSfmlTextGetStyle = function (const Text: PSfmlText): sfUint32; cdecl;
  TSfmlTextGetColor = function (const Text: PSfmlText): TSfmlColor; cdecl;
  TSfmlTextFindCharacterPos = function (const Text: PSfmlText; Index: NativeUInt): TSfmlVector2f; cdecl;
  TSfmlTextGetLocalBounds = function (const Text: PSfmlText): TSfmlFloatRect; cdecl;
  TSfmlTextGetGlobalBounds = function (const Text: PSfmlText): TSfmlFloatRect; cdecl;

  TSfmlTextureCreate = function (Width, Height: Cardinal): PSfmlTexture; cdecl;
  TSfmlTextureCreateFromFile = function (const FileName: PAnsiChar; const Area: PSfmlIntRect): PSfmlTexture; cdecl;
  TSfmlTextureCreateFromMemory = function (const data: Pointer; SizeInBytes: NativeUInt; const Area: PSfmlIntRect): PSfmlTexture; cdecl;
  TSfmlTextureCreateFromStream = function (Stream: PSfmlInputStream; const Area: PSfmlIntRect): PSfmlTexture; cdecl;
  TSfmlTextureCreateFromImage = function (const Image: PSfmlImage; const Area: PSfmlIntRect): PSfmlTexture; cdecl;
  TSfmlTextureCopy = function (const Texture: PSfmlTexture): PSfmlTexture; cdecl;
  TSfmlTextureDestroy = procedure (Texture: PSfmlTexture); cdecl;
  TSfmlTextureGetSize = function (const Texture: PSfmlTexture): TSfmlVector2u; cdecl;
  TSfmlTextureCopyToImage = function (const Texture: PSfmlTexture): PSfmlImage; cdecl;
  TSfmlTextureUpdateFromPixels = procedure (Texture: PSfmlTexture; const Pixels: PByte; Width, Height, X, Y: Cardinal); cdecl;
  TSfmlTextureUpdateFromImage = procedure (Texture: PSfmlTexture; const Image: PSfmlImage; X, Y: Cardinal); cdecl;
  TSfmlTextureUpdateFromWindow = procedure (Texture: PSfmlTexture; const Window: PSfmlWindow; X, Y: Cardinal); cdecl;
  TSfmlTextureUpdateFromRenderWindow = procedure (Texture: PSfmlTexture; const RenderWindow: PSfmlRenderWindow; X, Y: Cardinal); cdecl;
  TSfmlTextureSetSmooth = procedure (Texture: PSfmlTexture; Smooth: sfBool); cdecl;
  TSfmlTextureIsSmooth = function (const Texture: PSfmlTexture): sfBool; cdecl;
  TSfmlTextureSetRepeated = procedure (Texture: PSfmlTexture; Repeated: sfBool); cdecl;
  TSfmlTextureIsRepeated = function (const Texture: PSfmlTexture): sfBool; cdecl;
  TSfmlTextureBind = procedure (const Texture: PSfmlTexture); cdecl;
  TsfmlTextureGetMaximumSize = function : Cardinal; cdecl;

  TSfmlTransformIdentity = function : TSfmlTransform; cdecl;
  TSfmlTransformFromMatrix = function (a00, a01, a02, a10, a11, a12, a20, a21, a22: Single): TSfmlTransform; cdecl;
  TSfmlTransformGetMatrix = procedure (const Transform: PSfmlTransform; Matrix: PSingle); cdecl;
  TSfmlTransformGetInverse = function (const Transform: PSfmlTransform): TSfmlTransform; cdecl;
  TSfmlTransformTransformPoint = function (const Transform: PSfmlTransform; Point: TSfmlVector2f): TSfmlVector2f; cdecl;
  TSfmlTransformTransformRect = function (const Transform: PSfmlTransform; Rectangle: TSfmlFloatRect): TSfmlFloatRect; cdecl;
  TSfmlTransformCombine = procedure (Transform: PSfmlTransform; const Other: PSfmlTransform); cdecl;
  TSfmlTransformTranslate = procedure (Transform: PSfmlTransform; X, Y: Single); cdecl;
  TSfmlTransformRotate = procedure (Transform: PSfmlTransform; Angle: Single); cdecl;
  TSfmlTransformRotateWithCenter = procedure (Transform: PSfmlTransform; Angle: Single; centerX, centerY: Single); cdecl;
  TSfmlTransformScale = procedure (Transform: PSfmlTransform; ScaleX, ScaleY: Single); cdecl;
  TSfmlTransformScaleWithCenter = procedure (Transform: PSfmlTransform; ScaleX, ScaleY, CenterX, CenterY: Single); cdecl;

  TSfmlTransformableCreate = function : PSfmlTransformable; cdecl;
  TSfmlTransformableCopy = function (const Transformable: PSfmlTransformable): PSfmlTransformable; cdecl;
  TSfmlTransformableDestroy = procedure (Transformable: PSfmlTransformable); cdecl;
  TSfmlTransformableSetPosition = procedure (Transformable: PSfmlTransformable; Position: TSfmlVector2f); cdecl;
  TSfmlTransformableSetRotation = procedure (Transformable: PSfmlTransformable; Angle: Single); cdecl;
  TSfmlTransformableSetScale = procedure (Transformable: PSfmlTransformable; Scale: TSfmlVector2f); cdecl;
  TSfmlTransformableSetOrigin = procedure (Transformable: PSfmlTransformable; Origin: TSfmlVector2f); cdecl;
  TSfmlTransformableGetPosition = function (const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl;
  TSfmlTransformableGetRotation = function (const Transformable: PSfmlTransformable): Single; cdecl;
  TSfmlTransformableGetScale = function (const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl;
  TSfmlTransformableGetOrigin = function (const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl;
  TSfmlTransformableMove = procedure (Transformable: PSfmlTransformable; Offset: TSfmlVector2f); cdecl;
  TSfmlTransformableRotate = procedure (Transformable: PSfmlTransformable; Angle: Single); cdecl;
  TSfmlTransformableScale = procedure (Transformable: PSfmlTransformable; Factors: TSfmlVector2f); cdecl;
  TSfmlTransformableGetTransform = function (const Transformable: PSfmlTransformable): TSfmlTransform; cdecl;
  TSfmlTransformableGetInverseTransform = function (const Transformable: PSfmlTransformable): TSfmlTransform; cdecl;

  TSfmlVertexArrayCreate = function : PSfmlVertexArray; cdecl;
  TSfmlVertexArrayCopy = function (const VertexArray: PSfmlVertexArray): PSfmlVertexArray; cdecl;
  TSfmlVertexArrayDestroy = procedure (VertexArray: PSfmlVertexArray); cdecl;
  TSfmlVertexArrayGetVertexCount = function (const VertexArray: PSfmlVertexArray): Cardinal; cdecl;
  TSfmlVertexArrayGetVertex = function (VertexArray: PSfmlVertexArray; Index: Cardinal): PSfmlVertex; cdecl;
  TSfmlVertexArrayClear = procedure (VertexArray: PSfmlVertexArray); cdecl;
  TSfmlVertexArrayResize = procedure (VertexArray: PSfmlVertexArray; VertexCount: Cardinal); cdecl;
  TSfmlVertexArrayAppend = procedure (VertexArray: PSfmlVertexArray; Vertex: TSfmlVertex); cdecl;
  TSfmlVertexArraySetPrimitiveType = procedure (VertexArray: PSfmlVertexArray; &Type: TSfmlPrimitiveType); cdecl;
  TSfmlVertexArrayGetPrimitiveType = function (VertexArray: PSfmlVertexArray): TSfmlPrimitiveType; cdecl;
  TSfmlVertexArrayGetBounds = function (VertexArray: PSfmlVertexArray): TSfmlFloatRect; cdecl;

  TSfmlViewCreate = function : PSfmlView; cdecl;
  TSfmlViewCreateFromRect = function (Rectangle: TSfmlFloatRect): PSfmlView; cdecl;
  TSfmlViewCopy = function (const View: PSfmlView): PSfmlView; cdecl;
  TSfmlViewDestroy = procedure (View: PSfmlView); cdecl;
  TSfmlViewSetCenter = procedure (View: PSfmlView; Center: TSfmlVector2f); cdecl;
  TSfmlViewSetSize = procedure (View: PSfmlView; Size: TSfmlVector2f); cdecl;
  TSfmlViewSetRotation = procedure (View: PSfmlView; Angle: Single); cdecl;
  TSfmlViewSetViewport = procedure (View: PSfmlView; Viewport: TSfmlFloatRect); cdecl;
  TSfmlViewReset = procedure (View: PSfmlView; Rectangle: TSfmlFloatRect); cdecl;
  TSfmlViewGetCenter = function (const View: PSfmlView): TSfmlVector2f; cdecl;
  TSfmlViewGetSize = function (const View: PSfmlView): TSfmlVector2f; cdecl;
  TSfmlViewGetRotation = function (const View: PSfmlView): Single; cdecl;
  TSfmlViewGetViewport = function (const View: PSfmlView): TSfmlFloatRect; cdecl;
  TSfmlViewMove = procedure (View: PSfmlView; Offset: TSfmlVector2f); cdecl;
  TSfmlViewRotate = procedure (View: PSfmlView; Angle: Single); cdecl;
  TSfmlViewZoom = procedure (View: PSfmlView; Factor: Single); cdecl;

var
  SfmlBlendAlpha: TSfmlBlendAlpha;
  SfmlBlendAdd: TSfmlBlendAdd;
  SfmlBlendMultiply: TSfmlBlendMultiply;
  SfmlBlendNone: TSfmlBlendNone;

  SfmlBlack: TSfmlColor;
  SfmlWhite: TSfmlColor;
  SfmlRed: TSfmlColor;
  SfmlGreen: TSfmlColor;
  SfmlBlue: TSfmlColor;
  SfmlYellow: TSfmlColor;
  SfmlMagenta: TSfmlColor;
  SfmlCyan: TSfmlColor;
  SfmlTransparent: TSfmlColor;

  SfmlColorFromRGB: TSfmlColorFromRGB;
  SfmlColorFromRGBA: TSfmlColorFromRGBA;
  SfmlColorAdd: TSfmlColorAdd;
  SfmlColorModulate: TSfmlColorModulate;

  SfmlCircleShapeCreate: TSfmlCircleShapeCreate;
  SfmlCircleShapeCopy: TSfmlCircleShapeCopy;
  SfmlCircleShapeDestroy: TSfmlCircleShapeDestroy;
  SfmlCircleShapeSetPosition: TSfmlCircleShapeSetPosition;
  SfmlCircleShapeSetRotation: TSfmlCircleShapeSetRotation;
  SfmlCircleShapeSetScale: TSfmlCircleShapeSetScale;
  SfmlCircleShapeSetOrigin: TSfmlCircleShapeSetOrigin;
  SfmlCircleShapeGetPosition: TSfmlCircleShapeGetPosition;
  SfmlCircleShapeGetRotation: TSfmlCircleShapeGetRotation;
  SfmlCircleShapeGetScale: TSfmlCircleShapeGetScale;
  SfmlCircleShapeGetOrigin: TSfmlCircleShapeGetOrigin;
  SfmlCircleShapeMove: TSfmlCircleShapeMove;
  SfmlCircleShapeRotate: TSfmlCircleShapeRotate;
  SfmlCircleShapeScale: TSfmlCircleShapeScale;
  SfmlCircleShapeGetTransform: TSfmlCircleShapeGetTransform;
  SfmlCircleShapeGetInverseTransform: TSfmlCircleShapeGetInverseTransform;
  SfmlCircleShapeSetTexture: TSfmlCircleShapeSetTexture;
  SfmlCircleShapeSetTextureRect: TSfmlCircleShapeSetTextureRect;
  SfmlCircleShapeSetFillColor: TSfmlCircleShapeSetFillColor;
  SfmlCircleShapeSetOutlineColor: TSfmlCircleShapeSetOutlineColor;
  SfmlCircleShapeSetOutlineThickness: TSfmlCircleShapeSetOutlineThickness;
  SfmlCircleShapeGetTexture: TSfmlCircleShapeGetTexture;
  SfmlCircleShapeGetTextureRect: TSfmlCircleShapeGetTextureRect;
  SfmlCircleShapeGetFillColor: TSfmlCircleShapeGetFillColor;
  SfmlCircleShapeGetOutlineColor: TSfmlCircleShapeGetOutlineColor;
  SfmlCircleShapeGetOutlineThickness: TSfmlCircleShapeGetOutlineThickness;
  SfmlCircleShapeGetPointCount: TSfmlCircleShapeGetPointCount;
  SfmlCircleShapeGetPoint: TSfmlCircleShapeGetPoint;
  SfmlCircleShapeSetRadius: TSfmlCircleShapeSetRadius;
  SfmlCircleShapeGetRadius: TSfmlCircleShapeGetRadius;
  SfmlCircleShapeSetPointCount: TSfmlCircleShapeSetPointCount;
  SfmlCircleShapeGetLocalBounds: TSfmlCircleShapeGetLocalBounds;
  SfmlCircleShapeGetGlobalBounds: TSfmlCircleShapeGetGlobalBounds;

  SfmlConvexShapeCreate: TSfmlConvexShapeCreate;
  SfmlConvexShapeCopy: TSfmlConvexShapeCopy;
  SfmlConvexShapeDestroy: TSfmlConvexShapeDestroy;
  SfmlConvexShapeSetPosition: TSfmlConvexShapeSetPosition;
  SfmlConvexShapeSetRotation: TSfmlConvexShapeSetRotation;
  SfmlConvexShapeSetScale: TSfmlConvexShapeSetScale;
  SfmlConvexShapeSetOrigin: TSfmlConvexShapeSetOrigin;
  SfmlConvexShapeGetPosition: TSfmlConvexShapeGetPosition;
  SfmlConvexShapeGetRotation: TSfmlConvexShapeGetRotation;
  SfmlConvexShapeGetScale: TSfmlConvexShapeGetScale;
  SfmlConvexShapeGetOrigin: TSfmlConvexShapeGetOrigin;
  SfmlConvexShapeMove: TSfmlConvexShapeMove;
  SfmlConvexShapeRotate: TSfmlConvexShapeRotate;
  SfmlConvexShapeScale: TSfmlConvexShapeScale;
  SfmlConvexShapeGetTransform: TSfmlConvexShapeGetTransform;
  SfmlConvexShapeGetInverseTransform: TSfmlConvexShapeGetInverseTransform;
  SfmlConvexShapeSetTexture: TSfmlConvexShapeSetTexture;
  SfmlConvexShapeSetTextureRect: TSfmlConvexShapeSetTextureRect;
  SfmlConvexShapeSetFillColor: TSfmlConvexShapeSetFillColor;
  SfmlConvexShapeSetOutlineColor: TSfmlConvexShapeSetOutlineColor;
  SfmlConvexShapeSetOutlineThickness: TSfmlConvexShapeSetOutlineThickness;
  SfmlConvexShapeGetTexture: TSfmlConvexShapeGetTexture;
  SfmlConvexShapeGetTextureRect: TSfmlConvexShapeGetTextureRect;
  SfmlConvexShapeGetFillColor: TSfmlConvexShapeGetFillColor;
  SfmlConvexShapeGetOutlineColor: TSfmlConvexShapeGetOutlineColor;
  SfmlConvexShapeGetOutlineThickness: TSfmlConvexShapeGetOutlineThickness;
  SfmlConvexShapeGetPointCount: TSfmlConvexShapeGetPointCount;
  SfmlConvexShapeGetPoint: TSfmlConvexShapeGetPoint;
  SfmlConvexShapeSetPointCount: TSfmlConvexShapeSetPointCount;
  SfmlConvexShapeSetPoint: TSfmlConvexShapeSetPoint;
  SfmlConvexShapeGetLocalBounds: TSfmlConvexShapeGetLocalBounds;
  SfmlConvexShapeGetGlobalBounds: TSfmlConvexShapeGetGlobalBounds;

  SfmlFontCreateFromFile: TSfmlFontCreateFromFile;
  SfmlFontCreateFromMemory: TSfmlFontCreateFromMemory;
  SfmlFontCreateFromStream: TSfmlFontCreateFromStream;
  SfmlFontCopy: TSfmlFontCopy;
  SfmlFontDestroy: TSfmlFontDestroy;
  SfmlFontGetGlyph: TSfmlFontGetGlyph;
  SfmlFontGetKerning: TSfmlFontGetKerning;
  SfmlFontGetLineSpacing: TSfmlFontGetLineSpacing;
  SfmlFontGetUnderlinePosition: TSfmlFontGetUnderlinePosition;
  SfmlFontGetUnderlineThickness: TSfmlFontGetUnderlineThickness;
  SfmlFontGetTexture: TSfmlFontGetTexture;
  SfmlFontGetInfo: TSfmlFontGetInfo;

  SfmlImageCreate: TSfmlImageCreate;
  SfmlImageCreateFromColor: TSfmlImageCreateFromColor;
  SfmlImageCreateFromPixels: TSfmlImageCreateFromPixels;
  SfmlImageCreateFromFile: TSfmlImageCreateFromFile;
  SfmlImageCreateFromMemory: TSfmlImageCreateFromMemory;
  SfmlImageCreateFromStream: TSfmlImageCreateFromStream;
  SfmlImageCopy: TSfmlImageCopy;
  SfmlImageDestroy: TSfmlImageDestroy;
  SfmlImageSaveToFile: TSfmlImageSaveToFile;
  SfmlImageGetSize: TSfmlImageGetSize;
  SfmlImageCreateMaskFromColor: TSfmlImageCreateMaskFromColor;
  SfmlImageCopyImage: TSfmlImageCopyImage;
  SfmlImageSetPixel: TSfmlImageSetPixel;
  SfmlImageGetPixel: TSfmlImageGetPixel;
  SfmlImageGetPixelsPtr: TSfmlImageGetPixelsPtr;
  SfmlImageFlipHorizontally: TSfmlImageFlipHorizontally;
  SfmlImageFlipVertically: TSfmlImageFlipVertically;

  SfmlFloatRectContains: TSfmlFloatRectContains;
  SfmlIntRectContains: TSfmlIntRectContains;
  SfmlFloatRectIntersects: TSfmlFloatRectIntersects;
  SfmlIntRectIntersects: TSfmlIntRectIntersects;

  SfmlRectangleShapeCreate: TSfmlRectangleShapeCreate;
  SfmlRectangleShapeCopy: TSfmlRectangleShapeCopy;
  SfmlRectangleShapeDestroy: TSfmlRectangleShapeDestroy;
  SfmlRectangleShapeSetPosition: TSfmlRectangleShapeSetPosition;
  SfmlRectangleShapeSetRotation: TSfmlRectangleShapeSetRotation;
  SfmlRectangleShapeSetScale: TSfmlRectangleShapeSetScale;
  SfmlRectangleShapeSetOrigin: TSfmlRectangleShapeSetOrigin;
  SfmlRectangleShapeGetPosition: TSfmlRectangleShapeGetPosition;
  SfmlRectangleShapeGetRotation: TSfmlRectangleShapeGetRotation;
  SfmlRectangleShapeGetScale: TSfmlRectangleShapeGetScale;
  SfmlRectangleShapeGetOrigin: TSfmlRectangleShapeGetOrigin;
  SfmlRectangleShapeMove: TSfmlRectangleShapeMove;
  SfmlRectangleShapeRotate: TSfmlRectangleShapeRotate;
  SfmlRectangleShapeScale: TSfmlRectangleShapeScale;
  SfmlRectangleShapeGetTransform: TSfmlRectangleShapeGetTransform;
  SfmlRectangleShapeGetInverseTransform: TSfmlRectangleShapeGetInverseTransform;
  SfmlRectangleShapeSetTexture: TSfmlRectangleShapeSetTexture;
  SfmlRectangleShapeSetTextureRect: TSfmlRectangleShapeSetTextureRect;
  SfmlRectangleShapeSetFillColor: TSfmlRectangleShapeSetFillColor;
  SfmlRectangleShapeSetOutlineColor: TSfmlRectangleShapeSetOutlineColor;
  SfmlRectangleShapeSetOutlineThickness: TSfmlRectangleShapeSetOutlineThickness;
  SfmlRectangleShapeGetTexture: TSfmlRectangleShapeGetTexture;
  SfmlRectangleShapeGetTextureRect: TSfmlRectangleShapeGetTextureRect;
  SfmlRectangleShapeGetFillColor: TSfmlRectangleShapeGetFillColor;
  SfmlRectangleShapeGetOutlineColor: TSfmlRectangleShapeGetOutlineColor;
  SfmlRectangleShapeGetOutlineThickness: TSfmlRectangleShapeGetOutlineThickness;
  SfmlRectangleShapeGetPointCount: TSfmlRectangleShapeGetPointCount;
  SfmlRectangleShapeGetPoint: TSfmlRectangleShapeGetPoint;
  SfmlRectangleShapeSetSize: TSfmlRectangleShapeSetSize;
  SfmlRectangleShapeGetSize: TSfmlRectangleShapeGetSize;
  SfmlRectangleShapeGetLocalBounds: TSfmlRectangleShapeGetLocalBounds;
  SfmlRectangleShapeGetGlobalBounds: TSfmlRectangleShapeGetGlobalBounds;

  SfmlRenderTextureCreate: TSfmlRenderTextureCreate;
  SfmlRenderTextureDestroy: TSfmlRenderTextureDestroy;
  SfmlRenderTextureGetSize: TSfmlRenderTextureGetSize;
  SfmlRenderTextureSetActive: TSfmlRenderTextureSetActive;
  SfmlRenderTextureDisplay: TSfmlRenderTextureDisplay;
  SfmlRenderTextureClear: TSfmlRenderTextureClear;
  SfmlRenderTextureSetView: TSfmlRenderTextureSetView;
  SfmlRenderTextureGetView: TSfmlRenderTextureGetView;
  SfmlRenderTextureGetDefaultView: TSfmlRenderTextureGetDefaultView;
  SfmlRenderTextureGetViewport: TSfmlRenderTextureGetViewport;
  SfmlRenderTextureMapPixelToCoords: TSfmlRenderTextureMapPixelToCoords;
  SfmlRenderTextureMapCoordsToPixel: TSfmlRenderTextureMapCoordsToPixel;
  SfmlRenderTextureDrawSprite: TSfmlRenderTextureDrawSprite;
  SfmlRenderTextureDrawText: TSfmlRenderTextureDrawText;
  SfmlRenderTextureDrawShape: TSfmlRenderTextureDrawShape;
  SfmlRenderTextureDrawCircleShape: TSfmlRenderTextureDrawCircleShape;
  SfmlRenderTextureDrawConvexShape: TSfmlRenderTextureDrawConvexShape;
  SfmlRenderTextureDrawRectangleShape: TSfmlRenderTextureDrawRectangleShape;
  SfmlRenderTextureDrawVertexArray: TSfmlRenderTextureDrawVertexArray;
  SfmlRenderTextureDrawPrimitives: TSfmlRenderTextureDrawPrimitives;
  SfmlRenderTexturePushGLStates: TSfmlRenderTexturePushGLStates;
  SfmlRenderTexturePopGLStates: TSfmlRenderTexturePopGLStates;
  SfmlRenderTextureResetGLStates: TSfmlRenderTextureResetGLStates;
  SfmlRenderTextureGetTexture: TSfmlRenderTextureGetTexture;
  SfmlRenderTextureSetSmooth: TSfmlRenderTextureSetSmooth;
  SfmlRenderTextureIsSmooth: TSfmlRenderTextureIsSmooth;
  SfmlRenderTextureSetRepeated: TSfmlRenderTextureSetRepeated;
  SfmlRenderTextureIsRepeated: TSfmlRenderTextureIsRepeated;

  SfmlRenderWindowCreate: TSfmlRenderWindowCreate;
  SfmlRenderWindowCreateUnicode: TSfmlRenderWindowCreateUnicode;
  SfmlRenderWindowCreateFromHandle: TSfmlRenderWindowCreateFromHandle;
  SfmlRenderWindowDestroy: TSfmlRenderWindowDestroy;
  SfmlRenderWindowClose: TSfmlRenderWindowClose;
  SfmlRenderWindowIsOpen: TSfmlRenderWindowIsOpen;
  SfmlRenderWindowGetSettings: TSfmlRenderWindowGetSettings;
  SfmlRenderWindowPollEvent: TSfmlRenderWindowPollEvent;
  SfmlRenderWindowWaitEvent: TSfmlRenderWindowWaitEvent;
  SfmlRenderWindowGetPosition: TSfmlRenderWindowGetPosition;
  SfmlRenderWindowSetPosition: TSfmlRenderWindowSetPosition;
  SfmlRenderWindowGetSize: TSfmlRenderWindowGetSize;
  SfmlRenderWindowSetSize: TSfmlRenderWindowSetSize;
  SfmlRenderWindowSetTitle: TSfmlRenderWindowSetTitle;
  SfmlRenderWindowSetUnicodeTitle: TSfmlRenderWindowSetUnicodeTitle;
  SfmlRenderWindowSetIcon: TSfmlRenderWindowSetIcon;
  SfmlRenderWindowSetVisible: TSfmlRenderWindowSetVisible;
  SfmlRenderWindowSetMouseCursorVisible: TSfmlRenderWindowSetMouseCursorVisible;
  SfmlRenderWindowSetVerticalSyncEnabled: TSfmlRenderWindowSetVerticalSyncEnabled;
  SfmlRenderWindowSetKeyRepeatEnabled: TSfmlRenderWindowSetKeyRepeatEnabled;
  SfmlRenderWindowSetActive: TSfmlRenderWindowSetActive;
  SfmlRenderWindowRequestFocus: TSfmlRenderWindowRequestFocus;
  SfmlRenderWindowHasFocus: TSfmlRenderWindowHasFocus;
  SfmlRenderWindowDisplay: TSfmlRenderWindowDisplay;
  SfmlRenderWindowSetFramerateLimit: TSfmlRenderWindowSetFramerateLimit;
  SfmlRenderWindowSetJoystickThreshold: TSfmlRenderWindowSetJoystickThreshold;
  SfmlRenderWindowGetSystemHandle: TSfmlRenderWindowGetSystemHandle;
  SfmlRenderWindowClear: TSfmlRenderWindowClear;
  SfmlRenderWindowSetView: TSfmlRenderWindowSetView;
  SfmlRenderWindowGetView: TSfmlRenderWindowGetView;
  SfmlRenderWindowGetDefaultView: TSfmlRenderWindowGetDefaultView;
  SfmlRenderWindowGetViewport: TSfmlRenderWindowGetViewport;
  SfmlRenderWindowMapPixelToCoords: TSfmlRenderWindowMapPixelToCoords;
  SfmlRenderWindowMapCoordsToPixel: TSfmlRenderWindowMapCoordsToPixel;
  SfmlRenderWindowDrawSprite: TSfmlRenderWindowDrawSprite;
  SfmlRenderWindowDrawText: TSfmlRenderWindowDrawText;
  SfmlRenderWindowDrawShape: TSfmlRenderWindowDrawShape;
  SfmlRenderWindowDrawCircleShape: TSfmlRenderWindowDrawCircleShape;
  SfmlRenderWindowDrawConvexShape: TSfmlRenderWindowDrawConvexShape;
  SfmlRenderWindowDrawRectangleShape: TSfmlRenderWindowDrawRectangleShape;
  SfmlRenderWindowDrawVertexArray: TSfmlRenderWindowDrawVertexArray;
  SfmlRenderWindowDrawPrimitives: TSfmlRenderWindowDrawPrimitives;
  SfmlRenderWindowPushGLStates: TSfmlRenderWindowPushGLStates;
  SfmlRenderWindowPopGLStates: TSfmlRenderWindowPopGLStates;
  SfmlRenderWindowResetGLStates: TSfmlRenderWindowResetGLStates;
  SfmlRenderWindowCapture: TSfmlRenderWindowCapture;
  SfmlMouseGetPositionRenderWindow: TSfmlMouseGetPositionRenderWindow;
  SfmlMouseSetPositionRenderWindow: TSfmlMouseSetPositionRenderWindow;
  SfmlTouchGetPositionRenderWindow: TSfmlTouchGetPositionRenderWindow;

  SfmlShaderCreateFromFile: TSfmlShaderCreateFromFile;
  SfmlShaderCreateFromMemory: TSfmlShaderCreateFromMemory;
  SfmlShaderCreateFromStream: TSfmlShaderCreateFromStream;
  SfmlShaderDestroy: TSfmlShaderDestroy;
  SfmlShaderSetFloatParameter: TSfmlShaderSetFloatParameter;
  SfmlShaderSetFloat2Parameter: TSfmlShaderSetFloat2Parameter;
  SfmlShaderSetFloat3Parameter: TSfmlShaderSetFloat3Parameter;
  SfmlShaderSetFloat4Parameter: TSfmlShaderSetFloat4Parameter;
  SfmlShaderSetVector2Parameter: TSfmlShaderSetVector2Parameter;
  SfmlShaderSetVector3Parameter: TSfmlShaderSetVector3Parameter;
  SfmlShaderSetColorParameter: TSfmlShaderSetColorParameter;
  SfmlShaderSetTransformParameter: TSfmlShaderSetTransformParameter;
  SfmlShaderSetTextureParameter: TSfmlShaderSetTextureParameter;
  SfmlShaderSetCurrentTextureParameter: TSfmlShaderSetCurrentTextureParameter;
  SfmlShaderBind: TSfmlShaderBind;
  SfmlShaderIsAvailable: TSfmlShaderIsAvailable;

  SfmlShapeCreate: TSfmlShapeCreate;
  SfmlShapeDestroy: TSfmlShapeDestroy;
  SfmlShapeSetPosition: TSfmlShapeSetPosition;
  SfmlShapeSetRotation: TSfmlShapeSetRotation;
  SfmlShapeSetScale: TSfmlShapeSetScale;
  SfmlShapeSetOrigin: TSfmlShapeSetOrigin;
  SfmlShapeGetPosition: TSfmlShapeGetPosition;
  SfmlShapeGetRotation: TSfmlShapeGetRotation;
  SfmlShapeGetScale: TSfmlShapeGetScale;
  SfmlShapeGetOrigin: TSfmlShapeGetOrigin;
  SfmlShapeMove: TSfmlShapeMove;
  SfmlShapeRotate: TSfmlShapeRotate;
  SfmlShapeScale: TSfmlShapeScale;
  SfmlShapeGetTransform: TSfmlShapeGetTransform;
  SfmlShapeGetInverseTransform: TSfmlShapeGetInverseTransform;
  SfmlShapeSetTexture: TSfmlShapeSetTexture;
  SfmlShapeSetTextureRect: TSfmlShapeSetTextureRect;
  SfmlShapeSetFillColor: TSfmlShapeSetFillColor;
  SfmlShapeSetOutlineColor: TSfmlShapeSetOutlineColor;
  SfmlShapeSetOutlineThickness: TSfmlShapeSetOutlineThickness;
  SfmlShapeGetTexture: TSfmlShapeGetTexture;
  SfmlShapeGetTextureRect: TSfmlShapeGetTextureRect;
  SfmlShapeGetFillColor: TSfmlShapeGetFillColor;
  SfmlShapeGetOutlineColor: TSfmlShapeGetOutlineColor;
  SfmlShapeGetOutlineThickness: TSfmlShapeGetOutlineThickness;
  SfmlShapeGetPointCount: TSfmlShapeGetPointCount;
  SfmlShapeGetPoint: TSfmlShapeGetPoint;
  SfmlShapeGetLocalBounds: TSfmlShapeGetLocalBounds;
  SfmlShapeGetGlobalBounds: TSfmlShapeGetGlobalBounds;
  SfmlShapeUpdate: TSfmlShapeUpdate;

  SfmlSpriteCreate: TSfmlSpriteCreate;
  SfmlSpriteCopy: TSfmlSpriteCopy;
  SfmlSpriteDestroy: TSfmlSpriteDestroy;
  SfmlSpriteSetPosition: TSfmlSpriteSetPosition;
  SfmlSpriteSetRotation: TSfmlSpriteSetRotation;
  SfmlSpriteSetScale: TSfmlSpriteSetScale;
  SfmlSpriteSetOrigin: TSfmlSpriteSetOrigin;
  SfmlSpriteGetPosition: TSfmlSpriteGetPosition;
  SfmlSpriteGetRotation: TSfmlSpriteGetRotation;
  SfmlSpriteGetScale: TSfmlSpriteGetScale;
  SfmlSpriteGetOrigin: TSfmlSpriteGetOrigin;
  SfmlSpriteMove: TSfmlSpriteMove;
  SfmlSpriteRotate: TSfmlSpriteRotate;
  SfmlSpriteScale: TSfmlSpriteScale;
  SfmlSpriteGetTransform: TSfmlSpriteGetTransform;
  SfmlSpriteGetInverseTransform: TSfmlSpriteGetInverseTransform;
  SfmlSpriteSetTexture: TSfmlSpriteSetTexture;
  SfmlSpriteSetTextureRect: TSfmlSpriteSetTextureRect;
  SfmlSpriteSetColor: TSfmlSpriteSetColor;
  SfmlSpriteGetTexture: TSfmlSpriteGetTexture;
  SfmlSpriteGetTextureRect: TSfmlSpriteGetTextureRect;
  SfmlSpriteGetColor: TSfmlSpriteGetColor;
  SfmlSpriteGetLocalBounds: TSfmlSpriteGetLocalBounds;
  SfmlSpriteGetGlobalBounds: TSfmlSpriteGetGlobalBounds;

  SfmlTextCreate: TSfmlTextCreate;
  SfmlTextCopy: TSfmlTextCopy;
  SfmlTextDestroy: TSfmlTextDestroy;
  SfmlTextSetPosition: TSfmlTextSetPosition;
  SfmlTextSetRotation: TSfmlTextSetRotation;
  SfmlTextSetScale: TSfmlTextSetScale;
  SfmlTextSetOrigin: TSfmlTextSetOrigin;
  SfmlTextGetPosition: TSfmlTextGetPosition;
  SfmlTextGetRotation: TSfmlTextGetRotation;
  SfmlTextGetScale: TSfmlTextGetScale;
  SfmlTextGetOrigin: TSfmlTextGetOrigin;
  SfmlTextMove: TSfmlTextMove;
  SfmlTextRotate: TSfmlTextRotate;
  SfmlTextScale: TSfmlTextScale;
  SfmlTextGetTransform: TSfmlTextGetTransform;
  SfmlTextGetInverseTransform: TSfmlTextGetInverseTransform;
  SfmlTextSetString: TSfmlTextSetString;
  SfmlTextSetUnicodeString: TSfmlTextSetUnicodeString;
  SfmlTextSetFont: TSfmlTextSetFont;
  SfmlTextSetCharacterSize: TSfmlTextSetCharacterSize;
  SfmlTextSetStyle: TSfmlTextSetStyle;
  SfmlTextSetColor: TSfmlTextSetColor;
  SfmlTextGetString: TSfmlTextGetString;
  SfmlTextGetUnicodeString: TSfmlTextGetUnicodeString;
  SfmlTextGetFont: TSfmlTextGetFont;
  SfmlTextGetCharacterSize: TSfmlTextGetCharacterSize;
  SfmlTextGetStyle: TSfmlTextGetStyle;
  SfmlTextGetColor: TSfmlTextGetColor;
  SfmlTextFindCharacterPos: TSfmlTextFindCharacterPos;
  SfmlTextGetLocalBounds: TSfmlTextGetLocalBounds;
  SfmlTextGetGlobalBounds: TSfmlTextGetGlobalBounds;

  SfmlTextureCreate: TSfmlTextureCreate;
  SfmlTextureCreateFromFile: TSfmlTextureCreateFromFile;
  SfmlTextureCreateFromMemory: TSfmlTextureCreateFromMemory;
  SfmlTextureCreateFromStream: TSfmlTextureCreateFromStream;
  SfmlTextureCreateFromImage: TSfmlTextureCreateFromImage;
  SfmlTextureCopy: TSfmlTextureCopy;
  SfmlTextureDestroy: TSfmlTextureDestroy;
  SfmlTextureGetSize: TSfmlTextureGetSize;
  SfmlTextureCopyToImage: TSfmlTextureCopyToImage;
  SfmlTextureUpdateFromPixels: TSfmlTextureUpdateFromPixels;
  SfmlTextureUpdateFromImage: TSfmlTextureUpdateFromImage;
  SfmlTextureUpdateFromWindow: TSfmlTextureUpdateFromWindow;
  SfmlTextureUpdateFromRenderWindow: TSfmlTextureUpdateFromRenderWindow;
  SfmlTextureSetSmooth: TSfmlTextureSetSmooth;
  SfmlTextureIsSmooth: TSfmlTextureIsSmooth;
  SfmlTextureSetRepeated: TSfmlTextureSetRepeated;
  SfmlTextureIsRepeated: TSfmlTextureIsRepeated;
  SfmlTextureBind: TSfmlTextureBind;
  SfmlTextureGetMaximumSize: TsfmlTextureGetMaximumSize;

  SfmlTransformIdentity: TSfmlTransformIdentity;
  SfmlTransformFromMatrix: TSfmlTransformFromMatrix;
  SfmlTransformGetMatrix: TSfmlTransformGetMatrix;
  SfmlTransformGetInverse: TSfmlTransformGetInverse;
  SfmlTransformTransformPoint: TSfmlTransformTransformPoint;
  SfmlTransformTransformRect: TSfmlTransformTransformRect;
  SfmlTransformCombine: TSfmlTransformCombine;
  SfmlTransformTranslate: TSfmlTransformTranslate;
  SfmlTransformRotate: TSfmlTransformRotate;
  SfmlTransformRotateWithCenter: TSfmlTransformRotateWithCenter;
  SfmlTransformScale: TSfmlTransformScale;
  SfmlTransformScaleWithCenter: TSfmlTransformScaleWithCenter;

  SfmlTransformableCreate: TSfmlTransformableCreate;
  SfmlTransformableCopy: TSfmlTransformableCopy;
  SfmlTransformableDestroy: TSfmlTransformableDestroy;
  SfmlTransformableSetPosition: TSfmlTransformableSetPosition;
  SfmlTransformableSetRotation: TSfmlTransformableSetRotation;
  SfmlTransformableSetScale: TSfmlTransformableSetScale;
  SfmlTransformableSetOrigin: TSfmlTransformableSetOrigin;
  SfmlTransformableGetPosition: TSfmlTransformableGetPosition;
  SfmlTransformableGetRotation: TSfmlTransformableGetRotation;
  SfmlTransformableGetScale: TSfmlTransformableGetScale;
  SfmlTransformableGetOrigin: TSfmlTransformableGetOrigin;
  SfmlTransformableMove: TSfmlTransformableMove;
  SfmlTransformableRotate: TSfmlTransformableRotate;
  SfmlTransformableScale: TSfmlTransformableScale;
  SfmlTransformableGetTransform: TSfmlTransformableGetTransform;
  SfmlTransformableGetInverseTransform: TSfmlTransformableGetInverseTransform;

  SfmlVertexArrayCreate: TSfmlVertexArrayCreate;
  SfmlVertexArrayCopy: TSfmlVertexArrayCopy;
  SfmlVertexArrayDestroy: TSfmlVertexArrayDestroy;
  SfmlVertexArrayGetVertexCount: TSfmlVertexArrayGetVertexCount;
  SfmlVertexArrayGetVertex: TSfmlVertexArrayGetVertex;
  SfmlVertexArrayClear: TSfmlVertexArrayClear;
  SfmlVertexArrayResize: TSfmlVertexArrayResize;
  SfmlVertexArrayAppend: TSfmlVertexArrayAppend;
  SfmlVertexArraySetPrimitiveType: TSfmlVertexArraySetPrimitiveType;
  SfmlVertexArrayGetPrimitiveType: TSfmlVertexArrayGetPrimitiveType;
  SfmlVertexArrayGetBounds: TSfmlVertexArrayGetBounds;

  SfmlViewCreate: TSfmlViewCreate;
  SfmlViewCreateFromRect: TSfmlViewCreateFromRect;
  SfmlViewCopy: TSfmlViewCopy;
  SfmlViewDestroy: TSfmlViewDestroy;
  SfmlViewSetCenter: TSfmlViewSetCenter;
  SfmlViewSetSize: TSfmlViewSetSize;
  SfmlViewSetRotation: TSfmlViewSetRotation;
  SfmlViewSetViewport: TSfmlViewSetViewport;
  SfmlViewReset: TSfmlViewReset;
  SfmlViewGetCenter: TSfmlViewGetCenter;
  SfmlViewGetSize: TSfmlViewGetSize;
  SfmlViewGetRotation: TSfmlViewGetRotation;
  SfmlViewGetViewport: TSfmlViewGetViewport;
  SfmlViewMove: TSfmlViewMove;
  SfmlViewRotate: TSfmlViewRotate;
  SfmlViewZoom: TSfmlViewZoom;
{$ELSE}
const
  SfmlBlack: TSfmlColor = (r: 0; g: 0; b: 0; a: $FF);
  SfmlWhite: TSfmlColor = (r: $FF; g: $FF; b: $FF; a: $FF);
  SfmlRed: TSfmlColor = (r: $FF; g: 0; b: 0; a: $FF);
  SfmlGreen: TSfmlColor = (r: 0; g: $FF; b: 0; a: $FF);
  SfmlBlue: TSfmlColor = (r: 0; g: 0; b: $FF; a: $FF);
  SfmlYellow: TSfmlColor = (r: $FF; g: $FF; b: 0; a: $FF);
  SfmlMagenta: TSfmlColor = (r: $FF; g: 0; b: $FF; a: $FF);
  SfmlCyan: TSfmlColor = (r: 0; g: $FF; b: $FF; a: $FF);
  SfmlTransparent: TSfmlColor = (r: 0; g: 0; b: 0; a: 0);

  // static linking
  function SfmlBlendAlpha: TSfmlBlendMode; cdecl; external CSfmlGraphicsLibrary name 'sfBlendAlpha';
  function SfmlBlendAdd: TSfmlBlendMode; cdecl; external CSfmlGraphicsLibrary name 'sfBlendAdd';
  function SfmlBlendMultiply: TSfmlBlendMode; cdecl; external CSfmlGraphicsLibrary name 'sfBlendMultiply';
  function SfmlBlendNone: TSfmlBlendMode; cdecl; external CSfmlGraphicsLibrary name 'sfBlendNone';

  function SfmlColorFromRGB(Red, Green, Blue: Byte): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfColor_fromRGB';
  function SfmlColorFromRGBA(Red, Green, Blue, Alpha: Byte): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfColor_fromRGBA';
  function SfmlColorAdd(color1, color2: TSfmlColor): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfColor_add';
  function SfmlColorModulate(color1, color2: TSfmlColor): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfColor_modulate';

  function SfmlCircleShapeCreate: PSfmlCircleShape; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_create';
  function SfmlCircleShapeCopy(const Shape: PSfmlCircleShape): PSfmlCircleShape; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_copy';
  procedure SfmlCircleShapeDestroy(Shape: PSfmlCircleShape); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_destroy';
  procedure SfmlCircleShapeSetPosition(Shape: PSfmlCircleShape; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setPosition';
  procedure SfmlCircleShapeSetRotation(Shape: PSfmlCircleShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setRotation';
  procedure SfmlCircleShapeSetScale(Shape: PSfmlCircleShape; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setScale';
  procedure SfmlCircleShapeSetOrigin(Shape: PSfmlCircleShape; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setOrigin';
  function SfmlCircleShapeGetPosition(const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getPosition';
  function SfmlCircleShapeGetRotation(const Shape: PSfmlCircleShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getRotation';
  function SfmlCircleShapeGetScale(const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getScale';
  function SfmlCircleShapeGetOrigin(const Shape: PSfmlCircleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getOrigin';
  procedure SfmlCircleShapeMove(Shape: PSfmlCircleShape; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_move';
  procedure SfmlCircleShapeRotate(Shape: PSfmlCircleShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_rotate';
  procedure SfmlCircleShapeScale(Shape: PSfmlCircleShape; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_scale';
  function SfmlCircleShapeGetTransform(const Shape: PSfmlCircleShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getTransform';
  function SfmlCircleShapeGetInverseTransform(const Shape: PSfmlCircleShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getInverseTransform';
  procedure SfmlCircleShapeSetTexture(Shape: PSfmlCircleShape; const Texture: PSfmlTexture; resetRect: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setTexture';
  procedure SfmlCircleShapeSetTextureRect(Shape: PSfmlCircleShape; Rect: TSfmlIntRect); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setTextureRect';
  procedure SfmlCircleShapeSetFillColor(Shape: PSfmlCircleShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setFillColor';
  procedure SfmlCircleShapeSetOutlineColor(Shape: PSfmlCircleShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setOutlineColor';
  procedure SfmlCircleShapeSetOutlineThickness(Shape: PSfmlCircleShape; Thickness: Single); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setOutlineThickness';
  function SfmlCircleShapeGetTexture(const Shape: PSfmlCircleShape): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getTexture';
  function SfmlCircleShapeGetTextureRect(const Shape: PSfmlCircleShape): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getTextureRect';
  function SfmlCircleShapeGetFillColor(const Shape: PSfmlCircleShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getFillColor';
  function SfmlCircleShapeGetOutlineColor(const Shape: PSfmlCircleShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getOutlineColor';
  function SfmlCircleShapeGetOutlineThickness(const Shape: PSfmlCircleShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getOutlineThickness';
  function SfmlCircleShapeGetPointCount(const Shape: PSfmlCircleShape): Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getPointCount';
  function SfmlCircleShapeGetPoint(const Shape: PSfmlCircleShape; Index: Cardinal): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getPoint';
  procedure SfmlCircleShapeSetRadius(Shape: PSfmlCircleShape; Radius: Single); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setRadius';
  function SfmlCircleShapeGetRadius(const Shape: PSfmlCircleShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getRadius';
  procedure SfmlCircleShapeSetPointCount(Shape: PSfmlCircleShape; Count: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_setPointCount';
  function SfmlCircleShapeGetLocalBounds(const Shape: PSfmlCircleShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getLocalBounds';
  function SfmlCircleShapeGetGlobalBounds(const Shape: PSfmlCircleShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfCircleShape_getGlobalBounds';

  function SfmlConvexShapeCreate: PSfmlConvexShape; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_create';
  function SfmlConvexShapeCopy(const Shape: PSfmlConvexShape): PSfmlConvexShape; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_copy';
  procedure SfmlConvexShapeDestroy(Shape: PSfmlConvexShape); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_destroy';
  procedure SfmlConvexShapeSetPosition(Shape: PSfmlConvexShape; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setPosition';
  procedure SfmlConvexShapeSetRotation(Shape: PSfmlConvexShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setRotation';
  procedure SfmlConvexShapeSetScale(Shape: PSfmlConvexShape; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setScale';
  procedure SfmlConvexShapeSetOrigin(Shape: PSfmlConvexShape; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setOrigin';
  function SfmlConvexShapeGetPosition(const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getPosition';
  function SfmlConvexShapeGetRotation(const Shape: PSfmlConvexShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getRotation';
  function SfmlConvexShapeGetScale(const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getScale';
  function SfmlConvexShapeGetOrigin(const Shape: PSfmlConvexShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getOrigin';
  procedure SfmlConvexShapeMove(Shape: PSfmlConvexShape; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_move';
  procedure SfmlConvexShapeRotate(Shape: PSfmlConvexShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_rotate';
  procedure SfmlConvexShapeScale(Shape: PSfmlConvexShape; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_scale';
  function SfmlConvexShapeGetTransform(const Shape: PSfmlConvexShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getTransform';
  function SfmlConvexShapeGetInverseTransform(const Shape: PSfmlConvexShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getInverseTransform';
  procedure SfmlConvexShapeSetTexture(Shape: PSfmlConvexShape; const Texture: PSfmlTexture; ResetRect: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setTexture';
  procedure SfmlConvexShapeSetTextureRect(Shape: PSfmlConvexShape; Rect: TSfmlIntRect); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setTextureRect';
  procedure SfmlConvexShapeSetFillColor(Shape: PSfmlConvexShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setFillColor';
  procedure SfmlConvexShapeSetOutlineColor(Shape: PSfmlConvexShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setOutlineColor';
  procedure SfmlConvexShapeSetOutlineThickness(Shape: PSfmlConvexShape; Thickness: Single); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setOutlineThickness';
  function SfmlConvexShapeGetTexture(const Shape: PSfmlConvexShape): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getTexture';
  function SfmlConvexShapeGetTextureRect(const Shape: PSfmlConvexShape): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getTextureRect';
  function SfmlConvexShapeGetFillColor(const Shape: PSfmlConvexShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getFillColor';
  function SfmlConvexShapeGetOutlineColor(const Shape: PSfmlConvexShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getOutlineColor';
  function SfmlConvexShapeGetOutlineThickness(const Shape: PSfmlConvexShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getOutlineThickness';
  function SfmlConvexShapeGetPointCount(const Shape: PSfmlConvexShape): Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getPointCount';
  function SfmlConvexShapeGetPoint(const Shape: PSfmlConvexShape; Index: Cardinal): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getPoint';
  procedure SfmlConvexShapeSetPointCount(Shape: PSfmlConvexShape; Count: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setPointCount';
  procedure SfmlConvexShapeSetPoint(Shape: PSfmlConvexShape; Index: Cardinal; Point: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_setPoint';
  function SfmlConvexShapeGetLocalBounds(const Shape: PSfmlConvexShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getLocalBounds';
  function SfmlConvexShapeGetGlobalBounds(const Shape: PSfmlConvexShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfConvexShape_getGlobalBounds';

  function SfmlFontCreateFromFile(const FileName: PAnsiChar): PSfmlFont; cdecl; external CSfmlGraphicsLibrary name 'sfFont_createFromFile';
  function SfmlFontCreateFromMemory(const Data: Pointer; SizeInBytes: NativeUInt): PSfmlFont; cdecl; external CSfmlGraphicsLibrary name 'sfFont_createFromMemory';
  function SfmlFontCreateFromStream(const Stream: PSfmlInputStream): PSfmlFont; cdecl; external CSfmlGraphicsLibrary name 'sfFont_createFromStream';
  function SfmlFontCopy(const Font: PSfmlFont): PSfmlFont; cdecl; external CSfmlGraphicsLibrary name 'sfFont_copy';
  procedure SfmlFontDestroy(Font: PSfmlFont); cdecl; external CSfmlGraphicsLibrary name 'sfFont_destroy';
  function SfmlFontGetGlyph(Font: PSfmlFont; CodePoint: Cardinal; CharacterSize: Cardinal; Bold: Boolean): TSfmlGlyph; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getGlyph';
  function SfmlFontGetKerning(Font: PSfmlFont; First, second: Cardinal; CharacterSize: Cardinal): Single; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getKerning';
  function SfmlFontGetLineSpacing(Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getLineSpacing';
  function SfmlFontGetUnderlinePosition(Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getUnderlinePosition';
  function SfmlFontGetUnderlineThickness(Font: PSfmlFont; CharacterSize: Cardinal): Single; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getUnderlineThickness';
  function SfmlFontGetTexture(Font: PSfmlFont; CharacterSize: Cardinal): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getTexture';
  function SfmlFontGetInfo(const Font: PSfmlFont): TSfmlFontInfo; cdecl; external CSfmlGraphicsLibrary name 'sfFont_getInfo';

  function SfmlImageCreate(Width, Height: Cardinal): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_create';
  function SfmlImageCreateFromColor(Width, Height: Cardinal; Color: TSfmlColor): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_createFromColor';
  function SfmlImageCreateFromPixels(Width, Height: Cardinal; const Pixels: PByte): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_createFromPixels';
  function SfmlImageCreateFromFile(const FileName: PAnsiChar): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_createFromFile';
  function SfmlImageCreateFromMemory(const data: Pointer; Size: NativeUInt): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_createFromMemory';
  function SfmlImageCreateFromStream(const Stream: PSfmlInputStream): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_createFromStream';
  function SfmlImageCopy(const Image: PSfmlImage): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfImage_copy';
  procedure SfmlImageDestroy(Image: PSfmlImage); cdecl; external CSfmlGraphicsLibrary name 'sfImage_destroy';
  function SfmlImageSaveToFile(const Image: PSfmlImage; const FileName: PAnsiChar): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfImage_saveToFile';
  function SfmlImageGetSize(const Image: PSfmlImage): TSfmlVector2u; cdecl; external CSfmlGraphicsLibrary name 'sfImage_getSize';
  procedure SfmlImageCreateMaskFromColor(Image: PSfmlImage; Color: TSfmlColor; Alpha: Byte); cdecl; external CSfmlGraphicsLibrary name 'sfImage_createMaskFromColor';
  procedure SfmlImageCopyImage(Image: PSfmlImage; const source: PSfmlImage; destX, destY: Cardinal; sourceRect: TSfmlIntRect; applyAlpha: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfImage_copyImage';
  procedure SfmlImageSetPixel(Image: PSfmlImage; X, Y: Cardinal; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfImage_setPixel';
  function SfmlImageGetPixel(const Image: PSfmlImage; X, Y: Cardinal): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfImage_getPixel';
  function SfmlImageGetPixelsPtr(const Image: PSfmlImage): PByte; cdecl; external CSfmlGraphicsLibrary name 'sfImage_getPixelsPtr';
  procedure SfmlImageFlipHorizontally(Image: PSfmlImage); cdecl; external CSfmlGraphicsLibrary name 'sfImage_flipHorizontally';
  procedure SfmlImageFlipVertically(Image: PSfmlImage); cdecl; external CSfmlGraphicsLibrary name 'sfImage_flipVertically';

  function SfmlFloatRectContains(var Rect: TSfmlFloatRect; X, Y: Single): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfFloatRect_contains';
  function SfmlIntRectContains(var Rect: TSfmlIntRect; X, Y: LongInt): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfIntRect_contains';
  function SfmlFloatRectIntersects(var rect1, rect2: TSfmlFloatRect; var Intersection: TSfmlFloatRect): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfFloatRect_intersects';
  function SfmlIntRectIntersects(var rect1, rect2: TSfmlIntRect; var Intersection: TSfmlFloatRect): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfIntRect_intersects';

  function SfmlRectangleShapeCreate: PSfmlRectangleShape; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_create';
  function SfmlRectangleShapeCopy(const Shape: PSfmlRectangleShape): PSfmlRectangleShape; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_copy';
  procedure SfmlRectangleShapeDestroy(Shape: PSfmlRectangleShape); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_destroy';
  procedure SfmlRectangleShapeSetPosition(Shape: PSfmlRectangleShape; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setPosition';
  procedure SfmlRectangleShapeSetRotation(Shape: PSfmlRectangleShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setRotation';
  procedure SfmlRectangleShapeSetScale(Shape: PSfmlRectangleShape; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setScale';
  procedure SfmlRectangleShapeSetOrigin(Shape: PSfmlRectangleShape; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setOrigin';
  function SfmlRectangleShapeGetPosition(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getPosition';
  function SfmlRectangleShapeGetRotation(const Shape: PSfmlRectangleShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getRotation';
  function SfmlRectangleShapeGetScale(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getScale';
  function SfmlRectangleShapeGetOrigin(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getOrigin';
  procedure SfmlRectangleShapeMove(Shape: PSfmlRectangleShape; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_move';
  procedure SfmlRectangleShapeRotate(Shape: PSfmlRectangleShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_rotate';
  procedure SfmlRectangleShapeScale(Shape: PSfmlRectangleShape; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_scale';
  function SfmlRectangleShapeGetTransform(const Shape: PSfmlRectangleShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getTransform';
  function SfmlRectangleShapeGetInverseTransform(const Shape: PSfmlRectangleShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getInverseTransform';
  procedure SfmlRectangleShapeSetTexture(Shape: PSfmlRectangleShape; const Texture: PSfmlTexture; resetRect: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setTexture';
  procedure SfmlRectangleShapeSetTextureRect(Shape: PSfmlRectangleShape; rect: TSfmlIntRect); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setTextureRect';
  procedure SfmlRectangleShapeSetFillColor(Shape: PSfmlRectangleShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setFillColor';
  procedure SfmlRectangleShapeSetOutlineColor(Shape: PSfmlRectangleShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setOutlineColor';
  procedure SfmlRectangleShapeSetOutlineThickness(Shape: PSfmlRectangleShape; Thickness: Single); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setOutlineThickness';
  function SfmlRectangleShapeGetTexture(const Shape: PSfmlRectangleShape): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getTexture';
  function SfmlRectangleShapeGetTextureRect(const Shape: PSfmlRectangleShape): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getTextureRect';
  function SfmlRectangleShapeGetFillColor(const Shape: PSfmlRectangleShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getFillColor';
  function SfmlRectangleShapeGetOutlineColor(const Shape: PSfmlRectangleShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getOutlineColor';
  function SfmlRectangleShapeGetOutlineThickness(const Shape: PSfmlRectangleShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getOutlineThickness';
  function SfmlRectangleShapeGetPointCount(const Shape: PSfmlRectangleShape): Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getPointCount';
  function SfmlRectangleShapeGetPoint(const Shape: PSfmlRectangleShape; Index: Cardinal): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getPoint';
  procedure SfmlRectangleShapeSetSize(Shape: PSfmlRectangleShape; Size: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_setSize';
  function SfmlRectangleShapeGetSize(const Shape: PSfmlRectangleShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getSize';
  function SfmlRectangleShapeGetLocalBounds(const Shape: PSfmlRectangleShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getLocalBounds';
  function SfmlRectangleShapeGetGlobalBounds(const Shape: PSfmlRectangleShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfRectangleShape_getGlobalBounds';

  function SfmlRenderTextureCreate(Width, Height: Cardinal; depthBuffer: Boolean): PSfmlRenderTexture; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_create';
  procedure SfmlRenderTextureDestroy(RenderTexture: PSfmlRenderTexture); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_destroy';
  function SfmlRenderTextureGetSize(const RenderTexture: PSfmlRenderTexture): TSfmlVector2u; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_getSize';
  function SfmlRenderTextureSetActive(RenderTexture: PSfmlRenderTexture; Active: Boolean): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_setActive';
  procedure SfmlRenderTextureDisplay(RenderTexture: PSfmlRenderTexture); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_display';
  procedure SfmlRenderTextureClear(RenderTexture: PSfmlRenderTexture; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_clear';
  procedure SfmlRenderTextureSetView(RenderTexture: PSfmlRenderTexture; const View: PSfmlView); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_setView';
  function SfmlRenderTextureGetView(const RenderTexture: PSfmlRenderTexture): PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_getView';
  function SfmlRenderTextureGetDefaultView(const RenderTexture: PSfmlRenderTexture): PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_getDefaultView';
  function SfmlRenderTextureGetViewport(const RenderTexture: PSfmlRenderTexture; const View: PSfmlView): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_getViewport';
  function SfmlRenderTextureMapPixelToCoords(const RenderTexture: PSfmlRenderTexture; point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_mapPixelToCoords';
  function SfmlRenderTextureMapCoordsToPixel(const RenderTexture: PSfmlRenderTexture; point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_mapCoordsToPixel';
  procedure SfmlRenderTextureDrawSprite(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlSprite; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawSprite';
  procedure SfmlRenderTextureDrawText(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlText; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawText';
  procedure SfmlRenderTextureDrawShape(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawShape';
  procedure SfmlRenderTextureDrawCircleShape(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlCircleShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawCircleShape';
  procedure SfmlRenderTextureDrawConvexShape(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlConvexShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawConvexShape';
  procedure SfmlRenderTextureDrawRectangleShape(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawRectangleShape';
  procedure SfmlRenderTextureDrawVertexArray(RenderTexture: PSfmlRenderTexture; const &Object: PSfmlVertexArray; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawVertexArray';
  procedure SfmlRenderTextureDrawPrimitives(RenderTexture: PSfmlRenderTexture); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_drawPrimitives';
  procedure SfmlRenderTexturePushGLStates(RenderTexture: PSfmlRenderTexture); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_pushGLStates';
  procedure SfmlRenderTexturePopGLStates(RenderTexture: PSfmlRenderTexture); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_popGLStates';
  procedure SfmlRenderTextureResetGLStates(RenderTexture: PSfmlRenderTexture); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_resetGLStates';
  function SfmlRenderTextureGetTexture(const RenderTexture: PSfmlRenderTexture): PSfmlTexture ; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_getTexture';
  procedure SfmlRenderTextureSetSmooth(RenderTexture: PSfmlRenderTexture; Smooth: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_setSmooth';
  function SfmlRenderTextureIsSmooth(const RenderTexture: PSfmlRenderTexture): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_isSmooth';
  procedure SfmlRenderTextureSetRepeated(RenderTexture: PSfmlRenderTexture; Repeated: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_setRepeated';
  function SfmlRenderTextureIsRepeated(const RenderTexture: PSfmlRenderTexture): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfRenderTexture_isRepeated';

  function SfmlRenderWindowCreate(Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_create';
  function SfmlRenderWindowCreateUnicode(Mode: TSfmlVideoMode; const Title: PWideChar; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_createUnicode';
  function SfmlRenderWindowCreateFromHandle(Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings): PSfmlRenderWindow; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_createFromHandle';
  procedure SfmlRenderWindowDestroy(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_destroy';
  procedure SfmlRenderWindowClose(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_close';
  function SfmlRenderWindowIsOpen(const RenderWindow: PSfmlRenderWindow): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_isOpen';
  function SfmlRenderWindowGetSettings(const RenderWindow: PSfmlRenderWindow): TSfmlContextSettings; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getSettings';
  function SfmlRenderWindowPollEvent(RenderWindow: PSfmlRenderWindow; Event: PSfmlEvent): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_pollEvent';
  function SfmlRenderWindowWaitEvent(RenderWindow: PSfmlRenderWindow; Event: PSfmlEvent): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_waitEvent';
  function SfmlRenderWindowGetPosition(const RenderWindow: PSfmlRenderWindow): TSfmlVector2i; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getPosition';
  procedure SfmlRenderWindowSetPosition(RenderWindow: PSfmlRenderWindow; Position: TSfmlVector2i); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setPosition';
  function SfmlRenderWindowGetSize(const RenderWindow: PSfmlRenderWindow): TSfmlVector2u; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getSize';
  procedure SfmlRenderWindowSetSize(RenderWindow: PSfmlRenderWindow; Size: TSfmlVector2u); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setSize';
  procedure SfmlRenderWindowSetTitle(RenderWindow: PSfmlRenderWindow; const Title: PAnsiChar); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setTitle';
  procedure SfmlRenderWindowSetUnicodeTitle(RenderWindow: PSfmlRenderWindow; const Title: PWideChar); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setUnicodeTitle';
  procedure SfmlRenderWindowSetIcon(RenderWindow: PSfmlRenderWindow; Width, Height: Cardinal; const Pixels: PByte); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setIcon';
  procedure SfmlRenderWindowSetVisible(RenderWindow: PSfmlRenderWindow; Visible: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setVisible';
  procedure SfmlRenderWindowSetMouseCursorVisible(RenderWindow: PSfmlRenderWindow; show: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setMouseCursorVisible';
  procedure SfmlRenderWindowSetVerticalSyncEnabled(RenderWindow: PSfmlRenderWindow; enabled: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setVerticalSyncEnabled';
  procedure SfmlRenderWindowSetKeyRepeatEnabled(RenderWindow: PSfmlRenderWindow; enabled: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setKeyRepeatEnabled';
  function SfmlRenderWindowSetActive(RenderWindow: PSfmlRenderWindow; Active: Boolean): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setActive';
  procedure SfmlRenderWindowRequestFocus(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_requestFocus';
  function SfmlRenderWindowHasFocus(const RenderWindow: PSfmlRenderWindow): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_hasFocus';
  procedure SfmlRenderWindowDisplay(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_display';
  procedure SfmlRenderWindowSetFramerateLimit(RenderWindow: PSfmlRenderWindow; Limit: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setFramerateLimit';
  procedure SfmlRenderWindowSetJoystickThreshold(RenderWindow: PSfmlRenderWindow; Threshold: Single); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setJoystickThreshold';
  function SfmlRenderWindowGetSystemHandle(const RenderWindow: PSfmlRenderWindow): TSfmlWindowHandle; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getSystemHandle';
  procedure SfmlRenderWindowClear(RenderWindow: PSfmlRenderWindow; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_clear';
  procedure SfmlRenderWindowSetView(RenderWindow: PSfmlRenderWindow; const View: PSfmlView); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_setView';
  function SfmlRenderWindowGetView(const RenderWindow: PSfmlRenderWindow): PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getView';
  function SfmlRenderWindowGetDefaultView(const RenderWindow: PSfmlRenderWindow): PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getDefaultView';
  function SfmlRenderWindowGetViewport(const RenderWindow: PSfmlRenderWindow; const View: PSfmlView): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_getViewport';
  function SfmlRenderWindowMapPixelToCoords(const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_mapPixelToCoords';
  function SfmlRenderWindowMapCoordsToPixel(const RenderWindow: PSfmlRenderWindow; Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_mapCoordsToPixel';
  procedure SfmlRenderWindowDrawSprite(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlSprite; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawSprite';
  procedure SfmlRenderWindowDrawText(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlText; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawText';
  procedure SfmlRenderWindowDrawShape(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawShape';
  procedure SfmlRenderWindowDrawCircleShape(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlCircleShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawCircleShape';
  procedure SfmlRenderWindowDrawConvexShape(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlConvexShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawConvexShape';
  procedure SfmlRenderWindowDrawRectangleShape(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawRectangleShape';
  procedure SfmlRenderWindowDrawVertexArray(RenderWindow: PSfmlRenderWindow; const &Object: PSfmlVertexArray; const States: PSfmlRenderStates); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawVertexArray';
  procedure SfmlRenderWindowDrawPrimitives(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_drawPrimitives';
  procedure SfmlRenderWindowPushGLStates(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_pushGLStates';
  procedure SfmlRenderWindowPopGLStates(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_popGLStates';
  procedure SfmlRenderWindowResetGLStates(RenderWindow: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_resetGLStates';
  function SfmlRenderWindowCapture(const RenderWindow: PSfmlRenderWindow): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfRenderWindow_capture';
  function SfmlMouseGetPositionRenderWindow(const relativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl; external CSfmlGraphicsLibrary name 'sfMouseGetPosi_TionRenderWindow';
  procedure SfmlMouseSetPositionRenderWindow(position: TSfmlVector2i; const RelativeTo: PSfmlRenderWindow); cdecl; external CSfmlGraphicsLibrary name 'sfMouseSetPosi_TionRenderWindow';
  function SfmlTouchGetPositionRenderWindow(Finger: Cardinal; const RelativeTo: PSfmlRenderWindow): TSfmlVector2i; cdecl; external CSfmlGraphicsLibrary name 'sfTouchGetPosi_TionRenderWindow';

  function SfmlShaderCreateFromFile(const VertexShaderFilename: PAnsiChar; const FragmentShaderFilename: PAnsiChar): PSfmlShader; cdecl; external CSfmlGraphicsLibrary name 'sfShader_createFromFile';
  function SfmlShaderCreateFromMemory(const VertexShader: PAnsiChar; const FragmentShader: PAnsiChar): PSfmlShader; cdecl; external CSfmlGraphicsLibrary name 'sfShader_createFromMemory';
  function SfmlShaderCreateFromStream(VertexShaderStream: PSfmlInputStream; FragmentShaderStream: PSfmlInputStream): PSfmlShader; cdecl; external CSfmlGraphicsLibrary name 'sfShader_createFromStream';
  procedure SfmlShaderDestroy(Shader: PSfmlShader); cdecl; external CSfmlGraphicsLibrary name 'sfShader_destroy';
  procedure SfmlShaderSetFloatParameter(Shader: PSfmlShader; const Name: PAnsiChar; X: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setFloatParameter';
  procedure SfmlShaderSetFloat2Parameter(Shader: PSfmlShader; const Name: PAnsiChar; X, Y: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setFloat2Parameter';
  procedure SfmlShaderSetFloat3Parameter(Shader: PSfmlShader; const Name: PAnsiChar; X, Y, Z: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setFloat3Parameter';
  procedure SfmlShaderSetFloat4Parameter(Shader: PSfmlShader; const Name: PAnsiChar; X, Y, Z, W: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setFloat4Parameter';
  procedure SfmlShaderSetVector2Parameter(Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setVector2Parameter';
  procedure SfmlShaderSetVector3Parameter(Shader: PSfmlShader; const Name: PAnsiChar; Vector: TSfmlVector3f); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setVector3Parameter';
  procedure SfmlShaderSetColorParameter(Shader: PSfmlShader; const Name: PAnsiChar; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setColorParameter';
  procedure SfmlShaderSetTransformParameter(Shader: PSfmlShader; const Name: PAnsiChar; Transform: TSfmlTransform); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setTransformParameter';
  procedure SfmlShaderSetTextureParameter(Shader: PSfmlShader; const Name: PAnsiChar; const Texture: PSfmlTexture); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setTextureParameter';
  procedure SfmlShaderSetCurrentTextureParameter(Shader: PSfmlShader; const Name: PAnsiChar); cdecl; external CSfmlGraphicsLibrary name 'sfShader_setCurrentTextureParameter';
  procedure SfmlShaderBind(const Shader: PSfmlShader); cdecl; external CSfmlGraphicsLibrary name 'sfShader_bind';
  function SfmlShaderIsAvailable: Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfShader_isAvailable';

  function SfmlShapeCreate(getPointCount: TSfmlShapeGetPointCountCallback; GetPoint: TSfmlShapeGetPointCallback; UserData: Pointer): PSfmlShape; cdecl; external CSfmlGraphicsLibrary name 'sfShape_create';
  procedure SfmlShapeDestroy(Shape: PSfmlShape); cdecl; external CSfmlGraphicsLibrary name 'sfShape_destroy';
  procedure SfmlShapeSetPosition(Shape: PSfmlShape; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setPosition';
  procedure SfmlShapeSetRotation(Shape: PSfmlShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setRotation';
  procedure SfmlShapeSetScale(Shape: PSfmlShape; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setScale';
  procedure SfmlShapeSetOrigin(Shape: PSfmlShape; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setOrigin';
  function SfmlShapeGetPosition(const Shape: PSfmlShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getPosition';
  function SfmlShapeGetRotation(const Shape: PSfmlShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getRotation';
  function SfmlShapeGetScale(const Shape: PSfmlShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getScale';
  function SfmlShapeGetOrigin(const Shape: PSfmlShape): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getOrigin';
  procedure SfmlShapeMove(Shape: PSfmlShape; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfShape_move';
  procedure SfmlShapeRotate(Shape: PSfmlShape; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShape_rotate';
  procedure SfmlShapeScale(Shape: PSfmlShape; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfShape_scale';
  function SfmlShapeGetTransform(const Shape: PSfmlShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getTransform';
  function SfmlShapeGetInverseTransform(const Shape: PSfmlShape): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getInverseTransform';
  procedure SfmlShapeSetTexture(Shape: PSfmlShape; const Texture: PSfmlTexture; ResetRect: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setTexture';
  procedure SfmlShapeSetTextureRect(Shape: PSfmlShape; Rect: TSfmlIntRect); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setTextureRect';
  procedure SfmlShapeSetFillColor(Shape: PSfmlShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setFillColor';
  procedure SfmlShapeSetOutlineColor(Shape: PSfmlShape; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setOutlineColor';
  procedure SfmlShapeSetOutlineThickness(Shape: PSfmlShape; Thickness: Single); cdecl; external CSfmlGraphicsLibrary name 'sfShape_setOutlineThickness';
  function SfmlShapeGetTexture(const Shape: PSfmlShape): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getTexture';
  function SfmlShapeGetTextureRect(const Shape: PSfmlShape): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getTextureRect';
  function SfmlShapeGetFillColor(const Shape: PSfmlShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getFillColor';
  function SfmlShapeGetOutlineColor(const Shape: PSfmlShape): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getOutlineColor';
  function SfmlShapeGetOutlineThickness(const Shape: PSfmlShape): Single; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getOutlineThickness';
  function SfmlShapeGetPointCount(const Shape: PSfmlShape): Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getPointCount';
  function SfmlShapeGetPoint(const Shape: PSfmlShape; Index: Cardinal): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getPoint';
  function SfmlShapeGetLocalBounds(const Shape: PSfmlShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getLocalBounds';
  function SfmlShapeGetGlobalBounds(const Shape: PSfmlShape): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfShape_getGlobalBounds';
  procedure SfmlShapeUpdate(Shape: PSfmlShape); cdecl; external CSfmlGraphicsLibrary name 'sfShape_update';

  function SfmlSpriteCreate: PSfmlSprite; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_create';
  function SfmlSpriteCopy(const Sprite: PSfmlSprite): PSfmlSprite; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_copy';
  procedure SfmlSpriteDestroy(Sprite: PSfmlSprite); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_destroy';
  procedure SfmlSpriteSetPosition(Sprite: PSfmlSprite; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setPosition';
  procedure SfmlSpriteSetRotation(Sprite: PSfmlSprite; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setRotation';
  procedure SfmlSpriteSetScale(Sprite: PSfmlSprite; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setScale';
  procedure SfmlSpriteSetOrigin(Sprite: PSfmlSprite; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setOrigin';
  function SfmlSpriteGetPosition(const Sprite: PSfmlSprite): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getPosition';
  function SfmlSpriteGetRotation(const Sprite: PSfmlSprite): Single; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getRotation';
  function SfmlSpriteGetScale(const Sprite: PSfmlSprite): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getScale';
  function SfmlSpriteGetOrigin(const Sprite: PSfmlSprite): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getOrigin';
  procedure SfmlSpriteMove(Sprite: PSfmlSprite; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_move';
  procedure SfmlSpriteRotate(Sprite: PSfmlSprite; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_rotate';
  procedure SfmlSpriteScale(Sprite: PSfmlSprite; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_scale';
  function SfmlSpriteGetTransform(const Sprite: PSfmlSprite): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getTransform';
  function SfmlSpriteGetInverseTransform(const Sprite: PSfmlSprite): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getInverseTransform';
  procedure SfmlSpriteSetTexture(Sprite: PSfmlSprite; const Texture: PSfmlTexture; resetRect: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setTexture';
  procedure SfmlSpriteSetTextureRect(Sprite: PSfmlSprite; Rectangle: TSfmlIntRect); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setTextureRect';
  procedure SfmlSpriteSetColor(Sprite: PSfmlSprite; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfSprite_setColor';
  function SfmlSpriteGetTexture(const Sprite: PSfmlSprite): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getTexture';
  function SfmlSpriteGetTextureRect(const Sprite: PSfmlSprite): TSfmlIntRect; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getTextureRect';
  function SfmlSpriteGetColor(const Sprite: PSfmlSprite): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getColor';
  function SfmlSpriteGetLocalBounds(const Sprite: PSfmlSprite): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getLocalBounds';
  function SfmlSpriteGetGlobalBounds(const Sprite: PSfmlSprite): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfSprite_getGlobalBounds';

  function SfmlTextCreate: PSfmlText; cdecl; external CSfmlGraphicsLibrary name 'sfText_create';
  function SfmlTextCopy(const Text: PSfmlText): PSfmlText; cdecl; external CSfmlGraphicsLibrary name 'sfText_copy';
  procedure SfmlTextDestroy(Text: PSfmlText); cdecl; external CSfmlGraphicsLibrary name 'sfText_destroy';
  procedure SfmlTextSetPosition(Text: PSfmlText; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfText_setPosition';
  procedure SfmlTextSetRotation(Text: PSfmlText; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfText_setRotation';
  procedure SfmlTextSetScale(Text: PSfmlText; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfText_setScale';
  procedure SfmlTextSetOrigin(Text: PSfmlText; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfText_setOrigin';
  function SfmlTextGetPosition(const Text: PSfmlText): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfText_getPosition';
  function SfmlTextGetRotation(const Text: PSfmlText): Single; cdecl; external CSfmlGraphicsLibrary name 'sfText_getRotation';
  function SfmlTextGetScale(const Text: PSfmlText): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfText_getScale';
  function SfmlTextGetOrigin(const Text: PSfmlText): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfText_getOrigin';
  procedure SfmlTextMove(Text: PSfmlText; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfText_move';
  procedure SfmlTextRotate(Text: PSfmlText; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfText_rotate';
  procedure SfmlTextScale(Text: PSfmlText; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfText_scale';
  function SfmlTextGetTransform(const Text: PSfmlText): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfText_getTransform';
  function SfmlTextGetInverseTransform(const Text: PSfmlText): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfText_getInverseTransform';
  procedure SfmlTextSetString(Text: PSfmlText; const &string: PAnsiChar); cdecl; external CSfmlGraphicsLibrary name 'sfText_setString';
  procedure SfmlTextSetUnicodeString(Text: PSfmlText; const &string: PWideChar); cdecl; external CSfmlGraphicsLibrary name 'sfText_setUnicodeString';
  procedure SfmlTextSetFont(Text: PSfmlText; const Font: PSfmlFont); cdecl; external CSfmlGraphicsLibrary name 'sfText_setFont';
  procedure SfmlTextSetCharacterSize(Text: PSfmlText; Size: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfText_setCharacterSize';
  procedure SfmlTextSetStyle(Text: PSfmlText; Style: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfText_setStyle';
  procedure SfmlTextSetColor(Text: PSfmlText; Color: TSfmlColor); cdecl; external CSfmlGraphicsLibrary name 'sfText_setColor';
  function SfmlTextGetString(const Text: PSfmlText): PAnsiChar; cdecl; external CSfmlGraphicsLibrary name 'sfText_getString';
  function SfmlTextGetUnicodeString(const Text: PSfmlText): PWideChar; cdecl; external CSfmlGraphicsLibrary name 'sfText_getUnicodeString';
  function SfmlTextGetFont(const Text: PSfmlText): PSfmlFont; cdecl; external CSfmlGraphicsLibrary name 'sfText_getFont';
  function SfmlTextGetCharacterSize(const Text: PSfmlText): Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfText_getCharacterSize';
  function SfmlTextGetStyle(const Text: PSfmlText): Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfText_getStyle';
  function SfmlTextGetColor(const Text: PSfmlText): TSfmlColor; cdecl; external CSfmlGraphicsLibrary name 'sfText_getColor';
  function SfmlTextFindCharacterPos(const Text: PSfmlText; Index: NativeUInt): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfText_findCharacterPos';
  function SfmlTextGetLocalBounds(const Text: PSfmlText): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfText_getLocalBounds';
  function SfmlTextGetGlobalBounds(const Text: PSfmlText): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfText_getGlobalBounds';

  function SfmlTextureCreate(Width, Height: Cardinal): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_create';
  function SfmlTextureCreateFromFile(const FileName: PAnsiChar; const Area: PSfmlIntRect): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_createFromFile';
  function SfmlTextureCreateFromMemory(const data: Pointer; SizeInBytes: NativeUInt; const Area: PSfmlIntRect): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_createFromMemory';
  function SfmlTextureCreateFromStream(Stream: PSfmlInputStream; const Area: PSfmlIntRect): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_createFromStream';
  function SfmlTextureCreateFromImage(const Image: PSfmlImage; const Area: PSfmlIntRect): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_createFromImage';
  function SfmlTextureCopy(const Texture: PSfmlTexture): PSfmlTexture; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_copy';
  procedure SfmlTextureDestroy(Texture: PSfmlTexture); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_destroy';
  function SfmlTextureGetSize(const Texture: PSfmlTexture): TSfmlVector2u; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_getSize';
  function SfmlTextureCopyToImage(const Texture: PSfmlTexture): PSfmlImage; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_copyToImage';
  procedure SfmlTextureUpdateFromPixels(Texture: PSfmlTexture; const Pixels: PByte; Width, Height, X, Y: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_updateFromPixels';
  procedure SfmlTextureUpdateFromImage(Texture: PSfmlTexture; const Image: PSfmlImage; X, Y: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_updateFromImage';
  procedure SfmlTextureUpdateFromWindow(Texture: PSfmlTexture; const Window: PSfmlWindow; X, Y: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_updateFromWindow';
  procedure SfmlTextureUpdateFromRenderWindow(Texture: PSfmlTexture; const RenderWindow: PSfmlRenderWindow; X, Y: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_updateFromRenderWindow';
  procedure SfmlTextureSetSmooth(Texture: PSfmlTexture; Smooth: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_setSmooth';
  function SfmlTextureIsSmooth(const Texture: PSfmlTexture): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_isSmooth';
  procedure SfmlTextureSetRepeated(Texture: PSfmlTexture; Repeated: Boolean); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_setRepeated';
  function SfmlTextureIsRepeated(const Texture: PSfmlTexture): Boolean; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_isRepeated';
  procedure SfmlTextureBind(const Texture: PSfmlTexture); cdecl; external CSfmlGraphicsLibrary name 'sfTexture_bind';
  function sfmlTextureGetMaximumSize: Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfTexture_getMaximumSize';

  function SfmlTransformIdentity: TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfTransform_identity';
  function SfmlTransformFromMatrix(a00, a01, a02, a10, a11, a12, a20, a21, a22: Single): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfTransform_fromMatrix';
  procedure SfmlTransformGetMatrix(const Transform: PSfmlTransform; Matrix: PSingle); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_getMatrix';
  function SfmlTransformGetInverse(const Transform: PSfmlTransform): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfTransform_getInverse';
  function SfmlTransformTransformPoint(const Transform: PSfmlTransform; Point: TSfmlVector2f): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfTransform_transformPoint';
  function SfmlTransformTransformRect(const Transform: PSfmlTransform; Rectangle: TSfmlFloatRect): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfTransform_transformRect';
  procedure SfmlTransformCombine(Transform: PSfmlTransform; const Other: PSfmlTransform); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_combine';
  procedure SfmlTransformTranslate(Transform: PSfmlTransform; X, Y: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_translate';
  procedure SfmlTransformRotate(Transform: PSfmlTransform; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_rotate';
  procedure SfmlTransformRotateWithCenter(Transform: PSfmlTransform; Angle: Single; centerX, centerY: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_rotateWithCenter';
  procedure SfmlTransformScale(Transform: PSfmlTransform; ScaleX, ScaleY: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_scale';
  procedure SfmlTransformScaleWithCenter(Transform: PSfmlTransform; ScaleX, ScaleY, CenterX, CenterY: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransform_scaleWithCenter';

  function SfmlTransformableCreate: PSfmlTransformable; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_create';
  function SfmlTransformableCopy(const Transformable: PSfmlTransformable): PSfmlTransformable; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_copy';
  procedure SfmlTransformableDestroy(Transformable: PSfmlTransformable); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_destroy';
  procedure SfmlTransformableSetPosition(Transformable: PSfmlTransformable; Position: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_setPosition';
  procedure SfmlTransformableSetRotation(Transformable: PSfmlTransformable; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_setRotation';
  procedure SfmlTransformableSetScale(Transformable: PSfmlTransformable; Scale: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_setScale';
  procedure SfmlTransformableSetOrigin(Transformable: PSfmlTransformable; Origin: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_setOrigin';
  function SfmlTransformableGetPosition(const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_getPosition';
  function SfmlTransformableGetRotation(const Transformable: PSfmlTransformable): Single; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_getRotation';
  function SfmlTransformableGetScale(const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_getScale';
  function SfmlTransformableGetOrigin(const Transformable: PSfmlTransformable): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_getOrigin';
  procedure SfmlTransformableMove(Transformable: PSfmlTransformable; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_move';
  procedure SfmlTransformableRotate(Transformable: PSfmlTransformable; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_rotate';
  procedure SfmlTransformableScale(Transformable: PSfmlTransformable; Factors: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_scale';
  function SfmlTransformableGetTransform(const Transformable: PSfmlTransformable): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_getTransform';
  function SfmlTransformableGetInverseTransform(const Transformable: PSfmlTransformable): TSfmlTransform; cdecl; external CSfmlGraphicsLibrary name 'sfTransformable_getInverseTransform';

  function SfmlVertexArrayCreate: PSfmlVertexArray; cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_create';
  function SfmlVertexArrayCopy(const VertexArray: PSfmlVertexArray): PSfmlVertexArray; cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_copy';
  procedure SfmlVertexArrayDestroy(VertexArray: PSfmlVertexArray); cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_destroy';
  function SfmlVertexArrayGetVertexCount(const VertexArray: PSfmlVertexArray): Cardinal; cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_getVertexCount';
  function SfmlVertexArrayGetVertex(VertexArray: PSfmlVertexArray; Index: Cardinal): PSfmlVertex; cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_getVertex';
  procedure SfmlVertexArrayClear(VertexArray: PSfmlVertexArray); cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_clear';
  procedure SfmlVertexArrayResize(VertexArray: PSfmlVertexArray; VertexCount: Cardinal); cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_resize';
  procedure SfmlVertexArrayAppend(VertexArray: PSfmlVertexArray; Vertex: TSfmlVertex); cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_append';
  procedure SfmlVertexArraySetPrimitiveType(VertexArray: PSfmlVertexArray; &Type: TSfmlPrimitiveType); cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_setPrimitiveType';
  function SfmlVertexArrayGetPrimitiveType(VertexArray: PSfmlVertexArray): TSfmlPrimitiveType; cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_getPrimitiveType';
  function SfmlVertexArrayGetBounds(VertexArray: PSfmlVertexArray): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfVertexArray_getBounds';

  function SfmlViewCreate: PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfView_create';
  function SfmlViewCreateFromRect(Rectangle: TSfmlFloatRect): PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfView_createFromRect';
  function SfmlViewCopy(const View: PSfmlView): PSfmlView; cdecl; external CSfmlGraphicsLibrary name 'sfView_copy';
  procedure SfmlViewDestroy(View: PSfmlView); cdecl; external CSfmlGraphicsLibrary name 'sfView_destroy';
  procedure SfmlViewSetCenter(View: PSfmlView; Center: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfView_setCenter';
  procedure SfmlViewSetSize(View: PSfmlView; Size: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfView_setSize';
  procedure SfmlViewSetRotation(View: PSfmlView; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfView_setRotation';
  procedure SfmlViewSetViewport(View: PSfmlView; Viewport: TSfmlFloatRect); cdecl; external CSfmlGraphicsLibrary name 'sfView_setViewport';
  procedure SfmlViewReset(View: PSfmlView; Rectangle: TSfmlFloatRect); cdecl; external CSfmlGraphicsLibrary name 'sfView_reset';
  function SfmlViewGetCenter(const View: PSfmlView): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfView_getCenter';
  function SfmlViewGetSize(const View: PSfmlView): TSfmlVector2f; cdecl; external CSfmlGraphicsLibrary name 'sfView_getSize';
  function SfmlViewGetRotation(const View: PSfmlView): Single; cdecl; external CSfmlGraphicsLibrary name 'sfView_getRotation';
  function SfmlViewGetViewport(const View: PSfmlView): TSfmlFloatRect; cdecl; external CSfmlGraphicsLibrary name 'sfView_getViewport';
  procedure SfmlViewMove(View: PSfmlView; Offset: TSfmlVector2f); cdecl; external CSfmlGraphicsLibrary name 'sfView_move';
  procedure SfmlViewRotate(View: PSfmlView; Angle: Single); cdecl; external CSfmlGraphicsLibrary name 'sfView_rotate';
  procedure SfmlViewZoom(View: PSfmlView; Factor: Single); cdecl; external CSfmlGraphicsLibrary name 'sfView_zoom';
{$ENDIF}

type
  TSfmlCircleShape = class
  private
    FHandle: PSfmlCircleShape;
    function GetFillColor: TSfmlColor;
    function GetGlobalBounds: TSfmlFloatRect;
    function GetInverseTransform: TSfmlTransform;
    function GetLocalBounds: TSfmlFloatRect;
    function GetOrigin: TSfmlVector2f;
    function GetOutlineColor: TSfmlColor;
    function GetOutlineThickness: Single;
    function GetPointCount: Cardinal;
    function GetPosition: TSfmlVector2f;
    function GetRadius: Single;
    function GetRotation: Single;
    function GetScale: TSfmlVector2f;
    function GetTexture: PSfmlTexture;
    function GetTextureRect: TSfmlIntRect;
    function GetTransform: TSfmlTransform;
    procedure SetFillColor(Color: TSfmlColor);
    procedure SetOrigin(Origin: TSfmlVector2f);
    procedure SetOutlineColor(Color: TSfmlColor);
    procedure SetOutlineThickness(Thickness: Single);
    procedure SetPointCount(Count: Cardinal);
    procedure SetPosition(Position: TSfmlVector2f);
    procedure SetRadius(Radius: Single);
    procedure SetRotation(Angle: Single);
    procedure SetScale(Scale: TSfmlVector2f);
    procedure SetTextureRect(Rect: TSfmlIntRect);
  public
    constructor Create;
    destructor Destroy; override;

    function Copy: TSfmlCircleShape;

    procedure Move(Offset: TSfmlVector2f);
    procedure Rotate(Angle: Single);
    procedure Scale(Factors: TSfmlVector2f);

    function GetPoint(Index: Cardinal): TSfmlVector2f;
    procedure SetTexture(const Texture: PSfmlTexture; resetRect: Boolean);

    property FillColor: TSfmlColor read GetFillColor write SetFillColor;
    property GlobalBounds: TSfmlFloatRect read GetGlobalBounds;
    property InverseTransform: TSfmlTransform read GetInverseTransform;
    property LocalBounds: TSfmlFloatRect read GetLocalBounds;
    property Origin: TSfmlVector2f read GetOrigin write SetOrigin;
    property OutlineColor: TSfmlColor read GetOutlineColor write SetOutlineColor;
    property OutlineThickness: Single read GetOutlineThickness write SetOutlineThickness;
    property PointCount: Cardinal read GetPointCount write SetPointCount;
    property Position: TSfmlVector2f read GetPosition write SetPosition;
    property Radius: Single read GetRadius write SetRadius;
    property Rotation: Single read GetRotation write SetRotation;
    property ScaleVector: TSfmlVector2f read GetScale write SetScale;
    property Texture: PSfmlTexture read GetTexture;
    property TextureRect: TSfmlIntRect read GetTextureRect write SetTextureRect;
    property Transform: TSfmlTransform read GetTransform;
  end;

  TSfmlConvexShape = class
  private
    FHandle: PSfmlConvexShape;
  public
    constructor Create;
    destructor Destroy; override;

    function Copy: TSfmlConvexShape;
    procedure SetPosition(Position: TSfmlVector2f);
    procedure SetRotation(Angle: Single);
    procedure SetScale(Scale: TSfmlVector2f);
    procedure SetOrigin(Origin: TSfmlVector2f);
    function GetPosition: TSfmlVector2f;
    function GetRotation: Single;
    function GetScale: TSfmlVector2f;
    function GetOrigin: TSfmlVector2f;
    procedure Move(Offset: TSfmlVector2f);
    procedure Rotate(Angle: Single);
    procedure Scale(Factors: TSfmlVector2f);
    function GetTransform: TSfmlTransform;
    function GetInverseTransform: TSfmlTransform;
    procedure SetTexture(const Texture: PSfmlTexture; ResetRect: Boolean);
    procedure SetTextureRect(Rect: TSfmlIntRect);
    procedure SetFillColor(Color: TSfmlColor);
    procedure SetOutlineColor(Color: TSfmlColor);
    procedure SetOutlineThickness(Thickness: Single);
    function GetTexture: PSfmlTexture;
    function GetTextureRect: TSfmlIntRect;
    function GetFillColor: TSfmlColor;
    function GetOutlineColor: TSfmlColor;
    function GetOutlineThickness: Single;
    function GetPointCount: Cardinal;
    function GetPoint(Index: Cardinal): TSfmlVector2f;
    procedure SetPointCount(Count: Cardinal);
    procedure SetPoint(Index: Cardinal; Point: TSfmlVector2f);
    function GetLocalBounds: TSfmlFloatRect;
    function GetGlobalBounds: TSfmlFloatRect;
  end;

  TSfmlFont = class
  private
    FHandle: PSfmlFont;
  public
    constructor Create(const FileName: PAnsiChar); overload;
    constructor Create(const Data: Pointer; SizeInBytes: NativeUInt); overload;
    constructor Create(const Stream: PSfmlInputStream); overload;
    destructor Destroy; override;

    function Copy: TSfmlFont;
    function GetGlyph(CodePoint: Cardinal; CharacterSize: Cardinal; Bold: Boolean): TSfmlGlyph;
    function GetKerning(First, second: Cardinal; CharacterSize: Cardinal): Single;
    function GetLineSpacing(CharacterSize: Cardinal): Single;
    function GetUnderlinePosition(CharacterSize: Cardinal): Single;
    function GetUnderlineThickness(CharacterSize: Cardinal): Single;
    function GetTexture(CharacterSize: Cardinal): PSfmlTexture;
    function GetInfo: TSfmlFontInfo;
  end;

  TSfmlImage = class
  private
    FHandle: PSfmlImage;
  public
    constructor Create(Width, Height: Cardinal); overload;
    constructor Create(Width, Height: Cardinal; Color: TSfmlColor); overload;
    constructor Create(Width, Height: Cardinal; const Pixels: PByte); overload;
    constructor Create(const FileName: PAnsiChar); overload;
    constructor Create(const data: Pointer; Size: NativeUInt); overload;
    constructor Create(const Stream: PSfmlInputStream); overload;
    destructor Destroy; override;

    function Copy: TSfmlImage;
    function SaveToFile(const FileName: PAnsiChar): Boolean;
    function GetSize: TSfmlVector2u;
    procedure CreateMaskFromColor(Color: TSfmlColor; Alpha: Byte);
    procedure CopyImage(const source: TSfmlImage; destX, destY: Cardinal; sourceRect: TSfmlIntRect; applyAlpha: Boolean); overload;
    procedure CopyImage(const source: PSfmlImage; destX, destY: Cardinal; sourceRect: TSfmlIntRect; applyAlpha: Boolean); overload;
    procedure SetPixel(X, Y: Cardinal; Color: TSfmlColor);
    function GetPixel(X, Y: Cardinal): TSfmlColor;
    function GetPixelsPtr: PByte;
    procedure FlipHorizontally;
    procedure FlipVertically;
  end;

  TSfmlRectangleShape = class
  private
    FHandle: PSfmlRectangleShape;
  public
    constructor Create;
    destructor Destroy; override;

    function Copy: TSfmlRectangleShape;
    procedure SetPosition(Position: TSfmlVector2f);
    procedure SetRotation(Angle: Single);
    procedure SetScale(Scale: TSfmlVector2f);
    procedure SetOrigin(Origin: TSfmlVector2f);
    function GetPosition: TSfmlVector2f;
    function GetRotation: Single;
    function GetScale: TSfmlVector2f;
    function GetOrigin: TSfmlVector2f;
    procedure Move(Offset: TSfmlVector2f);
    procedure Rotate(Angle: Single);
    procedure Scale(Factors: TSfmlVector2f);
    function GetTransform: TSfmlTransform;
    function GetInverseTransform: TSfmlTransform;
    procedure SetTexture(const Texture: PSfmlTexture; resetRect: Boolean);
    procedure SetTextureRect(rect: TSfmlIntRect);
    procedure SetFillColor(Color: TSfmlColor);
    procedure SetOutlineColor(Color: TSfmlColor);
    procedure SetOutlineThickness(Thickness: Single);
    function GetTexture: PSfmlTexture;
    function GetTextureRect: TSfmlIntRect;
    function GetFillColor: TSfmlColor;
    function GetOutlineColor: TSfmlColor;
    function GetOutlineThickness: Single;
    function GetPointCount: Cardinal;
    function GetPoint(Index: Cardinal): TSfmlVector2f;
    procedure SetSize(Size: TSfmlVector2f);
    function GetSize: TSfmlVector2f;
    function GetLocalBounds: TSfmlFloatRect;
    function GetGlobalBounds: TSfmlFloatRect;
  end;

  TSfmlRenderTexture = class
  private
    FHandle: PSfmlRenderTexture;
  public
    constructor Create(Width, Height: Cardinal; depthBuffer: Boolean);
    destructor Destroy; override;

    function GetSize: TSfmlVector2u;
    function SetActive(Active: Boolean): Boolean;
    procedure Display;
    procedure Clear(Color: TSfmlColor);
    procedure SetView(const View: PSfmlView);
    function GetView: PSfmlView;
    function GetDefaultView: PSfmlView;
    function GetViewport(const View: PSfmlView): TSfmlIntRect;
    function MapPixelToCoords(point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f;
    function MapCoordsToPixel(point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i;
    procedure DrawSprite(const &Object: PSfmlSprite; const States: PSfmlRenderStates);
    procedure DrawText(const &Object: PSfmlText; const States: PSfmlRenderStates);
    procedure DrawShape(const &Object: PSfmlShape; const States: PSfmlRenderStates);
    procedure DrawCircleShape(const &Object: PSfmlCircleShape; const States: PSfmlRenderStates);
    procedure DrawConvexShape(const &Object: PSfmlConvexShape; const States: PSfmlRenderStates);
    procedure DrawRectangleShape(const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates);
    procedure DrawVertexArray(const &Object: PSfmlVertexArray; const States: PSfmlRenderStates);
    procedure DrawPrimitives;
    procedure PushGLStates;
    procedure PopGLStates;
    procedure ResetGLStates;
    function GetTexture: PSfmlTexture ;
    procedure SetSmooth(Smooth: Boolean);
    function IsSmooth: Boolean;
    procedure SetRepeated(Repeated: Boolean);
    function IsRepeated: Boolean;
  end;

  TSfmlRenderWindow = class
  private
    FHandle: PSfmlRenderWindow;
  public
    constructor Create(Mode: TSfmlVideoMode; const Title: PAnsiChar; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings); overload;
    constructor Create(Mode: TSfmlVideoMode; const Title: PWideChar; Style: TSfmlWindowStyles; const Settings: PSfmlContextSettings); overload;
    constructor Create(Handle: TSfmlWindowHandle; const Settings: PSfmlContextSettings); overload;
    destructor Destroy; override;

    procedure Close;
    function IsOpen: Boolean;
    function GetSettings: TSfmlContextSettings;
    function PollEvent(Event: PSfmlEvent): Boolean;
    function WaitEvent(Event: PSfmlEvent): Boolean;
    function GetPosition: TSfmlVector2i;
    procedure SetPosition(Position: TSfmlVector2i);
    function GetSize: TSfmlVector2u;
    procedure SetSize(Size: TSfmlVector2u);
    procedure SetTitle(const Title: PAnsiChar);
    procedure SetUnicodeTitle(const Title: PWideChar);
    procedure SetIcon(Width, Height: Cardinal; const Pixels: PByte);
    procedure SetVisible(Visible: Boolean);
    procedure SetMouseCursorVisible(show: Boolean);
    procedure SetVerticalSyncEnabled(enabled: Boolean);
    procedure SetKeyRepeatEnabled(enabled: Boolean);
    function SetActive(Active: Boolean): Boolean;
    procedure RequestFocus;
    function HasFocus: Boolean;
    procedure Display;
    procedure SetFramerateLimit(Limit: Cardinal);
    procedure SetJoystickThreshold(Threshold: Single);
    function GetSystemHandle: TSfmlWindowHandle;
    procedure Clear(Color: TSfmlColor);
    procedure SetView(const View: PSfmlView);
    function GetView: PSfmlView;
    function GetDefaultView: PSfmlView;
    function GetViewport(const View: PSfmlView): TSfmlIntRect;
    function MapPixelToCoords(Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2f;
    function MapCoordsToPixel(Point: TSfmlVector2i; const View: PSfmlView): TSfmlVector2i;
    procedure DrawSprite(const &Object: PSfmlSprite; const States: PSfmlRenderStates);
    procedure DrawText(const &Object: PSfmlText; const States: PSfmlRenderStates);
    procedure DrawShape(const &Object: PSfmlShape; const States: PSfmlRenderStates);
    procedure DrawCircleShape(const &Object: PSfmlCircleShape; const States: PSfmlRenderStates);
    procedure DrawConvexShape(const &Object: PSfmlConvexShape; const States: PSfmlRenderStates);
    procedure DrawRectangleShape(const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates);
    procedure DrawVertexArray(const &Object: PSfmlVertexArray; const States: PSfmlRenderStates);
    procedure DrawPrimitives;
    procedure PushGLStates;
    procedure PopGLStates;
    procedure ResetGLStates;
    function Capture: PSfmlImage;
    function SfmlMouseGetPositionRenderWindow(const relativeTo: PSfmlRenderWindow): TSfmlVector2i;
    procedure SfmlMouseSetPositionRenderWindow(position: TSfmlVector2i; const RelativeTo: PSfmlRenderWindow);
    function SfmlTouchGetPositionRenderWindow(Finger: Cardinal; const RelativeTo: PSfmlRenderWindow): TSfmlVector2i;
  end;

  TSfmlShader = class
  private
    FHandle: PSfmlShader;
  public
    constructor Create(const VertexShader: PAnsiChar; const FragmentShader: PAnsiChar); overload;
    constructor Create(VertexShaderStream: PSfmlInputStream; FragmentShaderStream: PSfmlInputStream); overload;
    constructor CreateFromFile(const VertexShaderFilename: PAnsiChar; const FragmentShaderFilename: PAnsiChar);
    destructor Destroy; override;

    procedure SetFloatParameter(const Name: PAnsiChar; X: Single);
    procedure SetFloat2Parameter(const Name: PAnsiChar; X, Y: Single);
    procedure SetFloat3Parameter(const Name: PAnsiChar; X, Y, Z: Single);
    procedure SetFloat4Parameter(const Name: PAnsiChar; X, Y, Z, W: Single);
    procedure SetVector2Parameter(const Name: PAnsiChar; Vector: TSfmlVector2f);
    procedure SetVector3Parameter(const Name: PAnsiChar; Vector: TSfmlVector3f);
    procedure SetColorParameter(const Name: PAnsiChar; Color: TSfmlColor);
    procedure SetTransformParameter(const Name: PAnsiChar; Transform: TSfmlTransform);
    procedure SetTextureParameter(const Name: PAnsiChar; const Texture: PSfmlTexture);
    procedure SetCurrentTextureParameter(const Name: PAnsiChar);
    procedure Bind;
    function IsAvailable: Boolean;
  end;

  TSfmlShape = class
  private
    FHandle: PSfmlShape;
  public
    constructor Create(getPointCount: TSfmlShapeGetPointCountCallback; GetPoint: TSfmlShapeGetPointCallback; UserData: Pointer); overload;
    destructor Destroy; override;

    procedure SetPosition(Position: TSfmlVector2f);
    procedure SetRotation(Angle: Single);
    procedure SetScale(Scale: TSfmlVector2f);
    procedure SetOrigin(Origin: TSfmlVector2f);
    function GetPosition: TSfmlVector2f;
    function GetRotation: Single;
    function GetScale: TSfmlVector2f;
    function GetOrigin: TSfmlVector2f;
    procedure Move(Offset: TSfmlVector2f);
    procedure Rotate(Angle: Single);
    procedure Scale(Factors: TSfmlVector2f);
    function GetTransform: TSfmlTransform;
    function GetInverseTransform: TSfmlTransform;
    procedure SetTexture(const Texture: PSfmlTexture; ResetRect: Boolean);
    procedure SetTextureRect(Rect: TSfmlIntRect);
    procedure SetFillColor(Color: TSfmlColor);
    procedure SetOutlineColor(Color: TSfmlColor);
    procedure SetOutlineThickness(Thickness: Single);
    function GetTexture: PSfmlTexture;
    function GetTextureRect: TSfmlIntRect;
    function GetFillColor: TSfmlColor;
    function GetOutlineColor: TSfmlColor;
    function GetOutlineThickness: Single;
    function GetPointCount: Cardinal;
    function GetPoint(Index: Cardinal): TSfmlVector2f;
    function GetLocalBounds: TSfmlFloatRect;
    function GetGlobalBounds: TSfmlFloatRect;
    procedure Update;
  end;

  TSfmlSprite = class
  private
    FHandle: PSfmlSprite;
  public
    constructor Create;
    destructor Destroy; override;

    function Copy: TSfmlSprite;
    procedure SetPosition(Position: TSfmlVector2f);
    procedure SetRotation(Angle: Single);
    procedure SetScale(Scale: TSfmlVector2f);
    procedure SetOrigin(Origin: TSfmlVector2f);
    function GetPosition: TSfmlVector2f;
    function GetRotation: Single;
    function GetScale: TSfmlVector2f;
    function GetOrigin: TSfmlVector2f;
    procedure Move(Offset: TSfmlVector2f);
    procedure Rotate(Angle: Single);
    procedure Scale(Factors: TSfmlVector2f);
    function GetTransform: TSfmlTransform;
    function GetInverseTransform: TSfmlTransform;
    procedure SetTexture(const Texture: PSfmlTexture; resetRect: Boolean);
    procedure SetTextureRect(Rectangle: TSfmlIntRect);
    procedure SetColor(Color: TSfmlColor);
    function GetTexture: PSfmlTexture;
    function GetTextureRect: TSfmlIntRect;
    function GetColor: TSfmlColor;
    function GetLocalBounds: TSfmlFloatRect;
    function GetGlobalBounds: TSfmlFloatRect;
  end;

  TSfmlText = class
  private
    FHandle: PSfmlText;
  public
    constructor Create;
    destructor Destroy; override;

    function Copy: TSfmlText;
    procedure SetPosition(Position: TSfmlVector2f);
    procedure SetRotation(Angle: Single);
    procedure SetScale(Scale: TSfmlVector2f);
    procedure SetOrigin(Origin: TSfmlVector2f);
    function GetPosition: TSfmlVector2f;
    function GetRotation: Single;
    function GetScale: TSfmlVector2f;
    function GetOrigin: TSfmlVector2f;
    procedure Move(Offset: TSfmlVector2f);
    procedure Rotate(Angle: Single);
    procedure Scale(Factors: TSfmlVector2f);
    function GetTransform: TSfmlTransform;
    function GetInverseTransform: TSfmlTransform;
    procedure SetString(const &string: PAnsiChar);
    procedure SetUnicodeString(const &string: PWideChar);
    procedure SetFont(const Font: PSfmlFont);
    procedure SetCharacterSize(Size: Cardinal);
    procedure SetStyle(Style: Cardinal);
    procedure SetColor(Color: TSfmlColor);
    function GetString: PAnsiChar;
    function GetUnicodeString: PWideChar;
    function GetFont: PSfmlFont;
    function GetCharacterSize: Cardinal;
    function GetStyle: Cardinal;
    function GetColor: TSfmlColor;
    function FindCharacterPos(Index: NativeUInt): TSfmlVector2f;
    function GetLocalBounds: TSfmlFloatRect;
    function GetGlobalBounds: TSfmlFloatRect;
  end;

  TSfmlTexture = class
  private
    FHandle: PSfmlTexture;
  public
    constructor Create(Width, Height: Cardinal); overload;
    constructor Create(const FileName: PAnsiChar; const Area: PSfmlIntRect); overload;
    constructor Create(const data: Pointer; SizeInBytes: NativeUInt; const Area: PSfmlIntRect); overload;
    constructor Create(Stream: PSfmlInputStream; const Area: PSfmlIntRect); overload;
    constructor Create(const Image: PSfmlImage; const Area: PSfmlIntRect); overload;
    destructor Destroy; override;

    function Copy: TSfmlTexture;
    function GetSize: TSfmlVector2u;
    function CopyToImage: PSfmlImage;
    procedure UpdateFromPixels(const Pixels: PByte; Width, Height, X, Y: Cardinal);
    procedure UpdateFromImage(const Image: PSfmlImage; X, Y: Cardinal);
    procedure UpdateFromWindow(const Window: PSfmlWindow; X, Y: Cardinal);
    procedure UpdateFromRenderWindow(const RenderWindow: PSfmlRenderWindow; X, Y: Cardinal);
    procedure SetSmooth(Smooth: Boolean);
    function IsSmooth: Boolean;
    procedure SetRepeated(Repeated: Boolean);
    function IsRepeated: Boolean;
    procedure Bind;
    function GetMaximumSize: Cardinal;
  end;

  TSfmlTransformable = class
  private
    FHandle: PSfmlTransformable;
  public
    constructor Create;
    destructor Destroy; override;

    function Copy: TSfmlTransformable;
    procedure SetPosition(Position: TSfmlVector2f);
    procedure SetRotation(Angle: Single);
    procedure SetScale(Scale: TSfmlVector2f);
    procedure SetOrigin(Origin: TSfmlVector2f);
    function GetPosition: TSfmlVector2f;
    function GetRotation: Single;
    function GetScale: TSfmlVector2f;
    function GetOrigin: TSfmlVector2f;
    procedure Move(Offset: TSfmlVector2f);
    procedure Rotate(Angle: Single);
    procedure Scale(Factors: TSfmlVector2f);
    function GetTransform: TSfmlTransform;
    function GetInverseTransform: TSfmlTransform;
  end;

  TSfmlVertexArray = class
  private
    FHandle: PSfmlVertexArray;
  public
    constructor Create;
    destructor Destroy; override;

    function Copy: TSfmlVertexArray;
    function GetVertexCount: Cardinal;
    function GetVertex(Index: Cardinal): PSfmlVertex;
    procedure Clear;
    procedure Resize(VertexCount: Cardinal);
    procedure Append(Vertex: TSfmlVertex);
    procedure SetPrimitiveType(&Type: TSfmlPrimitiveType);
    function GetPrimitiveType: TSfmlPrimitiveType;
    function GetBounds: TSfmlFloatRect;
  end;

  TSfmlView = class
  private
    FHandle: PSfmlView;
  public
    constructor Create; overload;
    constructor Create(Rectangle: TSfmlFloatRect); overload;
    destructor Destroy; override;

    function Copy: TSfmlView;
    procedure SetCenter(Center: TSfmlVector2f);
    procedure SetSize(Size: TSfmlVector2f);
    procedure SetRotation(Angle: Single);
    procedure SetViewport(Viewport: TSfmlFloatRect);
    procedure Reset(Rectangle: TSfmlFloatRect);
    function GetCenter: TSfmlVector2f;
    function GetSize: TSfmlVector2f;
    function GetRotation: Single;
    function GetViewport: TSfmlFloatRect;
    procedure Move(Offset: TSfmlVector2f);
    procedure Rotate(Angle: Single);
    procedure Zoom(Factor: Single);
  end;

implementation

{$IFDEF DynLink}
{$IFDEF MSWindows}
uses
  Windows;
{$ENDIF}
{$ENDIF}

{ TSfmlCircleShape }

constructor TSfmlCircleShape.Create;
begin

end;

destructor TSfmlCircleShape.Destroy;
begin

  inherited;
end;

function TSfmlCircleShape.Copy: TSfmlCircleShape;
begin

end;

function TSfmlCircleShape.GetFillColor: TSfmlColor;
begin

end;

function TSfmlCircleShape.GetGlobalBounds: TSfmlFloatRect;
begin

end;

function TSfmlCircleShape.GetInverseTransform: TSfmlTransform;
begin

end;

function TSfmlCircleShape.GetLocalBounds: TSfmlFloatRect;
begin

end;

function TSfmlCircleShape.GetOrigin: TSfmlVector2f;
begin

end;

function TSfmlCircleShape.GetOutlineColor: TSfmlColor;
begin

end;

function TSfmlCircleShape.GetOutlineThickness: Single;
begin

end;

function TSfmlCircleShape.GetPoint(Index: Cardinal): TSfmlVector2f;
begin

end;

function TSfmlCircleShape.GetPointCount: Cardinal;
begin

end;

function TSfmlCircleShape.GetPosition: TSfmlVector2f;
begin

end;

function TSfmlCircleShape.GetRadius: Single;
begin

end;

function TSfmlCircleShape.GetRotation: Single;
begin

end;

function TSfmlCircleShape.GetScale: TSfmlVector2f;
begin

end;

function TSfmlCircleShape.GetTexture: PSfmlTexture;
begin

end;

function TSfmlCircleShape.GetTextureRect: TSfmlIntRect;
begin

end;

function TSfmlCircleShape.GetTransform: TSfmlTransform;
begin

end;

procedure TSfmlCircleShape.Move(Offset: TSfmlVector2f);
begin

end;

procedure TSfmlCircleShape.Rotate(Angle: Single);
begin

end;

procedure TSfmlCircleShape.Scale(Factors: TSfmlVector2f);
begin

end;

procedure TSfmlCircleShape.SetFillColor(Color: TSfmlColor);
begin

end;

procedure TSfmlCircleShape.SetOrigin(Origin: TSfmlVector2f);
begin

end;

procedure TSfmlCircleShape.SetOutlineColor(Color: TSfmlColor);
begin

end;

procedure TSfmlCircleShape.SetOutlineThickness(Thickness: Single);
begin

end;

procedure TSfmlCircleShape.SetPointCount(Count: Cardinal);
begin

end;

procedure TSfmlCircleShape.SetPosition(Position: TSfmlVector2f);
begin

end;

procedure TSfmlCircleShape.SetRadius(Radius: Single);
begin

end;

procedure TSfmlCircleShape.SetRotation(Angle: Single);
begin

end;

procedure TSfmlCircleShape.SetScale(Scale: TSfmlVector2f);
begin

end;

procedure TSfmlCircleShape.SetTexture(const Texture: PSfmlTexture;
  resetRect: Boolean);
begin

end;

procedure TSfmlCircleShape.SetTextureRect(Rect: TSfmlIntRect);
begin

end;


{ TSfmlConvexShape }

function TSfmlConvexShape.Copy: TSfmlConvexShape;
begin

end;

constructor TSfmlConvexShape.Create;
begin

end;

destructor TSfmlConvexShape.Destroy;
begin

  inherited;
end;

function TSfmlConvexShape.GetFillColor: TSfmlColor;
begin

end;

function TSfmlConvexShape.GetGlobalBounds: TSfmlFloatRect;
begin

end;

function TSfmlConvexShape.GetInverseTransform: TSfmlTransform;
begin

end;

function TSfmlConvexShape.GetLocalBounds: TSfmlFloatRect;
begin

end;

function TSfmlConvexShape.GetOrigin: TSfmlVector2f;
begin

end;

function TSfmlConvexShape.GetOutlineColor: TSfmlColor;
begin

end;

function TSfmlConvexShape.GetOutlineThickness: Single;
begin

end;

function TSfmlConvexShape.GetPoint(Index: Cardinal): TSfmlVector2f;
begin

end;

function TSfmlConvexShape.GetPointCount: Cardinal;
begin

end;

function TSfmlConvexShape.GetPosition: TSfmlVector2f;
begin

end;

function TSfmlConvexShape.GetRotation: Single;
begin

end;

function TSfmlConvexShape.GetScale: TSfmlVector2f;
begin

end;

function TSfmlConvexShape.GetTexture: PSfmlTexture;
begin

end;

function TSfmlConvexShape.GetTextureRect: TSfmlIntRect;
begin

end;

function TSfmlConvexShape.GetTransform: TSfmlTransform;
begin

end;

procedure TSfmlConvexShape.Move(Offset: TSfmlVector2f);
begin

end;

procedure TSfmlConvexShape.Rotate(Angle: Single);
begin

end;

procedure TSfmlConvexShape.Scale(Factors: TSfmlVector2f);
begin

end;

procedure TSfmlConvexShape.SetFillColor(Color: TSfmlColor);
begin

end;

procedure TSfmlConvexShape.SetOrigin(Origin: TSfmlVector2f);
begin

end;

procedure TSfmlConvexShape.SetOutlineColor(Color: TSfmlColor);
begin

end;

procedure TSfmlConvexShape.SetOutlineThickness(Thickness: Single);
begin

end;

procedure TSfmlConvexShape.SetPoint(Index: Cardinal; Point: TSfmlVector2f);
begin

end;

procedure TSfmlConvexShape.SetPointCount(Count: Cardinal);
begin

end;

procedure TSfmlConvexShape.SetPosition(Position: TSfmlVector2f);
begin

end;

procedure TSfmlConvexShape.SetRotation(Angle: Single);
begin

end;

procedure TSfmlConvexShape.SetScale(Scale: TSfmlVector2f);
begin

end;

procedure TSfmlConvexShape.SetTexture(const Texture: PSfmlTexture;
  ResetRect: Boolean);
begin

end;

procedure TSfmlConvexShape.SetTextureRect(Rect: TSfmlIntRect);
begin

end;


{ TSfmlFont }

function TSfmlFont.Copy: TSfmlFont;
begin

end;

constructor TSfmlFont.Create(const FileName: PAnsiChar);
begin

end;

constructor TSfmlFont.Create(const Stream: PSfmlInputStream);
begin

end;

constructor TSfmlFont.Create(const Data: Pointer; SizeInBytes: NativeUInt);
begin

end;

destructor TSfmlFont.Destroy;
begin

  inherited;
end;

function TSfmlFont.GetGlyph(CodePoint, CharacterSize: Cardinal;
  Bold: Boolean): TSfmlGlyph;
begin

end;

function TSfmlFont.GetInfo: TSfmlFontInfo;
begin

end;

function TSfmlFont.GetKerning(First, second, CharacterSize: Cardinal): Single;
begin

end;

function TSfmlFont.GetLineSpacing(CharacterSize: Cardinal): Single;
begin

end;

function TSfmlFont.GetTexture(CharacterSize: Cardinal): PSfmlTexture;
begin

end;

function TSfmlFont.GetUnderlinePosition(CharacterSize: Cardinal): Single;
begin

end;

function TSfmlFont.GetUnderlineThickness(CharacterSize: Cardinal): Single;
begin

end;


{ TSfmlImage }

function TSfmlImage.Copy: TSfmlImage;
begin

end;

procedure TSfmlImage.CopyImage(const source: PSfmlImage; destX, destY: Cardinal;
  sourceRect: TSfmlIntRect; applyAlpha: Boolean);
begin

end;

procedure TSfmlImage.CopyImage(const source: TSfmlImage; destX, destY: Cardinal;
  sourceRect: TSfmlIntRect; applyAlpha: Boolean);
begin

end;

constructor TSfmlImage.Create(Width, Height: Cardinal; const Pixels: PByte);
begin

end;

constructor TSfmlImage.Create(Width, Height: Cardinal; Color: TSfmlColor);
begin

end;

constructor TSfmlImage.Create(Width, Height: Cardinal);
begin

end;

constructor TSfmlImage.Create(const Stream: PSfmlInputStream);
begin

end;

constructor TSfmlImage.Create(const data: Pointer; Size: NativeUInt);
begin

end;

constructor TSfmlImage.Create(const FileName: PAnsiChar);
begin

end;

procedure TSfmlImage.CreateMaskFromColor(Color: TSfmlColor; Alpha: Byte);
begin

end;

destructor TSfmlImage.Destroy;
begin

  inherited;
end;

procedure TSfmlImage.FlipHorizontally;
begin

end;

procedure TSfmlImage.FlipVertically;
begin

end;

function TSfmlImage.GetPixel(X, Y: Cardinal): TSfmlColor;
begin

end;

function TSfmlImage.GetPixelsPtr: PByte;
begin

end;

function TSfmlImage.GetSize: TSfmlVector2u;
begin

end;

function TSfmlImage.SaveToFile(const FileName: PAnsiChar): Boolean;
begin

end;

procedure TSfmlImage.SetPixel(X, Y: Cardinal; Color: TSfmlColor);
begin

end;


{ TSfmlRectangleShape }

function TSfmlRectangleShape.Copy: TSfmlRectangleShape;
begin

end;

constructor TSfmlRectangleShape.Create;
begin

end;

destructor TSfmlRectangleShape.Destroy;
begin

  inherited;
end;

function TSfmlRectangleShape.GetFillColor: TSfmlColor;
begin

end;

function TSfmlRectangleShape.GetGlobalBounds: TSfmlFloatRect;
begin

end;

function TSfmlRectangleShape.GetInverseTransform: TSfmlTransform;
begin

end;

function TSfmlRectangleShape.GetLocalBounds: TSfmlFloatRect;
begin

end;

function TSfmlRectangleShape.GetOrigin: TSfmlVector2f;
begin

end;

function TSfmlRectangleShape.GetOutlineColor: TSfmlColor;
begin

end;

function TSfmlRectangleShape.GetOutlineThickness: Single;
begin

end;

function TSfmlRectangleShape.GetPoint(Index: Cardinal): TSfmlVector2f;
begin

end;

function TSfmlRectangleShape.GetPointCount: Cardinal;
begin

end;

function TSfmlRectangleShape.GetPosition: TSfmlVector2f;
begin

end;

function TSfmlRectangleShape.GetRotation: Single;
begin

end;

function TSfmlRectangleShape.GetScale: TSfmlVector2f;
begin

end;

function TSfmlRectangleShape.GetSize: TSfmlVector2f;
begin

end;

function TSfmlRectangleShape.GetTexture: PSfmlTexture;
begin

end;

function TSfmlRectangleShape.GetTextureRect: TSfmlIntRect;
begin

end;

function TSfmlRectangleShape.GetTransform: TSfmlTransform;
begin

end;

procedure TSfmlRectangleShape.Move(Offset: TSfmlVector2f);
begin

end;

procedure TSfmlRectangleShape.Rotate(Angle: Single);
begin

end;

procedure TSfmlRectangleShape.Scale(Factors: TSfmlVector2f);
begin

end;

procedure TSfmlRectangleShape.SetFillColor(Color: TSfmlColor);
begin

end;

procedure TSfmlRectangleShape.SetOrigin(Origin: TSfmlVector2f);
begin

end;

procedure TSfmlRectangleShape.SetOutlineColor(Color: TSfmlColor);
begin

end;

procedure TSfmlRectangleShape.SetOutlineThickness(Thickness: Single);
begin

end;

procedure TSfmlRectangleShape.SetPosition(Position: TSfmlVector2f);
begin

end;

procedure TSfmlRectangleShape.SetRotation(Angle: Single);
begin

end;

procedure TSfmlRectangleShape.SetScale(Scale: TSfmlVector2f);
begin

end;

procedure TSfmlRectangleShape.SetSize(Size: TSfmlVector2f);
begin

end;

procedure TSfmlRectangleShape.SetTexture(const Texture: PSfmlTexture;
  resetRect: Boolean);
begin

end;

procedure TSfmlRectangleShape.SetTextureRect(rect: TSfmlIntRect);
begin

end;


{ TSfmlRenderTexture }

procedure TSfmlRenderTexture.Clear(Color: TSfmlColor);
begin

end;

constructor TSfmlRenderTexture.Create(Width, Height: Cardinal;
  depthBuffer: Boolean);
begin

end;

destructor TSfmlRenderTexture.Destroy;
begin

  inherited;
end;

procedure TSfmlRenderTexture.Display;
begin

end;

procedure TSfmlRenderTexture.DrawCircleShape(const &Object: PSfmlCircleShape;
  const States: PSfmlRenderStates);
begin

end;

procedure TSfmlRenderTexture.DrawConvexShape(const &Object: PSfmlConvexShape;
  const States: PSfmlRenderStates);
begin

end;

procedure TSfmlRenderTexture.DrawPrimitives;
begin

end;

procedure TSfmlRenderTexture.DrawRectangleShape(
  const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates);
begin

end;

procedure TSfmlRenderTexture.DrawShape(const &Object: PSfmlShape;
  const States: PSfmlRenderStates);
begin

end;

procedure TSfmlRenderTexture.DrawSprite(const &Object: PSfmlSprite;
  const States: PSfmlRenderStates);
begin

end;

procedure TSfmlRenderTexture.DrawText(const &Object: PSfmlText;
  const States: PSfmlRenderStates);
begin

end;

procedure TSfmlRenderTexture.DrawVertexArray(const &Object: PSfmlVertexArray;
  const States: PSfmlRenderStates);
begin

end;

function TSfmlRenderTexture.GetDefaultView: PSfmlView;
begin

end;

function TSfmlRenderTexture.GetSize: TSfmlVector2u;
begin

end;

function TSfmlRenderTexture.GetTexture: PSfmlTexture;
begin

end;

function TSfmlRenderTexture.GetView: PSfmlView;
begin

end;

function TSfmlRenderTexture.GetViewport(const View: PSfmlView): TSfmlIntRect;
begin

end;

function TSfmlRenderTexture.IsRepeated: Boolean;
begin

end;

function TSfmlRenderTexture.IsSmooth: Boolean;
begin

end;

function TSfmlRenderTexture.MapCoordsToPixel(point: TSfmlVector2i;
  const View: PSfmlView): TSfmlVector2i;
begin

end;

function TSfmlRenderTexture.MapPixelToCoords(point: TSfmlVector2i;
  const View: PSfmlView): TSfmlVector2f;
begin

end;

procedure TSfmlRenderTexture.PopGLStates;
begin

end;

procedure TSfmlRenderTexture.PushGLStates;
begin

end;

procedure TSfmlRenderTexture.ResetGLStates;
begin

end;

function TSfmlRenderTexture.SetActive(Active: Boolean): Boolean;
begin

end;

procedure TSfmlRenderTexture.SetRepeated(Repeated: Boolean);
begin

end;

procedure TSfmlRenderTexture.SetSmooth(Smooth: Boolean);
begin

end;

procedure TSfmlRenderTexture.SetView(const View: PSfmlView);
begin

end;


{ TSfmlRenderWindow }

function TSfmlRenderWindow.Capture: PSfmlImage;
begin

end;

procedure TSfmlRenderWindow.Clear(Color: TSfmlColor);
begin

end;

procedure TSfmlRenderWindow.Close;
begin

end;

constructor TSfmlRenderWindow.Create(Mode: TSfmlVideoMode;
  const Title: PAnsiChar; Style: TSfmlWindowStyles;
  const Settings: PSfmlContextSettings);
begin

end;

constructor TSfmlRenderWindow.Create(Mode: TSfmlVideoMode;
  const Title: PWideChar; Style: TSfmlWindowStyles;
  const Settings: PSfmlContextSettings);
begin

end;

constructor TSfmlRenderWindow.Create(Handle: TSfmlWindowHandle;
  const Settings: PSfmlContextSettings);
begin

end;

destructor TSfmlRenderWindow.Destroy;
begin

  inherited;
end;

procedure TSfmlRenderWindow.Display;
begin

end;

procedure TSfmlRenderWindow.DrawCircleShape(const &Object: PSfmlCircleShape;
  const States: PSfmlRenderStates);
begin

end;

procedure TSfmlRenderWindow.DrawConvexShape(const &Object: PSfmlConvexShape;
  const States: PSfmlRenderStates);
begin

end;

procedure TSfmlRenderWindow.DrawPrimitives;
begin

end;

procedure TSfmlRenderWindow.DrawRectangleShape(
  const &Object: PSfmlRectangleShape; const States: PSfmlRenderStates);
begin

end;

procedure TSfmlRenderWindow.DrawShape(const &Object: PSfmlShape;
  const States: PSfmlRenderStates);
begin

end;

procedure TSfmlRenderWindow.DrawSprite(const &Object: PSfmlSprite;
  const States: PSfmlRenderStates);
begin

end;

procedure TSfmlRenderWindow.DrawText(const &Object: PSfmlText;
  const States: PSfmlRenderStates);
begin

end;

procedure TSfmlRenderWindow.DrawVertexArray(const &Object: PSfmlVertexArray;
  const States: PSfmlRenderStates);
begin

end;

function TSfmlRenderWindow.GetDefaultView: PSfmlView;
begin

end;

function TSfmlRenderWindow.GetPosition: TSfmlVector2i;
begin

end;

function TSfmlRenderWindow.GetSettings: TSfmlContextSettings;
begin

end;

function TSfmlRenderWindow.GetSize: TSfmlVector2u;
begin

end;

function TSfmlRenderWindow.GetSystemHandle: TSfmlWindowHandle;
begin

end;

function TSfmlRenderWindow.GetView: PSfmlView;
begin

end;

function TSfmlRenderWindow.GetViewport(const View: PSfmlView): TSfmlIntRect;
begin

end;

function TSfmlRenderWindow.HasFocus: Boolean;
begin

end;

function TSfmlRenderWindow.IsOpen: Boolean;
begin

end;

function TSfmlRenderWindow.MapCoordsToPixel(Point: TSfmlVector2i;
  const View: PSfmlView): TSfmlVector2i;
begin

end;

function TSfmlRenderWindow.MapPixelToCoords(Point: TSfmlVector2i;
  const View: PSfmlView): TSfmlVector2f;
begin

end;

function TSfmlRenderWindow.PollEvent(Event: PSfmlEvent): Boolean;
begin

end;

procedure TSfmlRenderWindow.PopGLStates;
begin

end;

procedure TSfmlRenderWindow.PushGLStates;
begin

end;

procedure TSfmlRenderWindow.RequestFocus;
begin

end;

procedure TSfmlRenderWindow.ResetGLStates;
begin

end;

function TSfmlRenderWindow.SetActive(Active: Boolean): Boolean;
begin

end;

procedure TSfmlRenderWindow.SetFramerateLimit(Limit: Cardinal);
begin

end;

procedure TSfmlRenderWindow.SetIcon(Width, Height: Cardinal;
  const Pixels: PByte);
begin

end;

procedure TSfmlRenderWindow.SetJoystickThreshold(Threshold: Single);
begin

end;

procedure TSfmlRenderWindow.SetKeyRepeatEnabled(enabled: Boolean);
begin

end;

procedure TSfmlRenderWindow.SetMouseCursorVisible(show: Boolean);
begin

end;

procedure TSfmlRenderWindow.SetPosition(Position: TSfmlVector2i);
begin

end;

procedure TSfmlRenderWindow.SetSize(Size: TSfmlVector2u);
begin

end;

procedure TSfmlRenderWindow.SetTitle(const Title: PAnsiChar);
begin

end;

procedure TSfmlRenderWindow.SetUnicodeTitle(const Title: PWideChar);
begin

end;

procedure TSfmlRenderWindow.SetVerticalSyncEnabled(enabled: Boolean);
begin

end;

procedure TSfmlRenderWindow.SetView(const View: PSfmlView);
begin

end;

procedure TSfmlRenderWindow.SetVisible(Visible: Boolean);
begin

end;

function TSfmlRenderWindow.SfmlMouseGetPositionRenderWindow(
  const relativeTo: PSfmlRenderWindow): TSfmlVector2i;
begin

end;

procedure TSfmlRenderWindow.SfmlMouseSetPositionRenderWindow(
  position: TSfmlVector2i; const RelativeTo: PSfmlRenderWindow);
begin

end;

function TSfmlRenderWindow.SfmlTouchGetPositionRenderWindow(Finger: Cardinal;
  const RelativeTo: PSfmlRenderWindow): TSfmlVector2i;
begin

end;

function TSfmlRenderWindow.WaitEvent(Event: PSfmlEvent): Boolean;
begin

end;


{ TSfmlShader }

procedure TSfmlShader.Bind;
begin

end;

constructor TSfmlShader.Create(const VertexShader, FragmentShader: PAnsiChar);
begin

end;

constructor TSfmlShader.Create(VertexShaderStream,
  FragmentShaderStream: PSfmlInputStream);
begin

end;

constructor TSfmlShader.CreateFromFile(const VertexShaderFilename,
  FragmentShaderFilename: PAnsiChar);
begin

end;

destructor TSfmlShader.Destroy;
begin

  inherited;
end;

function TSfmlShader.IsAvailable: Boolean;
begin

end;

procedure TSfmlShader.SetColorParameter(const Name: PAnsiChar;
  Color: TSfmlColor);
begin

end;

procedure TSfmlShader.SetCurrentTextureParameter(const Name: PAnsiChar);
begin

end;

procedure TSfmlShader.SetFloat2Parameter(const Name: PAnsiChar; X, Y: Single);
begin

end;

procedure TSfmlShader.SetFloat3Parameter(const Name: PAnsiChar; X, Y,
  Z: Single);
begin

end;

procedure TSfmlShader.SetFloat4Parameter(const Name: PAnsiChar; X, Y, Z,
  W: Single);
begin

end;

procedure TSfmlShader.SetFloatParameter(const Name: PAnsiChar; X: Single);
begin

end;

procedure TSfmlShader.SetTextureParameter(const Name: PAnsiChar;
  const Texture: PSfmlTexture);
begin

end;

procedure TSfmlShader.SetTransformParameter(const Name: PAnsiChar;
  Transform: TSfmlTransform);
begin

end;

procedure TSfmlShader.SetVector2Parameter(const Name: PAnsiChar;
  Vector: TSfmlVector2f);
begin

end;

procedure TSfmlShader.SetVector3Parameter(const Name: PAnsiChar;
  Vector: TSfmlVector3f);
begin

end;


{ TSfmlShape }

constructor TSfmlShape.Create(getPointCount: TSfmlShapeGetPointCountCallback;
  GetPoint: TSfmlShapeGetPointCallback; UserData: Pointer);
begin

end;

destructor TSfmlShape.Destroy;
begin

  inherited;
end;

function TSfmlShape.GetFillColor: TSfmlColor;
begin

end;

function TSfmlShape.GetGlobalBounds: TSfmlFloatRect;
begin

end;

function TSfmlShape.GetInverseTransform: TSfmlTransform;
begin

end;

function TSfmlShape.GetLocalBounds: TSfmlFloatRect;
begin

end;

function TSfmlShape.GetOrigin: TSfmlVector2f;
begin

end;

function TSfmlShape.GetOutlineColor: TSfmlColor;
begin

end;

function TSfmlShape.GetOutlineThickness: Single;
begin

end;

function TSfmlShape.GetPoint(Index: Cardinal): TSfmlVector2f;
begin

end;

function TSfmlShape.GetPointCount: Cardinal;
begin

end;

function TSfmlShape.GetPosition: TSfmlVector2f;
begin

end;

function TSfmlShape.GetRotation: Single;
begin

end;

function TSfmlShape.GetScale: TSfmlVector2f;
begin

end;

function TSfmlShape.GetTexture: PSfmlTexture;
begin

end;

function TSfmlShape.GetTextureRect: TSfmlIntRect;
begin

end;

function TSfmlShape.GetTransform: TSfmlTransform;
begin

end;

procedure TSfmlShape.Move(Offset: TSfmlVector2f);
begin

end;

procedure TSfmlShape.Rotate(Angle: Single);
begin

end;

procedure TSfmlShape.Scale(Factors: TSfmlVector2f);
begin

end;

procedure TSfmlShape.SetFillColor(Color: TSfmlColor);
begin

end;

procedure TSfmlShape.SetOrigin(Origin: TSfmlVector2f);
begin

end;

procedure TSfmlShape.SetOutlineColor(Color: TSfmlColor);
begin

end;

procedure TSfmlShape.SetOutlineThickness(Thickness: Single);
begin

end;

procedure TSfmlShape.SetPosition(Position: TSfmlVector2f);
begin

end;

procedure TSfmlShape.SetRotation(Angle: Single);
begin

end;

procedure TSfmlShape.SetScale(Scale: TSfmlVector2f);
begin

end;

procedure TSfmlShape.SetTexture(const Texture: PSfmlTexture;
  ResetRect: Boolean);
begin

end;

procedure TSfmlShape.SetTextureRect(Rect: TSfmlIntRect);
begin

end;

procedure TSfmlShape.Update;
begin

end;


{ TSfmlSprite }

function TSfmlSprite.Copy: TSfmlSprite;
begin

end;

constructor TSfmlSprite.Create;
begin

end;

destructor TSfmlSprite.Destroy;
begin

  inherited;
end;

function TSfmlSprite.GetColor: TSfmlColor;
begin

end;

function TSfmlSprite.GetGlobalBounds: TSfmlFloatRect;
begin

end;

function TSfmlSprite.GetInverseTransform: TSfmlTransform;
begin

end;

function TSfmlSprite.GetLocalBounds: TSfmlFloatRect;
begin

end;

function TSfmlSprite.GetOrigin: TSfmlVector2f;
begin

end;

function TSfmlSprite.GetPosition: TSfmlVector2f;
begin

end;

function TSfmlSprite.GetRotation: Single;
begin

end;

function TSfmlSprite.GetScale: TSfmlVector2f;
begin

end;

function TSfmlSprite.GetTexture: PSfmlTexture;
begin

end;

function TSfmlSprite.GetTextureRect: TSfmlIntRect;
begin

end;

function TSfmlSprite.GetTransform: TSfmlTransform;
begin

end;

procedure TSfmlSprite.Move(Offset: TSfmlVector2f);
begin

end;

procedure TSfmlSprite.Rotate(Angle: Single);
begin

end;

procedure TSfmlSprite.Scale(Factors: TSfmlVector2f);
begin

end;

procedure TSfmlSprite.SetColor(Color: TSfmlColor);
begin

end;

procedure TSfmlSprite.SetOrigin(Origin: TSfmlVector2f);
begin

end;

procedure TSfmlSprite.SetPosition(Position: TSfmlVector2f);
begin

end;

procedure TSfmlSprite.SetRotation(Angle: Single);
begin

end;

procedure TSfmlSprite.SetScale(Scale: TSfmlVector2f);
begin

end;

procedure TSfmlSprite.SetTexture(const Texture: PSfmlTexture;
  resetRect: Boolean);
begin

end;

procedure TSfmlSprite.SetTextureRect(Rectangle: TSfmlIntRect);
begin

end;


{ TSfmlText }

function TSfmlText.Copy: TSfmlText;
begin

end;

constructor TSfmlText.Create;
begin

end;

destructor TSfmlText.Destroy;
begin

  inherited;
end;

function TSfmlText.FindCharacterPos(Index: NativeUInt): TSfmlVector2f;
begin

end;

function TSfmlText.GetCharacterSize: Cardinal;
begin

end;

function TSfmlText.GetColor: TSfmlColor;
begin

end;

function TSfmlText.GetFont: PSfmlFont;
begin

end;

function TSfmlText.GetGlobalBounds: TSfmlFloatRect;
begin

end;

function TSfmlText.GetInverseTransform: TSfmlTransform;
begin

end;

function TSfmlText.GetLocalBounds: TSfmlFloatRect;
begin

end;

function TSfmlText.GetOrigin: TSfmlVector2f;
begin

end;

function TSfmlText.GetPosition: TSfmlVector2f;
begin

end;

function TSfmlText.GetRotation: Single;
begin

end;

function TSfmlText.GetScale: TSfmlVector2f;
begin

end;

function TSfmlText.GetString: PAnsiChar;
begin

end;

function TSfmlText.GetStyle: Cardinal;
begin

end;

function TSfmlText.GetTransform: TSfmlTransform;
begin

end;

function TSfmlText.GetUnicodeString: PWideChar;
begin

end;

procedure TSfmlText.Move(Offset: TSfmlVector2f);
begin

end;

procedure TSfmlText.Rotate(Angle: Single);
begin

end;

procedure TSfmlText.Scale(Factors: TSfmlVector2f);
begin

end;

procedure TSfmlText.SetCharacterSize(Size: Cardinal);
begin

end;

procedure TSfmlText.SetColor(Color: TSfmlColor);
begin

end;

procedure TSfmlText.SetFont(const Font: PSfmlFont);
begin

end;

procedure TSfmlText.SetOrigin(Origin: TSfmlVector2f);
begin

end;

procedure TSfmlText.SetPosition(Position: TSfmlVector2f);
begin

end;

procedure TSfmlText.SetRotation(Angle: Single);
begin

end;

procedure TSfmlText.SetScale(Scale: TSfmlVector2f);
begin

end;

procedure TSfmlText.SetString(const &string: PAnsiChar);
begin

end;

procedure TSfmlText.SetStyle(Style: Cardinal);
begin

end;

procedure TSfmlText.SetUnicodeString(const &string: PWideChar);
begin

end;


{ TSfmlTexture }

procedure TSfmlTexture.Bind;
begin

end;

function TSfmlTexture.Copy: TSfmlTexture;
begin

end;

function TSfmlTexture.CopyToImage: PSfmlImage;
begin

end;

constructor TSfmlTexture.Create(Width, Height: Cardinal);
begin

end;

constructor TSfmlTexture.Create(const Image: PSfmlImage;
  const Area: PSfmlIntRect);
begin

end;

constructor TSfmlTexture.Create(Stream: PSfmlInputStream;
  const Area: PSfmlIntRect);
begin

end;

constructor TSfmlTexture.Create(const FileName: PAnsiChar;
  const Area: PSfmlIntRect);
begin

end;

constructor TSfmlTexture.Create(const data: Pointer; SizeInBytes: NativeUInt;
  const Area: PSfmlIntRect);
begin

end;

destructor TSfmlTexture.Destroy;
begin

  inherited;
end;

function TSfmlTexture.GetMaximumSize: Cardinal;
begin

end;

function TSfmlTexture.GetSize: TSfmlVector2u;
begin

end;

function TSfmlTexture.IsRepeated: Boolean;
begin

end;

function TSfmlTexture.IsSmooth: Boolean;
begin

end;

procedure TSfmlTexture.SetRepeated(Repeated: Boolean);
begin

end;

procedure TSfmlTexture.SetSmooth(Smooth: Boolean);
begin

end;

procedure TSfmlTexture.UpdateFromImage(const Image: PSfmlImage; X, Y: Cardinal);
begin

end;

procedure TSfmlTexture.UpdateFromPixels(const Pixels: PByte; Width, Height, X,
  Y: Cardinal);
begin

end;

procedure TSfmlTexture.UpdateFromRenderWindow(
  const RenderWindow: PSfmlRenderWindow; X, Y: Cardinal);
begin

end;

procedure TSfmlTexture.UpdateFromWindow(const Window: PSfmlWindow; X,
  Y: Cardinal);
begin

end;


{ TSfmlTransformable }

function TSfmlTransformable.Copy: TSfmlTransformable;
begin

end;

constructor TSfmlTransformable.Create;
begin

end;

destructor TSfmlTransformable.Destroy;
begin

  inherited;
end;

function TSfmlTransformable.GetInverseTransform: TSfmlTransform;
begin

end;

function TSfmlTransformable.GetOrigin: TSfmlVector2f;
begin

end;

function TSfmlTransformable.GetPosition: TSfmlVector2f;
begin

end;

function TSfmlTransformable.GetRotation: Single;
begin

end;

function TSfmlTransformable.GetScale: TSfmlVector2f;
begin

end;

function TSfmlTransformable.GetTransform: TSfmlTransform;
begin

end;

procedure TSfmlTransformable.Move(Offset: TSfmlVector2f);
begin

end;

procedure TSfmlTransformable.Rotate(Angle: Single);
begin

end;

procedure TSfmlTransformable.Scale(Factors: TSfmlVector2f);
begin

end;

procedure TSfmlTransformable.SetOrigin(Origin: TSfmlVector2f);
begin

end;

procedure TSfmlTransformable.SetPosition(Position: TSfmlVector2f);
begin

end;

procedure TSfmlTransformable.SetRotation(Angle: Single);
begin

end;

procedure TSfmlTransformable.SetScale(Scale: TSfmlVector2f);
begin

end;


{ TSfmlVertexArray }

procedure TSfmlVertexArray.Append(Vertex: TSfmlVertex);
begin

end;

procedure TSfmlVertexArray.Clear;
begin

end;

function TSfmlVertexArray.Copy: TSfmlVertexArray;
begin

end;

constructor TSfmlVertexArray.Create;
begin

end;

destructor TSfmlVertexArray.Destroy;
begin

  inherited;
end;

function TSfmlVertexArray.GetBounds: TSfmlFloatRect;
begin

end;

function TSfmlVertexArray.GetPrimitiveType: TSfmlPrimitiveType;
begin

end;

function TSfmlVertexArray.GetVertex(Index: Cardinal): PSfmlVertex;
begin

end;

function TSfmlVertexArray.GetVertexCount: Cardinal;
begin

end;

procedure TSfmlVertexArray.Resize(VertexCount: Cardinal);
begin

end;

procedure TSfmlVertexArray.SetPrimitiveType(&Type: TSfmlPrimitiveType);
begin

end;


{ TSfmlView }

function TSfmlView.Copy: TSfmlView;
begin

end;

constructor TSfmlView.Create;
begin

end;

constructor TSfmlView.Create(Rectangle: TSfmlFloatRect);
begin

end;

destructor TSfmlView.Destroy;
begin

  inherited;
end;

function TSfmlView.GetCenter: TSfmlVector2f;
begin

end;

function TSfmlView.GetRotation: Single;
begin

end;

function TSfmlView.GetSize: TSfmlVector2f;
begin

end;

function TSfmlView.GetViewport: TSfmlFloatRect;
begin

end;

procedure TSfmlView.Move(Offset: TSfmlVector2f);
begin

end;

procedure TSfmlView.Reset(Rectangle: TSfmlFloatRect);
begin

end;

procedure TSfmlView.Rotate(Angle: Single);
begin

end;

procedure TSfmlView.SetCenter(Center: TSfmlVector2f);
begin

end;

procedure TSfmlView.SetRotation(Angle: Single);
begin

end;

procedure TSfmlView.SetSize(Size: TSfmlVector2f);
begin

end;

procedure TSfmlView.SetViewport(Viewport: TSfmlFloatRect);
begin

end;

procedure TSfmlView.Zoom(Factor: Single);
begin

end;

{$IFDEF DynLink}
var
  CSfmlGraphicsHandle: HINST;

procedure InitDLL;

  function BindFunction(Name: AnsiString): Pointer;
  begin
    Result := GetProcAddress(CSfmlGraphicsHandle, PAnsiChar(Name));
    Assert(Assigned(Result));
  end;

begin
  CSfmlGraphicsHandle := LoadLibraryA(CSfmlGraphicsLibrary);
  if CSfmlGraphicsHandle <> 0 then
    try
      SfmlBlendAlpha := BindFunction('sfBlendAlpha');
      SfmlBlendAdd := BindFunction('sfBlendAdd');
      SfmlBlendMultiply := BindFunction('sfBlendMultiply');
      SfmlBlendNone := BindFunction('sfBlendNone');

      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlack'))^, SfmlBlack, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfWhite'))^, SfmlWhite, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfRed'))^, SfmlRed, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfGreen'))^, SfmlGreen, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfBlue'))^, SfmlBlue, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfYellow'))^, SfmlYellow, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfMagenta'))^, SfmlMagenta, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfCyan'))^, SfmlCyan, 4);
      Move(GetProcAddress(CSfmlGraphicsHandle, PAnsiChar('sfTransparent'))^, SfmlTransparent, 4);

      SfmlColorFromRGB := BindFunction('sfColor_fromRGB');
      SfmlColorFromRGBA := BindFunction('sfColor_fromRGBA');
      SfmlColorAdd := BindFunction('sfColor_add');
      SfmlColorModulate := BindFunction('sfColor_modulate');
      SfmlCircleShapeCreate := BindFunction('sfCircleShape_create');
      SfmlCircleShapeCopy := BindFunction('sfCircleShape_copy');
      SfmlCircleShapeDestroy := BindFunction('sfCircleShape_destroy');
      SfmlCircleShapeSetPosition := BindFunction('sfCircleShape_setPosition');
      SfmlCircleShapeSetRotation := BindFunction('sfCircleShape_setRotation');
      SfmlCircleShapeSetScale := BindFunction('sfCircleShape_setScale');
      SfmlCircleShapeSetOrigin := BindFunction('sfCircleShape_setOrigin');
      SfmlCircleShapeGetPosition := BindFunction('sfCircleShape_getPosition');
      SfmlCircleShapeGetRotation := BindFunction('sfCircleShape_getRotation');
      SfmlCircleShapeGetScale := BindFunction('sfCircleShape_getScale');
      SfmlCircleShapeGetOrigin := BindFunction('sfCircleShape_getOrigin');
      SfmlCircleShapeMove := BindFunction('sfCircleShape_move');
      SfmlCircleShapeRotate := BindFunction('sfCircleShape_rotate');
      SfmlCircleShapeScale := BindFunction('sfCircleShape_scale');
      SfmlCircleShapeGetTransform := BindFunction('sfCircleShape_getTransform');
      SfmlCircleShapeGetInverseTransform := BindFunction('sfCircleShape_getInverseTransform');
      SfmlCircleShapeSetTexture := BindFunction('sfCircleShape_setTexture');
      SfmlCircleShapeSetTextureRect := BindFunction('sfCircleShape_setTextureRect');
      SfmlCircleShapeSetFillColor := BindFunction('sfCircleShape_setFillColor');
      SfmlCircleShapeSetOutlineColor := BindFunction('sfCircleShape_setOutlineColor');
      SfmlCircleShapeSetOutlineThickness := BindFunction('sfCircleShape_setOutlineThickness');
      SfmlCircleShapeGetTexture := BindFunction('sfCircleShape_getTexture');
      SfmlCircleShapeGetTextureRect := BindFunction('sfCircleShape_getTextureRect');
      SfmlCircleShapeGetFillColor := BindFunction('sfCircleShape_getFillColor');
      SfmlCircleShapeGetOutlineColor := BindFunction('sfCircleShape_getOutlineColor');
      SfmlCircleShapeGetOutlineThickness := BindFunction('sfCircleShape_getOutlineThickness');
      SfmlCircleShapeGetPointCount := BindFunction('sfCircleShape_getPointCount');
      SfmlCircleShapeGetPoint := BindFunction('sfCircleShape_getPoint');
      SfmlCircleShapeSetRadius := BindFunction('sfCircleShape_setRadius');
      SfmlCircleShapeGetRadius := BindFunction('sfCircleShape_getRadius');
      SfmlCircleShapeSetPointCount := BindFunction('sfCircleShape_setPointCount');
      SfmlCircleShapeGetLocalBounds := BindFunction('sfCircleShape_getLocalBounds');
      SfmlCircleShapeGetGlobalBounds := BindFunction('sfCircleShape_getGlobalBounds');
      SfmlConvexShapeCreate:= BindFunction('sfConvexShape_create');
      SfmlConvexShapeCopy := BindFunction('sfConvexShape_copy');
      SfmlConvexShapeDestroy := BindFunction('sfConvexShape_destroy');
      SfmlConvexShapeSetPosition := BindFunction('sfConvexShape_setPosition');
      SfmlConvexShapeSetRotation := BindFunction('sfConvexShape_setRotation');
      SfmlConvexShapeSetScale := BindFunction('sfConvexShape_setScale');
      SfmlConvexShapeSetOrigin := BindFunction('sfConvexShape_setOrigin');
      SfmlConvexShapeGetPosition := BindFunction('sfConvexShape_getPosition');
      SfmlConvexShapeGetRotation := BindFunction('sfConvexShape_getRotation');
      SfmlConvexShapeGetScale := BindFunction('sfConvexShape_getScale');
      SfmlConvexShapeGetOrigin := BindFunction('sfConvexShape_getOrigin');
      SfmlConvexShapeMove := BindFunction('sfConvexShape_move');
      SfmlConvexShapeRotate := BindFunction('sfConvexShape_rotate');
      SfmlConvexShapeScale := BindFunction('sfConvexShape_scale');
      SfmlConvexShapeGetTransform := BindFunction('sfConvexShape_getTransform');
      SfmlConvexShapeGetInverseTransform := BindFunction('sfConvexShape_getInverseTransform');
      SfmlConvexShapeSetTexture := BindFunction('sfConvexShape_setTexture');
      SfmlConvexShapeSetTextureRect := BindFunction('sfConvexShape_setTextureRect');
      SfmlConvexShapeSetFillColor := BindFunction('sfConvexShape_setFillColor');
      SfmlConvexShapeSetOutlineColor := BindFunction('sfConvexShape_setOutlineColor');
      SfmlConvexShapeSetOutlineThickness := BindFunction('sfConvexShape_setOutlineThickness');
      SfmlConvexShapeGetTexture := BindFunction('sfConvexShape_getTexture');
      SfmlConvexShapeGetTextureRect := BindFunction('sfConvexShape_getTextureRect');
      SfmlConvexShapeGetFillColor := BindFunction('sfConvexShape_getFillColor');
      SfmlConvexShapeGetOutlineColor := BindFunction('sfConvexShape_getOutlineColor');
      SfmlConvexShapeGetOutlineThickness := BindFunction('sfConvexShape_getOutlineThickness');
      SfmlConvexShapeGetPointCount := BindFunction('sfConvexShape_getPointCount');
      SfmlConvexShapeGetPoint := BindFunction('sfConvexShape_getPoint');
      SfmlConvexShapeSetPointCount := BindFunction('sfConvexShape_setPointCount');
      SfmlConvexShapeSetPoint := BindFunction('sfConvexShape_setPoint');
      SfmlConvexShapeGetLocalBounds := BindFunction('sfConvexShape_getLocalBounds');
      SfmlConvexShapeGetGlobalBounds := BindFunction('sfConvexShape_getGlobalBounds');
      SfmlFontCreateFromFile := BindFunction('sfFont_createFromFile');
      SfmlFontCreateFromMemory := BindFunction('sfFont_createFromMemory');
      SfmlFontCreateFromStream := BindFunction('sfFont_createFromStream');
      SfmlFontCopy := BindFunction('sfFont_copy');
      SfmlFontDestroy := BindFunction('sfFont_destroy');
      SfmlFontGetGlyph := BindFunction('sfFont_getGlyph');
      SfmlFontGetKerning := BindFunction('sfFont_getKerning');
      SfmlFontGetLineSpacing := BindFunction('sfFont_getLineSpacing');
      SfmlFontGetUnderlinePosition := BindFunction('sfFont_getUnderlinePosition');
      SfmlFontGetUnderlineThickness := BindFunction('sfFont_getUnderlineThickness');
      SfmlFontGetTexture := BindFunction('sfFont_getTexture');
      SfmlFontGetInfo := BindFunction('sfFont_getInfo');
      SfmlImageCreate := BindFunction('sfImage_create');
      SfmlImageCreateFromColor := BindFunction('sfImage_createFromColor');
      SfmlImageCreateFromPixels := BindFunction('sfImage_createFromPixels');
      SfmlImageCreateFromFile := BindFunction('sfImage_createFromFile');
      SfmlImageCreateFromMemory := BindFunction('sfImage_createFromMemory');
      SfmlImageCreateFromStream := BindFunction('sfImage_createFromStream');
      SfmlImageCopy := BindFunction('sfImage_copy');
      SfmlImageDestroy := BindFunction('sfImage_destroy');
      SfmlImageSaveToFile := BindFunction('sfImage_saveToFile');
      SfmlImageGetSize := BindFunction('sfImage_getSize');
      SfmlImageCreateMaskFromColor := BindFunction('sfImage_createMaskFromColor');
      SfmlImageCopyImage := BindFunction('sfImage_copyImage');
      SfmlImageSetPixel := BindFunction('sfImage_setPixel');
      SfmlImageGetPixel := BindFunction('sfImage_getPixel');
      SfmlImageGetPixelsPtr := BindFunction('sfImage_getPixelsPtr');
      SfmlImageFlipHorizontally := BindFunction('sfImage_flipHorizontally');
      SfmlImageFlipVertically := BindFunction('sfImage_flipVertically');
      SfmlFloatRectContains := BindFunction('sfFloatRect_contains');
      SfmlIntRectContains := BindFunction('sfIntRect_contains');
      SfmlFloatRectIntersects := BindFunction('sfFloatRect_intersects');
      SfmlIntRectIntersects := BindFunction('sfIntRect_intersects');
      SfmlRectangleShapeCreate := BindFunction('sfRectangleShape_create');
      SfmlRectangleShapeCopy := BindFunction('sfRectangleShape_copy');
      SfmlRectangleShapeDestroy := BindFunction('sfRectangleShape_destroy');
      SfmlRectangleShapeSetPosition := BindFunction('sfRectangleShape_setPosition');
      SfmlRectangleShapeSetRotation := BindFunction('sfRectangleShape_setRotation');
      SfmlRectangleShapeSetScale := BindFunction('sfRectangleShape_setScale');
      SfmlRectangleShapeSetOrigin := BindFunction('sfRectangleShape_setOrigin');
      SfmlRectangleShapeGetPosition := BindFunction('sfRectangleShape_getPosition');
      SfmlRectangleShapeGetRotation := BindFunction('sfRectangleShape_getRotation');
      SfmlRectangleShapeGetScale := BindFunction('sfRectangleShape_getScale');
      SfmlRectangleShapeGetOrigin := BindFunction('sfRectangleShape_getOrigin');
      SfmlRectangleShapeMove := BindFunction('sfRectangleShape_move');
      SfmlRectangleShapeRotate := BindFunction('sfRectangleShape_rotate');
      SfmlRectangleShapeScale := BindFunction('sfRectangleShape_scale');
      SfmlRectangleShapeGetTransform := BindFunction('sfRectangleShape_getTransform');
      SfmlRectangleShapeGetInverseTransform := BindFunction('sfRectangleShape_getInverseTransform');
      SfmlRectangleShapeSetTexture := BindFunction('sfRectangleShape_setTexture');
      SfmlRectangleShapeSetTextureRect := BindFunction('sfRectangleShape_setTextureRect');
      SfmlRectangleShapeSetFillColor := BindFunction('sfRectangleShape_setFillColor');
      SfmlRectangleShapeSetOutlineColor := BindFunction('sfRectangleShape_setOutlineColor');
      SfmlRectangleShapeSetOutlineThickness := BindFunction('sfRectangleShape_setOutlineThickness');
      SfmlRectangleShapeGetTexture := BindFunction('sfRectangleShape_getTexture');
      SfmlRectangleShapeGetTextureRect := BindFunction('sfRectangleShape_getTextureRect');
      SfmlRectangleShapeGetFillColor := BindFunction('sfRectangleShape_getFillColor');
      SfmlRectangleShapeGetOutlineColor := BindFunction('sfRectangleShape_getOutlineColor');
      SfmlRectangleShapeGetOutlineThickness := BindFunction('sfRectangleShape_getOutlineThickness');
      SfmlRectangleShapeGetPointCount := BindFunction('sfRectangleShape_getPointCount');
      SfmlRectangleShapeGetPoint := BindFunction('sfRectangleShape_getPoint');
      SfmlRectangleShapeSetSize := BindFunction('sfRectangleShape_setSize');
      SfmlRectangleShapeGetSize := BindFunction('sfRectangleShape_getSize');
      SfmlRectangleShapeGetLocalBounds := BindFunction('sfRectangleShape_getLocalBounds');
      SfmlRectangleShapeGetGlobalBounds := BindFunction('sfRectangleShape_getGlobalBounds');
      SfmlRenderTextureCreate := BindFunction('sfRenderTexture_create');
      SfmlRenderTextureDestroy := BindFunction('sfRenderTexture_destroy');
      SfmlRenderTextureGetSize := BindFunction('sfRenderTexture_getSize');
      SfmlRenderTextureSetActive := BindFunction('sfRenderTexture_setActive');
      SfmlRenderTextureDisplay := BindFunction('sfRenderTexture_display');
      SfmlRenderTextureClear := BindFunction('sfRenderTexture_clear');
      SfmlRenderTextureSetView := BindFunction('sfRenderTexture_setView');
      SfmlRenderTextureGetView := BindFunction('sfRenderTexture_getView');
      SfmlRenderTextureGetDefaultView := BindFunction('sfRenderTexture_getDefaultView');
      SfmlRenderTextureGetViewport := BindFunction('sfRenderTexture_getViewport');
      SfmlRenderTextureMapPixelToCoords := BindFunction('sfRenderTexture_mapPixelToCoords');
      SfmlRenderTextureMapCoordsToPixel := BindFunction('sfRenderTexture_mapCoordsToPixel');
      SfmlRenderTextureDrawSprite := BindFunction('sfRenderTexture_drawSprite');
      SfmlRenderTextureDrawText := BindFunction('sfRenderTexture_drawText');
      SfmlRenderTextureDrawShape := BindFunction('sfRenderTexture_drawShape');
      SfmlRenderTextureDrawCircleShape := BindFunction('sfRenderTexture_drawCircleShape');
      SfmlRenderTextureDrawConvexShape := BindFunction('sfRenderTexture_drawConvexShape');
      SfmlRenderTextureDrawRectangleShape := BindFunction('sfRenderTexture_drawRectangleShape');
      SfmlRenderTextureDrawVertexArray := BindFunction('sfRenderTexture_drawVertexArray');
      SfmlRenderTextureDrawPrimitives := BindFunction('sfRenderTexture_drawPrimitives');
      SfmlRenderTexturePushGLStates := BindFunction('sfRenderTexture_pushGLStates');
      SfmlRenderTexturePopGLStates := BindFunction('sfRenderTexture_popGLStates');
      SfmlRenderTextureResetGLStates := BindFunction('sfRenderTexture_resetGLStates');
      SfmlRenderTextureGetTexture := BindFunction('sfRenderTexture_getTexture');
      SfmlRenderTextureSetSmooth := BindFunction('sfRenderTexture_setSmooth');
      SfmlRenderTextureIsSmooth := BindFunction('sfRenderTexture_isSmooth');
      SfmlRenderTextureSetRepeated := BindFunction('sfRenderTexture_setRepeated');
      SfmlRenderTextureIsRepeated := BindFunction('sfRenderTexture_isRepeated');
      SfmlRenderWindowCreate := BindFunction('sfRenderWindow_create');
      SfmlRenderWindowCreateUnicode := BindFunction('sfRenderWindow_createUnicode');
      SfmlRenderWindowCreateFromHandle := BindFunction('sfRenderWindow_createFromHandle');
      SfmlRenderWindowDestroy := BindFunction('sfRenderWindow_destroy');
      SfmlRenderWindowClose := BindFunction('sfRenderWindow_close');
      SfmlRenderWindowIsOpen := BindFunction('sfRenderWindow_isOpen');
      SfmlRenderWindowGetSettings := BindFunction('sfRenderWindow_getSettings');
      SfmlRenderWindowPollEvent := BindFunction('sfRenderWindow_pollEvent');
      SfmlRenderWindowWaitEvent := BindFunction('sfRenderWindow_waitEvent');
      SfmlRenderWindowGetPosition := BindFunction('sfRenderWindow_getPosition');
      SfmlRenderWindowSetPosition := BindFunction('sfRenderWindow_setPosition');
      SfmlRenderWindowGetSize := BindFunction('sfRenderWindow_getSize');
      SfmlRenderWindowSetSize := BindFunction('sfRenderWindow_setSize');
      SfmlRenderWindowSetTitle := BindFunction('sfRenderWindow_setTitle');
      SfmlRenderWindowSetUnicodeTitle := BindFunction('sfRenderWindow_setUnicodeTitle');
      SfmlRenderWindowSetIcon := BindFunction('sfRenderWindow_setIcon');
      SfmlRenderWindowSetVisible := BindFunction('sfRenderWindow_setVisible');
      SfmlRenderWindowSetMouseCursorVisible := BindFunction('sfRenderWindow_setMouseCursorVisible');
      SfmlRenderWindowSetVerticalSyncEnabled := BindFunction('sfRenderWindow_setVerticalSyncEnabled');
      SfmlRenderWindowSetKeyRepeatEnabled := BindFunction('sfRenderWindow_setKeyRepeatEnabled');
      SfmlRenderWindowSetActive := BindFunction('sfRenderWindow_setActive');
      SfmlRenderWindowRequestFocus := BindFunction('sfRenderWindow_requestFocus');
      SfmlRenderWindowHasFocus := BindFunction('sfRenderWindow_hasFocus');
      SfmlRenderWindowDisplay := BindFunction('sfRenderWindow_display');
      SfmlRenderWindowSetFramerateLimit := BindFunction('sfRenderWindow_setFramerateLimit');
      SfmlRenderWindowSetJoystickThreshold := BindFunction('sfRenderWindow_setJoystickThreshold');
      SfmlRenderWindowGetSystemHandle := BindFunction('sfRenderWindow_getSystemHandle');
      SfmlRenderWindowClear := BindFunction('sfRenderWindow_clear');
      SfmlRenderWindowSetView := BindFunction('sfRenderWindow_setView');
      SfmlRenderWindowGetView := BindFunction('sfRenderWindow_getView');
      SfmlRenderWindowGetDefaultView := BindFunction('sfRenderWindow_getDefaultView');
      SfmlRenderWindowGetViewport := BindFunction('sfRenderWindow_getViewport');
      SfmlRenderWindowMapPixelToCoords := BindFunction('sfRenderWindow_mapPixelToCoords');
      SfmlRenderWindowMapCoordsToPixel := BindFunction('sfRenderWindow_mapCoordsToPixel');
      SfmlRenderWindowDrawSprite := BindFunction('sfRenderWindow_drawSprite');
      SfmlRenderWindowDrawText := BindFunction('sfRenderWindow_drawText');
      SfmlRenderWindowDrawShape := BindFunction('sfRenderWindow_drawShape');
      SfmlRenderWindowDrawCircleShape := BindFunction('sfRenderWindow_drawCircleShape');
      SfmlRenderWindowDrawConvexShape := BindFunction('sfRenderWindow_drawConvexShape');
      SfmlRenderWindowDrawRectangleShape := BindFunction('sfRenderWindow_drawRectangleShape');
      SfmlRenderWindowDrawVertexArray := BindFunction('sfRenderWindow_drawVertexArray');
      SfmlRenderWindowDrawPrimitives := BindFunction('sfRenderWindow_drawPrimitives');
      SfmlRenderWindowPushGLStates := BindFunction('sfRenderWindow_pushGLStates');
      SfmlRenderWindowPopGLStates := BindFunction('sfRenderWindow_popGLStates');
      SfmlRenderWindowResetGLStates := BindFunction('sfRenderWindow_resetGLStates');
      SfmlRenderWindowCapture := BindFunction('sfRenderWindow_capture');
      SfmlMouseGetPositionRenderWindow := BindFunction('sfMouse_getPositionRenderWindow');
      SfmlMouseSetPositionRenderWindow := BindFunction('sfMouse_setPositionRenderWindow');
      SfmlTouchGetPositionRenderWindow := BindFunction('sfTouch_getPositionRenderWindow');
      SfmlShaderCreateFromFile := BindFunction('sfShader_createFromFile');
      SfmlShaderCreateFromMemory := BindFunction('sfShader_createFromMemory');
      SfmlShaderCreateFromStream := BindFunction('sfShader_createFromStream');
      SfmlShaderDestroy := BindFunction('sfShader_destroy');
      SfmlShadersetFloatParameter := BindFunction('sfShader_setFloatParameter');
      SfmlShaderSetFloat2Parameter := BindFunction('sfShader_setFloat2Parameter');
      SfmlShaderSetFloat3Parameter := BindFunction('sfShader_setFloat3Parameter');
      SfmlShaderSetFloat4Parameter := BindFunction('sfShader_setFloat4Parameter');
      SfmlShaderSetVector2Parameter := BindFunction('sfShader_setVector2Parameter');
      SfmlShaderSetVector3Parameter := BindFunction('sfShader_setVector3Parameter');
      SfmlShaderSetColorParameter := BindFunction('sfShader_setColorParameter');
      SfmlShaderSetTransformParameter := BindFunction('sfShader_setTransformParameter');
      SfmlShaderSetTextureParameter := BindFunction('sfShader_setTextureParameter');
      SfmlShaderSetCurrentTextureParameter := BindFunction('sfShader_setCurrentTextureParameter');
      SfmlShaderBind := BindFunction('sfShader_bind');
      SfmlShaderIsAvailable := BindFunction('sfShader_isAvailable');
      SfmlShapeCreate := BindFunction('sfShape_create');
      SfmlShapeDestroy := BindFunction('sfShape_destroy');
      SfmlShapeSetPosition := BindFunction('sfShape_setPosition');
      SfmlShapeSetRotation := BindFunction('sfShape_setRotation');
      SfmlShapeSetScale := BindFunction('sfShape_setScale');
      SfmlShapeSetOrigin := BindFunction('sfShape_setOrigin');
      SfmlShapeGetPosition := BindFunction('sfShape_getPosition');
      SfmlShapeGetRotation := BindFunction('sfShape_getRotation');
      SfmlShapeGetScale := BindFunction('sfShape_getScale');
      SfmlShapeGetOrigin := BindFunction('sfShape_getOrigin');
      SfmlShapeMove := BindFunction('sfShape_move');
      SfmlShapeRotate := BindFunction('sfShape_rotate');
      SfmlShapeScale := BindFunction('sfShape_scale');
      SfmlShapeGetTransform := BindFunction('sfShape_getTransform');
      SfmlShapeGetInverseTransform := BindFunction('sfShape_getInverseTransform');
      SfmlShapeSetTexture := BindFunction('sfShape_setTexture');
      SfmlShapeSetTextureRect := BindFunction('sfShape_setTextureRect');
      SfmlShapeSetFillColor := BindFunction('sfShape_setFillColor');
      SfmlShapeSetOutlineColor := BindFunction('sfShape_setOutlineColor');
      SfmlShapeSetOutlineThickness := BindFunction('sfShape_setOutlineThickness');
      SfmlShapeGetTexture := BindFunction('sfShape_getTexture');
      SfmlShapeGetTextureRect := BindFunction('sfShape_getTextureRect');
      SfmlShapeGetFillColor := BindFunction('sfShape_getFillColor');
      SfmlShapeGetOutlineColor := BindFunction('sfShape_getOutlineColor');
      SfmlShapeGetOutlineThickness := BindFunction('sfShape_getOutlineThickness');
      SfmlShapeGetPointCount := BindFunction('sfShape_getPointCount');
      SfmlShapeGetPoint := BindFunction('sfShape_getPoint');
      SfmlShapeGetLocalBounds := BindFunction('sfShape_getLocalBounds');
      SfmlShapeGetGlobalBounds := BindFunction('sfShape_getGlobalBounds');
      SfmlShapeUpdate := BindFunction('sfShape_update');
      SfmlSpriteCreate := BindFunction('sfSprite_create');
      SfmlSpriteCopy := BindFunction('sfSprite_copy');
      SfmlSpriteDestroy := BindFunction('sfSprite_destroy');
      SfmlSpriteSetPosition := BindFunction('sfSprite_setPosition');
      SfmlSpriteSetRotation := BindFunction('sfSprite_setRotation');
      SfmlSpriteSetScale := BindFunction('sfSprite_setScale');
      SfmlSpriteSetOrigin := BindFunction('sfSprite_setOrigin');
      SfmlSpriteGetPosition := BindFunction('sfSprite_getPosition');
      SfmlSpriteGetRotation := BindFunction('sfSprite_getRotation');
      SfmlSpriteGetScale := BindFunction('sfSprite_getScale');
      SfmlSpriteGetOrigin := BindFunction('sfSprite_getOrigin');
      SfmlSpriteMove := BindFunction('sfSprite_move');
      SfmlSpriteRotate := BindFunction('sfSprite_rotate');
      SfmlSpriteScale := BindFunction('sfSprite_scale');
      SfmlSpriteGetTransform := BindFunction('sfSprite_getTransform');
      SfmlSpriteGetInverseTransform := BindFunction('sfSprite_getInverseTransform');
      SfmlSpriteSetTexture := BindFunction('sfSprite_setTexture');
      SfmlSpriteSetTextureRect := BindFunction('sfSprite_setTextureRect');
      SfmlSpriteSetColor := BindFunction('sfSprite_setColor');
      SfmlSpriteGetTexture := BindFunction('sfSprite_getTexture');
      SfmlSpriteGetTextureRect := BindFunction('sfSprite_getTextureRect');
      SfmlSpriteGetColor := BindFunction('sfSprite_getColor');
      SfmlSpriteGetLocalBounds := BindFunction('sfSprite_getLocalBounds');
      SfmlSpriteGetGlobalBounds := BindFunction('sfSprite_getGlobalBounds');
      SfmlTextCreate := BindFunction('sfText_create');
      SfmlTextCopy := BindFunction('sfText_copy');
      SfmlTextDestroy := BindFunction('sfText_destroy');
      SfmlTextSetPosition := BindFunction('sfText_setPosition');
      SfmlTextSetRotation := BindFunction('sfText_setRotation');
      SfmlTextSetScale := BindFunction('sfText_setScale');
      SfmlTextSetOrigin := BindFunction('sfText_setOrigin');
      SfmlTextGetPosition := BindFunction('sfText_getPosition');
      SfmlTextGetRotation := BindFunction('sfText_getRotation');
      SfmlTextGetScale := BindFunction('sfText_getScale');
      SfmlTextGetOrigin := BindFunction('sfText_getOrigin');
      SfmlTextMove := BindFunction('sfText_move');
      SfmlTextRotate := BindFunction('sfText_rotate');
      SfmlTextScale := BindFunction('sfText_scale');
      SfmlTextGetTransform := BindFunction('sfText_getTransform');
      SfmlTextGetInverseTransform := BindFunction('sfText_getInverseTransform');
      SfmlTextSetString := BindFunction('sfText_setString');
      SfmlTextSetUnicodeString := BindFunction('sfText_setUnicodeString');
      SfmlTextSetFont := BindFunction('sfText_setFont');
      SfmlTextSetCharacterSize := BindFunction('sfText_setCharacterSize');
      SfmlTextSetStyle := BindFunction('sfText_setStyle');
      SfmlTextSetColor := BindFunction('sfText_setColor');
      SfmlTextGetString := BindFunction('sfText_getString');
      SfmlTextGetUnicodeString := BindFunction('sfText_getUnicodeString');
      SfmlTextGetFont := BindFunction('sfText_getFont');
      SfmlTextGetCharacterSize := BindFunction('sfText_getCharacterSize');
      SfmlTextGetStyle := BindFunction('sfText_getStyle');
      SfmlTextGetColor := BindFunction('sfText_getColor');
      SfmlTextFindCharacterPos := BindFunction('sfText_findCharacterPos');
      SfmlTextGetLocalBounds := BindFunction('sfText_getLocalBounds');
      SfmlTextGetGlobalBounds := BindFunction('sfText_getGlobalBounds');
      SfmlTextureCreate := BindFunction('sfTexture_create');
      SfmlTextureCreateFromFile := BindFunction('sfTexture_createFromFile');
      SfmlTextureCreateFromMemory := BindFunction('sfTexture_createFromMemory');
      SfmlTextureCreateFromStream := BindFunction('sfTexture_createFromStream');
      SfmlTextureCreateFromImage := BindFunction('sfTexture_createFromImage');
      SfmlTextureCopy := BindFunction('sfTexture_copy');
      SfmlTextureDestroy := BindFunction('sfTexture_destroy');
      SfmlTextureGetSize := BindFunction('sfTexture_getSize');
      SfmlTextureCopyToImage := BindFunction('sfTexture_copyToImage');
      SfmlTextureUpdateFromPixels := BindFunction('sfTexture_updateFromPixels');
      SfmlTextureUpdateFromImage := BindFunction('sfTexture_updateFromImage');
      SfmlTextureUpdateFromWindow := BindFunction('sfTexture_updateFromWindow');
      SfmlTextureUpdateFromRenderWindow := BindFunction('sfTexture_updateFromRenderWindow');
      SfmlTextureSetSmooth := BindFunction('sfTexture_setSmooth');
      SfmlTextureIsSmooth := BindFunction('sfTexture_isSmooth');
      SfmlTextureSetRepeated := BindFunction('sfTexture_setRepeated');
      SfmlTextureIsRepeated := BindFunction('sfTexture_isRepeated');
      SfmlTextureBind := BindFunction('sfTexture_bind');
      SfmlTextureGetMaximumSize := BindFunction('sfTexture_getMaximumSize');
      SfmlTransformidentity := BindFunction('sfTransform_Identity');
      SfmlTransformFromMatrix := BindFunction('sfTransform_fromMatrix');
      SfmlTransformGetMatrix := BindFunction('sfTransform_getMatrix');
      SfmlTransformGetInverse := BindFunction('sfTransform_getInverse');
      SfmlTransformTransformPoint := BindFunction('sfTransform_transformPoint');
      SfmlTransformTransformRect := BindFunction('sfTransform_transformRect');
      SfmlTransformCombine := BindFunction('sfTransform_combine');
      SfmlTransformTranslate := BindFunction('sfTransform_translate');
      SfmlTransformRotate := BindFunction('sfTransform_rotate');
      SfmlTransformRotateWithCenter := BindFunction('sfTransform_rotateWithCenter');
      SfmlTransformScale := BindFunction('sfTransform_scale');
      SfmlTransformScaleWithCenter := BindFunction('sfTransform_scaleWithCenter');
      SfmlTransformableCreate := BindFunction('sfTransformable_create');
      SfmlTransformableCopy := BindFunction('sfTransformable_copy');
      SfmlTransformableDestroy := BindFunction('sfTransformable_destroy');
      SfmlTransformableSetPosition := BindFunction('sfTransformable_setPosition');
      SfmlTransformableSetRotation := BindFunction('sfTransformable_setRotation');
      SfmlTransformableSetScale := BindFunction('sfTransformable_setScale');
      SfmlTransformableSetOrigin := BindFunction('sfTransformable_setOrigin');
      SfmlTransformableGetPosition := BindFunction('sfTransformable_getPosition');
      SfmlTransformableGetRotation := BindFunction('sfTransformable_getRotation');
      SfmlTransformableGetScale := BindFunction('sfTransformable_getScale');
      SfmlTransformableGetOrigin := BindFunction('sfTransformable_getOrigin');
      SfmlTransformableMove := BindFunction('sfTransformable_move');
      SfmlTransformableRotate := BindFunction('sfTransformable_rotate');
      SfmlTransformableScale := BindFunction('sfTransformable_scale');
      SfmlTransformableGetTransform := BindFunction('sfTransformable_getTransform');
      SfmlTransformableGetInverseTransform := BindFunction('sfTransformable_getInverseTransform');
      SfmlVertexArrayCreate := BindFunction('sfVertexArray_create');
      SfmlVertexArrayCopy := BindFunction('sfVertexArray_copy');
      SfmlVertexArrayDestroy := BindFunction('sfVertexArray_destroy');
      SfmlVertexArrayGetVertexCount := BindFunction('sfVertexArray_getVertexCount');
      SfmlVertexArrayGetVertex := BindFunction('sfVertexArray_getVertex');
      SfmlVertexArrayClear := BindFunction('sfVertexArray_clear');
      SfmlVertexArrayResize := BindFunction('sfVertexArray_resize');
      SfmlVertexArrayAppend := BindFunction('sfVertexArray_append');
      SfmlVertexArraySetPrimitiveType := BindFunction('sfVertexArray_setPrimitiveType');
      SfmlVertexArrayGetPrimitiveType := BindFunction('sfVertexArray_getPrimitiveType');
      SfmlVertexArrayGetBounds := BindFunction('sfVertexArray_getBounds');
      SfmlViewCreate := BindFunction('sfView_create');
      SfmlViewCreateFromRect := BindFunction('sfView_createFromRect');
      SfmlViewCopy := BindFunction('sfView_copy');
      SfmlViewDestroy := BindFunction('sfView_destroy');
      SfmlViewSetCenter := BindFunction('sfView_setCenter');
      SfmlViewSetSize := BindFunction('sfView_setSize');
      SfmlViewSetRotation := BindFunction('sfView_setRotation');
      SfmlViewSetViewport := BindFunction('sfView_setViewport');
      SfmlViewReset := BindFunction('sfView_reset');
      SfmlViewGetCenter := BindFunction('sfView_getCenter');
      SfmlViewGetSize := BindFunction('sfView_getSize');
      SfmlViewGetRotation := BindFunction('sfView_getRotation');
      SfmlViewGetViewport := BindFunction('sfView_getViewport');
      SfmlViewMove := BindFunction('sfView_move');
      SfmlViewRotate := BindFunction('sfView_rotate');
      SfmlViewZoom := BindFunction('sfView_zoom');
    except
      FreeLibrary(CSfmlGraphicsHandle);
      CSfmlGraphicsHandle := 0;
    end;
end;

procedure FreeDLL;
begin
  if CSfmlGraphicsHandle <> 0 then
    FreeLibrary(CSfmlGraphicsHandle);
end;

initialization

InitDLL;

finalization

FreeDLL;

{$ENDIF}
end.
