unit HopfieldApp;
(*Elric Werst*)

interface

uses
  GBMatrixOperations, HopFieldNetwork,

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, AdvObj, BaseGrid, AdvGrid, Shader,
  AdvSmoothLabel;

type
  THopfieldForm = class(TForm)
    sheet: TAdvStringGrid;
    Shader: TShader;
    TrainBtn: TButton;
    matchBtn: TButton;
    ClearBtn: TButton;
    EraseBtn: TButton;
    TitleLbl: TAdvSmoothLabel;
    procedure FormCreate(Sender: TObject);
    procedure sheetClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure TrainBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure EraseBtnClick(Sender: TObject);
    procedure matchBtnClick(Sender: TObject);
  private
    (*hopfield network*)
    network : HopfieldNet;
    (*grid contains boolean values corresponding to the sheet*)
    grid : T2DBoolean;
    procedure redrawGrid;
  end;

var
  HopfieldForm: THopfieldForm;

implementation

{$R *.dfm}

(*clear button event- sets ever cell in the sheet white*)
procedure THopfieldForm.ClearBtnClick(Sender: TObject);
var
  r,c : integer;
begin
  for r := 0 to sheet.RowCount-1 do
    for c := 0 to sheet.ColCount-1 do
    begin
      sheet.ColorRect(c,r,c,r,clWhite);
      grid[r,c] := false;
    end;
  sheet.SelectionColor := clWhite;

end;

(*Erase button event-sets all the weights in the network to zero*)
procedure THopfieldForm.EraseBtnClick(Sender: TObject);
begin
  ClearBtnClick(sender);
  network.EraseMatrix;
end;

procedure THopfieldForm.FormCreate(Sender: TObject);
begin
  caption := 'Hopfield Network';
  TrainBtn.Caption := 'Train';
  MatchBtn.Caption := 'Match pattern';
  ClearBtn.Caption := 'Clear Table';
  EraseBtn.Caption := 'Erase matrix';
  TitleLbl.Caption.Text := caption;
  setLength(grid,sheet.RowCount, sheet.ColCount);
  network := HopfieldNet.Create(sheet.RowCount*sheet.ColCount);
  clearBtnClick(sender);
  network.EraseMatrix;
end;

(*Match button event*)
procedure THopfieldForm.matchBtnClick(Sender: TObject);
begin
  grid := network.MatchMatrix(grid);
  sheet.SelectionColor := clGreen;
  redrawGrid;
end;


(*loops through the grid and sets the cell to either black or white*)
procedure THopfieldForm.redrawGrid;
var
  r,c : integer;
begin
  for r := 0 to sheet.RowCount-1 do
    for c := 0 to sheet.ColCount-1 do
      if grid[r,c] then
        sheet.ColorRect(c,r,c,r,clBlack)
      else
        sheet.ColorRect(c,r,c,r,clWhite);
end;

(*Event triggered when the mouse clicks on a cell in the sheet*)
procedure THopfieldForm.sheetClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  grid[aRow,aCol] := not grid[aRow,aCol];
  if grid[aRow,aCol] then
  begin
    sheet.ColorRect(aCol,aRow,aCol,aRow,clBlack);
    sheet.SelectionColor := clBlack;
  end
  else
  begin
    sheet.SelectionColor := clWhite;
    sheet.ColorRect(aCol,aRow,aCol,aRow,clWhite);
  end;
end;

(*train button event*)
procedure THopfieldForm.TrainBtnClick(Sender: TObject);
begin
  (*trains current pattern displayed*)
  network.TrainMatrix(grid);
end;

end.
