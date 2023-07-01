unit game_consts;
const
  window_w = 120;
  window_h = 30;
  w = 80;
  h = 20;
  
  tile_posx = w+3;
  tile_posy = 2;
  tile_len = 3;
type 
  tile_m=array [1..2] of integer;
type 
  mapi = array [1..h] of array[1..w] of array[1..tile_len*tile_len] of tile_m;
type
  backpack=array [1..9] of tile_m;


end.