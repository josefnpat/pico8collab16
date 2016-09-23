airattack = {
name="air attack",
author="gamax92",
_init=function(self)
	poke"0x5f40" poke"0x5f42"
	music(52)
	local enemies,tick,lives,score,bullet={},0,3,0
	for i=1,64 do
		add(enemies,{rnd"64"-32,200+i*3})
	end
	camera(0xffc0,0xffe0)
	function self._update()
		if (lives <= 0) return
		local offset=btn"0" and 0xffff or (btn"1" and 1 or 0)
		if bullet then
			bullet[1]-=offset
			bullet[2]+=8
			if bullet[2]>=200 then
				bullet=nil
			end
		end
		if not bullet and btn"4" then
			bullet={0,17}
			sfx(1)
		end
		for i,enemy in pairs(enemies) do
			enemy[1]=((enemy[1]+32-offset)%64)-32
			enemy[2]-=1
			if not enemy.d then
				if bullet and abs(enemy[1]-bullet[1])<5 and abs(enemy[2]-bullet[2])<3 then
					enemy.d=15
					bullet=nil
					score+=1
					sfx(3)
				end
				if abs(enemy[1])<6 and enemy[2]<20 and enemy[2]>15 and tick<=0 then
					enemy.d=15
					tick=30
					lives-=1
					sfx(3)
				end
			end
			if (enemy[2]<=0) enemies[i]={rnd"64"-32,200}
		end
		if (tick > 0) tick-=1
	end
	function self._draw()
		cls"12"
		color"0"
		print("lives: "..lives.."\nscore: "..score,0xffc1,0xffe1)
		if lives <= 0 then poke(0x5f40,7) poke(0x5f42,7) if tick>0xffa6 then print("you are dead\n    lol",0xffe8,16) tick-=1 else self:_init() end return end
		for i,enemy in pairs(enemies) do
			local y=576/enemy[2]
			local x=enemy[1]/enemy[2]*64-y/2
			if enemy.d then
				if enemy.d>0 then
					enemy.d-=1
					for i=1,8 do
						circfill(x+rnd(y),y+rnd(y/2),y/8,rnd"3"+8)
					end
				end
			else
				sspr(64,112,32,16,x,y,y,y/2)
			end
		end
		if bullet then
			local bullet1,bullet2=bullet[1],bullet[2]/16
			local x1,y1=(bullet1-2)/bullet2,48/bullet2
			local x2,y2=(bullet1-2)/(bullet2+1),48/(bullet2+1)
			local x3=(bullet1+2)/bullet2
			local x4=(bullet1+2)/(bullet2+1)
			line(x1*4,y1,x2*4,y2,8)
			line(x3*4,y1,x4*4,y2)
		end
		if (tick%2==0) spr(232,0xfff0,32,4,2)
	end
end
}
add(games,airattack)
