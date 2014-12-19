program Hopfield;

uses
  Forms,
  HopfieldApp in 'HopfieldApp.pas' {HopfieldForm},
  HopfieldNetwork in 'HopfieldNetwork.pas',
  GBMatrixOperations in 'GBMatrixOperations.pas',
  UTIL in 'UTIL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THopfieldForm, HopfieldForm);
  Application.Run;
end.
