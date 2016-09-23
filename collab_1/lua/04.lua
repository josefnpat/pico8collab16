sheepdog = {
 name = "sheep dog",

 author = "felixmreeve",

 _init = function(self)
  t = 0
  posx = 63
  posy = 80
  velx = 0
  vely = 0
  accy = 0
  accx = 0
  push = 1
  self.placesheep()
  speed = 0.1
  score = 0
  gameover = false
  pat = false
  sfx(14)
 end,

 _update = function(self)
  if gameover then
   if(btnp(5)) self:_init()
  else
   sheepz -= speed
   if sheepz < 1 then
    if abs(sheepx - posx) < 12
    and abs(sheepy - posy) < 12 then
     score += 1
     speed += 0.01
     sfx(13)
     self.placesheep()
    else
     gameover = true
     sfx(12)
    end
   end

   accx = 0
   accy = 0
   if (btn(0)) accx = -0.2
   if (btn(1)) accx = 0.2
   if (btn(2)) accy = -0.2
   if (btn(3)) accy = 0.2
   velx += accx
   vely += accy
   avelx = abs(velx)
   avely = abs(vely)
   if (avelx > 3) velx *= 3 / avelx
   if (avely > 3) vely *= 3 / avely
   if (posx < 26)  velx = 1
   if (posx > 103) velx = -1
   if (posy < 30)  vely = 1
   if (posy > 101) vely = -1
   posx += velx
   posy += vely
   t += avelx + avely
  end
 end,

 _draw = function(self)
  cls(11)
  color(13)
  print("catch the sheep!")
  print("score: "..score)
  if gameover then
   print("game over...")
   print("press x to retry")
  else
   circ(sheepx, sheepy, sheepz, 10)
   self.drawrow(20)
   self.drawdog()
   spr(96 + sheepz % 4 + 16 * (flr(sheepz/4) % 2), sheepx - 4, sheepy - sheepz * 5)
   self.drawrow(100)
   self.drawcol(20)
   self.drawcol(108)
  end
 end,

 drawrow = function(y)
  for x = 21, 101, 8 do
   spr(80, x, y)
  end
 end,

 drawcol = function(x)
  line(x, 21, x, 107, 7)
 end,

 drawdog = function()
  local a = atan2(velx, vely)
  local hop = abs(3 * sin(t / 15))
  for z = 0, 3 do
   local z8 = z * 8
   for y = -6, 6 do
    for x = -6, 6 do
     local x2 = cos(a) * x + sin(a) * y + 4 + z8
     local y2 = cos(a) * y - sin(a) * x  + 36
     if x2 >= z8
     and x2 < 8 + z8
     and y2 >= 32
     and y2 < 40 then
      local col = sget(x2, y2)
      if (col ~= 0) pset(posx + x, posy + y - z - hop, col)
     end
    end
   end
  end
 end,

 placesheep = function()
  sheepx = 30 + rnd(69)
  sheepy = 34 + rnd(63)
  sheepz = 20
 end
}
add(games,sheepdog)
