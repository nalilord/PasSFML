unit SceneNode;

interface

uses
  SfmlGraphics, SfmlSystem, SfmlWindow;

type
  TSceneNode = class(TSfmlTransformable) //SfmlTransformable, public SfmlDrawable, private SfmlNonCopyable
  private
    FChildren: array of TSceneNode;
    FParent: TSceneNode;
    procedure UpdateChildren(dt: TSfmlTime);
    procedure DrawChildren(Target: TSfmlRenderTarget;
      States: PSfmlRenderStates = nil);
  protected
    procedure UpdateCurrent(dt: TSfmlTime); virtual;
    procedure DrawCurrent(Target: TSfmlRenderTarget; States: PSfmlRenderStates = nil); virtual;
  public
    constructor Create;

    procedure AttachChild(Child: TSceneNode);
    function DetachChild(const Node: TSceneNode): TSceneNode;

    procedure Draw(Target: TSfmlRenderTarget; States: PSfmlRenderStates = nil); virtual;
    procedure Update(dt: TSfmlTime);

    function GetWorldPosition: TSfmlVector2f;
    function GetWorldTransform: TSfmlTransform;
  end;

implementation

{ TSceneNode }

constructor TSceneNode.Create;
begin
  inherited Create;
  FParent := nil;
  SetLength(FChildren, 0);
end;

procedure TSceneNode.AttachChild(Child: TSceneNode);
var
  Position: Integer;
begin
  Child.FParent := Self;
  Position := Length(FChildren);
  SetLength(FChildren, Position + 1);
  FChildren[Position] := Child;
end;

function TSceneNode.DetachChild(const Node: TSceneNode): TSceneNode;
var
  Index: Integer;
begin
  Result := nil;
  for Index := Low(FChildren) to High(FChildren) do
  begin
    if FChildren[Index] = Node then
    begin
      Node.FParent := nil;
      Result := Node;
      if Index < High(FChildren) then
        System.Move(FChildren[Index + 1], FChildren[Index], (High(FChildren) - Index) * SizeOf(TSceneNode));
      SetLength(FChildren, High(FChildren));
      Exit;
    end;
  end;
end;

procedure TSceneNode.Update(dt: TSfmlTime);
begin
  UpdateCurrent(dt);
  UpdateChildren(dt);
end;

procedure TSceneNode.UpdateCurrent(dt: TSfmlTime);
begin
  // Do nothing by default
end;

procedure TSceneNode.UpdateChildren(dt: TSfmlTime);
var
  Index: Integer;
begin
  for Index := Low(FChildren) to High(FChildren) do
    FChildren[Index].Update(dt);
end;

procedure TSceneNode.Draw(Target: TSfmlRenderTarget;
  States: PSfmlRenderStates = nil);
var
  LocalStates: TSfmlRenderStates;
  NodeTransform: TSfmlTransform;
begin
  if Assigned(States) then
    LocalStates := States^
  else
  begin
    FillChar(LocalStates, SizeOf(LocalStates), 0);
    LocalStates.BlendMode := SfmlBlendAlpha;
    LocalStates.Transform := SfmlTransformIdentity;
  end;

  // Apply transform of current node
  NodeTransform := Transform;
  SfmlTransformCombine(LocalStates.Transform, @NodeTransform);

  // Draw node and children with changed transform
  DrawCurrent(Target, @LocalStates);
  DrawChildren(Target, @LocalStates);
end;

procedure TSceneNode.DrawCurrent(Target: TSfmlRenderTarget;
  States: PSfmlRenderStates = nil);
begin
  // Do nothing by default
end;

procedure TSceneNode.DrawChildren(Target: TSfmlRenderTarget;
  States: PSfmlRenderStates = nil);
var
  Index: Integer;
begin
  for Index := Low(FChildren) to High(FChildren) do
    FChildren[Index].Draw(Target, States);
end;

function TSceneNode.GetWorldPosition: TSfmlVector2f;
begin
  Result := GetWorldTransform.TransformPoint(SfmlVector2f(0, 0));
end;

function TSceneNode.getWorldTransform: TSfmlTransform;
var
  Node: TSceneNode;
  NodeTransform: TSfmlTransform;
begin
  Result := SfmlTransformIdentity;
  Node := Self;
  repeat
    NodeTransform := Node.Transform;
    SfmlTransformCombine(NodeTransform, @Result);
    Result := NodeTransform;
    Node := Node.FParent;
  until Node = nil;
end;

end.
