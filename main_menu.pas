uses crt;
uses game_consts;
uses main;

//texts
var t1:='new game'; var t2:='contuine'; var t3:='rules'; var t4:='avtors '; var t5:='quit'; 
var tlen:=6+max(t1.Length, t2.Length, t3.Length, t4.Length, t5.length);

//in borders & text
var xs:=floor(window_w/2)-floor(tlen/2);
var ys:=floor(window_h/2)-floor((5+2)/2);

procedure create_borders();
begin
  for var i:=1 to window_w do
  begin
    for var j:=1 to window_h do
    begin
      if (i=1) or (i=window_w) or (j=1) or (j=window_h) then
        begin gotoxy(i, j); write('#'); end
    end;
  end;
end;

procedure menu_create();
begin
  crt.TextBackground(0); crt.TextColor(15); clrscr();
  create_borders();
  

  gotoxy(xs, ys); 
  write('+', '-'*(tlen-2), '+');
  gotoxy(xs, ys+1);
  write('|'); gotoxy(floor(window_w/2)-floor(t1.Length/2), ys+1);  write(t1); gotoxy(xs+tlen-1, ys+1); write('|');
  
  gotoxy(xs, ys+2); 
  crt.TextColor(crt.DarkGray);
  write('|'); gotoxy(floor(window_w/2)-floor(t2.Length/2), ys+2);  write(t2); gotoxy(xs+tlen-1, ys+2); write('|');
  crt.TextColor(15);
  
  gotoxy(xs, ys+3);
  write('|'); gotoxy(floor(window_w/2)-floor(t3.Length/2), ys+3);  write(t3); gotoxy(xs+tlen-1, ys+3); write('|');
  
  gotoxy(xs, ys+4);
  write('|'); gotoxy(floor(window_w/2)-floor(t4.Length/2), ys+4);  write(t4); gotoxy(xs+tlen-1, ys+4); write('|');
  
  gotoxy(xs, ys+5);
  write('|'); gotoxy(floor(window_w/2)-floor(t5.Length/2), ys+5);  write(t5); gotoxy(xs+tlen-1, ys+5); write('|');
  
  gotoxy(xs, ys+6);
  write('+', '-'*(tlen-2), '+');
end;
procedure rules_out();
begin
  clrscr();
  create_borders();
  var xs:=3;//floor(window_w/2)-20;
  for var i:=0 to rules.length-1 do
  begin
    gotoxy(xs, i+2); write(rules[i]);
  end;
  readkey();
end;
procedure avtors_out();
begin
  clrscr();
  create_borders();
  var xs:=3;//floor(window_w/2)-20;
  for var i:=0 to avtors.length-1 do
  begin
    gotoxy(xs, i+2); write(avtors[i]);
  end;
  readkey();
end;
begin
  SetWindowSize(window_w, window_h);
  //swither
  rules_out(); //сначала выводим правила
  menu_create(); //затем рисуем меню выбора
  var px:=xs-1; var py:=ys+1; var sven:=0;
  crt.HideCursor();
  var a:char;
  while true do
  begin
    a:=' ';
    if keypressed then a:=readkey;
    
    if a='2' then begin gotoxy(px, py+sven); write(' '); gotoxy(px+tlen+1, py+sven); write(' '); sven+=1; end;
    if a='8' then begin gotoxy(px, py+sven); write(' '); gotoxy(px+tlen+1, py+sven); write(' '); sven-=1; end;
    
    if py+sven>ys+5 then sven:=0;
    if py+sven<ys+1 then sven:=4;
    
    if (sven=1) and (a='2') then sven+=1      //блокировкка возможности перехода 
    else if (sven=1) and (a='8') then sven-=1;//к пункту о продож
    
    gotoxy(px, py+sven); write('*'); 
    gotoxy(px+tlen+1, py+sven); write('*');
    
    if a='5' then
    begin
      case sven of
       0 : begin main.new_game; end;
       1 : ;//не работает!!
       2 : rules_out();
       3 : avtors_out();
       4 : begin break end;
      end;
      menu_create();    
    end;
  end;
  clrscr(); write('Good bye');
  crt.TextColor(black);
end.