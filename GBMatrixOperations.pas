unit GBMatrixOperations;

interface
uses
  math, Util;
const
  UA_RandomSeed = 123;
 type
  T1DArray = array of double;
  T2DArray = array of array of double;
  T3DArray = array of array of array of double;
  T4DArray = array of array of array of array of double;
  T1DBoolean = array of boolean;
  T2DBoolean = array of array of boolean;

  Matrix1DRec = Record
    data : T1DArray;
    class operator Multiply(a: Matrix1DRec; b: Matrix1DRec) : Matrix1DRec;
    class operator Multiply(a: Matrix1DRec; b: double) : Matrix1DRec;
    class operator Multiply(b: double;a: Matrix1DRec) : Matrix1DRec;
    class operator Add(a: Matrix1DRec; b: Matrix1DRec) : Matrix1DRec;
    class operator Add(a: Matrix1DRec; b: double) : Matrix1DRec;
    class operator Add(b: double; a: Matrix1DRec) : Matrix1DRec;
    class operator Subtract(a: Matrix1DRec; b: Matrix1DRec) : Matrix1DRec;
    class operator Subtract(a: Matrix1DRec; b: double) : Matrix1DRec;
    class operator Subtract(b: double; a: Matrix1DRec) : Matrix1DRec;
    class operator Divide(a: Matrix1DRec; b: Matrix1DRec) : Matrix1DRec;
    class operator Divide(a: Matrix1DRec; b: double) : Matrix1DRec;
    class operator Divide(b: double; a: Matrix1DRec) : Matrix1DRec;
    class operator Implicit(a: T1DArray): Matrix1DRec;
    class operator Implicit(a: Matrix1DRec): T1DArray;
    class operator Explicit(a:Matrix1DRec): T1Darray;
    procedure setDimension(x:integer);
    procedure init(x:integer;val:double);
    procedure SetDefaultValues(x:double);
    function  Max : double;
    procedure RandG(m,v:double);
    procedure TriangInv(a,b,c:double);
    procedure RandBeta(a,b : integer);

  End;
  Matrix2DRec = Record
    mult : boolean;
    data :  T2DArray;
    class operator Multiply(a: Matrix2DRec; b: Matrix2DRec) : Matrix2DRec;
    class operator Multiply(a: T1DArray; b : Matrix2DRec):Matrix2DRec;
    class operator Multiply(b : Matrix2DRec;a: T1DArray):Matrix2DRec;
    class operator Multiply(a: Matrix2DRec; b: double) : Matrix2DRec;
    class operator Multiply(b: double;a: Matrix2DRec) : Matrix2DRec;
    class operator Add(a: Matrix2DRec; b: Matrix2DRec) : Matrix2DRec;
    class operator Add(a: Matrix2DRec; b: double) : Matrix2DRec;
    class operator Add(b: double; a: Matrix2DRec) : Matrix2DRec;
    class operator Subtract(a: Matrix2DRec; b: Matrix2DRec) : Matrix2DRec;
    class operator Subtract(a: Matrix2DRec; b: double) : Matrix2DRec;
    class operator Subtract(b: double; a: Matrix2DRec) : Matrix2DRec;
    class operator Divide(a: Matrix2DRec; b: Matrix2DRec) : Matrix2DRec;
    class operator Divide(a: Matrix2DRec; b: double) : Matrix2DRec;
    class operator Divide(b: double; a: Matrix2DRec) : Matrix2DRec;
    class operator Implicit(a: T2DArray): Matrix2DRec;
    class operator Implicit(a: Matrix2DRec): T2DArray;
    class operator Implicit(a: Matrix1DRec):Matrix2DRec;
    class operator Explicit(a:Matrix2DRec): T2Darray;
    procedure setDimension(x,y:integer);
    procedure SetDefaultValues(x:double);
    procedure init(x,y:integer;val:double);
    procedure RandG(m,v:double);overload;
    procedure TriangInv(a,b,c:double);overload;
    procedure RandBeta(a,b : T1DArray);overload;
    procedure RandG(m,v:double;height,width:integer);overload;
    procedure TriangInv(a,b,c:double;height,width:integer);overload;
    procedure RandBeta(a,b : T1DArray;height,width:integer);overload;
    procedure RepMat(a : T1DArray; n : integer);
    procedure Upperbound(x:double);
    procedure LowerBound(x:double);
    function  Transpose():Matrix2DRec;
    function  Identity():Matrix2DRec;
    function  DotProduct(Val1, Val2: Matrix2DRec):double;
    function  Size():integer;
    function  GetNumCols():integer;
    function  GetNumRows():integer;

    Function  Percentile(p : double):Matrix1DRec; (*returns a single array*)


  End;
implementation


class operator Matrix2DRec.Multiply(a: Matrix2DRec; b: Matrix2DRec):Matrix2DRec;
var
  r,c :integer;
  res : Matrix2DRec;
begin
  setLength(res.data,length(a.data),length(a.data[0]));
  for r := 0 to length(a.data)-1 do
    for c := 0 to length(a.data[r])-1 do
      res.data[r,c] := a.data[r,c]*b.data[r,c];

  result := res;
end;
class operator Matrix2DRec.Multiply(a: Matrix2DRec; b: double) : Matrix2DRec;
var
  r,c:integer;
  res : Matrix2DRec;
begin
  setLength(res.data,length(a.data),length(a.data[0]));
  for r := 0 to length(a.data)-1 do
    for c := 0 to length(a.data[r])-1 do
      res.data[r,c] := a.data[r,c]*b;

  result := res;
end;
class operator Matrix2DRec.Multiply(b: double;a: Matrix2DRec) : Matrix2DRec;
begin
  result := a*b;
end;
class operator Matrix2DRec.Multiply(a: T1DArray; b : Matrix2DRec):Matrix2DRec;
var
  r,c :integer;
  res : Matrix2DRec;
begin
  setLength(res.data,length(b.data),length(b.data[0]));
  for r := 0 to length(b.data)-1 do
    for c := 0 to length(b.data[r])-1 do
      res.data[r,c] := b.data[r,c]+a[c];
  result := res;
end;
class operator Matrix2DRec.Multiply(b : Matrix2DRec;a: T1DArray):Matrix2DRec;
begin
  result := a*b;
end;
class operator Matrix2DRec.Add(a: Matrix2DRec; b: Matrix2DRec) : Matrix2DRec;
var
  r,c :integer;
  res : Matrix2DRec;
begin
  setLength(res.data,length(a.data),length(a.data[0]));
  for r := 0 to length(a.data)-1 do
    for c := 0 to length(a.data[r])-1 do
      res.data[r,c] := a.data[r,c]+b.data[r,c];

  result := res;
end;
class operator Matrix2DRec.Add(a: Matrix2DRec; b: double) : Matrix2DRec;
var
  r,c :integer;
  res : Matrix2DRec;
begin
  setLength(res.data,length(a.data),length(a.data[0]));
  for r := 0 to length(a.data)-1 do
    for c := 0 to length(a.data[r])-1 do
      res.data[r,c] := a.data[r,c]+b;

  result := res;
end;
class operator Matrix2DRec.Add(b: double; a: Matrix2DRec) : Matrix2DRec;
begin
  result := a+b;
end;
class operator Matrix2DRec.Subtract(a: Matrix2DRec; b: Matrix2DRec) : Matrix2DRec;
var
  r,c:integer;
  res : Matrix2DRec;
begin
  setLength(res.data,length(a.data),length(a.data[0]));
  for r := 0 to length(a.data)-1 do
    for c := 0 to length(a.data[r])-1 do
      res.data[r,c] := a.data[r,c]-b.data[r,c];

  result := res;
end;
class operator Matrix2DRec.Subtract(a: Matrix2DRec; b: double) : Matrix2DRec;
var
  r,c:integer;
  res : Matrix2DRec;
begin
  setLength(res.data,length(a.data),length(a.data[0]));
  for r := 0 to length(a.data)-1 do
    for c := 0 to length(a.data[r])-1 do
      res.data[r,c] := a.data[r,c]-b;

  result := res;
end;
class operator Matrix2DRec.Subtract(b: double; a: Matrix2DRec) : Matrix2DRec;
var
  r,c:integer;
  res : Matrix2DRec;
begin
  setLength(res.data,length(a.data),length(a.data[0]));
  for r := 0 to length(a.data)-1 do
    for c := 0 to length(a.data[r])-1 do
      res.data[r,c] := b-a.data[r,c];

  result := res;
end;
class operator Matrix2DRec.Divide(a: Matrix2DRec; b: Matrix2DRec) : Matrix2DRec;
var
  r,c:integer;
  res : Matrix2DRec;
begin
  setLength(res.data,length(a.data),length(a.data[0]));
  for r := 0 to length(a.data)-1 do
    for c := 0 to length(a.data[r])-1 do
      if b.data[r,c]<>0 then
        res.data[r,c] := a.data[r,c]/b.data[r,c]
      else
        res.data[r,c] := 0;
  result := res;
end;
class operator Matrix2DRec.Divide(a: Matrix2DRec; b: double) : Matrix2DRec;
var
  r,c:integer;
  res : Matrix2DRec;
begin
  setLength(res.data,length(a.data),length(a.data[0]));
  for r := 0 to length(a.data)-1 do
    for c := 0 to length(a.data[r])-1 do
      if b<>0 then
        res.data[r,c] := a.data[r,c]/b
      else
        res.data[r,c] := 0;
  result := res;
end;
class operator Matrix2DRec.Divide(b: double; a: Matrix2DRec) : Matrix2DRec;
var
  r,c:integer;
  res : Matrix2DRec;
begin
  setLength(res.data,length(a.data),length(a.data[0]));
  for r := 0 to length(a.data)-1 do
    for c := 0 to length(a.data[r])-1 do
      if a.data[r,c] <> 0 then
        res.data[r,c] := b/a.data[r,c]
      else
        res.data[r,c] := 0;

  result := res;
end;
class operator Matrix2DRec.Implicit(a: T2DArray): Matrix2DRec;
begin
  result.data := a;
end;
class operator Matrix2DRec.Implicit(a: Matrix2DRec):T2DArray;
begin
  result := a.data;
end;
class operator Matrix2DRec.Implicit(a: Matrix1DRec):Matrix2DRec;
var
  r,c : integer;
begin
  for r := 0 to length(result.data)-1 do
    for c := 0 to length(result.data[r])-1 do
      result.data[r,c] := a.data[c];
end;

class operator Matrix2DRec.Explicit(a:Matrix2DRec): T2Darray;
begin
  result := a.data;
end;
procedure Matrix2DRec.setDimension(x: Integer; y: Integer);
begin
  System.SetLength(data,x,y);
end;
procedure Matrix2DRec.init(x,y:integer;val:double);
begin
  System.SetLength(data,x,y);
  SetDefaultValues(val);
end;
procedure Matrix2DRec.SetDefaultValues(x:double);
var
  r,c : integer;
begin
  for r := 0 to length(data)-1 do
    for c := 0 to length(data[r])-1 do
      data[r,c] := x;
end;
procedure Matrix2DRec.RandG(m,v:double);
var
  r,c : integer;
begin
  for r := 0 to length(data)-1 do
    for c := 0 to length(data[r])-1 do
      data[r,c] := Math.RandG(m,v);
end;
procedure Matrix2DRec.RandG(m,v:double;height,width:integer);
begin
  SetDimension(height,width);
  RandG(m,v);
end;
procedure Matrix2DRec.TriangInv(a,b,c:double;height,width:integer);
begin
  SetDimension(height,width);
  TriangInv(a,b,c);
end;
procedure Matrix2DRec.RandBeta(a,b : T1DArray;height,width:integer);
begin
  SetDimension(height,width);
  RandBeta(a,b);
end;
procedure Matrix2DRec.TriangInv(a,b,c:double);
var
  rw,cl : integer;
begin
  for rw := 0 to length(data)-1 do
    for cl := 0 to length(data[rw])-1 do
      data[rw,cl] := GBTriangInv(a,b,c);
end;
procedure Matrix2DRec.RandBeta(a,b : T1DArray);
var
  r,c : integer;
begin
  for c := 0 to length(data[0])-1 do
  begin
    randSeed := UA_RandomSeed;
    for r := 0 to length(data)-1 do
    begin
//      randGamma1 := GBRandomBetaV2(a[c],1);
//      randGamma2 := GBRandomBetaV2(b[c],1);

      data[r,c] :=  GBRandomBeta(a[c],b[c]);//randGamma1/(randGamma1+randGamma2);
    end;
  end;
end;

procedure Matrix2DRec.RepMat(a : T1DArray; n : integer);
var
  r,c : integer;
begin
  for r := 0 to length(data)-1 do
    for c := 0 to length(data[r])-1 do
      data[r,c] := a[c];
end;
procedure Matrix2DRec.Upperbound(x:double);
var
  r,c : integer;
begin
  for r := 0 to length(data)-1 do
    for c := 0 to length(data[r])-1 do
      if data[r,c]>x then
        data[r,c] := x;
end;
procedure Matrix2DRec.LowerBound(x:double);
var
  r,c : integer;
begin
  for r := 0 to length(data)-1 do
    for c := 0 to length(data[r])-1 do
      if data[r,c]<x then
        data[r,c] := x;
end;

function  Matrix2DRec.Transpose():Matrix2DRec;
var
  r,c : integer;
begin
  result.init(length(data),length(data),0);
  for r := 0 to length(data)-1 do
    for c := 0 to length(data[r])-1 do
      result.data[r,c] := data[c,r];
end;

function  Matrix2DRec.Identity():Matrix2DRec;
var
  size : integer;
begin
  result.init(length(data),length(data),0);
  for size := 0 to length(data)-1 do
    result.data[size,size] := 1;
end;

function  Matrix2DRec.DotProduct(Val1, Val2: Matrix2DRec):double;
  function ToPackagedArray(pack: Matrix2Drec):Matrix1DRec;
  var
    index, r, c : integer;
  begin
    result.init(pack.Size,0);
    index := 0;
    for r := 0 to length(pack.data)-1 do
      for c := 0 to length(pack.data[r])-1 do
      begin
        result.data[index] := pack.data[r,c];
        inc(index);
      end;

  end;
var
  size : integer;
  a,b : Matrix1DRec;
begin
  result := 0;
  a := ToPackagedArray(Val1);
  b := ToPackagedArray(Val2);
  for size := 0 to length(a.data)-1 do
    result := result+ a.data[size]*b.data[size];

end;


function  Matrix2DRec.Size():integer;
begin
  result := (length(data))*(length(data));
end;


function  Matrix2DRec.GetNumCols():integer;
begin
  result := length(data[0])-1;
end;

function  Matrix2DRec.GetNumRows():integer;
begin
  result := length(data)-1;
end;


(*assumes a square matrix*)
Function  Matrix2DRec.Percentile(p : double):Matrix1DRec;
var
  res,curr : Matrix1DRec;
  r,c : integer;
begin
  (*initialize arrays*)
  setLength(curr.data,length(data));
  setLength(res.data, length(data[0]));
  (*typically will loop through years*)
  for c := 0 to length(data[0])-1 do
  begin
    (*obtain sample data for year c *)
    for r := 0 to length(data)-1 do
      curr.data[r] := data[r,c];
    (*set year data according to percentile*)
    res.data[c] := GBPercentile(p,curr.data);
  end;
  (*send result back*)
  result := res;
end;
(******************************************************************************)
(*****************************  1D Matrix Operations  *************************)
(******************************************************************************)

class operator Matrix1DRec.Multiply(a: Matrix1DRec; b: Matrix1DRec):Matrix1DRec;
var
  r   : integer;
  res : Matrix1DRec;
begin
  setLength(res.data,length(a.data));
  for r := 0 to length(a.data)-1 do
    res.data[r] := a.data[r]*b.data[r];

  result := res;
end;
class operator Matrix1DRec.Multiply(a: Matrix1DRec; b: double) : Matrix1DRec;
var
  r   : integer;
  res : Matrix1DRec;
begin
  setLength(res.data,length(a.data));
  for r := 0 to length(a.data)-1 do
      res.data[r] := a.data[r]*b;

  result := res;
end;

(*
void quickSort(int arr[], int left, int right) {
      int i = left, j = right;
      int tmp;
      int pivot = arr[(left + right) / 2];

      /* partition */
      while (i <= j) {
            while (arr[i] < pivot)
                  i++;
            while (arr[j] > pivot)
                  j--;
            if (i <= j) {
                  tmp = arr[i];
                  arr[i] = arr[j];
                  arr[j] = tmp;
                  i++;
                  j--;
            }
      };

      /* recursion */
      if (left < j)
            quickSort(arr, left, j);
      if (i < right)
            quickSort(arr, i, right);
} *)

class operator Matrix1DRec.Multiply(b: double;a: Matrix1DRec) : Matrix1DRec;
begin
  result := a*b;
end;

class operator Matrix1DRec.Add(a: Matrix1DRec; b: Matrix1DRec) : Matrix1DRec;
var
  r   : integer;
  res : Matrix1DRec;
begin
  setLength(res.data,length(a.data));
  for r := 0 to length(a.data)-1 do
    res.data[r] := a.data[r]+b.data[r];

  result := res;
end;

class operator Matrix1DRec.Add(a: Matrix1DRec; b: double) : Matrix1DRec;
var
  r   : integer;
  res : Matrix1DRec;
begin
  setLength(res.data,length(a.data));
  for r := 0 to length(a.data)-1 do
    res.data[r] := a.data[r]+b;

  result := res;
end;
class operator Matrix1DRec.Add(b: double; a: Matrix1DRec) : Matrix1DRec;
begin
  result := a+b;
end;
class operator Matrix1DRec.Subtract(a: Matrix1DRec; b: Matrix1DRec) : Matrix1DRec;
var
  r   : integer;
  res : Matrix1DRec;
begin
  setLength(res.data,length(a.data));
  for r := 0 to length(a.data)-1 do
    res.data[r] := a.data[r]-b.data[r];

  result := res;
end;
class operator Matrix1DRec.Subtract(a: Matrix1DRec; b: double) : Matrix1DRec;
var
  r   : integer;
  res : Matrix1DRec;
begin
  setLength(res.data,length(a.data));
  for r := 0 to length(a.data)-1 do
    res.data[r] := a.data[r]-b;

  result := res;
end;
class operator Matrix1DRec.Subtract(b: double; a: Matrix1DRec) : Matrix1DRec;
var
  r   : integer;
  res : Matrix1DRec;
begin
  setLength(res.data,length(a.data));
  for r := 0 to length(a.data)-1 do
    res.data[r] := b-a.data[r];

  result := res;
end;
class operator Matrix1DRec.Divide(a: Matrix1DRec; b: Matrix1DRec) : Matrix1DRec;
var
  r : integer;
  res : Matrix1DRec;
begin
  setLength(res.data,length(a.data));
  for r := 0 to length(a.data)-1 do
    if b.data[r]<>0 then
      res.data[r] := a.data[r]/b.data[r]
    else
      res.data[r] := 0;

  result := res;
end;
class operator Matrix1DRec.Divide(a: Matrix1DRec; b: double) : Matrix1DRec;
var
  r :integer;
  res : Matrix1DRec;
begin
  setLength(res.data,length(a.data));
  for r := 0 to length(a.data)-1 do
    if b <> 0 then
      res.data[r] := a.data[r]/b
    else
      res.data[r] := 0;
  result := res;
end;
class operator Matrix1DRec.Divide(b: double; a: Matrix1DRec) : Matrix1DRec;
var
  r   : integer;
  res : Matrix1DRec;
begin
  setLength(res.data,length(a.data));
  for r := 0 to length(a.data)-1 do
    if a.data[r]<>0 then
      res.data[r] := b/a.data[r]
    else
      res.data[r] := 0;

  result := res;
end;

class operator Matrix1DRec.Implicit(a: T1DArray): Matrix1DRec;
begin
  result.data := a;
end;
class operator Matrix1DRec.Implicit(a: Matrix1DRec):T1DArray;
begin
  result := a.data;
end;

class operator Matrix1DRec.Explicit(a:Matrix1DRec): T1Darray;
begin
  result := a.data;
end;

procedure Matrix1DRec.setDimension(x: Integer);
begin
  System.SetLength(data,x);
end;

procedure Matrix1DRec.init(x:integer;val:double);
begin
  setDimension(x);
  SetDefaultValues(val);
end;

procedure Matrix1DRec.SetDefaultValues(x:double);
var
  r : integer;
begin
  for r := 0 to length(data)-1 do
    data[r] := x;
end;
function  Matrix1DRec.Max : double;
 var
  r : integer;
begin
  result := data[0];
  for r := 1 to length(data)-1 do
    if result<data[r] then
      result := data[r];
end;
procedure Matrix1DRec.RandG(m,v:double);
var
  r : integer;
begin
  for r := 0 to length(data)-1 do
    data[r] := Math.RandG(m,v);
end;
procedure Matrix1DRec.TriangInv(a,b,c:double);
var
  r : integer;
begin
  for r := 0 to length(data)-1 do
    data[r] := GBTriangInv(a,b,c);
end;
procedure Matrix1DRec.RandBeta(a,b : integer);
var
  r : integer;
begin
  for r := 0 to length(data)-1 do
    data[r] := GBRandomBeta(a,b);
end;

end.
