uses perss;
uses aobjects;
//uses simple_map;
uses map_tools_v2;

uses crt;

var posx:=35; var posy:=5;

procedure set_on_map(obj_type:integer; obj_id:integer; posx:integer; posy:integer; posz:integer:=1);
begin

      global_map[posy][posx][posz][1]:=obj_type;
      global_map[posy][posx][posz][2]:=obj_id;

end;
begin
  global_map:=map_tools_v2.map_gen();
  global_map[posy][posx][1][1]:=2; global_map[posy][posx][1][2]:=aobjects.new_object(2, 0);
  var old_obj_type:=0; var old_obj_id:=w-1;
  var hero:=aobjects.hero;
  var now_color:=0;
  
  SetWindowSize(window_w, window_h);
  crt.HideCursor();


while true do
begin
  map_printer(global_map);
  tile_printer(posx, posy);


  //ch2 mooving and doing something
  var input_key:=readkey; var old_x:=posx; var old_y:=posy;
  hero.input(input_key);

  posx+=hero.vecx; posy+=hero.vecy;
  if posx>w-1 then begin posx:=2; end;
  if posy>h-1 then begin posy:=2; end;
  if posx<=1 then begin posx:=w-1; end;
  if posy<=1 then begin posy:=h-1; end;
  
  crt.TextBackground(now_color);
  gotoxy(1, window_h-1); clearline(); tech_info(posx, posy, input_key); 
  

  crt.TextBackground(now_color);
  
  if (posx<>old_x) or (posy<>old_y) then
  begin
    crt.TextBackground(now_color);
    set_on_map(2, -1, posx, posy);
    set_on_map(old_obj_type, old_obj_id, old_x, old_y);
    old_obj_type:=global_map[posy][posx][2][1];
    old_obj_id:=global_map[posy][posx][2][2];
  end;

  
  gotoxy(1, window_h-1);
  
end;
  gotoxy(1, window_h-2);
end.