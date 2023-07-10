unit main;
uses perss;
uses aobjects;
//uses simple_map;
uses map_tools_v2;
uses game_consts;
uses crt;


procedure set_on_map(obj_type:integer; obj_id:integer; posx:integer; posy:integer; posz:integer:=1);
begin

      global_map[posy][posx][posz][1]:=obj_type;
      global_map[posy][posx][posz][2]:=obj_id;

end;
procedure new_game();
begin
  var posx:=7; var posy:=7;
  
  global_map:=map_tools_v2.map_gen(); //map generation
  global_map[posy][posx][1][1]:=2; global_map[posy][posx][1][2]:=aobjects.new_object(2, 0); //create and set player on map
  var old_obj_type:=0; var old_obj_id:=w-1-tile_len; //im forget why i maked this vars
  var hero:=aobjects.hero; //for fast dostup to hero
  hero.name:='Spidy';
  var input_key:char; //very poleznaya var
    
  SetWindowSize(window_w, window_h);
  crt.HideCursor();


  while input_key<>'Q' do
  begin
    
    //drawing
    map_printer(global_map);
    tile_printer(posx, posy);
    hero_stats_printer();
    //hero_backpack_printer();
    gotoxy(1, window_h-1); clearline(); tech_info(posx, posy, input_key, hero.hp);

    //player thinking
    input_key:=readkey; var old_x:=posx; var old_y:=posy;
    hero.input(input_key);
    var now_tile:=global_map[posy][posx][1];
    var will_tile:=global_map[posy+hero.vecy][posx+hero.vecx];
    
    var l:=1; 
    var mooving:=false; //dont forget to rechange!
    if get_obj_touchable(will_tile[l]) and (now_tile<>will_tile[l])then 
    begin 
      posx+=hero.vecx; posy+=hero.vecy; mooving:=true; 
    end
    else
    begin
      if will_tile[1][1]=1 then aobjects.attack_on(now_tile, will_tile[1]);
      if will_tile[1][1]=2 then aobjects.attack_on(now_tile, will_tile[1]);
    end;
    if will_tile[1][1]=3 then aobjects.attack_on(now_tile, will_tile[1]);

    if mooving=true then
    begin
      set_on_map(2, -1, posx, posy);
      set_on_map(old_obj_type, old_obj_id, old_x, old_y);
      old_obj_type:=will_tile[1][1];
      old_obj_id:=will_tile[1][2];
    end;
    map_analyzer(global_map, posx, posy);
    
    if hero.hp<=0 then input_key:='Q';
  end;
  
  clrscr(); delay(3000); 
  gotoxy(1, window_h-2);

end;
  
end.