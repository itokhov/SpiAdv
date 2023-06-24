unit map_tools_v2;
uses crt; 
uses aobjects;
const
  window_w = 120;
  window_h = 30;
  w = 80;
  h = 20;
  
  tile_posx = w+5;
  tile_posy = 5;
  tile_len = 3;

type 
  mapi = array [1..h] of array[1..w] of array[1..tile_len*tile_len] of tile_m;
var k:integer; var p_sym:char;

var old_map:mapi;

var global_map:mapi;

function noiser(posx:integer; posy:integer):integer;
begin
  noiser:=Random(posx, posy); 
end;
procedure tech_info(posx, posy:integer; input_key:char:='i');
begin
  crt.TextColor(hero.def_tcolor); crt.TextBackground(hero.def_bgcolor);
  write('|', posx, ' ', posy, '|', input_key.Code, ' ', input_key, '|', hero.vecx, ' ', hero.vecy );  
end;
function map_gen():mapi;
begin
for var i:=1 to h do
begin    
  for var j:=1 to w do
  begin
    if (i=1) or (j=1) or (i=h) or (j=w) then begin
      global_map[i][j][2][1]:= 0; //bedrock
      global_map[i][j][2][2]:= aobjects.new_object(0, 0); //second zero - type_id of bedrock "#"
    end
    
    else 
    begin
      k:=random(-30, 20);
      if k=15 then 
      begin
        global_map[i][j][2][1]:= 2; //wood
        global_map[i][j][2][2]:= aobjects.new_object(2, 1); 
      end
      else if k=20 then begin 
        global_map[i][j][2][1]:= 1; //anger
        global_map[i][j][2][2]:= aobjects.new_object(1, 0);
      end
      else if k= 0 then 
      begin
        global_map[i][j][2][1]:= 2; //point
        global_map[i][j][2][2]:= aobjects.new_object(2, 2); //second zero - type_id of air " "
      end
      else 
      begin
        global_map[i][j][2][1]:= 0; //air
        global_map[i][j][2][2]:= aobjects.new_object(0, 1); //second zero - type_id of air " "
      end;
    end;
    
    //tile gen
    for var n:=3 to tile_len*tile_len do
    begin
        global_map[i][j][n][1]:= 2; //wood
        global_map[i][j][n][2]:= aobjects.new_object(2, 1); 
    end;
  end;
end;
result:=global_map;
end;

procedure map_printer(gmap:mapi);
begin
  //map print
  var now_color:=0;
  for var j:=1 to w do
  begin
    for var i:=1 to h do
    begin
      var k:=gmap[i][j][2];
      var old_k:=old_map[i][j][2];
      if true then //((k[1]=old_k[1]) and (k[2]<>old_k[2])) or (k[1] <> old_k[1]) then
      begin
      if k[1]=0 then begin p_sym:=aobjects.not_destroy[gmap[i][j][2][2]].sym; end; //dot forget about "now_color"
      if k[1]=1 then begin p_sym:=aobjects.live_objs[gmap[i][j][2][2]].sym; end;
      if k[1]=2 then 
      begin
          if global_map[i][j][1][2]=-1 then p_sym:=aobjects.hero.sym 
          else p_sym:=aobjects.other_objs[gmap[i][j][2][2]].sym;
          //delay(1000);
      end;
      if gmap[i][j][1][2]=-1 then p_sym:=aobjects.hero.sym; 
      gotoxy(j, i); crt.TextColor(aobjects.get_obj_tcolor(k)); crt.TextBackground(aobjects.get_obj_bgcolor(k));
      if gmap[i][j][1][2]=-1 then begin crt.TextColor(aobjects.get_obj_tcolor(global_map[i][j][1])); crt.TextBackground(aobjects.get_obj_bgcolor(global_map[i][j][1])); end;
      Write(p_sym);//k, ' ');//, ' | ');
      end;
    end;
    //writeln();
  end;
  old_map:=gmap;
end;

procedure tile_printer(posx, posy:integer);
begin
  //tile_print
  for var j:=0 to tile_len do
  begin
    for var i:=0 to tile_len do
    begin
      var tx:=0;
      var ty:=0;
      var now_color:=0; //redoing it!
      gotoxy(tile_posx, tile_posy); crt.TextBackground(now_color);
      
      for var n:=1 to tile_len*tile_len do
      begin
        var k:=global_map[posy][posx][n];
        if k[1]=0 then p_sym:=aobjects.not_destroy[k[2]].sym;
        if k[1]=1 then p_sym:=aobjects.live_objs[k[2]].sym;
        if k[1]=2 then 
        begin
          if k[2]=-1 then p_sym:=aobjects.hero.sym 
          else p_sym:=aobjects.other_objs[k[2]].sym;
          //delay(1000);
        end;
        gotoxy(tile_posx+tx, tile_posy+ty); crt.TextColor(aobjects.get_obj_tcolor(k)); crt.TextBackground(aobjects.get_obj_bgcolor(k));
        Write(p_sym, '|');//, ' | ');
        tx+=3;
        if tx>=tile_len*3 THEN begin tx:=0; ty+=1 end;
        
      end;
    end;
    //writeln();
  end;
end;
end.