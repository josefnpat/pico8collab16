add(games,{
	name="zzzzap!",
	author="scathe",
 _init=function()
  t,a,b,et,ex,score,ea,ew,level,speed,timer,thresh=0,0,0,0,0,0,false,false,1,120,210,5
  hiscore=dget"0"
  rndxy=function()
   return flr(rnd(6)+1)*16+1,flr(rnd(6)+1)*16+1
  end
  rndl=function(m) return m+flr(rnd(4)+1) end
  playerx,playery=rndxy()
  goalx,goaly=rndxy()
 end,

 _draw=function(self)
  cls()
  if not gameover then
   s2=speed/2
   timer-=1
   if(timer<=0) sfx"35" gameover=true
   rectfill(0,115,timer,117,8)
   if btnp"0" then
    if(playerx>17) playerx-=16 sfx"16"
   elseif btnp"1" then
    if(playerx<96) playerx+=16 sfx"16"
   elseif btnp"2" then
    if(playery>17) playery-=16 sfx"16"
   elseif btnp"3" then
    if(playery<96) playery+=16 sfx"16"
   end

   if playerx==goalx and playery==goaly then
    sfx"32"
    goalx=200
    score+=1
    timer+=60
    if(score>hiscore) dset(0,score) hiscore=score
    if(score%thresh==0) level+=1 thresh+=10*level/2 speed-=25
   end

   if goalx==200 then
    t+=1
    if(t==30) goalx,goaly=rndxy() t=0
   end

   for ny=1,6 do
    for nx=1,6 do
     ox,oy=nx*16+1,ny*16+1
     rectfill(ox,oy,ox+14,oy+14,6)
    end
   end

   map(64,0,0,0,16,16)
   rectfill(playerx,playery,playerx+14,playery+14,8)
   rectfill(goalx,goaly,goalx+14,goaly+14,11)

   et+=1
   if et>=speed then
    sfx"33"
    et,a,b,ew,ex=0,0,0,true,rndxy()
   end

   if ew then
    a+=1
    b+=1
    spr(rndl(211),ex,9) spr(rndl(211),ex+8,9)
    if(b>=s2) sfx"34" b=0
    if a>s2 then
     for i=1,6 do
      spr(228,ex,i*16)
      spr(229,ex+8,i*16)
      spr(230,ex,i*16+8)
      spr(231,ex+8,i*16+8)
     end
     if(playerx==ex) sfx "35" gameover=true
    end
    if(a>=s2+15) ew=false a=0
   end
  else
   print("           game over!\n\n        press \x97 to retry",0,50,7)
   if(btnp"5") gameover=false self._init()
  end

  print("score " .. score .. "       hi " .. hiscore .. "     level " .. level,0,122,9)
 end
}) -- game 9
