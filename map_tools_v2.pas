unit map_tools_v2;
uses crt; 
uses aobjects;
uses game_consts;

var k:integer; var p_sym:char;

var old_map:mapi;

var global_map:mapi;

procedure tech_info(posx, posy:integer; input_key:char:='i'; hp:integer:=-1);
begin
  crt.TextColor(hero.def_tcolor); crt.TextBackground(hero.def_bgcolor);
  write('|', posx, ' ', posy, '|', input_key.Code, ' ', input_key, '|', hero.vecx, ' ', hero.vecy );  
  if hp<>-1 then write('|', hp);
end;

function map_gen():mapi;
begin
  for var i:=1 to h do
  begin    
    for var j:=1 to w do
    begin
      if (i=1) or (j=1) or (i=h) or (j=w) then begin
        global_map[i][j][1][1]:= 0; //bedrock
        global_map[i][j][1][2]:= aobjects.new_object(0, 0); //second zero - type_id of bedrock "#"
      end
      else 
        //room
        if ((i=10) or (j=10)) and (i<>5) and (i<11) and (j<11) then begin global_map[i][j][1][1]:= 0; global_map[i][j][1][2]:= aobjects.new_object(0, 0); end
        else if (j=10) and (i=5) then begin global_map[i][j][1][1]:= 2; global_map[i][j][1][2]:= aobjects.new_object(2, 3); end
      else
      begin
        k:=random(100);
{        if k=15 then 
        begin
          global_map[i][j][1][1]:= 2; //wood
          global_map[i][j][1][2]:= aobjects.new_object(2, 1); 
        end
        else 
}
        if k=20 then begin
          global_map[i][j][1][1]:= 1; //anger
          global_map[i][j][1][2]:= aobjects.new_object(1, 0);
        end
        else 
        begin
          global_map[i][j][1][1]:= 0; //air
          global_map[i][j][1][2]:= aobjects.new_object(0, 1); //second zero - type_id of air " "
        end;
      end;
    
      //tile gen
      for var n:=2 to tile_len*tile_len-1 do
      begin
        k:=random(-30, 90);
        if k=15 then 
        begin
          global_map[i][j][n][1]:= 2; //wood
          global_map[i][j][n][2]:= aobjects.new_object(2, 1);
        end 
        else 
        begin
          global_map[i][j][n][1]:= 0; //air
          global_map[i][j][n][2]:= aobjects.new_object(0, 1); 
        end;
      end;
      global_map[i][j][tile_len*tile_len][1]:= 2; //point
      global_map[i][j][tile_len*tile_len][2]:= aobjects.new_object(2, 2); 
    end;
  end;
  result:=global_map;
end;

procedure map_printer(gmap:mapi);
begin
  //map print
  for var j:=1 to w do
  begin
    for var i:=1 to h do
    begin
      var k:=gmap[i][j][1]; var l:=1;
      while not aobjects.get_obj_visible(k) do begin l+=1; k:=gmap[i][j][l] end;
      p_sym:=aobjects.get_obj_sym(k);
      //if gmap[i][j][1][2]=-1 then p_sym:=aobjects.hero.sym; 
      gotoxy(j, i); crt.TextColor(aobjects.get_obj_tcolor(k)); crt.TextBackground(aobjects.get_obj_bgcolor(k));
      //if gmap[i][j][1][2]=-1 then begin crt.TextColor(aobjects.get_obj_tcolor(global_map[i][j][1])); crt.TextBackground(aobjects.get_obj_bgcolor(global_map[i][j][1])); end;
      Write(p_sym);//k, ' ');//, ' | ');
    end;
  end;
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
      gotoxy(tile_posx, tile_posy);
      
      for var n:=1 to tile_len*tile_len do
      begin
        var k:=global_map[posy][posx][n];

        p_sym:=aobjects.get_obj_sym(k);
        gotoxy(tile_posx+tx, tile_posy+ty); 
        crt.TextColor(aobjects.get_obj_tcolor(k)); 
        crt.TextBackground(aobjects.get_obj_bgcolor(k));
        
        Write(p_sym); crt.TextColor(15); write( '|');//, ' | ');
        tx+=3;
        if tx>=tile_len*3 THEN begin tx:=0; ty+=1 end;
        
      end;
    end;
  end;
end;

procedure hero_stats_printer();
begin
  gotoxy(stats_posx, stats_posy); write('name:', '.'*(stats_min_len+1), hero.name);
  gotoxy(stats_posx, stats_posy+1); write('level:', '.'*stats_min_len, hero.level);
  gotoxy(stats_posx, stats_posy+2); write('hp:', '.'*(stats_min_len+3), hero.hp);
  gotoxy(stats_posx, stats_posy+3); write('atk:', '.'*(stats_min_len+2), hero.atk);
end;

procedure map_analyzer(var gmap:mapi; p_posx, p_posy:integer);
begin
  for var i:=1 to h do
  begin
    for var j:=1 to w do
    begin
      for var n:=1 to tile_len*tile_len do
      begin
        var k:=gmap[i][j][n];
        if k[1]=1 then
        begin
          if aobjects.live_objs[k[2]].hp<=0 then
          begin
            //rechange it! -- add id's gravitation
            {aobjects.live_objs[k[2]].sym:='%';
            aobjects.live_objs[k[2]].touchable:=true;}
            gmap[i][j][n][1]:=aobjects.live_objs[k[2]].next_station[1];
            gmap[i][j][n][2]:=aobjects.live_objs[k[2]].next_station[2];
          end
          else 
          begin
            var vx, vy :integer;
            if i<p_posy then begin vx:=1; vy:=0; end
            else if i>p_posy then begin vx:=-1; vy:=0; end;
            
            if j<p_posx then begin vy:=1; vx:=0; end
            else if j>p_posx then begin vy:=-1; vx:=0; end;
            
            
            if (i+vx<h) and (j+vy<w) and (i+vx>1) and(j+vy>1) and (aobjects.live_objs[k[2]].step=false) and ((abs(i-p_posy)>1) or (abs(j-p_posx)>1)) then 
            begin
              var t_tble:=gmap[i+vx][j+vy][1]; var l:=1;
              while aobjects.get_obj_touchable(t_tble) and (l<=tile_len) do begin l+=1; t_tble:=gmap[i+vx][j+vy][l] end;
            
              if aobjects.get_obj_touchable(t_tble)=true then 
              begin 
                gmap[i][j][n][1]:=gmap[i][j][tile_len][1]; gmap[i][j][n][2]:=gmap[i][j][tile_len][2]; //write('\', i+vx, ' ', j+vy, ' ', k[2], '/'); //delay(1000);
                gmap[i+vx][j+vy][n][1]:=k[1]; gmap[i+vx][j+vy][n][2]:=k[2]; aobjects.live_objs[k[2]].step:=true;
                //map_printer(gmap);
              end; 
            end
            else if (abs(i-p_posy)<=1) and (abs(j-p_posx)<=1) and ((i=p_posy) or (j=p_posx)) then aobjects.attack_on(k, gmap[p_posy][p_posx][1])
            else if aobjects.live_objs[k[2]].step=true then aobjects.live_objs[k[2]].step:=false;
          end;
          
        end;
        if (k[1]=2) and (k[2]<>-1) then 
        begin
          if aobjects.other_objs[k[2]].hp<=0 then
          begin
            aobjects.other_objs[k[2]].hp:=aobjects.other_objs[k[2]].max_hp;
            gmap[i][j][n][1]:=aobjects.other_objs[k[2]].next_station[1];
            gmap[i][j][n][2]:=aobjects.other_objs[k[2]].next_station[2];
          end
        end
        else if (k[1]=3) then 
        begin
          if aobjects.next_oobjs[k[2]].hp<=0 then
          begin
            //delay(5000);
            aobjects.next_oobjs[k[2]].hp:=aobjects.next_oobjs[k[2]].max_hp;
            gmap[i][j][n][1]:=aobjects.next_oobjs[k[2]].next_station[1];
            gmap[i][j][n][2]:=aobjects.next_oobjs[k[2]].next_station[2];
          end
        end;
      end;
    end;
  end;
  
end;

end.