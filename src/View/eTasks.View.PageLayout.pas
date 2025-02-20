unit eTasks.View.PageLayout;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, eTasks.View.Interfaces,
  eTasks.Components.Interfaces;

type


  TPageLayout = class(TForm, iPageLayout)
    PageViewLayout: TLayout;
    Background: TRectangle;
  private
    { Private declarations }
    MainLayout: TLayout;
    UpdateScreenMethod : TUpdateScreenMethod;
    NavBar : iNavBar;
    procedure GoBack(Sender: TObject);
    procedure RemovePageViewLayout;
  public
    { Public declarations }
    function Layout: TLayout;
    function IsMobile(const Value: boolean): iPageLayout;
    function Resize(const Formwidth: integer): iPageLayout;

    class function New(const pLayout: TLayout; pUpdateScreenMethod: TUpdateScreenMethod; LayoutForm: TLayoutForm; EntityID: string = string.Empty) : iPageLayout;
    destructor Destroy; override;
  end;

var
  PageLayout: TPageLayout;

implementation

uses
  eTasks.Components.Builder;

{$R *.fmx}

{ TPageLayout }

destructor TPageLayout.Destroy;
begin
  RemovePageViewLayout;

  inherited;
end;

procedure TPageLayout.GoBack(Sender: TObject);
begin
    RemovePageViewLayout;

    Application.ProcessMessages;

    UpdateScreenMethod;
end;

function TPageLayout.IsMobile(const Value: boolean): iPageLayout;
begin
  Result := Self;
end;

procedure TPageLayout.RemovePageViewLayout;
begin
  if Assigned(MainLayout) and MainLayout.ContainsObject(PageViewLayout) then
    MainLayout.RemoveObject(PageViewLayout);
end;

function TPageLayout.Resize(const Formwidth: integer): iPageLayout;
begin
  Result := Self;
  NavBar.Resize(Formwidth);
end;

function TPageLayout.Layout: TLayout;
begin
  Result := Self.PageViewLayout;
end;

class function TPageLayout.New(const pLayout: TLayout;
  pUpdateScreenMethod: TUpdateScreenMethod; LayoutForm: TLayoutForm;
  EntityID: string): iPageLayout;
begin
  PageLayout := Self.Create(pLayout);
  PageLayout.MainLayout := pLayout;

  PageLayout.NavBar := tcomponentbars.NavBar(PageLayout.PageViewLayout);
  PageLayout.NavBar.OnBtnBackClick(PageLayout.GoBack);

  case LayoutForm of
    lfEditButtons: PageLayout.NavBar.ShowButtons(TNavBarButtons.NavBarEditButtons);
    lfWithUpdateButton: PageLayout.NavBar.ShowButtons(TNavBarButtons.NavBarUpdateButton);
    lfWithHelpButton: PageLayout.NavBar.ShowButtons(TNavBarButtons.NavBarHelpButton);
  end;

  pLayout.AddObject(PageLayout.PageViewLayout);

  PageLayout.UpdateScreenMethod := pUpdateScreenMethod;

  Result := PageLayout;
end;

end.
