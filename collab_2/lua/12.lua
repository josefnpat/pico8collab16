btnp_45=function()
 return btnp"4" or btnp"5"
end

add(games,{
 name="  tele",
 author="@rhythm_lynx\nmusic:  @robbyduguay",
 
 _init=function(self)
  poke(0x5f2c,3)
  music(4,1000)
  state,level,lx,ly,moves,restarts="title",1,16,16,0,0
  self.find_player()
 end,
 
 find_player=function()
  for x=0,7 do
   for y=0,7 do
    if(mget(lx+x,ly+y)==160)px,py=lx+x,ly+y
   end
  end
 end,
 
 find_telepad=function(dx,dy)
  x,y=px-lx,py-ly
  while x>0 and x<7 and y>0 and y<7 do
   x+=dx y+=dy
   if(fget(mget(lx+x,ly+y),1))return lx+x,ly+y,true
  end
  return 0,0,false
 end,
 
 _update=function(self)
  if state=="title" then
   if(btnp_45())state="game"
   return
  elseif state=="complete" then
   if(btnp_45())cgame=menu poke(0x5f2c,0)music(-1,1000)
  end
  
  if(btnp_45())reload(0x1000,0x1000,0x2000)self.find_player()restarts+=1
  
  count=0
  for x=0,7 do
   for y=0,7 do
    m=mget(lx+x,ly+y)
    if(fget(m,1))count+=1
    if(m==145)gx,gy=lx+x,ly+y
   end
  end
  if(count==0)mset(gx,gy,144)
  
  found=false
  if(btnp"0")newx,newy,found=self.find_telepad(0xffff,0)
  if(btnp"1")newx,newy,found=self.find_telepad(1,0)
  if(btnp"2")newx,newy,found=self.find_telepad(0,0xffff)
  if(btnp"3")newx,newy,found=self.find_telepad(0,1)
  if found then
   moves+=1
   px,py,m=newx,newy,mget(newx,newy)
   if m==144 then
    level+=1
    lx+=8 if(lx>24)lx=16 ly+=8
    if(level==5)state="complete"
    self.find_player()
   end
   m-=1 if(m==127)m=179
   mset(px,py,m)
  end
 end,
 
 _draw=function(self)
  cls"1"
  map(16,16,0,0,8,8,4)
  if state=="title" then
   rect(23,10,41,18,13)
   print("   tele\n\nmove\n\139\145\148\131\n\nrestart\n\142\151 (z/x)",
    13,12,6)
  elseif state=="complete" then
   rect(17,10,47,18,13)
   print("  you win\n\n"
    ..moves.." moves\n\n"
    ..restarts.." restarts\n\nwell done!",
    11,12,6)
  else
   map(lx,ly,0,0,8,8,1)
   spr(146,8*(px-lx),8*(py-ly))
  end
 end
})--game 12
