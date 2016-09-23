met ={
name = "solo shredder",
author="met",
_init=function(self)
	local l_arr,d_arr,u_arr,r_arr,arrs,frame,pressed,success,score,uicolor = 27,25,26,24,{},0,{l=0,d=0,u=0,r=0},true,0,1

 local coltox = function(col)
  if(col==l_arr)return 38
  if(col==d_arr)return 53
  if(col==u_arr)return 68
  if(col==r_arr)return 83
 end

	local is_active = function(dur)
 	if(dur==0)return false
 	return true
	end

	 local succeed = function()
 	success = true
 	score += 100
 end

 local kill_arr = function(arr)
  del(arrs,arr)
  if(arr.col==l_arr and is_active(pressed.l))return succeed()
  if(arr.col==r_arr and is_active(pressed.r))return succeed()
  if(arr.col==u_arr and is_active(pressed.u))return succeed()
  if(arr.col==d_arr and is_active(pressed.d))return succeed()
  success = false
  score -= 250
 end

	music(4)

self._update = function()
	if(frame%15==0)then
		uicolor += 1
 	if(uicolor >4) uicolor =1
		local col = flr(24+rnd(5))
		if(col<28) then
			local arr = {x=coltox(col),y=0,col=col}
			add(arrs,arr)
		end
	end

	for k,v in pairs(arrs) do
		v.y += 1
		if(v.y>87)	kill_arr(v)
	end

	if(btn(0)) pressed.l = 5
 if(pressed.l>0) pressed.l-=1
 if(btn(1)) pressed.r = 5
 if(pressed.r>0) pressed.r-=1
 if(btn(2)) pressed.u = 5
 if(pressed.u>0) pressed.u-=1
 if(btn(3)) pressed.d = 5
 if(pressed.d>0) pressed.d-=1

	frame += 1
 if(frame>29) frame = 0
end

self._draw = function()
	cls()
	color(uicolor)
	line(0,90,125,90)
	line(30,0,30,127)
	line(100,0,100,127)
	for i=0,3 do
		circ(42+15*i,90,3)
	end
	for k,v in pairs(arrs) do
		spr(v.col,v.x,v.y)
	end
	if(is_active(pressed.l))spr(42,38,86)
	if(is_active(pressed.d))spr(40,53,86)
	if(is_active(pressed.u))spr(41,68,86)
	if(is_active(pressed.r))spr(43,83,86)
	if(success) then
		spr(10,60,100)
	else
		spr(9,60,100)
	end
	local pepe = 11
	if(success)pepe = 8
	spr(pepe,50,100)
	spr(1,70,100)
	print(score,0,0)
end
end
}
add(games,met)
