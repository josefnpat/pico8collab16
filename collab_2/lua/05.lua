add(games,{
	name="freedom",
	author="zatyka",
	_init = function()

  text,tick,px,py,ps,pdy,pjmax,pjcnt,pspd,pf,solids,pwrups="               freedom",0,200,91,21,0,1,0,3,0,{},{{384,408,"shrink"},{384,136,"shrink"},{176,440,"air jump"},{16,80,"speed"}}
		camera(136,27)
		for ix=0,31 do
			for iy=0,31 do
				tileval=mget(ix+96,iy)
				for i=7,0,0xffff do
					if (tileval>=2^i) s={(32*(i%2)+ix)*8, (16*flr(i/2)+iy)*8,rnd(4)}	add(solids,s) tileval-=2^i
				end
			end
		end
		function col(objs)
			for o in all(objs) do
				if(px<o[1]+8 and px+ps>o[1] and py<o[2]+8 and py+ps>o[2]) fobj,pwrup=o,o[3] return true		end
			return false
		end
		
	end,
	_update = function()
		tick+=1
		
		pf,colsol=0,{}
		for s in all(solids) do
			if (abs(s[1]-px)<50 and	abs(s[2]-py)<50) add(colsol,s)
		end
		
		if(btn(1)) px+=pspd xdirc,pf=1,tick%4
		if(btn(0)) px-=pspd xdirc,pf=0xffff,tick%4

		while col(colsol) do
			px-=xdirc
		end

		if((btnp(2) or btnp(4)) and pjcnt<pjmax) pdy=0xfff8	pjcnt+=1	sfx(16)
		pdy=min(pdy+1,14)
		py+=pdy
		local ydirc=sgn(pdy)	
		if (pjcnt==0) pjcnt=1
		while col(colsol) do
			py-=ydirc
			pdy=0
			if (ydirc==1)	pjcnt=0 
		end
		
		
		if col(pwrups)	then
			if pwrup=="air jump" then 
				pjmax+=1 
			elseif pwrup=="shrink" then
				ps-=7 
			else 
				pspd+=1
			end
			del(pwrups,fobj)	
			sfx(17)
		end

	camera(mid(px-64,0,384),mid(py-64,0,384))
	if (px<0) text,py,px="   thanks for playing",0xfff8,64 sfx(18)
	end, 
	_draw = function() 
		cls()
		sspr(64+pf*8,40,7,7,px,py,ps,ps,xdirc==0xffff)
		
		for s in all(solids) do
			spr(120+s[3],s[1],s[2])
		end
		for pwr in all(pwrups) do
			local x,y = pwr[1],pwr[2]
				spr(105+x%3,x,y+sin(tick/25))
			print(pwr[3],x-8,y-7)
		end
		print(text,10,17)
--	 print(pf,px,py-8,6)

	end
}) -- game 5
