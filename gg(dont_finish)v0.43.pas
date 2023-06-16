uses perss;
uses simple_map;
uses crt;

var posx:=30; var posy:=5;

procedure tech_info();
begin
  write('|', posx, ' ', posy, '|' );  
end;

begin
  
  var p:Person:=new Person;
  p.Print();
  
  SetWindowSize(window_w, window_h);
  
  for var i:=1 to h do
  begin
    for var j:=1 to w do
    begin
      k:=global_map[i][j][1][1];
      if k<0 then p_sym:='~';
      if k=0 then p_sym:='#';
      if k>0 then p_sym:='.';
      if k>3 then p_sym:='|';
      if k>6 then p_sym:='*';
      gotoxy(j, i); crt.TextBackground(k mod 15);
      Write(p_sym);//k, ' ');//, ' | ');
    end;
    writeln();
  end;

  //map tile 
  var tx, ty:integer;
  
while true do
begin
  for var j:=0 to tile_len do
  begin
    for var i:=0 to tile_len do
    begin
      tx:=0;
      ty:=0;
      for var n:=1 to tile_len*tile_len do
      begin
        k:=global_map[posy][posx][n][2];

        gotoxy(tile_posx+tx, tile_posy+ty); crt.TextBackground(k mod 15);
        Write(k, '|');//, ' | ');
        tx+=3;
        if tx>=tile_len*3 THEN begin tx:=0; ty+=1 end;
        
      end;
    end;
    //writeln();
  end;

  var input_key:=readkey;
  p.input(input_key);
  input_key:=' ';
  posx+=p.vecx; posy+=p.vecy;
  if posx>w-1 then begin posx:=2; end;
  if posy>h-1 then begin posy:=2; end;
  if posx<=1 then begin posx:=w-1; end;
  if posy<=1 then begin posy:=h-1; end;
  crt.TextBackground(black);//global_map[posy][posx][1][1] mod 15);
  gotoxy(1, window_h-1); clearline(); tech_info(); 
  
  crt.TextBackground(global_map[posy][posx][1][1] mod 15);
  gotoxy(posx, posy); write('@'); gotoxy(1, window_h-1); 
  
end;
  gotoxy(1, window_h-2);
end.