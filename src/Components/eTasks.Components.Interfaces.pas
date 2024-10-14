unit eTasks.Components.Interfaces;

interface

uses
  FMX.Objects,
  FMX.Layouts,
  FMX.MultiView;

type
  TButtonAppBar = (ThemeBtn, MenuBtn);
  TOffcanvasDirection = (ocdLeft, ocdRight);

  TEventoClick = procedure(sender: TObject) of object;

  iTitleBar = interface
    ['{CCA6D914-787E-495F-ADE7-F9472A0FBC45}']
    function SetTitle(const Title: string): iTitleBar;
    function Resize(const FormWidth: Integer): iTitleBar;
    function isDarkMode(const value: boolean): iTitleBar;
  end;

  iAppBar = interface
    ['{D3781F3B-96FF-4017-9F8E-5472178C9ABB}']
    function ChangeTitle(const Title: string): iAppBar;
    function ShowTitleBar(const value: Boolean): TRectangle;
    function Render: TRectangle;
    function isDarkMode(const value: boolean): iAppBar;
    function SetButtonAppBarAction(const ButtonAppBar: TButtonAppBar; const Action: TEventoClick): iAppBar;
  end;

  iOffcanvas = interface
    function Render(const Direction: TOffcanvasDirection = ocdRight; isDarkMode: Boolean = false): TMultiView;
    function isDarkMode(const value: boolean): iOffcanvas;
    function OpenMenu: iOffcanvas;
  end;

implementation


end.
