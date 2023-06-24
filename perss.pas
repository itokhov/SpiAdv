unit perss;

type Person = class
  
  vecx:integer;
  vecy:integer;
  vis_range:integer:=5;//potom
  step_size:integer:=1;
  
  name:string;
  level:integer:=0;
  sym:char := 'Ж'; //SPIDERS!!!
  max_hp:=100; hp:=max_hp; atk:=10;
  def_tcolor:integer:=1;
  def_bgcolor:integer:=4;
  touchable:boolean:=false;//if false, then you cant mooving on it
  
  procedure Print;
  begin
    writeln('My name is ', name, ', level - ', level);
  end;
  
  procedure input(input_key:char);
  begin
    if input_key='2' then begin vecy:=step_size; vecx:=0; end;
    if input_key='6' then begin vecx:=step_size; vecy:=0; end;
    if input_key='8' then begin vecy:=-step_size; vecx:=0; end;
    if input_key='4' then begin vecx:=-step_size; vecy:=0; end;
  end;
end;

type Anger = class(Person)
  
  sym:char;
  max_hp:integer;
  hp:integer;
  atk:integer;
  
  def_tcolor:integer:=4;//red
  def_bgcolor:integer:=0;
  //def_bgcolor:integer:=; //adaptive(not have static)
  touchable:boolean:=false;//if false, then you cant mooving on it
  constructor (symb:char; tc:integer; bg:integer; max_hp:integer; atk:integer);
  begin
    sym:=symb;
    def_tcolor:=tc;
    def_bgcolor:=bg;
    self.max_hp:=max_hp; hp:=max_hp;
    self.atk:=atk;
  end;
  procedure Print;
  begin
    write('My name is ', name, ', level - ', level);
  end;
  
  procedure input(input_key:char);
  begin
    if input_key='2' then begin vecy:=step_size; vecx:=0; end;
    if input_key='6' then begin vecx:=step_size; vecy:=0; end;
    if input_key='8' then begin vecy:=-step_size; vecx:=0; end;
    if input_key='4' then begin vecx:=-step_size; vecy:=0; end;
  end;
end;


type Not_destroyble = class
  sym:char;
  def_tcolor:integer;
  def_bgcolor:integer; //adaptive(not have static)
  touchable:boolean;//if false, then you cant mooving on it
  constructor (symb:char; tc:integer; bg:integer; t:boolean:=false);
  begin
    sym:=symb;
    def_tcolor:=tc;//black
    def_bgcolor:=bg; //white
    touchable:=t;
  end;
end;

type Block = class
  sym:char;
  def_tcolor:integer;
  def_bgcolor:integer; //adaptive(not have static)
  max_hp:integer; hp:integer;
  constructor (symb:char; tc:integer:=15; bg:integer:=0; max_hp:integer:=30);
  begin
    sym:=symb;
    def_tcolor:=tc;
    def_bgcolor:=bg; 
    self.max_hp:=max_hp; hp:=max_hp;
  end;
end;

{
type Bedrock =class(Not_destroyble)
  sym:='#';
  def_tcolor:=0;//black
  def_bgcolor:=15; //white
end;
type Air = class(Not_destroyble)
  sym:=' ';
end;
}
end.