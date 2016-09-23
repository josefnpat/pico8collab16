midnightclub = {
  name = "midnight club",
  author = "dollarone",
  _init = function(self)
    player_x = 86
    player_sprite2 = 0
    road_y_offset = 0
    player_speed = 20
    cars = {}
    score = 0
    music"28"
    for y=-3000,964,18 do
      for x=-28,29,10 do
        score += 1
        if score<4 or y>-300 and x<=0 or (y < 0 or y>300) and x>0 then
          r = flr(rnd"500")
          if score<4 or r < 29+x then
            r = r%8 + 128
            if r>131 then
              r += 12
            end
            add(cars, {x=x+64,y=y,sprite=r, speed=370 - 4*abs(x)})
          end
        end
      end
    end
    score = 0
  end,

  _update = function(self)
    move_car = function(c)
      if c.x < 64 then
        c.y += (player_speed-100)/100 + c.speed/100
        if c.y > 228 then
          c.y -= 360
        end
      else
        c.y += player_speed/100 - c.speed/100
      end

      if (c.y >= 84 and c.y <= 93 and c.x >= player_x and
        c.x <= player_x + 6 or
        c.y >= 84 and c.y <= 92 and c.x+5 >= player_x and
        c.x+5 <= player_x + 6 or
        c.y+5 >= 84 and c.y+5 <= 92 and c.x >= player_x and
        c.x <= player_x + 6 or
        c.y+5 >= 84 and c.y+5 <= 92 and c.x+5 >= player_x and
        c.x+5 <= player_x + 6) and player_speed>0 then
        sfx"28"
        player_sprite2 = 160
        if player_speed > dget"28" then
          dset(28, player_speed)
          score = player_speed .. "\nnew highscore!"
        else
          score = player_speed .. "\nhighscore: " .. dget"28"
        end
        player_speed = 0
      end
    end

    if btnp"5" then
      self:_init()
    end

    for k,v in pairs(cars) do
      move_car(v)
    end
    road_y_offset += player_speed/100
    if road_y_offset >= 128 then
      road_y_offset -= 132
    end

    if player_sprite2 == 0 then
      player_speed += 1
      score = player_speed
      if btn"0" and pget(player_x - 1, 84) != 13 then
        player_x -= 2
      elseif btn"1" and pget(player_x + 8, 84) != 13 then
        player_x += 2
      end
    end
  end,

  _draw = function(self)
    rectfill(0, -50, 128, 128, 13)
    rectfill(32, -50, 96, 128, 5)

    for i=-164,164,12 do
      rect(64, road_y_offset + i, 65, road_y_offset + i + 4, 6)
    end

    spr(19, player_x, 84)
    if player_sprite2 > 0 then
      spr(player_sprite2, player_x, 84)
      player_sprite2 += 1
      if player_sprite2 == 164 or player_sprite2 == 181 then
        player_sprite2 = 176
      end
    end

    for k,car in pairs(cars) do
      spr(car.sprite, car.x, car.y, 1, 1, false, car.x < 64)
    end
    print("score: " .. score, 0, 0)
  end
}
add(games,midnightclub)
