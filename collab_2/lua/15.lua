add(games,{name="videopirate",author="team_disposable",

_update = function()
	
	cls()

	if notgameover then

		if cliptimer <= 0 then
					
			if (#obs > 0 or success == 15) notgameover = false
				
			
			size1,size2,rand = rnd"6.9"*8,rnd"6.9"*8,rnd"3.9"
			
			obs = {}
			
			for i=1,success,1 do

				add(obs,{i,flr(rnd"4"),11})

			end
				
			cliptimer += 100
			
				sprite1x,sprite1y,sprite2x,sprite2y = 32,64,40,64
				
				if(rand < 3) sprite1y = 80 
				
				if(rand < 2) sprite1y,sprite2y = 72,80
				
				if(rand < 1) sprite1y,sprite2y = 64,72

		end -- end of cliptimer is 0

		--draw the clip

		adjust,adjust2 = rnd"8",rnd"8"
	
		sspr(sprite1x,sprite1y,8,8,32+adjust,40+adjust2,size1,size1)
		
		sspr(sprite2x,sprite2y,8,8,60+adjust2,40+adjust,size2,size2)
		
		--update obstructions
	
		if #obs == 0 then 
			success += 1  cliptimer = 0 
	
		else
	
		o = obs[1]
		o1,o2,o3 = o[1],o[2],o[3]
		if o1 == 1 then 
				
				
			if (btnp"5" and btnp"4") o3 = 0  
					
			sspr(32,88,8,8,40,50,40,40)
					
			
		elseif o1 == 2 then
					
			if(btnp"4") o3 -= 2
			liney = rnd"40"+29
			for i = 19,109,5 do

				line(i,liney,i+o3,liney+o3,14)

			end
						
				
		elseif o1  < 11 then
						
			if btn(o2) then o3 -= 2 end
						
						
			spritex,flipped = 48,false
					
					
			if o2 == 1 then flipped = true   
						
			elseif o2 == 2 then spritex = 56  
						
			elseif o2 == 3 then spritex = 56 flipped = true end
						
			sspr(spritex,72,8,8,50,50,24,24,flipped,flipped)
						 
			for i=1,o3,1 do
				for j=1,20,1 do
								
					pset(rnd"90"+19,rnd"80"+19,o2+1)
								
								
				end
										
			end
					
		else
				
			bumpat -= 4
			if bumpat < 19 then bumpat = 109 end
						
			bmpcolour = 9
						
			if bumpat < 74 and bumpat > 54 then
				bmpcolour = 11
				if btnp"5" then o3,bumpat= 0,15   end
						
			end
						
			for b = 40+adjust,80,5 do
				line(19,b,bumpat,b,bmpcolour)
				line(bumpat+8,b,109,b)
				spr(181,bumpat,b-8)
			end
					
					
		end
			
		o[3] = o3
		if(o3 <= 0.1) del(obs,o) cliptimer += 35
		
		cliptimer -=1
		--cursor(20,28)
		print(cliptimer,85,20)
		
	end	
	
	
		
else
		cursor(20,28)
		
		if success == 15 then 
			print"your collection\nis superb. \nvhs will never die,\nyou gloat\n\n\n\n\npress z to restart" 
		
		else
			print"no one said piracy\nwas easy.\n\nz+x to break copyright\narrows reduce static\nz to remove scanlines\nx in time to lock on\n\npress z to restart"
		
		end
		--print(printline,20,28)
		
		if(btnp"4") cgame:_init()
end
	--draw tv
	sspr(48,80,16,16,4,4,120,120)
	--draw tape
	spr(134,30,110,2,1)
	print(success,50,110)
	
	
end,
		
_init = function(self)
			
		notgameover,cliptimer,success,bumpat,obs = true,0,0,0,{}
		music"0"
		
	end})
