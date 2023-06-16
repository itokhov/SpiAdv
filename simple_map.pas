unit simple_map;
uses crt;

//my stupid function
//not normal working
//DONT USE!!!
function noiser(posx:integer; posy:integer):integer;
begin
  noiser:=Random(posx, posy);
end;

const
  window_w = 120;
  window_h = 30;
  w = 80;
  h = 20;
  
  tile_posx = w+5;
  tile_posy = 5;
  tile_len = 3;

var global_map:array [1..h] of array[1..w] of array[1..tile_len*tile_len] of array[1..2] of integer;
var k:integer; var p_sym:char;
begin
for var i:=2 to h-1 do
begin    
  for var j:=2 to w-1 do
  begin
    global_map[i][j][1][1]:=max(i, j);//noiser(0, 10);
    global_map[i][j][1][2]:=1;//noiser(0, 10);
    for var n:=2 to tile_len*tile_len do
    begin
      global_map[i][j][n][1]:=0;
      global_map[i][j][n][2]:=i+j; //noiser(0, 8);
    end;
  end;
end;

end.