unit eTasks.View.PageLayout;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  iPageLayout = interface
    ['{E22EAB87-8030-43F8-B0DC-AB57B067C0CD}']
    function _Layout: TLayout;
  end;

  TPageLayout = class(TForm, iPageLayout)
    Button1: TButton;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    Layout: TLayout;
  public
    { Public declarations }
    function _Layout: TLayout;
    class function New(const pLayout: TLayout) : TLayout;
    destructor Destroy; override;
  end;

var
  PageLayout: TPageLayout;

implementation

{$R *.fmx}

{ TPageLayout }

procedure TPageLayout.Button1Click(Sender: TObject);
begin
  if Assigned(Self) then
  begin
    // Remove Layout1 do Layout principal
    if Assigned(Layout) and Layout.ContainsObject(Layout1) then
      Layout.RemoveObject(Layout1);

    // For�a a atualiza��o do foco para o formul�rio principal
    Application.ProcessMessages;

    // Use Release em vez de Free para evitar problemas de mem�ria e foco
    PageLayout.Release;
  end;
end;

destructor TPageLayout.Destroy;
begin

  // Certifique-se de que Layout1 seja removido do layout pai antes de destruir
  if Assigned(Layout) and Layout.ContainsObject(Layout1) then
    Layout.RemoveObject(Layout1);

  inherited;
end;

class function TPageLayout.New(const pLayout: TLayout): TLayout;
begin
  if(Assigned(PageLayout))then
   PageLayout.Release;

  PageLayout := Self.Create(nil);
  PageLayout.Layout := pLayout;
  pLayout.AddObject(PageLayout.Layout1);
  Result := PageLayout.Layout1;
end;

function TPageLayout._Layout: TLayout;
begin
  Result := Self.Layout1;
end;

end.
