xturn = true
add(games,{
	name = "tictactoe",
	author = "@ramilego4game",
	_init = function()
	 camera(-15,-15)
		rectfill(-15,-15,142,142,6)
		sspr(96,96,24,24,0,0,96,96)
		xo = {}
		for x=1,3 do xo[x] = {0,0,0} end
		cx, cy = 1,1
		win = 0
		steps = 0
		
		function chkxo(x1,y1,x2,y2,x3,y3)
			return xo[x1][y1] == xo[x2][y2] and xo[x2][y2] == xo[x3][y3] and xo[x1][y1] ~= 0
		end
		
		function calcwin()
		 for x=1,3 do
		  if chkxo(x,1,x,2,x,3)then
		   return xo[x][1]
		  end
		 end
		 for y=1,3 do
		  if chkxo(1,y,2,y,3,y) then
		   return xo[1][y]
		  end
		 end
		 if chkxo(1,1,2,2,3,3) then
		 	return xo[1][1]
		 elseif chkxo(3,1,2,2,1,3) then
		  return xo[2][2]
		 end
		 return steps == 9 and 3 or 0
		end
	end,
	
	_draw = function()
		if win > 0 then return end
		pal(9,xturn and 12 or 8)
		sspr(120,104,8,8,(cx-1)*32,(cy-1)*32,32,32)
		pal()
		for x=1,3 do for y=1,3 do
		 shp = xo[x][y]
		 if shp > 0 then
		 	sspr(shp==1 and 96 or 104,120,8,8,(x-1)*32,(y-1)*32,32,32)
		 end
		end end
	end,
	
	_update = function(self)
		if btnp() > 0 and win > 0 then self._init() return end
		sspr(120,96,8,8,(cx-1)*32,(cy-1)*32,32,32)
		if btnp(0) then --left
			cx -= 1
		elseif btnp(1) then --right
		 cx += 1
		elseif btnp(2) then --up
			cy -= 1
		elseif btnp(3) then --down
		 cy += 1
		end
		cx = mid(1,cx,3)
		cy = mid(1,cy,3)
		if btnp(4) or btnp(5) then
			if xo[cx][cy]<1 then sfx(5)
				xo[cx][cy] = xturn and 1 or 2
				xturn = not xturn
				steps += 1
				self._draw()
				win = calcwin()
				if win > 0 then
					rectfill(15,44,84,55,6)
					if win == 3 then
						color(9)
						print("draw !!!",38,48)
						spr(239,17,46)
					else
					 color(win==1 and 12 or 8)
					 print("player wins !",33,48)
					 spr(253+win,17,46)
					end
					rect(14,43,85,56)
				end
			end
		end
	end
}) -- game 2
