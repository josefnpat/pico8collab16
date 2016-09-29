add(games, {
 name = "bmx air king",
 author = "dollarone",

 _init = function(self)
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
  music"28" -- music yet to be added
end,

_draw = function(self)
  cls()
  map(0, 16, 0, 24, 16, 32)

  if death_y>1 then
    print(score, 18, 104)
    spr(43,death_x,death_y)
  else
  	print("alternate ‹ and ‘ to speed up\nin the air press ‹ and ‘ to spin,\n—, ƒ and ” for tricks\n      Ž to try again", 3, 96)
  end
  draw_rotated_sprite(player_sprite,player_x,player_y,player_angle)
end,

_update = function(self)
  timer+=player_speed
  if btn"4" then 
    self:_init()
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
    force *= 1.1 
    player_y-=player_speed*1.2 
    player_y+=force
    player_x+=player_speed
    --sfx"0" -- using someone else's sfx, woo. edit: ehh too much
  end 

  if player_y > 71 then
    player_y,
    flips = 71,-1
    if (player_angle+0.1)%1 < 0.23 then
      score += player_speed*25 + abs(player_angle)*50
      death_x,
      player_sprite,
      death_y,
      player_angle,
      force = 999,8,2,0,""
      if score > dget(29) then
        dset(29, score)
        force = "\n     new highscore!"
        sfx"17" -- using someone else's sfx, woo
      else
        sfx"12" -- using someone else's sfx, woo
      end     
      score = "nice jump! score: " .. score .. force
    else
      death_x,
      death_y,
      player_sprite,player_angle = player_x + 2,player_y,10,0
      sfx"16" -- using someone else's sfx, woo
      score = "    ouch ouch ouch..."
    end
  end  
end
})