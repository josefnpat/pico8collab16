-- zspr function
-- by adrian09_01
function zspr(n,w,h,dx,dy,dz)
  sx = 8 * (n % 16)
  sy = 8 * flr(n / 16)
  sw = 8 * w
  sh = 8 * h
  dw = sw * dz
  dh = sh * dz
  sspr(sx,sy,sw,sh, dx,dy,dw,dh)
end

add(games, {
 name = "midnight drive",
 author = "adrian09_01",
 _init = function(self)
	playercar = {}
	cars = {}
	nextdrive = 0
	score = 0
	over = 2
	local p = {}
 p.x = 48
 p.s = 0
 add(playercar, p)
 return p
 end,
 _update = function(self)
	if over == 0 then
	for car in all (playercar) do
 if (btn(0)) car.x -= 1.5
 if (btn(1)) car.x += 1.5
 if (btn(5)) then
 car.s += 1
 else
 car.s -= 1
 end
 if (car.s > 20) sfx(0) 
 if (btn(4)) car.s -= 4
 if (btn(4)) sfx(3)
 if (car.s > 200) car.s = 200
 if (car.s < 0) car.s = 0
 if (car.x < 0) car.x = 0
 if (car.x > 96) car.x = 96
 nextdrive += car.s
 score += car.s/100
end
	for car in all (cars) do
 for pcar in all (playercar) do
 car.y -= car.s - pcar.s/50
 if (car.y >= 110) then
 del(cars, car)
 sfx(2)
 end
 if (car.x < pcar.x + 32 and car.x + 32 > pcar.x and car.y >= 108) over = 1
 end
 end
	if nextdrive > 200 then
 nextdrive = 0
 if (flr(rnd(10)) == 0) self.spawn_car()
 end
	end
 end,
 _draw = function(self)
 map(0,0,0,0,16,16)
 for car in all(cars) do
 zspr(6, 2, 1, car.x, max(car.y, 87), max(-9+car.y/10,0.2))
 end
 for car in all (playercar) do
 zspr(4, 2, 1, car.x, 108, 2)
 print(flr(score).."0m", 16, 8, 8)
 print(car.s.."km/h", 56, 8, 8)
 zspr(36, 1, 1, 108, 80, nextdrive / 75)
 zspr(36, 1, 1, 4, 80, nextdrive / 75)
 end 
 if over == 2 then
 print("midnight drive", 32, 32)
 print("  to start", 32, 48)
 if (btnp(4)) over = 0
 end
 end,
 spawn_car = function()
 local p = {}
 p.x = flr(rnd(96))
 p.y = 64
 p.s = flr(rnd(3)+1)
 add(cars, p)
 return p
 end
}
) -- game 1
