unit UTIL;

interface

Uses
  Classes, Dialogs, Printers, StdCtrls, forms, Graphics, consts,
  Menus, AdvMenuStylers, AdvMenus, AdvGlowButton,
  WUpdate, WebCopy, Registry, Windows, Messages, Math, AdvPanel, sysutils;



(* replaces all currChr in str with newChr*)
function  GBReplaceCharacter(str: String; currChr, newChr: char): String;


function  GB_RaiseToPower(power, value: single; var ErrorCode: boolean): single;





function  GBQuadraticSolver(a, b, c:double):double;
function  GBQuarticSolver(a, b, c, d, e: double): double;

function  GBRandomBeta(alpha,beta:double):double;
function  GBTriangInv(lower,upper,mode:double):double;
function  GBPercentile(p:double; values : array of double):double;
procedure GBQuickSort(var A: array of double; iLo, iHi: Integer) ;


implementation

uses
 Controls, TaskDialog, TaskDialogEx;

(* Replaces all currChr in str with newChr *)
function GBReplaceCharacter(str: String; currChr, newChr: char): String;
var
  Source,SourceEnd : PChar;
  newStr           : String;
  index            : integer;
begin
  if str <> '' then
  begin
    Source := Pointer(str);
    SourceEnd := Source + Length(str);
   index :=0;                               // Needed because it changes with repeated use of replaceCharacter
    while Source <= SourceEnd do
    begin
      if (currChr=Source^) then
      begin
        newStr := newStr + Copy(str,0,index);
        newStr := newStr + newChr;           // Character at index+1
        str := Copy(str,index+2,MaxInt);     // Remove already read Str
        index := -1;                         // -1 because its going to increment to 0
      end;
      Inc(Source);
      inc(index);
    end;
    newStr := newStr+str;                   // rest of the string
    result := newStr;
    end
  else
    result := str;
end;

{ Raises any positive single number to any single power }
function GB_RaiseToPower(power, value: single; var ErrorCode: boolean): single;
begin
  if value <= 0 then
  begin
    GB_RaiseToPower := 0;
    ErrorCode := true;
  end
  else
  begin
    GB_RaiseToPower := exp(power * ln(value));
    ErrorCode := false;
  end
end;

function GBQuadraticSolver(a, b, c:double):double;
begin
  result := 0;
  if (a <> 0) and ((b*b)>=(4*a*c))  then
  begin
    result := (-b+sqrt(b*b-4*a*c))/(2*a);
    if result < 0 then
      result :=(-b-sqrt(b*b-4*a*c))/(2*a);
  end;
end;

function GBQuarticSolver(a, b, c, d, e: double): double;
var
  ap, bp, cp, dp, ep: double;
  f, g, h: double;
  A_, B_, C_, D_, F_, G_, H_, I_, J_, K_, L_, M_, N_, P_: double;
  X1, X3: double;
  KVal,
  answer1,answer2,answer3,answer4 : double;
begin
  try
    ap := 1;
    bp := b / a;
    cp := c / a;
    dp := d / a;
    ep := e / a;

    f := cp - ((3 * sqr(bp)) / 8);
    g := dp + ((sqr(bp) * bp) / 8) - (bp * cp) / 2;
    h := ep - ((3 * power(bp, 4)) / 256) + ((sqr(bp) * cp) / 16) -
      ((bp * dp) / 4);

    A_ := 1;
    B_ := f / 2;
    C_ := (sqr(f) - 4 * h) / 16;
    D_ := -1 * (sqr(g)) / 64;
    F_ := ((3 * C_) / A_ - (sqr(B_)) / (sqr(A_))) / 3;
    G_ := ((2 * sqr(B_) * B_) / (sqr(A_) * A_) - (9 * B_ * C_) / (sqr(A_)) +
        (27 * D_) / A_) / 27;
    H_ := (sqr(G_)) / 4 + (sqr(F_) * F_) / 27;
    I_ := sqrt((sqr(G_) / 4) - H_);
    J_ := power(I_, 1 / 3);
    KVal := -1 * G_ / (2 * I_);
    if  KVal < -1 then
      KVal := -1;
    K_ := arccos(KVal);
    L_ := -1 * J_;
    M_ := cos(K_ / 3);
    N_ := sqrt(3) * sin(K_ / 3);
    P_ := -1 * B_ / (3 * A_);
    X1 := 2 * J_ * M_ + P_;
    X3 := L_ * (M_ - N_) + P_;

    answer1 :=  sqrt(X1) + sqrt(X3) - (g / (8 * sqrt(X1) * sqrt(X3))) - (bp /(4 * ap));
    answer2 :=  sqrt(X1) - sqrt(X3) + (g / (8 * sqrt(X1) * sqrt(X3))) - (bp /(4 * ap));
    answer3 := -sqrt(X1) + sqrt(X3) + (g / (8 * sqrt(X1) * sqrt(X3))) - (bp /(4 * ap));
    answer4 := -sqrt(X1) - sqrt(X3) - (g / (8 * sqrt(X1) * sqrt(X3))) - (bp /(4 * ap));
    (*returns the first positive integer between 0 and 1, inclusive*)
    if (answer1 >=0) and (answer1<=1) then
      result := answer1
    else if (answer2 >=0) and (answer2<=1) then
      result := answer2
    else if (answer3 >=0) and (answer3<=1) then
      result := answer3
    else if (answer4 >=0) and (answer4<=1) then
      result := answer4
    else (*if no answer is positive*)
      result := -1;
  except
    on e: Exception do
      result := -1;
  end;
end;


(*Random generator for beta distribution*)
function GBRandomBeta(alpha,beta : double):double;
const
     aln4 = 1.3862943611198906;
     VSmall = MinDouble;
     VLarge = MaxDouble;
var
  a, b, g, r, s, x, y, z: double;
	d, f, h, t, c: double;
  Swap: Boolean;
  Done: Boolean;
begin
     if (alpha <= 0.0) or (beta <= 0.0) then
     begin
        result := 0;
        exit;
       //   raise EMathError.Create ('math error');
     end;

     a := alpha;
     b := beta;
     swap := b > a;
     if swap then
     begin
          g := b;
          b := a;
          a := g;
     end;
     d := a / b;
     f := a + b;
     if (b > 1.0) then
     begin
          h := Sqrt ((2.0 * a * b - f) / (f - 2.0));
          t := 1.0;
     end
     else
     begin
          h := b;
          t := 1.0 / (1.0 + Power (a / (VLarge * b), b));
     end;
     c := a + h;

     Done := False;
     Result := 0.0;
     repeat
          r := Random;
          x := Random;
          s := Sqr (r) * x;
          if (r < VSmall) or (s <= 0.0) then
               Continue;

          if (r < t) then
          begin
               x := Ln (r / (1.0 - r)) / h;
               y := d * Exp (x);
               z := c * x + f * Ln ((1.0 + d) / (1.0 + y)) - aln4;
               if (s - 1.0 > z) then
               begin
                    if (s - s * z > 1.0) then
				  	            Continue;
                    if (Ln (s) > z) then
                         Continue;
               end;
               Result := y / (1.0 + y);
          end
          else
          begin
               if 4.0 * s > Power (1.0 + 1.0 / d, f) then
                    Continue;
               Result := 1.0
          end;
          Done := True
     until Done;

     if Swap then
          Result := 1 - Result;
end;

(*triangular random number generator*)
function GBTriangInv(lower,upper,mode:double):double;
var
  p : double;
begin
  p:= random;(*uniform random number from 0 to 1*)
  if  ( p<((mode-lower)/(upper-lower)) )then
    result := lower+sqrt(p*(upper-lower)*(mode-lower))
  else
    result := upper-sqrt((1-p)*(upper-lower)*(upper-mode));
end;

function GBPercentile(p:double; values : array of double):double;
var
  loc : integer;
begin
  loc := round((p/100)*(length(values)-1));(*nearest rank equation. *)
  GBquickSort(values,0,length(Values)-1);
  result := values[loc];
end;

(* Quicksort procedure written by Bob *)
procedure GBQuickSort(var A: array of double; iLo, iHi: Integer) ;
var
  Lo, Hi   : Integer;
  Pivot, T : Double;
begin
  Lo := iLo;
  Hi := iHi;
  Pivot := A[(Lo + Hi) div 2];
  repeat
    while A[Lo] < Pivot do Inc(Lo) ;
    while A[Hi] > Pivot do Dec(Hi) ;
    if Lo <= Hi then
    begin
      T := A[Lo];
      A[Lo] := A[Hi];
      A[Hi] := T;
      Inc(Lo) ;
      Dec(Hi) ;
    end;
  until Lo > Hi;
  if Hi > iLo then GBQuickSort(A, iLo, Hi) ;
  if Lo < iHi then GBQuickSort(A, Lo, iHi) ;
end;


end.
