unit eTasks.view.categorias;

interface

Uses fmx.listbox, system.json;

Type
  iCategorias = interface
    ['{EDB4DEE7-1710-4DF4-9AA8-9046D159FA59}']
    Function PegaImagem (Codigo : string) : string;
    Procedure MontaListagem(lista : tlistbox);
  end;

  TCategorias = Class(TInterfacedObject, iCategorias)
    Private
     FJson : TJSONObject;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iCategorias;
     Function PegaImagem (Codigo : string) : string;
     Procedure MontaListagem(lista : tlistbox);
  End;

implementation

uses
  System.Classes, System.Types, FMX.Objects, eTasks.libraries.Imagens64, 
  FMX.Graphics, System.Generics.Collections;

{ TCategorias }

constructor TCategorias.Create;
Var
 ResStream : TResourceStream;
 Arq_json  : TStrings;
begin
  Arq_json := TStringList.Create;
  try
   ResStream := TResourceStream.Create(HInstance, 'categorias_json', RT_RCDATA);
   try
    ResStream.Position := 0;
    Arq_json.LoadFromStream(ResStream);
    FJson := TJSONObject.ParseJSONValue(Arq_json.Text) as TJSONObject;
   finally
    ResStream.DisposeOf;
   end;
  finally
   Arq_json.DisposeOf;
  end;
end;

destructor TCategorias.Destroy;
begin
  FJson.DisposeOf;
  inherited;
end;

procedure TCategorias.MontaListagem(lista: tlistbox);
Var
 lbitem    : TListBoxItem;
 Bitmap    : tbitmap;
 ItemImage : TImage;
 item      : integer;
begin
  lista.BeginUpdate;
  lista.Items.Clear;
  try
   for item := 0 to FJson.Count-1 do
     begin
       lbitem             := TListBoxItem.Create(nil);
       lbitem.Parent      := lista;
       lbitem.StyleLookup := 'ListBoxItem_EstiloCategoria';
       lbitem.TagString   := FJson.Pairs[item].JsonString.Value;
       ItemImage          := lbitem.FindStyleResource('img_categoria') as TImage;
       if Assigned(ItemImage) then
        begin
         Bitmap           := TImagens64.fromBase64(FJson.Pairs[item].JsonValue.Value);
         ItemImage.Bitmap := Bitmap;
         Bitmap.DisposeOf;
        end;
     end;
  finally
   lista.EndUpdate;
  end;
end;

class function TCategorias.New: iCategorias;
begin
  Result := Self.Create;
end;

function TCategorias.PegaImagem(Codigo: string): string;
begin
  if codigo <> '' then
   Result := FJson.GetValue(Codigo).Value;
end;

end.
