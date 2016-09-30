add(games,{name="videopirate",author="team_disposable",

_update = function()
			cls()

	if notgameover then

		if cliptimer <= 0 then
					
			if (#obs > 0 or success == 15) notgameover = false
				
			
			size1,size2,rand = rnd"6.9"*8,rnd"6.9"*8,rnd"3.9"
			
			obs = {}
				for i=success,-1,-1 do

					add(obs,{rnd"4.5",flr(rnd"4"),11})

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
		--sx sy sw sh dx dy [dw dh] [flip_x] [flip_y]
	sspr(sprite2x,sprite2y,8,8,60+adjust2,40+adjust,size2,size2)
		

		--update obstructions
	--obs = nextclip[3]
	if(#obs == 0) success += 1  cliptimer = 0 
	for o in all(obs) do
		
		if o[1] < 0.5 then 
			
				--copyright symbol
				copyrightnotshowing = false
				if (btnp"5" and btnp"4") o[3] = 0  copyrightnotshowing=true
				sspr(32,88,8,8,40,50,40,40)
				--spr(180,50,50)
			
		end
		
		if copyrightnotshowing then 
			if o[1] < 1.5 then
				
					if(btnp"4") o[3] -= 1
					liney = rnd"40"+29
					for i = 19,109,5 do

						line(i,liney,i+o[3],liney+o[3],14)

					end
			
			
			elseif o[1] < 3.5 then
				--static
				
					--controls to fix
					if(btn"o[2]") o[3] -= 0.5  
					
					 
					for i=1,o[3],1 do
						for j=1,20,1 do
							
							pset(rnd"90"+19,rnd"80"+19,o[2]+1)
							
							
						end
									
					end
				
					
			elseif o[1] < 4.5 then
				
				bumpat -= 2
				if(bumpat < 19) bumpat = 109
				
				bmpcolour = 9
				if bumpat < 74 and bumpat > 54 then
					bmpcolour = 11
					if btnp"5" then o[3] = 0 end
				
				end
				
				for b = 40+adjust,80,5 do
					line(19,b,bumpat,b,bmpcolour)
					line(bumpat+8,b,109,b)
					spr(181,bumpat,b-8)
				end
				
			end
		end
		if(o[3] <= 0.1) del(obs,o) cliptimer += 20
	
	end
	
	--draw the tv

	sspr(48,80,16,16,4,4,120,120)	
		
		cliptimer -=1
		print(cliptimer,85,20,15)
			

	else
		
		xval,yval,printline = 80,100,"better luck next time."
		for i=1,success,1 do
		printline = "your collection is superb. \nvhs will never die, you gloat"
			sspr(48,64,16,8,xval,yval,48,24)
			yval -=4
			xval -=4
	
		end
		print(printline,5,20,15)
		
	
	end

	spr(134,30,110,2,1)
	print(success,50,110)
	
	
end,
		
_init = function(self)
			
		notgameover,cliptimer,success,bumpat,copyrightnotshowing,obs = true,0,0,0,true,{}
		music"0"
	end})
