som={
 name="bubble booper",
 author="somnule",
 hiscore=dget(8),
 _init=function(self)
  self.title=true
  self.bubbles={}
  self.big_bubbles={}
  dset(8,self.hiscore)
  t=0
  self:populate_bubbles(28)
  for i=0,6 do
   add(self.big_bubbles,
    {
    sx=rnd(128),
    y=rnd(128),
    r=15+rnd(10),
    dy=-rnd(1)
    })
  end
  pl={x=64,y=127,dx=0,dy=-5,s=12}
 end,
 draw_entity=function(entity)
  spr(entity.s,entity.x,entity.y,1,1,entity.dx<0)
 end,
 distance=function(a,b)
  return abs(a.x-b.x)+abs(a.y-b.y)
 end,
 closest_bubble=function(self)
  local poppable
  local min_distance=8
  foreach(self.bubbles, function(bubble)
   local distance=self.distance(pl,bubble)
   if distance < min_distance then
    poppable=bubble
    min_distance=distance
   end
  end)
  return poppable
 end,
 populate_bubbles=function(self,sprite)
  for i=0,15 do
   add(self.bubbles,{s=sprite,x=rnd(128),y=127+rnd(128),dx=0})
  end
 end,

 _update=function(self)
   t+=.01
  foreach(self.big_bubbles,function(bubble)
   bubble.y+=bubble.dy
   bubble.x=bubble.sx+5*sin(t+bubble.r)
   if bubble.y<-30 then
    bubble.y=150
   end
  end)

  if self.title then
   if btnp(5) then
    self.title=false
    score=0
    sfx(10)
   end
   return
  end
  if btn(0) then
   pl.dx-=1
  end
  if btn(1) then
   pl.dx+=1
  end
  pl.dx*=.8

  pl.dx=mid(pl.dx,-2,2)
  pl.x+=pl.dx
  pl.y+=pl.dy
  pl.x=mid(pl.x,0,122)

  if pl.y>140 then
   sfx(9)
   self.hiscore=max(self.hiscore,score)
   self:_init()
  end

  foreach(self.bubbles,function(bubble)
   bubble.y-=1
   if bubble.y<-10 then
    bubble.y=128
    bubble.x=rnd(128)
   end
  end)

  pl.dy+=.15
  local pop=self:closest_bubble()
  if pop then
   pl.dy=-3
   sfx(8)
   del(self.bubbles, pop)
   score+=16-#self.bubbles
   if #self.bubbles==0 then
    self:populate_bubbles(28+(pop.s+1)%4)
   end
  end

  pl.s=13+sgn(pl.dy)
 end,
 _draw=function(self)
  cls()
  rectfill(0,0,127,127,1)
  foreach(self.big_bubbles,function(bubble)
   circfill(bubble.x,bubble.y,bubble.r,13)
  end)

  if self.title then
   print("bubble booper",40,60,7)
   print("press ",48,66)
   if score then
    print("your score: "..score,36,102)
   end
   print("high score: "..self.hiscore,36,110)
   return
  end
  foreach(self.bubbles,self.draw_entity)
  self.draw_entity(pl)
  print(score)
 end
}
add(games,som)
