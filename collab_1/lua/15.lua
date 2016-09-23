seansleblanc={
name="  \136.\136  ",
author="@seansleblanc",
_init=function(self)

local px,py,pr,cam,ticks,v,sprs,win,score,highscore=8,8,5,0,0,{},{},false,0,dget(40)

local getitem=function(t)
 return t[flr(rnd(#t-1))+1]
end

local tick_map=function(c)
 del(sprs,c)

 for x=24,39 do
 for y=0,15 do
  if mget(x,y) == c then
   mset(x,y)
  end
 end
 end
 sfx"41"
 cam+=10
 ticks=0
end

	for i=1,255 do
	 local sv=0
	 for x=0,7 do
  for y=0,7 do
  sv+=sget(i*8%128+x,flr(i/16)*8+y)
  end
  end
  if sv>0 then
   add(v,i)
  end
 end

 ts=getitem(v)
 del(v,ts)
 for i=1,max(16,#v) do
  local s=getitem(v)
  add(sprs,s)
  del(v,s)
 end

 for x=24,39 do
 for y=0,15 do
  mset(x,y,getitem(sprs))
 end
 end
 mset(24+rnd"16",rnd"16",ts)


self._update=function()
	if win then
	 if btnp"5" then
	  run""
	 end
	else

  ticks+=1
  if ticks > 120 then
   tick_map(getitem(sprs))
  end

  if btnp"4" then
   pr+=10
   local s=mget(24+px,py)
   if s==ts then
    win=true
    for x=0,15 do
    for y=0,15 do
     if mget(24+x,y) != 0 then
      score+=1
     end
    end
    end
    if score > highscore then
     highscore=score
     dset(40,highscore)
    end
    sfx"42"
   elseif s==0 then
    sfx"43"
    cam+=5
   else
    tick_map(s)
   end
  end

  local dx,dy=0,0
  if btnp"0" then
   dx-=1
  elseif btnp"1" then
   dx+=1
  elseif btnp"2" then
   dy-=1
  elseif btnp"3" then
   dy+=1
  end

  if dx!=dy then
   cam-=10
   sfx"40"

   px+=dx
   py+=dy

   px%=16
   py%=16
  end

 end

 pr*=0.7
 pr+=abs(sin(time""))+1

 cam*=0.3
end


self._draw=function()
 camera(cam+1)
	for i=0,500 do
	 circ(rnd"128",rnd"128")
	end
	map"24"

 local pxx,pyy=px*8+4,py*8+4
 for x=-pr,pr do
 for y=-pr,pr do
  if x*x+y*y<=pr*pr then
   a=x+pxx
   b=y+pyy
   pset(a,b,pget(a,b)-5)
  end
 end
 end
 circ(pxx,pyy,pr+1,7)
 circ(pxx,pyy,pr,0)

 if win then
  for x=20,22 do
  for y=71,73 do
  print("oh hey gg you found it\n   your score: "..score.."\n   high score: "..highscore.."\n press \151 to continue",
  x,pr+y,x+y)
  end
  end
 end
end

end
}
add(games,seansleblanc)
