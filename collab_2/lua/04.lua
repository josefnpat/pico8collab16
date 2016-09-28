add(games, {
name="zapp-alike",
author="@adam_sporka",

_init=function(self)
	cx,cy,matrix,mask,score,t,started_at,pl=16,16,{},{},0,120,time(),true
	for a=0,1023 do
		matrix[a]=flr(rnd(2))+12
	end
	self:clear_mask()
end,

idx=function(x,y)
	return x+y*32
end,

clear_mask=function()
	for a=0,1023 do mask[a]=false end
	lx,ly=-1,-1
end,

toggle=function(self)
	i=self.idx(cx,cy)
	mask[i],lx,ly=not mask[i],cx,cy
end,

match=function(self)
	dx,dy=cx-lx,cy-ly
	if (lx<0) return
	success,count=1,0
	for x=2,29 do
		for y=2,29 do
			tx,ty=x+dx,y+dy
			if (mask[self.idx(x,y)]) then
				count+=1
				if (mask[self.idx(tx,ty)]) return
				if (matrix[self.idx(tx,ty)]!=matrix[self.idx(x,y)]) success=0
			end
		end
	end
	score+=success*count^2
	sfx(13-success)
	for a=0,1023 do
		if (mask[a] or mask[a-dy*32-dx]) matrix[a]=29+success
	end
	self.clear_mask()
end,

_update=function(self)
	t=flr(120-time()+started_at)
	if t<0 then
		if (pl) sfx(14)
		pl=false
		return
	end
	if (btnp(0)) cx-=1
	if (btnp(1)) cx+=1
	if (btnp(2)) cy-=1
	if (btnp(3)) cy+=1
	cx,cy=(cx-2)%28+2,(cy-2)%28+2
	if (btnp(4)) self:toggle()
	if (btnp(5)) self:match()
end,

draw_box=function(x,y,c)
	rect(x*4-1,y*4-1,x*4+3,y*4+3,c)
end,

_draw=function(self)
	cls()
	for x=2,29 do
		for y=2,29 do
			if mask[self.idx(x,y)] then self.draw_box(x,y,3) end
			spr(matrix[self.idx(x,y)],x*4,y*4)
		end
	end
	box_color=12
	if (mask[self.idx(cx,cy)]) box_color=11
	self.draw_box(cx,cy,box_color)
	spr(28,lx*4,ly*4)
	print("score "..score,8,121,7)
	s="game over"
	if (t>=0) s="time "..t
	print(s,84,121)
end 
})

