dogdoghot = {
	name = "dog dog hot",
	author = "headchant",
	rx = function()
		return 5+flr(rnd()*5)
	end,
	x = 7, y = 7,
	points = 0,
	_init = function(self)
		if (self.points == 0) sfx(47)
		self.frame = 0
		self.time = 0
		self.got = false
		self.hx = self.rx()
		self.hy = self.rx()
		self.fx = self.rx()
		self.fy = self.rx()
		self.pvmx = self.rx()
		self.pvmy = 5
		self.phmx = 5
		self.phmy = self.rx()
		self.pv = 1
	end,
	_draw = function(self)
		cls(1+self.points%6)
		rectfill(40,40,88,88,0)
		spr(192+(self.frame%2)*16, self.x*8, self.y*8, 1, 1, self.flipx)
		spr(193, self.hx*8, self.hy*8)
		spr(209, self.pvmx*8, self.pvmy*8)
		spr(209, self.phmx*8, self.phmy*8)
		spr(224+(self.frame%2)*16, self.fx*8, self.fy*8,1,1,self.flipx)
		print("hot hot dog\n\npts:"..self.points.."("..dget(44)..")", 42, 10)
	end,
	_update = function(self)
		if self.got then
			self.time+=1
			if (self.time > 15) self:_init()
			return
		end
		local turn
		if (btnp(0)) self.x-=1; self.flipx = false; turn = true
		if (btnp(1)) self.x+=1; self.flipx = true; turn = true
		if (btnp(2)) self.y-=1; turn = true
		if (btnp(3)) self.y+=1; turn = true
		self.x = max(5,min(self.x,10))
		self.y = max(5,min(self.y,10))
		if turn then
			sfx(46)
			self.frame+=1
			if self.frame%2==0 then
				if (self.fx>self.x) then self.fx-=1
				elseif (self.fx<self.x) then self.fx+=1
				elseif (self.fy<self.y) then self.fy+=1
				elseif (self.fy>self.y) then self.fy-=1 end
			end
			self.pvmy+=self.pv
			self.phmx+=self.pv
			if (self.pvmy %5 ==0) self.pv = -self.pv
			self.ph = self.pv
			if ((self.pvmx == self.x and self.pvmy == self.y) or
			(self.phmx == self.x and self.phmy == self.y) or
			(self.fx == self.x and self.fy == self.y)) then
				sfx(44)
				if (self.points > dget(44)) dset(44, self.points)
				self.points = 0
				self.got = true
				return
			end
		end
		if (self.x == self.hx and self.y == self.hy) then
			self.points += 1
			self.got = true
			sfx(45)
		end
	end
}
add(games,dogdoghot)
