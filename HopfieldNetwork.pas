unit HopfieldNetwork;

interface
uses
  GBMatrixOperations;

type
  HopfieldNet = class(TObject)
    private
      weights : Matrix2DRec;
    public
      function  GetMatrix():Matrix2DRec;
      procedure TrainMatrix(pattern:T2DBoolean);
      function  MatchMatrix(pattern:T2DBoolean):T2DBoolean;
      procedure EraseMatrix();
      constructor Create( size : integer);
  end;


implementation

constructor HopfieldNet.Create( size : integer);
begin
  (*size corresponed to the number of neurons*)
  (*A weighted matrix is created with NXN neurons,
  which defines the connection between each neuron pair*)
  weights.init(size,size, 0);
end;

(*return weighted matrix*)
function  HopfieldNet.GetMatrix():Matrix2DRec;
begin
  result := weights;
end;

(*training procedure->given an input pattern the weighted matrix will change*)
procedure HopfieldNet.TrainMatrix(pattern:T2DBoolean);
var
  identity,
  transpose,
  inputMatrix,
  mult, sb : Matrix2DRec;
  inputBools : Matrix1DRec;
  r,c,index : integer;
begin
  (*convert boolean 2D array into a single array*)
  inputBools.init(length(weights.data),0);
  index := 0;
  for r := 0 to length(pattern)-1 do
    for c := 0 to length(pattern)-1 do
    begin
      if pattern[r,c] then
        inputBools.data[index] := 1
      else
        inputBools.data[index] := -1;
      inc(index);
    end;

  (*take that single array and copy to n rows of the input matrix*)
  inputMatrix.init(length(weights.data), length(weights.data),0);
  for r := 0 to length(weights.data)-1 do
    for c := 0 to length(weights.data)-1 do
        inputMatrix.data[r,c] := inputBools.data[c];

  (*transpose previous matrix, then multiply the two matrices*)
  transpose := inputMatrix.Transpose;
  mult := transpose*inputMatrix;
  (*subtract the previous matrix by the identity*)
  (*the reason is that neurons don't connect to themselves*)
  identity := inputMatrix.Identity;
  sb := mult-identity;

  (*add prev matrix to the weighted matrix*)
  weights := weights+sb;
end;

function  HopfieldNet.MatchMatrix(pattern:T2DBoolean):T2DBoolean;
var
  inputMatrix,
  transpose,
  colMatrix  : Matrix2DRec;
  inputBools : Matrix1DRec;
  r,r2,c, index,
  xpos,ypos : integer;
begin
(*convert boolean pattern into a matrix*)
  inputBools.init(length(weights.data),0);
  index := 0;
  for r := 0 to length(pattern)-1 do
    for c := 0 to length(pattern)-1 do
    begin
      if pattern[r,c] then
        inputBools.data[index] := 1
      else
        inputBools.data[index] := -1;
      inc(index);
    end;

  inputMatrix.init(length(weights.data), length(weights.data),0);
  for r := 0 to length(weights.data)-1 do
    for c := 0 to length(weights.data)-1 do
        inputMatrix.data[r,c] := inputBools.data[c];


  setlength(result, length(pattern), length(pattern));
  colMatrix.init(length(weights.data),length(weights.data),0);
  (*dot product of the input matrix and the transpose matrix*)
  for index := 0 to length(weights.data)-1 do
  begin
    for r2 := 0 to length(weights.data)-1 do
      for c := 0 to length(weights.data)-1 do
        colMatrix.data[r2,c] := weights.data[index,c];

    ypos := trunc(index/length(pattern));
    xpos := index mod length(pattern);
    if inputMatrix.DotProduct(inputMatrix,colMatrix)>0 then
      result[ypos, xpos] := true
    else
      result[ypos, xpos] := false;

  end;

end;

(*set all weights to zero*)
procedure HopfieldNet.EraseMatrix();
begin
  weights.SetDefaultValues(0);
end;

end.
