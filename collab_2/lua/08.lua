add(games,{
	name = "piconaut",
	author = "josefnpat",
	_init = function()
		music"8"
		c = cameralib.new{height=64}
		draw_player = function(x,height)
			color"5"
			spr(192,x-16,48-height*32,4,2)
		end
		draw_tile = function(x,y)
			local r = y + off-1.5
			local i = (death or 0) - 2
			local size = 0.45
			local possizex,negsizex = size+x,-size+x
			local possizer,negsizer = size+r,-size+r
			local ia = {possizex,i,possizer}
			local ib = {possizex,i,negsizer}
			c:line(ia,ib)
			local ic = {negsizex,i,negsizer}
			c:line(ib,ic)
			local id = {negsizex,i,possizer}
			c:line(ic,id)
			c:line(id,ia)
			-- x
			c:line(ia,ic)
			c:line(ib,id)
		end
		off = 0
		speed = 1
		score = 1
		jump_height = 0
		jump_v = 0
		player_x = 0
		player_y = 0
		death = nil

		map = {}
		chance = 0
		for j = -2,500 do
			chance += 1/500
			map[j] = {}
			for i = -2,2 do
				map[j][i] = rnd() > chance
			end
			map[j][flr(rnd"5")-2] = true
		end
	end,
	_update = function(self)
		player_y -= 1/30*speed
		off = player_y%1
		if not death then
			score += speed*0.05
			dset(8,max(score,dget"8"))
		end
		speed = btn"5" and min(5,speed+0.1) or max(1,speed-0.025)
		if btnp"4" and not death and jump_height == 0 then
			jump_v = 0.25
		end
		jump_v -= 0.025
		jump_height = max(0,jump_height+jump_v)
		if btn"0" then
			player_x += 0.1
		end
		if btn"1" then
			player_x -= 0.1
		end
		player_x = min(2,max(-2,player_x))
		if death then
			death += 0.1
		end
		rx = flr(player_x+0.5)
		ry = -flr(player_y)
		if jump_height == 0 and not map[ry][rx] then
			death = death or 0
		end
	end,
	_draw = function()
		cls()
		local perspective_x = c:_coordstopx{player_x,-2,0}
		for x = -2,2 do
			for y = -1,6 do
				ty = y-flr(player_y)
				if map[ty][x] then
					color( rx == x and 8 or y == 0 and 3 or 11)
					draw_tile(x,y)
				end
			end
		end
		color"5"
		draw_player(perspective_x[1],jump_height)
		--spr(224,48,112,4,2)
		--sspr(0,112,32,16,0,64,128,64)
		sspr(0,112,32,16,32,96,64,32)
		color"7"
		print("    score:"..flr(score)..",000\ntop score:"..flr(dget(8,best))..",000\n\n")
		if death then
			print"off track - game over\nreset cart to play again\n\n\n\n\n\ncredits:\ncode: @josefnpat\nart: @josefnpat\nmusic: @josefnpat"
		else
			print(flr(speed*100).."km/h")
		end
	end
})
