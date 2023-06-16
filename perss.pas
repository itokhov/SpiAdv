unit perss;

type Person = class
  
  vecx:integer;
  vecy:integer;
  name:string;
  vis_range:integer;
  step_size:integer:=1;
  
  procedure Print;
  begin
    writeln('My name is ', vecx, ', age - ', vecy);
  end;
  procedure input(input_key:char);
  begin
    if input_key='2' then begin vecy:=step_size; vecx:=0; end;
    if input_key='6' then begin vecx:=step_size; vecy:=0; end;
    if input_key='8' then begin vecy:=-step_size; vecx:=0; end;
    if input_key='4' then begin vecx:=-step_size; vecy:=0; end;
  end;
end;
  
end.