karateduck = {
  name = "karate duck",
  author = "xenophyn",

  _init = function()
   make_player = function(id,a,b)
  local pl={}
   pl.id=id
   pl.spr = 204
   pl.x = a
   pl.ready = 0
   pl.face = false
   pl.pal1 = b
   pl.attack = false
  add(player,pl)
 end
 player={}
 make_player(0,16,7)
 make_player(1,80,2)
 game_line = 64
 game_life0 = 20
 game_life1 = 20
 game_done = false
 game_block = false
 music(56)
  end,

  _draw = function()
 draw_player = function(pl)
  if pl.id==1 then
   rectfill(65,4,65+(3*game_life1),12,10)
  else
   rectfill(62-(3*game_life0),4,62,12,10)
  end
  pal(7,pl.pal1)
  sspr(pl.spr*8%128,flr(pl.spr*8/128)*8,8,8,pl.x,88,32,32,pl.face)
  pal()
  if(game_done) print("your goose is cooked!",25,40,rnd(14)+1)
 end
 cls()
 sspr(104,104,8,8,0,0,128,128)
 foreach(player, draw_player)
  end,

  _update = function()
 update_player = function(pl)
  if game_life0 <= 0 or game_life1 <= 0 then
   game_done = true
  end
  pl.ready -= 1
  pl.face = false
  if(pl.x >= game_line) pl.face = true
  if pl.ready < 4 then
   if pl.spr~=204 then
    pl.spr = 204
   end
   if pl.ready <= 0 then
    if pl.id==1 then
     if(pl.x>game_line+rnd(24)) then
      pl.back = true
     else
      pl.forward = true
     end
     if(20-game_life1>rnd(20)) pl.punch = true
    else
     pl.forward=btn(1,pl.id)
     pl.back=btn(0,pl.id)
     pl.punch=btn(4,pl.id)
     pl.block=btn(5,pl.id)
    end
   end
  end
  if pl.block then
   game_block = true
   pl.spr = 253
   pl.block = false
  else
   if(pl.id==0) game_block = false
  end
  if pl.forward then
   pl.x += 8
   pl.forward = false
   pl.ready = 8
   pl.spr = 252
  end
  if pl.back then
   pl.x -= 8
   pl.back = false
   pl.ready = 8
   pl.spr = 252
  end
  if pl.punch then
   pl.ready = 8
   x=flr(rnd(3)+1)
   if(x==1) pl.spr = 220
   if(x==2) pl.spr = 205
   if(x==3) pl.spr = 223
   if abs(pl.x-game_line)<16 then
    if pl.id==1 then
     if not game_block then
      game_life0-=x
      sfx(59)
     else
      sfx(58)
     end
    else
     if rnd(10)<5 then
      game_life1-=x
      sfx(59)
     else
      sfx(58)
     end
    end
   end
   sfx(57)
   pl.punch = false
  end
 end
 if not game_done then
  game_line = 0
  for pl in all(player) do
   game_line += pl.x
  end
  game_line = game_line/2
  foreach(player, update_player)
 else
  if(btn(5)) run()
 end
end,
}
add(games,karateduck)
