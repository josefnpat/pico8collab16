draw_rotated_sprite = function(spr, spr_x, spr_y, spr_ang)
  r=flr(spr_ang*20)/20
  s,c=sin(r),cos(r)
  b=s*s+c*c
  for y=-6,5 do 
    for x=-6,5 do
      ox,oy=( s*y+c*x)/b, (-s*x+c*y)/b

      ax,ay,
      colr=ox+4,oy+4,
        sget(spr%16*8+ox+4,flr(spr/16)*8+oy+4)

      if ax>=0 and ax<8 and ay>=0 and ay<8 and colr>0 then 
        pset(spr_x+4+x,spr_y+4+y,colr)
        color(7)
      end
    end
  end
end

add(games, {
 name = "bmx air king",
 author = "dollarone",
  
_init = function(self)
  music"28"
  self:startgame()
end,
startgame = function() 
  timer,
  player_x,
  player_y,
  player_sprite,
  player_angle,
  player_speed,
  force,
  death_y,
  death_x,
  flips,
  score = 0,0,23,8,0,1,0.2,0,0,-1,0
end,

_draw = function()
  cls()
  map(0, 16, 0, 24, 16, 32)

  if death_y>1 then
    print(score, 10, 104)
    spr(43,death_x,death_y)
  else
    print("alternate \x8b and \x91 to speed up.\n in the air press \x8b and \x91 to\n spin and \x83 \x94 \x97 for tricks!\n     press \x8e to try again", 1, 100)
  end
  draw_rotated_sprite(player_sprite,player_x,player_y,player_angle)
end,

_update = function(self)
  timer+=player_speed
  if btn"4" then 
    self:startgame()
  end

  if flr(timer)%3==0 then
    flips *= -1
    if player_sprite < 12 then
      player_sprite += flips
    end
  end

  if death_x==1 then
    if btn"0" then 
      player_angle+=0.03125
    elseif btn"1" then 
      player_angle-=0.03125
    elseif btn"5" then 
      player_sprite = 27
    elseif btn"2" then 
      player_sprite = 24
    elseif btn"3" then 
      player_sprite = 25 
    end
    score += flr(player_sprite/15)
  elseif btn"0" and death_y<0 or btn"1" and death_y==0 then 
    death_y = abs(death_y)-1
    player_speed += 0.01
  end

  if death_x > 1 or timer < 8 then
    player_x+=player_speed
  elseif timer < 48 then
    player_angle = -0.125
    player_y+=player_speed
    player_x+=player_speed/2
  elseif timer < 63 then
    player_x+=player_speed
    player_angle = 0
  elseif timer < 68 then
    player_x+=player_speed
    player_y-=player_speed
    player_angle = 0.125
  else
    death_x = 1
    force *= 1.09
    player_y-=player_speed
    player_y+=force
    player_x+=player_speed
    --sfx"0" -- using someone else's sfx, woo. edit: ehh too much sound
  end 

  if player_y>71 then
    player_y,
    flips = 71,-1
    if (player_angle+0.1)%1 < 0.23 then
      score += player_speed*25 + abs(player_angle-0.125)*50
      death_x,
      player_sprite,
      death_y,
      player_angle,
      force = 999,8,2,0,"\nhighscore remains: " .. dget(29)
      if score>dget"29" then
        dset(29, score)
        force = "\n     new highscore!"
        sfx"17" -- using someone else's sfx, woo 
     -- else
       -- sfx"12" -- using someone else's sfx, woo. edit: too many tokens!
      end     
      score = " nice jump! score: " .. score .. force
    else
      death_x,
      death_y,
      player_sprite,
      player_angle,
      score = player_x,player_y,10,0,"    ouch ouch ouch..."
      sfx"2" -- using someone else's sfx, woo
    end
  end  
end
})
