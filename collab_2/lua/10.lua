mazes = {
 name = "infinite mazes",
 author = "fayne aldan",
 _init = function(self)
  for x=0,63 do
  	for y=0,63 do
  		mset(x,y,77)
  		if (x>48 or y>48) mset(x,y,0)
  	end
  end
  cx=1;cy=0;ax=0;ay=0;al=8
  tmr=0;win=false
  self:carve(1,1)
  mset(1,0,78)
  mset(47,48,79)
 end,
 _update = function(self)
  tmr+=1
  if win then
   tmr-=1
 	 if (btnp(4)) self:_init()
 	elseif ax!=0 or ay!=0 then
 	 al-=2
 	 if (al==0) ax=0;ay=0
 	else
	 	ox=cx;oy=cy;al=8
 	 if (btn(0)) cx-=1;ax=-1
   if (btn(1)) cx+=1;ax= 1
   if (btn(2)) cy-=1;ay=-1
   if (btn(3)) cy+=1;ay= 1
   if (mget(cx,cy)==79) win=true
   if (mget(cx,cy)!=78) ax=0;ay=0;cx=ox;cy=oy
  end
 end,
 _draw = function()
  cls();color(12)
  local t=flr(tmr/30)
  if win then
  	print("maze complete! time: "..t.." secs")
  	print("press  for a new maze")
  else
	 	map(-9+cx,-9+cy,-12+ax*al,-12+ay*al,19,19)
 	 spr(76,60,60)
   print(t)
  end
 end,
 carve = function(self,x,y)
 	local r=flr(rnd(4))
  mset(x,y,78)
  for i=0,3 do
  	local d=(i+r)%4
  	local dx=0
  	local dy=0
  	if (d==0) dx= 1
  	if (d==1) dx=-1
  	if (d==2) dy= 1
  	if (d==3) dy=-1
  	local nx=x+dx
  	local ny=y+dy
  	local nx2=nx+dx
  	local ny2=ny+dy
  	if mget(nx,ny)==77 then
  		if mget(nx2,ny2)==77 then
  			mset(nx,ny,78)
  			self:carve(nx2,ny2)
  		end
  	end
  end
 end
}
add(games,mazes)
