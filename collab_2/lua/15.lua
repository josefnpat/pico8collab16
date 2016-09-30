add(games,{name="videopirate",author="team_disposable",

_update = function()
			cls()

	if(gameover == false) then

		if(cliptimer <= 0) then
			
			if(clipqueue[1] != null) then
				
			sprite1,sprite2,nextclip = {5,5,32,40,rnd(4),rnd(6.9) * 8},{6,6,60,40,rnd(4),rnd(6.9) * 8},clipqueue[#clipqueue]
			
			del(clipqueue,nextclip)
			cliptimer += nextclip[2]
			
				sprite1[1],val2,sprite2[1],val4 = 32,64,40,64
				
				if(nextclip[1] == 1) val2,val4 = 64,72

				if(nextclip[1] == 2) val2,val4 = 72,80

				if(nextclip[1] == 3) val2 = 80

				sprite1[2],sprite2[2] = val2,val4
			else

				gameover = true
				--end the game

			end


		end -- end of cliptimer is 0

		--draw the clip

	adjust = rnd(8)
	adjust2 = rnd(8)
	
	sspr(sprite1[1],sprite1[2],8,8,sprite1[3]+adjust,sprite1[4]+adjust2,sprite1[6],sprite1[6])
		--sx sy sw sh dx dy [dw dh] [flip_x] [flip_y]
	sspr(sprite2[1],sprite2[2],8,8,sprite2[3]+adjust2,sprite2[4]+adjust,sprite2[6],sprite2[6])
		

		--update obstructions
	obs = nextclip[3]
	if(#obs == 0) success += 1  cliptimer = 0 sfx(0) 
	for o in all(obs) do
	
		--{typeofobstruction,directionofobstruction,burstfreq,burstduration,burst_delaystart})
		if(o[1] < 1) then 
		
			--static
			
			--controls to fix
			if(btn(o[2])) o[3] -= 0.3  
			
			 
			
			for i=1,o[3],1 do
				for j=1,40,1 do
					
					pset(rnd(90)+19,rnd(80)+19,o[2])
					
					
				end
							
			end
			
			
		
		elseif (o[1] < 2) then
		
			if(btnp(5)) o[3] -= 1
			sspr(32,88,8,8,40,50,40,40)
			--spr(180,50,50)
		
		else
		
	
		--lines
		if(btnp(4)) o[3] -= 1
		liney = rnd(40)+29
		for i = 19,109,5 do

			line(i,liney,i+o[3],liney+o[3],14)

		end
		
		
		end
		if(o[3] <= 0.1) del(obs,o) sfx(1)
	
	end
		

	--draw the tv

	sspr(48,80,16,16,4,4,120,120)	
		
		

		cliptimer -=1

		print(cliptimer,85,20,15)
		
	

	else
	
		print("your collection is superb.",5,40,15)
		print("vhs will never die, you gloat",5,50,15)
	
	end

	xval = 40
	yval = 100
	for i=1,success,1 do
	
		sspr(48,64,16,8,xval,yval,48,24)
		yval -=4
		xval -=4
	
	end
	
	

end,
		
_init = function(self)
			
		clipqueue,cliptimer,gameover,success = {},0,false,0

		nextclip = null
		
		sprite1= null
		sprite2 = null


			--populate queue
			for difficulty = 10,1,-1 do
				
				obstructions = {}
				for i=1,difficulty,1 do

					add(obstructions,{rnd(2.9),flr(rnd(3.9)),difficulty})

				end
				add(clipqueue,{flr(rnd(3.9)),150,obstructions})

			end

	

	end})
