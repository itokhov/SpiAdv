uses perss;
uses simple_map;
uses crt;

begin
  var p:Person:=new Person;
  writeln(p.GetType);
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
      Write(p_sym);//k, ' ');//, ' | ');
    end;
    writeln();
  end;

  var posx:=5; var posy:=5;
  var t_num:=1;
  gotoxy(1, window_h-1);
end.