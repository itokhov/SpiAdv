unit aobjects;
uses perss;

var not_destroy: array of Not_destroyble; var nd_len:=0; //type 0
var live_objs: array of Anger; var lo_len:=0; //type 1
var other_objs: array of Block; var oo_len:=0; //type 2
var hero: Person:=new Person;
  
var o_id:integer;
var o_type:integer;
type tile_m=array [1..2] of integer;

function new_object(type_obj:integer; type_id:integer): integer;
begin
    if type_obj=0 then begin //Not_destroyble
    nd_len+=1;
    if type_id=0 then //bedrock
      begin SetLength(not_destroy, nd_len); not_destroy[nd_len-1]:=new Not_destroyble('#', 0, 15); end
    else if type_id=1 then //air
      begin SetLength(not_destroy, nd_len); not_destroy[nd_len-1]:=new Not_destroyble(' ', 0, 0, true); end; 
    result:=nd_len-1;
    end;
      
    if type_obj=1 then begin //live_obj
    lo_len+=1;
    if type_id=0 then //anger
      begin SetLength(live_objs, lo_len); live_objs[lo_len-1]:=new Anger('D', 4, 0, 30, 5); end; //dragon //dont forget to make the random angars generator
    result:=lo_len-1;
    end;
      
    if type_obj=2 then begin //other_obj
    if type_id=0 then //hero
      begin hero:=new Person; result:=-1; end
    else 
    begin 
      oo_len+=1;
      if type_id=1 then //wood
      begin SetLength(other_objs, oo_len); other_objs[oo_len-1]:=new Block('=', 6); end; 
      if type_id=2 then //point
      begin SetLength(other_objs, oo_len); other_objs[oo_len-1]:=new Block('.', 8); end; 
      result:=oo_len-1;
    end; end;

end;

function get_obj_bgcolor(k:tile_m): integer;
begin
  if k[1]=0 then begin result:=aobjects.not_destroy[k[2]].def_bgcolor; end; //dot forget about "now_color"
  if k[1]=1 then begin result:=aobjects.live_objs[k[2]].def_bgcolor; end;
  if k[1]=2 then 
  begin
    if k[2]=-1 then result:=aobjects.hero.def_bgcolor 
    else result:=aobjects.other_objs[k[2]].def_bgcolor;
  end;
  
end;
function get_obj_tcolor(k:tile_m): integer;
begin
  if k[1]=0 then begin result:=aobjects.not_destroy[k[2]].def_tcolor; end; //dot forget about "now_color"
  if k[1]=1 then begin result:=aobjects.live_objs[k[2]].def_tcolor; end;
  if k[1]=2 then 
  begin
    if k[2]=-1 then result:=aobjects.hero.def_tcolor 
    else result:=aobjects.other_objs[k[2]].def_tcolor;
  end;
  
end;
function get_obj_sym(k:tile_m): char;
begin
  if k[1]=0 then begin result:=aobjects.not_destroy[k[2]].sym; end; //dot forget about "now_color"
  if k[1]=1 then begin result:=aobjects.live_objs[k[2]].sym; end;
  if k[1]=2 then 
  begin
    if k[2]=-1 then result:=aobjects.hero.sym
    else result:=aobjects.other_objs[k[2]].sym;
  end;
end;

end.