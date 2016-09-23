pac1d = {
  x=512,
  z=0,
  b=0,
  dir=1,
  zdir=0,
  pell={},
  ghosts={},
  eat=0,
  name = "pac-1d",
  author = "drcode",
  _init = function(self)
   for t=1,30 do
   	add(self.ghosts,{(rnd(900)+574)%1024,1,60,t%4+1})
   end
   music(48,5000)
  end,
  _update = function(self)
		 x=self.x
  	cls()
	if self.msg then
		print(self.msg,40,60)
		return
	end
	if (btn(0) or x>=1020) self.dir=-1
	if (btn(1) or x<=0) self.dir=1
	if (btnp(4)) self.zdir=1 sfx(51,3)
	x+=self.dir
	pcur=(x-66)/8+8
	if x%8==2 and self.z==0 and not self.pell[pcur] then
	 sfx(48,1,24)
		self.b+=1
		self.pell[pcur]=1
	 if self.b==127 then self.msg="you win!" end
		if pcur%30==0 then self.eat=150 sfx(48,2) end
	end
	self.z+=self.zdir
	if self.z==30 then self.zdir=0 self.z=0 end
	self.eat=max(0,self.eat-1)
	self.x=x
	print("can u beat it? (z=jump)",572-x,30)
	rect(60-x,59,1085-x,68,12)
	for t=0,127 do
		p=self.pell[t]
		gs=212
		if t%30==0 then gs=199 end
		if not p then spr(gs,61+t*8-x,60) end
	end
	sx=32
	if flr(x/2)%2==0 then sx=40 end
	scale=(15-abs(self.z-15))
	for g in all(self.ghosts) do
		if g[1]>=1020 then g[2]=-1 end
		if g[1]<=0 then g[2]=1 end
		if rnd(100)<1 then g[2]=-g[2] end
		mul=1.5
		if self.eat>0 then mul=0.5 end
		g[1]+=g[2]*mul
		if abs(g[1]-x)<4 and g[3]==60 and self.z==0 then
			if self.eat==0 then self.msg="game over"
			else
			g[3]=59
			sfx(50,3)
			end
		end
	 gs=198
	 if self.eat>0 then gs=213 end
		if g[3]<60 then gs=214 g[3]-=2 end
		v={8,11,12,14}
		pal(14,v[g[4]])
		spr(gs,60+g[1]-x,g[3])
	end
	sspr(sx,96,8,8,60,60-scale/2,8+scale,8+scale,self.dir==-1)
  end
}
add(games,pac1d)
