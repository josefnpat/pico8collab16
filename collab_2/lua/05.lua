add(games,{
		name="super forum poster 2 turbo dx edition",
		author="@fweez",
		_update = function()
			cls()
			map(16,0,0,0,16,16)
			color"6"
			cursor(0,1)
			if not state then
				print"super forum poster 2 turbo dx"
				if (btnp"4") state = 0
			else
				print("@"..player.name.." score:"..score.." time:"..timer)
			end
			if state == 0 then
				if (btn"0") player.x -= 1.5
				if (btn"1") player.x += 1.5
				if (btn"2") player.y -= 1.5
				if (btn"3") player.y += 1.5

				timer -= 1
				if (timer == 0) state = 1
			end

			local yoff = 33
			for a in all(actors) do
				if state == 0 then
					a.x = mid(8, a.x+a.vx, 122)
					if (a.x <= 8 or a.x >= 122) a.vx *= -1
					a.y = mid(42, a.y + (a.vy or 0), 116)
				end
				local s = 64
				if a.color then
					s = 65
					if (a.y >= 116 or a.y <= 42) a.vy *= -1
					if a.y <= 42 then
						del(actors, a)
						add(actors, a)
					elseif a.vy > 0 then
						for o in all(actors) do
							if not o.color and abs(o.y-a.y-7) < 2 and abs(o.x-a.x) <= 6 then
								a.name = o.name
								a.vy = -1
								break
							end
						end
					end
					print("thread:"..a.topic.." lp: @"..a.name, 4, yoff, a.color)
					if (a.name == player.name and state == 0) score += 1
					pal(8, a.color)
					yoff -= 6
				elseif a == player then
					pal(13,14)
				end
				spr(s, a.x-4, a.y)
				pal()
			end

			cursor(4, 44)
			if (state == 1) print"game over"
			if not state then
				print"dominate the forum! z to start"
				print" arrows move. bounce threads,"
				print"and dominate the conversation!"
			end
		end,
		_init = function(self)
			actors = {}
			local function rndchar(l)
				local a = flr(rnd(#l))+1
				return sub(l, a, a)
			end
			local function rndactor(p, y)
				if (p) y = 116-rnd(60-p)
				local alpha = "abcdefghijklmnopqrstuvwxyz"
				local a = {
					x=8+rnd(112),
					y=y,
					vx=1 - rnd(2),
					name=rndchar(alpha)..rndchar(alpha)..flr(rnd(1000))
				}
				add(actors, a)
				return a
			end
			for i=1,20 do
				rndactor(i*2)
			end
			local wide = "\140\148\133\137\141\145\130\134\138\142\146\150\131\135\139\143\147\151"
			for i=0,4 do
				local t = rndactor(nil, 127)
				t.vy = -1
				t.topic = rndchar(wide)..rndchar(wide)
				t.color = 8+i
			end
			player = rndactor(nil, 64)
			player.x = 64
			player.vx = 0
			score = 0
			timer = 1800
			state = nil
		end,
})
